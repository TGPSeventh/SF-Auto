*** Settings ***
Resource                                                             ../core.robot

*** Keywords ***
#======================================================================================================
#================================== VERIFIES LOGIN FUNCTIONALITIES ====================================
#======================================================================================================
Login
    [Documentation]                                                  Login to Polaris
    [Arguments]                                                      ${username}
        ...                                                          ${password}
        ...                                                          ${valid_username}=${False}
        ...                                                          ${valid_password}=${False}
    Wait Until Element Is Visible                                    ${SShop.forms.login.login_page_validation}
    ${username_empty}                                                Run Keyword And Return Status
        ...                                                          Should Be Empty
        ...                                                          ${username}
    ${password_empty}                                                Run Keyword And Return Status
        ...                                                          Should Be Empty
        ...                                                          ${password}
    Input Text                                                       ${SShop.forms.login.username}
        ...                                                          ${username}
    Input Password                                                   ${SShop.forms.login..password}    
        ...                                                          ${password}
    Click Element                                                    ${SShop.forms.login.btnlogin}
    IF    ${username_empty}
        Element Should Be Visible                                    ${SShop.forms.login.invalid_username}
    END
    IF    ${password_empty}
        Element Should Be Visible                                    ${SShop.forms.login.invalid_password}
    END
    IF    not ${username_empty} and not ${password_empty}
        IF    ${valid_username} and ${valid_password}
            Wait Until Element Is Visible                            ${SShop.home.env_uat_id}
        ELSE
            Wait Until Element Is Visible                            ${SShop.forms.login.invalid_username}     
            Element Should Be Visible                                ${SShop.forms.login.invalid_username} 
        END
    END

Log in with ${username} username and ${password} password
    [Documentation]                                                  Login to SFPolaris with username and password
    ${username_status}                                               Set Variable
        ...                                                          ${False}
    ${password_status}                                               Set Variable
        ...                                                          ${False}
    IF    '${username}' == 'empty'
        ${username}                                                  Set Variable
        ...                                                          ${EMPTY}
    ELSE IF    '${username}' == 'invalid'
        ${username}                                                  FakerLibrary.User Name
    ELSE IF    '${username}' == 'valid'
        ${username}                                                  Set Variable
        ...                                                          ${app.user.loginid}
        ${username_status}                                           Set Variable
        ...                                                          ${True}
    END 

    IF    '${password}' == 'empty'
        ${password}                                                  Set Variable
            ...                                                      ${EMPTY}
    ELSE IF    '${password}' == 'invalid'
        ${password}                                                  FakerLibrary.Password
    ELSE IF    '${password}' == 'valid'
        ${password}                                                  Set Variable
            ...                                                      ${app.user.password}
        ${password_status}                                           Set Variable
            ...                                                      ${True}
    END
    Reload Page
    Login                                                            ${username}
        ...                                                          ${password}
        ...                                                          valid_username=${username_status} 
        ...                                                          valid_password=${password_status}

Input Element Values
    [Documentation]                                                  Inputs Multiple Text String
    [Arguments]                                                      ${locator1}
        ...                                                          ${locator2}
        ...                                                          ${locator3}
    
    ${value}                                                         FakerLibrary.Name
    ${value2}                                                        FakerLibrary.User Name
    ${value3}                                                        FakerLibrary.Password

    Input Text                                                       ${locator1}
        ...                                                          ${value}
    Input Text                                                       ${locator2}
        ...                                                          ${value2}
    Input Text                                                       ${locator3}
        ...                                                          ${value3}

Search User List
    [Documentation]                                                  Inputs Multiple Text String
    [Arguments]                                                      ${locator1}
    
    ${value}                                                         FakerLibrary.Name

    Input Text                                                       ${locator1}
        ...                                                          ${value}
