import re
import sys
import urllib.error
import urllib.request

import requests
from packaging.version import Version

import choco

PATH = '.\\gajim'
NUSPEC_FILE = PATH + '\\gajim.nuspec'
PS1_FILE = PATH + '\\tools\\chocolateyinstall.ps1'

print('Searching for Gajim update')

url = 'https://gajim.org/download/'
try:
    data = requests.get(url, timeout=60).text
except requests.RequestException as exc:
    print(f'ERROR: Could not fetch Gajim download page: {exc}')
    sys.exit(2)

# Prefer the Windows setup link; fall back to first semver on the page.
setup_matches = re.findall(
    r'https://gajim\.org/downloads/(\d+\.\d+)/Gajim-(\d+\.\d+\.\d+)-64bit\.exe',
    data,
)
if setup_matches:
    latest_version = setup_matches[0][1]
    download_url = (
        f'https://gajim.org/downloads/{setup_matches[0][0]}/'
        f'Gajim-{latest_version}-64bit.exe'
    )
else:
    versions = re.findall(r'\d+\.\d+\.\d+', data)
    if not versions:
        print('ERROR: Could not determine latest Gajim version from download page')
        sys.exit(2)
    latest_version = versions[0]
    minor = '.'.join(latest_version.split('.')[:2])
    download_url = (
        f'https://gajim.org/downloads/{minor}/Gajim-{latest_version}-64bit.exe'
    )

print('Latest version from Gajim download page: ' + latest_version)
print('Download URL 64 bit: ' + download_url)

nupkg_version = choco.get_version_from_nupgk(NUSPEC_FILE)
print('Chocolatey Version: ' + nupkg_version)

if Version(latest_version) <= Version(nupkg_version):
    print('No update available')
    sys.exit(0)

# Verify the installer is reachable before downloading/pushing.
try:
    request = urllib.request.Request(download_url, method='HEAD')
    with urllib.request.urlopen(request, timeout=60) as response:
        status = getattr(response, 'status', 200)
        if status >= 400:
            raise urllib.error.HTTPError(
                download_url, status, 'HEAD failed', response.headers, None
            )
        print(f'Download URL reachable (HTTP {status})')
except Exception as exc:
    print(f'ERROR: Download URL not reachable, aborting update: {exc}')
    sys.exit(2)

release_notes = (
    f'Gajim {latest_version}\n\n'
    f'See https://gajim.org/ for release details.\n'
    f'Download: {download_url}'
)
# Try to pull a short summary from the latest matching release post.
try:
    posts = requests.get('https://gajim.org/posts/', timeout=30).text
    post_links = re.findall(
        rf'href="(https://gajim\.org/posts/[^"]*{re.escape(latest_version)}[^"]*)"',
        posts,
    )
    if not post_links:
        post_links = re.findall(
            rf'href="(/posts/[^"]*{re.escape(latest_version)}[^"]*)"',
            posts,
        )
        post_links = ['https://gajim.org' + p for p in post_links]
    if post_links:
        post_url = post_links[0]
        post_html = requests.get(post_url, timeout=30).text
        # First paragraph after the title as a short summary.
        paragraphs = re.findall(r'<p>(.*?)</p>', post_html, flags=re.DOTALL)
        if paragraphs:
            summary = re.sub(r'<[^>]+>', '', paragraphs[0])
            summary = re.sub(r'\s+', ' ', summary).strip()
            release_notes = (
                f'Gajim {latest_version}\n\n{summary}\n\n{post_url}'
            )
except Exception as exc:
    print(f'Warning: Could not fetch release notes ({exc}), using fallback text')

choco.update_nuspec_release_notes(NUSPEC_FILE, release_notes)
choco.update_package(PATH, NUSPEC_FILE, PS1_FILE, latest_version, '', download_url)
