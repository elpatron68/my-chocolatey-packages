import re
import requests
import json
import sys
import choco
from packaging.version import Version

PATH = '.\\copypathmenu'
NUSPEC_FILE = PATH + '\\copypathmenu.nuspec'
PS1_FILE = PATH + '\\tools\\chocolateyinstall.ps1'

print('Searching for CopyPathMenu update')

# Get latest version information an download url from HTML
url = 'https://streamwriter.org/en/'
data = requests.get(url).text
version = re.findall(r'Current version: \d\.\d\.\d\.\d', data)[0]
download_url = 'https://streamwriter.org/en/downloads/2/'
latest_version = re.findall(r'\d\.\d\.\d\.\d', version)[0]
print('Latest version from Streamwriter download page: ' + latest_version)

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
