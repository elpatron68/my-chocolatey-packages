import re
import requests
import json
import sys
import choco
from packaging.version import Version

PATH = '.\\LANmonitor'
NUSPEC_FILE = PATH + '\\lanmonitor.nuspec'
PS1_FILE = PATH + '\\tools\\chocolateyinstall.ps1'

print('Searching for LANmonitor update')

# Get latest version information an download url from HTML
url = 'https://www.lancom-systems.de/downloads/'
data = requests.get(url).text
suburl = re.findall(r'LANmonitor-\d{2,3}\.\d{2,3}\.\d{4}-R..\.exe', data)[0]
download_url = 'https://my.lancom-systems.de/download/LANtools/' + suburl
latest_version = re.findall(r'\d{2,3}\.\d{2,3}\.\d{4}', suburl)[0]
# Remove leading zeros
latest_version = re.sub(r'\.0*', '.', latest_version)
print('Latest version from LANmonitor download page: ' + latest_version)

# Get last committed chocolatey version from nuspec
nupkg_version = choco.get_version_from_nupgk(NUSPEC_FILE)
print('Chocolatey Version: ' + nupkg_version)

if Version(latest_version) > Version(nupkg_version):
    print('Download URL: ' + download_url)
    choco.update_package(PATH, NUSPEC_FILE, PS1_FILE, latest_version, '', download_url)
else:
    print('No update available')
