# Common functions for Chocolatey update scripts
import fnmatch
import hashlib
import os
import re
import subprocess
import urllib.request


def sha256sum(filename):
    h = hashlib.sha256()
    b = bytearray(128*1024)
    mv = memoryview(b)
    with open(filename, 'rb', buffering=0) as f:
        for n in iter(lambda: f.readinto(mv), 0):
            h.update(mv[:n])
    return h.hexdigest()


def get_version_from_nupgk(nuspecfile):
    with open(nuspecfile, 'r', encoding='UTF8') as f:
        content = f.read()
        version = re.findall(r'<version>.*</version>', content)[0]
        version = version.replace('<version>', '').replace('</version>', '')
        return version


def update_package(package_path, nuspec_file, ps1_file, latest_version, url64, url32=''):
    print('Update found')
    nupgkfiles = find_files(package_path, '*.nupkg')
    try:
        if len(nupgkfiles) > 0:
            print('Deleting old *.nupgk file(s)')
            for f in nupgkfiles:
                try:
                    os.remove(f)
                except:
                    continue
    except TypeError as err:
        pass 
    update_nuspec(nuspec_file, latest_version)
    if url64 != '':
        shachecksum = calc_checksum(url64, package_path)
        update_ps1_file(ps1_file, shachecksum, url64, False, True)
    if url32 != '':
        shachecksum = calc_checksum(url32, package_path)
        update_ps1_file(ps1_file, shachecksum, url32, True, False)
    choco_pack_push(package_path)
    git_commit_push(package_path)
    print('All files updated.')


def update_nuspec(nuspec_file, version):
    print('Replacing version in ' + nuspec_file)
    with open(nuspec_file, 'r', encoding="utf8") as f:
        content = f.read()
        regex = re.compile(r'<version>\d*\.\d*\.\d*</version>', re.IGNORECASE)
        content_new = regex.sub("<version>" + version + "</version>", content)
    print('Writing new ' + nuspec_file)
    with open(nuspec_file, 'w', encoding="utf8") as f:
        f.write(content_new)


def update_ps1_file(ps1_file, shachecksum, url, x86=False, x64=False):
    print('Replacing checksums and downlod urls in ' + ps1_file)
    with open(ps1_file, 'r', encoding="utf8") as f:
        content = f.read()
        if x64 == True:
            print('Platform: x64')
            regex = re.compile(r"checksum64\s*=\s*'.*'", re.IGNORECASE)
            content_new1 = regex.sub(
                "checksum64    = '" + shachecksum + "'", content)
            regex = re.compile(r"\$url64\s*=\s*'.*'", re.IGNORECASE)
            content_new = regex.sub(
                "$url64      = '" + url + "'", content_new1)
        elif x86 == True:
            print('Platform: x86 / any')
            regex = re.compile(r"checksum\s*=\s*'.*'", re.IGNORECASE)
            content_new1 = regex.sub(
                "checksum      = '" + shachecksum + "'", content)
            regex = re.compile(r"\$url\s*=\s*'.*'", re.IGNORECASE)
            content_new = regex.sub(
                "$url        = '" + url + "'", content_new1)
    if x86 == True or x64 == True:
        print('Writing new ' + ps1_file)
        with open(ps1_file, 'w', encoding="utf8") as f:
            f.write(content_new)
    else:
        print('Nothing to do (no platform given).')


def calc_checksum(download_url, package_path):
    tmp_file = package_path + 'tmp.file'
    print('Downloading file')
    print('Download URL: ' + download_url)
    urllib.request.urlretrieve(download_url, tmp_file)
    print('Calculating sha256 checksum')
    shachecksum = sha256sum(tmp_file)
    print('New checksum: ' + shachecksum)
    print('Deleting downloaded file')
    os.remove(tmp_file)
    return shachecksum


def choco_pack_push(package_path):
    print('Chocolatey pack')
    subprocess.call(['choco.exe', 'pack'], cwd=package_path)
    print('Chocolatey push')
    subprocess.call(['choco.exe', 'push'], cwd=package_path)
    print('Git commit')


def git_commit_push(package_path):
    commitmessageparameter = '-am ' + '"' + package_path + ' automatic update"'
    # subprocess.call(['git.exe', 'pull', 'origin', 'master'], cwd=package_path + '/..')
    subprocess.call(['git.exe', 'commit', commitmessageparameter],
                    cwd=package_path + '/..')
    subprocess.call(['git.exe', 'push'], cwd=package_path + '/..')


'''
def purge_files(path, extension):
    for f in os.listdir(path):
        if re.search('*.' + extension, f):
            os.remove(os.path.join(path, f))
'''

def find_files(base, pattern):
    '''Return list of files matching pattern in base folder.'''
    return [n for n in fnmatch.filter(os.listdir(base), pattern) if
            os.path.isfile(os.path.join(base, n))]
