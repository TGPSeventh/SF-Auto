*** Settings ***
Resource                ../resources/core.robot

Force Tags              test_sf_automation

Suite Setup             Run Keywords
...                     Go to login Page
...                     Announce Test Launch

Suite Teardown          Run Keywords
...                     End Announcement
...                     Send Test Report


