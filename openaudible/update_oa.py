import os
import re
import subprocess
import requests
import urllib.request
import json
import hashlib
import untangle
from distutils.version import StrictVersion
from xml.etree import ElementTree as et

def sha256sum(filename):
    h  = hashlib.sha256()
    b  = bytearray(128*1024)
    mv = memoryview(b)
    with open(filename, 'rb', buffering=0) as f:
        for n in iter(lambda : f.readinto(mv), 0):
            h.update(mv[:n])
    return h.hexdigest()

nuspecfile = './openaudible/openaudible.nuspec'
ps1file = './openaudible/tools/chocolateyinstall.ps1'
tmpfile = './openaudible/tmp.file'

print('Searching for openaudible update')

# Get latest version information an download url from JSON
url = 'https://openaudible.org/swt_version.json'
data = requests.get(url).text
data = json.loads(data)
dlurl=data['download_dir'] + data['platforms']['win']['file']
latestversion=data['version']
print('Latest version from JSON: ' + latestversion)
print('Download URL: ' + dlurl)

# Get last committed chocolatey version from nuspec
obj = untangle.parse(nuspecfile)
chocoversion = obj.package.metadata.version.cdata
print('Chocolatey Version: ' + chocoversion)

if StrictVersion(latestversion) > StrictVersion(chocoversion):
    print('We have an update')
    print('Downloading file')
    urllib.request.urlretrieve(dlurl, tmpfile)
    print('Calculating sha256 checksum')
    shachecksum = sha256sum(tmpfile)
    print('Deleting downloaded file')
    os.remove(tmpfile)
    print('Replacing version in ' + nuspecfile)
    with open(nuspecfile, 'r') as f:
        content = f.read()
        content_new = re.sub(pattern="<version>\d\.\d\.\d</version>", repl="<version>" + latestversion + "</version>", string=content)
    print('Writing new ' + nuspecfile)
    with open(nuspecfile, 'w') as f:
        f.write(content_new)            
    print('Replacing checksum in ' + ps1file)
    with open(ps1file, 'r') as f:
        content = f.read()
        content_new = re.sub(pattern="checksum64\s*=\s*'.*'", repl="checksum64    = '" + sha256sum + "'", string=content)
    print('Writing new ' + ps1file)
    with open(ps1file, 'w') as f:
        f.write(content_new)            
    print('Chocolatey pack')
    subprocess.call(['choco.exe', 'pack'], cwd='./openaudible')
    print('Chocolatey push')
    subprocess.call(['choco.exe', 'push'], cwd='./openaudible')
    print('Git commit')
    subprocess.call(['git.exe', 'commit', '-m "Openaudible automatic update"'], cwd='./openaudible')
else:
    print('No update available')
