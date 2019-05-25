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
url = 'https://gajim.org/downloads.php?lang=en'
data = requests.get(url).text
suburl = re.findall(r'Latest\s*version\s*of\s*Gajim\s*is\s*<strong>\d*\.\d*\.\d*<\/strong>', data)[0]
latest_version = re.findall(r'\d*\.\d*\.\d*', suburl)[0]
print('Latest version from Gajim download page: ' + latest_version)

# Get last committed chocolatey version from nuspec
nupkg_version = choco.get_version_from_nupgk(NUSPEC_FILE)
print('Chocolatey Version: ' + nupkg_version)

if StrictVersion(latest_version) > StrictVersion(nupkg_version):
    # Find download urls
    suburl64 = re.findall(r'downloads\/\d\.\d\/gajim-\d*\.\d*\.\d*-64bits.*\.exe', data)
    download_url64 = 'https://gajim.org/' + suburl64
    print('Download URL 64 bit: ' + download_url64)
    suburl32 = re.findall(r'downloads\/\d\.\d\/gajim-\d*\.\d*\.\d*-32bits.*\.exe', data)
    download_url32 = 'https://gajim.org/' + suburl32
    print('Download URL 32 bit: ' + download_url32)
    choco.update_package(PATH, NUSPEC_FILE, PS1_FILE, latest_version, download_url64, download_url32)
    sys.exit(1)
else:
    print('No update available')
    sys.exit(0)
