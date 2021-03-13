import re
import requests
import json
import sys
import choco
from distutils.version import StrictVersion

PATH = '.\\gajim'
NUSPEC_FILE = PATH + '\\gajim.nuspec'
PS1_FILE = PATH + '\\tools\\chocolateyinstall.ps1'

print('Searching for Gajim update')

# Get latest version information an download url from HTML
url = 'https://gajim.org/download/'
data = requests.get(url).text
suburl = re.findall(r'<td><span class="label label-primary">\d*\.\d*\.\d*', data)[0]
latest_version = re.findall(r'\d*\.\d*\.\d*', suburl)[0]
print('Latest version from Gajim download page: ' + latest_version)

# Get last committed chocolatey version from nuspec
nupkg_version = choco.get_version_from_nupgk(NUSPEC_FILE)
print('Chocolatey Version: ' + nupkg_version)

if StrictVersion(latest_version) > StrictVersion(nupkg_version):
    # Find download urls
    download_url64 = re.findall(r'https:\/\/gajim\.org\/downloads\/\d*\.\d*\/Gajim-\d*\.\d*\.\d*-64bit?-?\d*\.exe', data)[0]
    print('Download URL 64 bit: ' + download_url64)
    download_url32 = re.findall(r'https:\/\/gajim\.org\/downloads\/\d*\.\d*\/Gajim-\d*\.\d*\.\d*-32bit?-?\d*\.exe', data)[0]
    print('Download URL 32 bit: ' + download_url32)
    choco.update_package(PATH, NUSPEC_FILE, PS1_FILE, latest_version, download_url64, download_url32)
    sys.exit(1)
else:
    print('No update available')
    sys.exit(0)
