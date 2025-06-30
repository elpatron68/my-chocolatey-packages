import re
import requests
# import json
import sys
import choco
from packaging.version import Version

PATH = '.\\gajim'
NUSPEC_FILE = PATH + '\\gajim.nuspec'
PS1_FILE = PATH + '\\tools\\chocolateyinstall.ps1'

print('Searching for Gajim update')

# Get latest version information an download url from HTML
url = 'https://gajim.org/download/'
data = requests.get(url).text
# suburl = re.findall(r'<td><span class="label label-primary">\d*\.\d*\.\d*', data)[0]
# https://gajim.org/downloads/2.3/Gajim-2.3.1-64bit.exe
latest_version = re.findall(r'\d*\.\d*\.\d*', data)[0]
print('Latest version from Gajim download page: ' + latest_version)

# Get last committed chocolatey version from nuspec
nupkg_version = choco.get_version_from_nupgk(NUSPEC_FILE)
print('Chocolatey Version: ' + nupkg_version)

if Version(latest_version) > Version(nupkg_version):
    # Find download urls
    download_url = re.findall(r'https:\/\/gajim\.org\/downloads\/\d*\.\d*\/Gajim-\d*\.\d*\.\d*-64bit?-?\d*\.exe', data)[0]
    print('Download URL 64 bit: ' + download_url)
    choco.update_package(PATH, NUSPEC_FILE, PS1_FILE, latest_version, download_url)
    sys.exit()
else:
    print('No update available')
    sys.exit()
