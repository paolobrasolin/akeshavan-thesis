#!/usr/bin/env python3
# coding: utf-8

import os
import sys
import time

from selenium import webdriver
from selenium.common.exceptions import TimeoutException


PROFILE = webdriver.FirefoxProfile()

# Disable images, css and subdocs but not JS.
PROFILE.set_preference("permissions.default.image", 2)
# PROFILE.set_preference("permissions.default.script", 2)
PROFILE.set_preference("permissions.default.stylesheet", 2)
PROFILE.set_preference("permissions.default.subdocument", 2)

# Prevent download dialog.
PROFILE.set_preference('browser.download.folderList', 2) # custom location
PROFILE.set_preference('browser.download.manager.showWhenStarting', False)
PROFILE.set_preference('browser.download.dir', os.path.dirname(os.path.abspath(sys.argv[0])))
PROFILE.set_preference('browser.helperApps.neverAsk.saveToDisk', 'application/zip')

BROWSER = webdriver.Firefox(PROFILE)

BROWSER.get('https://www.authorea.com/signin')

LOGIN_MAIL = 'etealfux@sharklasers.com'
LOGIN_PASS = os.environ['AUTHOREA_PASS'] # 'whateverworks'

USER_ID = 148328

DOCS = [
    {'id': 160890, 'basename': 'fst-doc'},
    {'id': 160891, 'basename': 'snd-doc'},
]

def doc_url(doc_id):
    return"https://www.authorea.com/users/{0}/articles/{1}/download_zip".format(USER_ID, doc_id)

# Log in.
BROWSER.find_element_by_id("email").send_keys(LOGIN_MAIL)
BROWSER.find_element_by_id("password").send_keys(LOGIN_PASS)
BROWSER.find_element_by_name("commit").click()

# Ensure we're logged in.
BROWSER.implicitly_wait(20) # 20 seconds
BROWSER.find_element_by_css_selector("a[href='/signout']")
BROWSER.implicitly_wait(0) # default behaviour

# Breathe.
time.sleep(2)

# We give it three secs to get the dowload started, then we pass.
# Why? Download links give no response.
BROWSER.set_page_load_timeout(3)

for doc in DOCS:
    file_path = os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), doc['basename']+'.zip')
    os.remove(file_path) if os.path.exists(file_path) else None
    print("Downloading doc {0} named {1}".format(doc['id'], doc['basename']))
    print("       from url {0}".format(doc_url(doc['id'])))
    try:
        BROWSER.get(doc_url(doc['id']))
    except TimeoutException:
        pass
    # We're not being extra careful. This might cause infinite polling loops
    # in case of legit timeout exceptions or wrong/unauthorized ids.
    while not os.path.exists(file_path):
        time.sleep(1)
    print("... done!")

# Relax.
BROWSER.quit()

