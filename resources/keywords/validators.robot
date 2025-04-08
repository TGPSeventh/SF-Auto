*** Settings ***
Resource                                                             ../core.robot

*** Keywords ***
#======================================================================================================
#================================== VERIFIES LOGIN FUNCTIONALITIES ====================================
#======================================================================================================
Dynamic Login Input
    [Documentation]    Check if login page has error message element is visible and perform actions accordingly.
    [Arguments]    
    ...                                                              ${username}
    ...                                                              ${password}
    ...                                                              ${use_alt_fields}=False
    IF    ${use_alt_fields}
        Log    ✅ Error message is visible. Performing action with Alt Locators...
        Input Text                                                   ${SF.forms.login.when_error_msg.txt_username_error}
        ...                                                          ${username}
        Input Text                                                   ${SF.forms.login.when_error_msg.txt_password_error}
        ...                                                          ${password}
        Click Element                                                ${SF.forms.login.when_error_msg.chk_rememberme_error}
        Click Element                                                ${SF.forms.login.when_error_msg.btn_login_error}
    ELSE
        Log    ❌ Error message is NOT visible. Performing action with Defult Locators...
        Input Text                                                   ${SF.forms.login.txt_username}
        ...                                                          ${username}
        Input Text                                                   ${SF.forms.login.txt_password}
        ...                                                          ${password}
        Click Element                                                ${SF.forms.login.chk_rememberme}
        Click Element                                                ${SF.forms.login.btn_login}
    END

Login
    [Documentation]                                                  Login to Polaris
    [Arguments]                                                      ${username}
        ...                                                          ${password}
        ...                                                          ${valid_username}=${False}
        ...                                                          ${valid_password}=${False}
    ${username_empty}                                                Run Keyword And Return Status
        ...                                                          Should Be Empty
        ...                                                          ${username}
    ${password_empty}                                                Run Keyword And Return Status
        ...                                                          Should Be Empty
        ...                                                          ${password}
    ${error_visible}=                                                Run Keyword And Return Status    
    ...                                                              Element Should Be Visible    ${SF.forms.login.lbl_login_error}
    Dynamic Login Input    
    ...                                                              ${username}
    ...                                                              ${password}
    ...                                                              ${error_visible}

    # Validation section
    IF    ${username_empty} or ${password_empty}
        Element Should Be Visible    ${SF.forms.login.lbl_login_error}
    ELSE IF    ${valid_username} and ${valid_password}
        Wait Until Element Is Visible    ${SF.forms.home.env_id}
    ELSE
        Wait Until Element Is Visible    ${SF.forms.login.lbl_login_error}
        Element Should Be Visible        ${SF.forms.login.lbl_login_error}
    END

Log in with ${username} username and ${password} password
    [Documentation]                                                  Login to SFPolaris with username and password
    ${username_status}                                               Set Variable
        ...                                                          ${False}
    ${password_status}                                               Set Variable
        ...                                                          ${False}
    IF    '${username}' == 'invalid'
        ${username}                                                  ${app.user.sf_inv_email}
    ELSE IF    '${username}' == 'valid'
        ${username}                                                  Set Variable
        ...                                                          ${app.user.sf_email}
        ${username_status}                                           Set Variable
        ...                                                          ${True}
    END 

    IF    '${password}' == 'empty'
        ${password}                                                  Set Variable
            ...                                                      ${EMPTY}
    ELSE IF    '${password}' == 'invalid'
        ${password}                                                  ${app.user.sf_inv_pw}
    ELSE IF    '${password}' == 'valid'
        ${password}                                                  Set Variable
            ...                                                      ${app.user.sf_password}
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
