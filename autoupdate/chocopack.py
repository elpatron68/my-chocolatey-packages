# packacke class

class chocopack:
    vendorUrl = ''
    downloadPattern = ''
    versionPattern = ''
    releasnotesPattern = ''

    def dump(self):
        return ('Vendor-URL: ' + chocopack.vendorUrl + '\n' +
                'Download-Pattern: ' + chocopack.downloadPattern + '\n' +
                'Version-Pattern: ' + chocopack.versionPattern + '\n' +
                'Release notes-Pattern: ' + chocopack.releasnotesPattern)
                