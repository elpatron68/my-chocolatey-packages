import re
import sys

import requests
from packaging.version import Version

import choco

PATH = '.\\LANmonitor'
NUSPEC_FILE = PATH + '\\lanmonitor.nuspec'
PS1_FILE = PATH + '\\tools\\chocolateyinstall.ps1'

print('Searching for LANmonitor update')

url = 'https://www.lancom-systems.de/downloads/'
try:
    data = requests.get(url, timeout=60).text
except requests.RequestException as exc:
    print(f'ERROR: Could not fetch LANCOM downloads page: {exc}')
    sys.exit(2)

# Prefer full URL from page (host changed from my.lancom-systems.de to downloads.lancom-systems.de).
url_matches = re.findall(
    r'https://downloads\.lancom-systems\.de/+LANtools/(LANmonitor-\d{2,3}\.\d{2,3}\.\d{4}-R.{2,3}\.exe)',
    data,
)
if not url_matches:
    print('ERROR: Could not find LANmonitor download URL on downloads page')
    sys.exit(2)

suburl = url_matches[0]
download_url = 'https://downloads.lancom-systems.de/LANtools/' + suburl
latest_version = re.findall(r'\d{2,3}\.\d{2,3}\.\d{4}', suburl)[0]
# Remove leading zeros in version segments (10.94.0015 -> 10.94.15)
latest_version = re.sub(r'\.0+', '.', latest_version)
print('Latest version from LANmonitor download page: ' + latest_version)

nupkg_version = choco.get_version_from_nupgk(NUSPEC_FILE)
print('Chocolatey Version: ' + nupkg_version)

if Version(latest_version) > Version(nupkg_version):
    print('Download URL: ' + download_url)
    choco.update_package(PATH, NUSPEC_FILE, PS1_FILE, latest_version, '', download_url)
else:
    print('No update available')
    sys.exit(0)
