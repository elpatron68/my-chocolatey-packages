# Chocolately package updater
#
# - Gets most recent version information and URL from download site
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
import chocopack
from configparser import ConfigParser

LOG = None
CONFIGFILE = r'.\autoupdate\chocoupdate.ini'

def setup_custom_logger(name):
    """
    Set up custom logging
    """
    config = ConfigParser()
    config.read(CONFIGFILE)
    settings = dict(config.items('logging'))
    loglevel = logging.getLevelName(settings['level'])


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


def getDownloadUrlVersion(url, expression, versionpattern):
    LOG.info('Getting website content')
    with urllib.request.urlopen(url) as response:
        htmltext = response.read().decode('utf-8')
    downloadUrl = re.findall(re.compile(expression), htmltext)[0]
    LOG.debug('Download Url: %s', downloadUrl)
    version = re.findall(re.compile(versionpattern), downloadUrl)[0]
    # remove leading 0 after version point
    version = re.sub(re.compile(r'\.0+'), '.', version)
    # remove LANCOM 'RU'
    version = re.sub(re.compile(r'-RU'), '.', version)
    LOG.debug('Version information: %s', version)
    return(downloadUrl, version)


def patchPackage(nuspecFile, psScriptfile, downloadUrl, newVersion):
    LOG.info('Checking %s if we have an update', nuspecFile)
    with open(nuspecFile, 'r', encoding='utf8') as f:
        content = f.read()
        oldVersion = re.findall(re.compile(r'<version>.+</version>'), content)[0]
        oldVersion = oldVersion.replace('<version>', '').replace('</version>', '')
    LOG.debug('Version from nuspec: ' + oldVersion)
    if not oldVersion == newVersion:
        LOG.info('We have an updated version - replacing version information')
        inplace_change(nuspecFile, oldVersion, newVersion)
        LOG.info('Updating PowerShell script with new url')
        patchPs1(psScriptfile, downloadUrl)
        packagename = nuspecFile.split('\\')[-1].split('.')[0]
        gitCommit('Autoupdate: Package updated to version ' + packagename)
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


def chocopush(projectDir):
    return


def gitCommit(message):
    repo = git.Repo(path='.')
    repo.git.status()
    try:
        repo.git.commit('-a', '-m', message)
    except:
        LOG.warn('Failed to git commit')
    
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


if __name__ == "__main__":
    # request = sendMessage("Chocoupdate has found updates. See attached file for details.\n\nSincerly,\nyours Chocoupdate", r'.\chocoupdate.log')
    # print('Status: {0}'.format(request.status_code))
    try:
        os.remove('chocoupdate.log', '.')
    except:
        print('Old log file not found or not deletable')

    LOG = setup_custom_logger('chocoupdate')
    LOG.info('Starting chocoupdate')
    url = 'https://www.lancom-systems.de/downloads/'
    downloadExpression = r'https:\/\/www\.lancom-systems\.de\/fileadmin\/download\/LANtools\/LANmonitor-\d{1,3}\.\d{1,3}\.\d{1,4}.*\.exe'
    releasenotesExpression = r'https:\/\/www\.lancom-systems\.de\/\/fileadmin\/download\/documentation\/Release_Notes\/RN_LANtools-\d{4,}.+DE.pdf'
    versionpattern = r'\d{1,3}\.\d{1,3}\.\d{1,4}-?R?U?\d?'
    LANmonitor = getDownloadUrlVersion(url, downloadExpression, versionpattern)
    downloadExpression = r'https:\/\/www\.lancom-systems\.de\/fileadmin\/download\/LANtools\/LANconfig-\d{1,3}\.\d{1,3}\.\d{1,4}.*\.exe'
    LANconfig = getDownloadUrlVersion(url, downloadExpression, versionpattern)
    LOG.debug('Newest LANconfig Download URL: %s', LANconfig[0])
    LOG.debug('Newest LANconfig version: %s', LANconfig[1])
    LOG.debug('Newest LANmonitor Download URL: %s', LANmonitor[0])
    LOG.debug('Newest LANmonitor version: %s', LANmonitor[1])
    updatedPackage = ''
    result = patchPackage(r'.\LANconfig\lanconfig.nuspec', 
                          r'.\LANconfig\tools\chocolateyinstall.ps1',
                          LANconfig[0],
                          LANconfig[1])
    if result == True:
        chocopush('.\\LANconfig\\')
        updatedPackage += 'LANconfig: Version ' + LANconfig[1]

    result = patchPackage(r'.\LANmonitor\lanmonitor.nuspec', 
                          r'.\LANmonitor\tools\chocolateyinstall.ps1',
                          LANmonitor[0],
                          LANmonitor[1])
    if result == True:
        chocopush('.\\LANmonitor\\')
        updatedPackage += '\nLANmonitor: Version ' + LANmonitor[1]

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
    
