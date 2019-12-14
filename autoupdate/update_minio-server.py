from bs4 import BeautifulSoup
import re
import requests
import json
import sys
import choco
from distutils.version import LooseVersion

PATH = '.\\minio-server'
NUSPEC_FILE = PATH + '\\minio-server.nuspec'
PS1_FILE = PATH + '\\tools\\chocolateyinstall.ps1'
DOWNLOAD_URL = 'https://dl.min.io/server/minio/release/windows-amd64/minio.exe'

print('Searching for minio-server update')

# Get latest version information an download url from HTML
url = 'https://dl.min.io/server/minio/release/windows-amd64/'
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

if LooseVersion(latest_version) > LooseVersion(nupkg_version):
    choco.update_package(PATH, NUSPEC_FILE, PS1_FILE, latest_version, DOWNLOAD_URL, '')
    sys.exit(1)
else:
    print('No update available')
    sys.exit(0)
