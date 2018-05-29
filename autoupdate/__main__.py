# Chocolately package updater
#
# - Gets most recent version information and URL from download site
"""
Author: Markus Busche (Twitter @elpatron_kiel, GitLab @m-busche, Github @elpatron68)
License: MIT https://opensource.org/licenses/MIT, see LICENSE
"""

import sys
import urllib
import re
import logging
from configparser import ConfigParser

LOG = None
CONFIGFILE = 'chocoupdate.ini'

def setup_custom_logger(name):
    """
    Set up custom logging
    """
    config = ConfigParser()
    config.read(CONFIGFILE)
    settings = dict(config.items('logging'))
    loglevel = logging.getLevelName(settings['level'])

    formatter = logging.Formatter(fmt='%(asctime)s %(levelname)-8s %(message)s',
                                  datefmt='%Y-%m-%d %H:%M:%S')
    handler = logging.FileHandler(name + '.log', mode='w')
    handler.setFormatter(formatter)
    screen_handler = logging.StreamHandler(stream=sys.stdout)
    screen_handler.setFormatter(formatter)
    logger = logging.getLogger(name)
    logger.setLevel(loglevel)
    logger.addHandler(handler)
    logger.addHandler(screen_handler)
    return logger


def getdownload(url, expression):
    expression = r'https:\/\/www\.lancom-systems\.de\/fileadmin\/download\/LANtools\/LANmonitor-\d{1,3}\.\d{1,3}\.\d{1,4}'
    url = 'https://www.lancom-systems.de/downloads/'
    pattern = re.compile(expression)
    htmlfile = urllib.request.urlopen(url)
    htmltext = htmlfile.read()
    titles = re.findall(pattern,htmltext)
    print(titles)


if __name__ == "__main__":
    LOG = setup_custom_logger('chocoupdate')
    LOG.info('Starting chocoupdate')
    getdownload('', '')