import re
import requests
import choco
from packaging.version import Version

PATH = '.\\netradio'
NUSPEC_FILE = PATH + '\\netradio.nuspec'
PS1_FILE = PATH + '\\tools\\chocolateyinstall.ps1'

print('Searching for Netradio update')

# Get latest version information an download url from HTML
url = 'https://www.ophthalmostar.de/freeware/'
data = requests.get(url).text

download_url = 'https://www.ophthalmostar.de/NetRadioSetup.exe'

version_line = re.findall(r'class="sdm_download_version_value">\d\.\d\.\d<\/span><\/div><div class="sdm_download_date">', data)[0]
latest_version = re.findall(r'\d\.\d\.\d', version_line)[0]
print('Latest version from download page: ' + latest_version)

# Get last committed chocolatey version from nuspec
nupkg_version = choco.get_version_from_nupgk(NUSPEC_FILE)
print('Chocolatey Version: ' + nupkg_version)

if Version(latest_version) > Version(nupkg_version):
    print('Download URL: ' + download_url)
    choco.update_package(PATH, NUSPEC_FILE, PS1_FILE, latest_version, '', download_url)

else:
    print('No update available')
