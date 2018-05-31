# Chocolately package updater
#
# - Gets most recent version information and URL from download site, updates Chocolately package, commits and pushes to Git, pushes Chocolately
"""
Author: Markus Busche (Twitter @elpatron_kiel, GitLab @m-busche, Github @elpatron68)
License: MIT https://opensource.org/licenses/MIT, see LICENSE
"""

import sys
import os
import urllib.request
import requests
import git
import re
import logging
import hashlib
import subprocess

LOG = None


# package class
class chocopkg:
    projectId = ''
    projectDir = ''
    nuspecFile = ''
    nupkgFile = ''
    ps1File = ''
    vendorUrl = ''
    downloadPattern = ''
    versionPattern = ''
    releasnotesPattern = ''
    releasnotesUrl = ''
    latestVersion = ''
    downloadUrl = ''
    sha256 = ''

    def setValues(self):
        self.projectDir = '.\\' + self.projectId + '\\'
        self.nuspecFile = self.projectDir + self.projectId + '.nuspec'
        self.ps1File = self.projectDir + 'tools\\chocolatelyinstall.ps1'

    def setNupgk(self):
        self.nupkgFile = self.projectId + '.' + self.latestVersion + '.nupkg'

    def dump(self):
        return ('Project ID: ' + self.projectId + '\n' +
                'Project directory: ' + self.projectDir + '\n' +
                'Nuspec file: ' + self.nuspecFile + '\n' +
                'Nupkg file: ' + self.nupkgFile + '\n' +
                'Powershell script: ' + self.ps1File + '\n' +
                'Vendor-URL: ' + self.vendorUrl + '\n' +
                'Download-Pattern: ' + self.downloadPattern + '\n' +
                'Version-Pattern: ' + self.versionPattern + '\n' +
                'Release notes-Pattern: ' + self.releasnotesPattern + '\n' +
                'Release notes-Url: ' + self.releasnotesUrl + '\n' +
                'Latest version: ' + self.latestVersion + '\n' +
                'Download URL: ' + self.downloadUrl + '\n' +
                'Sha256: ' + self.sha256)    


def setup_custom_logger(name):
    """
    Set up custom logging
    """
    loglevel = 'DEBUG'


    formatter = logging.Formatter(fmt='%(asctime)s %(levelname)-8s %(message)s',
                                  datefmt='%Y-%m-%d %H:%M:%S')
    handler = logging.FileHandler(name + '.log', mode='w')
    handler.setFormatter(formatter)
    screen_handler = logging.StreamHandler(stream=sys.stdout)
    screen_handler.setFormatter(formatter)
    logger = logging.getLogger(name)
    logger.setLevel(loglevel)
    logger.addHandler(handler)
    logger.addHandler(screen_handler)
    return logger


def getDownloadUrlVersion(pkgObject):
    LOG.debug('Downloading website content')
    with urllib.request.urlopen(pkgObject.vendorUrl) as response:
        htmltext = response.read().decode('utf-8')
    downloadUrl = re.findall(re.compile(pkgObject.downloadPattern), htmltext)[0]
    LOG.debug('Found download Url: %s', downloadUrl)
    version = re.findall(re.compile(pkgObject.versionPattern), downloadUrl)[0]
    # remove leading 0 after version point
    version = re.sub(re.compile(r'\.0+'), '.', version)
    # remove LANCOM 'RU'
    version = re.sub(re.compile(r'-RU'), '.', version)
    LOG.debug('Found version information: %s', version)
    releasnotesUrl = re.findall(re.compile(pkgObject.releasnotesPattern), htmltext)[0]
    return(downloadUrl, version, releasnotesUrl)


def patchPackage(pgkObject):
    LOG.info('Checking %s if we have an update', pgkObject.nuspecFile)
    with open(pgkObject.nuspecFile, 'r', encoding='utf8') as f:
        content = f.read()
        oldVersion = re.findall(re.compile(r'<version>.+</version>'), content)[0]
        oldVersion = oldVersion.replace('<version>', '').replace('</version>', '')
        oldRnotes = re.findall(re.compile(r'<releaseNotes>.+</releaseNotes>'), content)[0]
        oldRnotes = oldRnotes.replace('<releaseNotes>', '').replace('</releaseNotes>', '')

    LOG.debug('Version from nuspec: ' + oldVersion)
    if not oldVersion == pgkObject.latestVersion:
        LOG.info('We have an updated version - replacing version information and release notes Url')
        inplace_change(pgkObject.nuspecFile, oldVersion, pgkObject.latestVersion)
        inplace_change(pgkObject.nuspecFile, oldRnotes, pgkObject.releasnotesUrl)
        LOG.info('Updating PowerShell script with new url')
        patchPs1(pgkObject.ps1File, pgkObject.downloadUrl)
        gitCommit('Autoupdate: Package ' + pgkObject.projectId + 'updated to version ' + pgkObject.latestVersion)
        return True
    else:
        return False


def patchPs1(psScriptfile, newURL):
    LOG.info('Updating %s', psScriptfile)
    with open(psScriptfile, 'r', encoding='utf-8') as f:
        with open('tmpfile.txt', 'w', encoding='utf-8') as tmpfile:
            content = f.read()
            for line in content:
                if '$url' in line:
                    line = "$url        = '" + newURL + '\n'
                tmpfile.write(line)
    os.remove(psScriptfile)
    os.rename('tmpfile.txt', psScriptfile)


def inplace_change(filename, old_string, new_string):
    # Safely read the input filename using 'with'
    with open(filename, 'r', encoding="utf8") as f:
        s = f.read()
        if old_string not in s:
            LOG.warn('"{old_string}" not found in {filename}.'.format(**locals()))
            return

    # Safely write the changed content, if found in the file
    with open(filename, 'w', encoding="utf8") as f:
        LOG.debug('Changing "{old_string}" to "{new_string}" in {filename}'.format(**locals()))
        s = s.replace(old_string, new_string)
        f.write(s)


def chocopush(pkgObject):
    os.remove(pkgObject.projectDir + '\\*.nupkg')
    result[0] = subprocess.Popen(['choco', 'pack'], cwd=pkgObject.projectDir)
    result[1] = subprocess.Popen(['choco', 'push', pkgObject.nupkgFile, '--source https://push.chocolatey.org/'], cwd=pkgObject.projectDir)
    return result


def gitCommit(message):
    LOG.info('Committing changes to Git repository')
    repo = git.Repo(path='.')
    repo.git.status()
    try:
        repo.git.commit('-a', '-m', message)
    except:
        LOG.warn('Failed to git commit')
    
    LOG.info('Git pushing to remote server')
    try:
        repo.git.push("origin", "master")
        LOG.info('Git committed and pushed')
    except:
        LOG.warn('Failed to git push repository')
    return


def sendMessage(messageText, attachedFile):
    key = 'key-65d52cc570230f0f4e25684c2b2b7238'
    sandbox = 'sandbox2c45884527824533b2ccaae8ded609db.mailgun.org'
    recipient = 'm.busche@gmail.com'
    request_url = 'https://api.mailgun.net/v2/{0}/messages'.format(sandbox)

    return requests.post(
        request_url,
        auth=("api", key),
        files=[("inline", open(attachedFile))],
        data={"from": "m.busche@medisoftware.de",
              "to": recipient,
              "subject": "chocoupdate report",
              "text": messageText
              })


def sha256_checksum(filename, block_size=65536):
    sha256 = hashlib.sha256()
    with open(filename, 'rb') as f:
        for block in iter(lambda: f.read(block_size), b''):
            sha256.update(block)
    return sha256.hexdigest()


if __name__ == "__main__":
    # Delete former log file
    try:
        os.remove('chocoupdate.log', '.')
    except:
        print('Old log file not found or not deletable')

    # Set up logging
    LOG = setup_custom_logger('chocoupdate')
    LOG.info('Starting chocoupdate')
    
    updatedPackage = ''

    # Initialize packages
    packages = [chocopkg() for i in range(1)]
    packages[0].projectId = 'lanconfig'
    packages[0].vendorUrl = 'https://www.lancom-systems.de/downloads/'
    packages[0].downloadPattern = r'https:\/\/www\.lancom-systems\.de\/fileadmin\/download\/LANtools\/LANconfig-\d{1,3}\.\d{1,3}\.\d{1,4}.*\.exe'
    packages[0].releasnotesPattern = r'https:\/\/www\.lancom-systems\.de\/\/fileadmin\/download\/documentation\/Release_Notes\/RN_LANtools-\d{4,}.+DE.pdf'
    packages[0].versionPattern = r'\d{1,3}\.\d{1,3}\.\d{1,4}-?R?U?\d?'
    packages[0].setValues()

    packages[1].projectId = 'lanmonitor'
    packages[1].vendorUrl = 'https://www.lancom-systems.de/downloads/'
    packages[1].downloadPattern = r'https:\/\/www\.lancom-systems\.de\/fileadmin\/download\/LANtools\/LANmonitor-\d{1,3}\.\d{1,3}\.\d{1,4}.*\.exe'
    packages[1].releasnotesPattern = r'https:\/\/www\.lancom-systems\.de\/\/fileadmin\/download\/documentation\/Release_Notes\/RN_LANtools-\d{4,}.+DE.pdf'
    packages[1].versionPattern = r'\d{1,3}\.\d{1,3}\.\d{1,4}-?R?U?\d?'
    packages[1].setValues()

    for package in packages:
        # Download web page
        LOG.info('Getting information from %s', package.vendorUrl)
        [package.downloadUrl, package.latestVersion, package.releasnotesUrl] = getDownloadUrlVersion(package)
        package.nupkgFile = package.setNupgk
    
        # Download installation package
        LOG.info('Downloading file: %s', package.downloadUrl)
        if not os.path.exists('.\\tmp'):
            os.makedirs('.\\tmp')
        localfilename = '.\\tmp\\' + package.downloadUrl.split('/')[-1]
        urllib.request.urlretrieve(package.downloadUrl, localfilename)
        LOG.info('File saved as %s', localfilename)
    
        # Create sha256 checksum and delete file
        package.sha256 = sha256_checksum(localfilename)
        LOG.info('Sha256 checksum: %s', package.sha256)
        LOG.info('Deleting %s', localfilename)
        os.remove(localfilename)

        # Update chocolately package
        result = patchPackage(package)

        if result == True:
            chocopush(package)
            updatedPackage += 'LANconfig: Version %s', package.latestVersion


    # Send email report
    LOG.info('Sending email report')
    if not updatedPackage is '':
        sendMessage('Chocoupdate has found updates for the following packages:\n\n' + 
                    updatedPackage + 
                    '\n\nSee attached logfile for details.\n\nSincerly,\nyours Chocoupdate', 
                    r'.\chocoupdate.log')
    else:
        sendMessage('Chocoupdate has not found new updates.\n\n' +
                    'See attached logfile for details.\n\nSincerly,\nyours Chocoupdate', 
                    r'.\chocoupdate.log')
    
