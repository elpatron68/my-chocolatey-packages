import re
import requests
import json
import sys
import choco
from distutils.version import StrictVersion

PATH = '.\\openaudible'
NUSPEC_FILE = PATH + '\\openaudible.nuspec'
PS1_FILE = PATH + '\\tools\\chocolateyinstall.ps1'

print('Searching for openaudible update')

# Get latest version information an download url from JSON
url = 'https://openaudible.org/swt_version.json'
data = requests.get(url).text
data = json.loads(data)
dlurl = data['download_dir'] + data['platforms']['win']['file']
latest_version = data['version']
print('Latest version from JSON: ' + latest_version)

# Get last committed chocolatey version from nuspec
nupkg_version = choco.get_version_from_nupgk(NUSPEC_FILE)
print('Chocolatey Version: ' + nupkg_version)

if StrictVersion(latest_version) > StrictVersion(nupkg_version):
    choco.update_package(PATH, NUSPEC_FILE, PS1_FILE, latest_version, '', dlurl)
    sys.exit(1)
else:
    print('No update available')
    sys.exit(0)
    