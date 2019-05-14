import os
import re
import subprocess
import requests
import urllib.request
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

nuspecfile = './gajim/gajim.nuspec'
ps1file = './gajim/tools/chocolateyinstall.ps1'
tmpfile = './gajim/tmp.file'

print('Searching for Gajim update')

# Get latest version information an download url from HTML
url = 'https://gajim.org/downloads.php?lang=en'
data = requests.get(url).text
html = re.findall(r'Latest\s*version\s*of\s*Gajim\s*is\s*<strong>\d*\.\d*\.\d*<\/strong>', data)[0]
latestversion = re.findall(r'\d*\.\d*\.\d*', html)[0]
print('Latest version from Gajim download page: ' + latestversion)

# Get last committed chocolatey version from nuspec
obj = untangle.parse(nuspecfile)
gajimversion = obj.package.metadata.version.cdata
print('Chocolatey Version: ' + gajimversion)

if StrictVersion(latestversion) > StrictVersion(gajimversion):
    print('We have an update')
    html = re.findall(r'downloads\/\d\.\d\/gajim-\d*\.\d*\.\d*-32bits.*\.exe', data)
    dlurl32 = 'https://gajim.org/' + html
    print('Downloading 32 bit file')
    print('Download URL: ' + dlurl32)
    urllib.request.urlretrieve(dlurl32, tmpfile)
    print('Calculating sha256 checksum')
    shachecksum32 = sha256sum(tmpfile)
    print('Deleting downloaded file')
    os.remove(tmpfile)
    html = re.findall(r'downloads\/\d\.\d\/gajim-\d*\.\d*\.\d*-64bits.*\.exe', data)
    dlurl64 = 'https://gajim.org/' + html
    print('Downloading 64 bit file')
    print('Download URL: ' + dlurl64)
    urllib.request.urlretrieve(dlurl64, tmpfile)
    print('Calculating sha256 checksum')
    shachecksum64 = sha256sum(tmpfile)
    print('Deleting downloaded file')
    os.remove(tmpfile)

    print('Replacing version in ' + nuspecfile)
    with open(nuspecfile, 'r') as f:
        content = f.read()
        content_new = re.sub(pattern="<version>\d\.\d\.\d</version>", repl="<version>" + latestversion + "</version>", string=content)
    print('Writing new ' + nuspecfile)
    with open(nuspecfile, 'w') as f:
        f.write(content_new)            
    print('Replacing checksums and urls in ' + ps1file)
    with open(ps1file, 'r') as f:
        content = f.read()
        content_new = re.sub(pattern="checksum64\s*=\s*'.*'", repl="checksum64    = '" + shachecksum64 + "'", string=content)
        content_new = re.sub(pattern="checksum\s*=\s*'.*'", repl="checksum      = '" + shachecksum32 + "'", string=content_new)
        content_new = re.sub(pattern="url64\s*=\s*'.*'", repl="$url64      = '" + dlurl64 + "'", string=content_new)
        content_new = re.sub(pattern="url\s*=\s*'.*'", repl="$url      = '" + dlurl32 + "'", string=content_new)
    print('Writing new ' + ps1file)
    with open(ps1file, 'w') as f:
        f.write(content_new)
    print('Chocolatey pack')
    subprocess.call(['choco.exe', 'pack'], cwd='./gajim')
    print('Chocolatey push')
    subprocess.call(['choco.exe', 'push'], cwd='./gajim')
    print('Git commit')
    subprocess.call(['git.exe', 'commit', '-m "Gajim automatic update"', "--author=<autoupdate>"], cwd='./gajim')
    subprocess.call(['git.exe', 'push'], cwd='./gajim')
else:
    print('No update available')
