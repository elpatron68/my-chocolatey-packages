from bs4 import BeautifulSoup
import re
import requests
import json
import choco
from distutils.version import StrictVersion

PATH = '.\\minio-client'
NUSPEC_FILE = PATH + '\\minio-client.nuspec'
PS1_FILE = PATH + '\\tools\\chocolateyinstall.ps1'
DOWNLOAD_URL = 'https://dl.minio.io/client/mc/release/windows-amd64/mc.exe'

print('Searching for minio-client update')

# Get latest version information an download url from HTML
url = 'https://dl.minio.io/client/mc/release/windows-amd64/'
data = requests.get(url).text
soup = BeautifulSoup(data, 'lxml')
table = soup.find_all('table')[0] 
latest_version = ''
for row in table.find_all('tr'):
    if latest_version != '':
        break
    columns = row.find_all('td')
    for column in columns:
        val = column.get_text()
        if len(val) == 16:
            latest_version = val[:10].replace('-', '.')
            break

print('Latest version from minio download page: ' + latest_version)

# Get last committed chocolatey version from nuspec
nupkg_version = choco.get_version_from_nupgk(NUSPEC_FILE)
print('Chocolatey Version: ' + nupkg_version)

if StrictVersion(latest_version) > StrictVersion(nupkg_version):
    choco.update_package(PATH, NUSPEC_FILE, PS1_FILE, latest_version, DOWNLOAD_URL, '')
else:
    print('No update available')
