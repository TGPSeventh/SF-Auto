*** Settings ***
Resource                                                             ../core.robot

*** Keywords ***
# Previous method for login
Login
    [Documentation]                                                  Login to Polaris
    [Arguments]                                                      ${username}
        ...                                                          ${password}
        ...                                                          ${valid_username}=${False}
        ...                                                          ${valid_password}=${False}
    Wait Until Element Is Visible                                    ${SF.forms.login.sf_logo}
    ${username_empty}                                                Run Keyword And Return Status
        ...                                                          Should Be Empty
        ...                                                          ${username}
    ${password_empty}                                                Run Keyword And Return Status
        ...                                                          Should Be Empty
        ...                                                          ${password}
    Input Text                                                       ${SF.forms.login.txt_username}
        ...                                                          ${username}
    Input Password                                                   ${SF.forms.login.txt_password}    
        ...                                                          ${password}
    Click Element                                                    ${SF.forms.login.btn_login}
    IF    ${username_empty}
        Element Should Be Visible                                    ${SF.forms.login.lbl_login_error}
    END
    IF    ${password_empty}
        Element Should Be Visible                                    ${SF.forms.login.lbl_login_error}
    END
    IF    not ${username_empty} and not ${password_empty}
        IF    ${valid_username} and ${valid_password}
            Wait Until Elements Is Visible                           ${SF.forms.home.env_id}
        ELSE
            Wait Until Elements Is Visible                           ${SF.forms.login.lbl_login_error}     
            Element Should Be Visible                                ${SF.forms.login.lbl_login_error} 
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
