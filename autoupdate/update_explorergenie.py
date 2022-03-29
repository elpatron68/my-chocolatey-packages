import re
import requests
import json
import sys
import choco
from packaging.version import Version

PATH = '.\\explorergenie'
NUSPEC_FILE = PATH + '\\explorergenie.nuspec'
PS1_FILE = PATH + '\\tools\\chocolateyinstall.ps1'

print('Searching for ExplorerGenie update')

# Get latest version information an download url from HTML
url = 'https://www.martinstoeckli.ch/explorergenie/explorergenie.msi'
data = requests.get(url).text
version = re.findall(r'\d\.\d\.\d', data)[0]
download_url = 'https://www.martinstoeckli.ch/explorergenie/explorergenie.msi'
latest_version = re.findall(r'\d\.\d\.\d', version)[0]
print('Latest version from ExplorerGenie download page: ' + latest_version)

# Get last committed chocolatey version from nuspec
nupkg_version = choco.get_version_from_nupgk(NUSPEC_FILE)
print('Chocolatey Version: ' + nupkg_version)

if Version(latest_version) > Version(nupkg_version):
    print('Download URL: ' + download_url)
    choco.update_package(PATH, NUSPEC_FILE, PS1_FILE, latest_version, '', download_url)
    sys.exit()
else:
    print('No update available')
    sys.exit()
