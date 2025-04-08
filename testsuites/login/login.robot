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
Valid username and invalid password
    [Documentation]                                        User should not be able to login with valid username and a invalid password
    [Tags]                                                 Login-01
    @{keyword_dict}                                        Create List
        ...                                                Log in with valid username and invalid password
    Set Result Message                                     ${keyword_dict}
        ...                                                The error handler showed, "Please check your username and password.", prevented the login attempt.
        ...                                                The error handler did not showed or allowed a successful login attempt.
Valid username and empty password
    [Documentation]                                        User should not be able to login with valid username and a empty password
    [Tags]                                                 Login-02
    @{keyword_dict}                                        Create List
        ...                                                Log in with valid username and empty password
    Set Result Message                                     ${keyword_dict}
        ...                                                The error handler showed, "Please enter your password.", prevented the login attempt.
        ...                                                The error handler did not showed or allowed a successful login attempt.

Invalid username and valid password
    [Documentation]                                        User should not be able to login with valid username and a invalid password
    [Tags]                                                 Login-03
    @{keyword_dict}                                        Create List
        ...                                                Log in with invalid username and valid password
    Set Result Message                                     ${keyword_dict}
        ...                                                The error handler showed, "Please check your username and password.", prevented the login attempt.
        ...                                                The error handler did not showed or allowed a successful login attempt.

Invalid username and empty password
    [Documentation]                                        User should not be able to login with valid username and a empty password
    [Tags]                                                 Login-04
    @{keyword_dict}                                        Create List
        ...                                                Log in with invalid username and empty password
    Set Result Message                                     ${keyword_dict}
        ...                                                The error handler showed, "Please enter your password.", prevented the login attempt.
        ...                                                The error handler did not showed or allowed a successful login attempt.

Invalid username and invalid password
    [Documentation]                                        User should not be able to login with invalid username and a invalid password
    [Tags]                                                 Login-05
    @{keyword_dict}                                        Create List
        ...                                                Log in with invalid username and invalid password
    Set Result Message                                     ${keyword_dict}
        ...                                                The error handler showed, "Please check your username and password.", prevented the login attempt.
        ...                                                The error handler did not showed or allowed a successful login attempt.

Valid username and Valid password
    [Documentation]                                        User should be able to login with valid username and a valid password
    [Tags]                                                 Login-06
    @{keyword_dict}                                        Create List
        ...                                                Log in with valid username and valid password
    Set Result Message                                     ${keyword_dict}
        ...                                                The user was able to successfully log in and redirected to dashboard.
        ...                                                The user encountered an error and login attempt failed.
