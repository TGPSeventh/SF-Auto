*** Settings ***
Resource                ../resources/core.robot

Force Tags              test_automation

Suite Setup             Run Keywords
...                     Go to Site Home Page
...                     Announce Test Launch

Suite Teardown          Run Keywords
...                     End Announcement
...                     Send Test Report
