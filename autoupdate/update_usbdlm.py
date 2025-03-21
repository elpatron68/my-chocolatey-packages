import re
import requests
import json
import sys
import choco
from packaging.version import Version

PATH = '.\\usbdlm'
NUSPEC_FILE = PATH + '\\usbdlm.nuspec'
PS1_FILE = PATH + '\\tools\\chocolateyinstall.ps1'

print('Searching for usbdlm update')

# Get latest version information and download url from HTML
url = 'https://www.uwe-sieber.de/usbdlm_e.html'
data = requests.get(url).text
# suburl = re.findall(r'Download latest release V\d*\.\d*\.\d*', data)[0]
latest_version = re.findall(r'USBDLM V\d*\.\d*\.\d*', data)[0].split('V')[1]
print('Latest version from usbdlm download page: ' + latest_version)

# Get last committed chocolatey version from nuspec
nupkg_version = choco.get_version_from_nupgk(NUSPEC_FILE)
print('Chocolatey Version: ' + nupkg_version)

if Version(latest_version) > Version(nupkg_version):
    download_url = 'https://www.uwe-sieber.de/files/usbdlm_x64.msi'
    choco.update_package(PATH, NUSPEC_FILE, PS1_FILE, latest_version, download_url)
    sys.exit()
else:
    print('No update available')
    sys.exit()
