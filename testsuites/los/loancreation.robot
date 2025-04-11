*** Settings ***
Resource                                                ../../resources/core.robot

Force Tags                                                 Login
Suite Setup                                                Run Keywords
    ...                                                    Initialize Upfront GS Sheet
    ...                                                    Setup Suite Test

Suite Teardown                                             Run Keywords
    ...                                                    Per Test Scenario Teardown
    ...                                                    Append Suite Report

Test Setup                                                 Update Announcement
    ...                                                    ${TEST_NAME}
Test Teardown                                              Verify_Test_Teardown

*** Keywords ***
Initialize Upfront GS Sheet
    [Documentation]                                        Initialize the Google Sheet for Upfront
    Initialize Upfront Sheet
    Initiate Upfront Report Variable                       8

*** Test Cases ***


