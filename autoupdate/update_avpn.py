import re
import requests
import choco
from packaging.version import Version

PATH = '.\\LANCOM-VPN-Client'
NUSPEC_FILE = PATH + '\\lancom-vpn-client.nuspec'
PS1_FILE = PATH + '\\tools\\chocolateyinstall.ps1'

print('Searching for LANCOM VPN Client update')

# Get latest version information an download url from HTML
url = 'https://www.lancom-systems.de/downloads/'
data = requests.get(url).text
# https://my.lancom-systems.de/download/LC-VPN-Client/LC-Advanced-VPN-Client-Win-622-Rel-x86-64.exe
suburl = re.findall(r'LC-Advanced-VPN-Client-Win-\d{3,4}-Rel-x86-64.exe', data)[0]
download_url = 'https://my.lancom-systems.de/download/LC-VPN-Client/' + suburl

latest_version = re.findall(r'\d{3,4}', suburl)[0]
latest_version = latest_version[0] + '.' + latest_version[1:]
print('Latest version from LANCOM download page: ' + latest_version)

# Get last committed chocolatey version from nuspec
nupkg_version = choco.get_version_from_nupgk(NUSPEC_FILE)
print('Chocolatey Version: ' + nupkg_version)

if Version(latest_version) > Version(nupkg_version):
    print('Download URL: ' + download_url)
    choco.update_package(PATH, NUSPEC_FILE, PS1_FILE, latest_version, '', download_url)

else:
    print('No update available')
