*** Settings ***
Resource                                                   ../core.robot

*** Keywords ***

Navigate to Login
     [Documentation]                                        Go to Tickets Navigation Panel
     Mouse over                                             ${SShop.forms.login_btnlnk}
     Click Element                                          ${SShop.forms.login_btnlnk}
     Wait Until Element Is Visible                          ${SShop.forms.login_page_validation}

# Go to Admin List ${value}
#     [Documentation]                                        Go to Admin List Page
#     Mouse Over                                             ${Upfront.navigation.adminUserPanel}

#     IF    '${value}' == "User"
#         Mouse Over                                         ${Upfront.navigation.adminList}
#         Click Element                                      ${Upfront.navigation.adminUser}
#         Wait Until Element Is Visible                      ${Upfront.pages.total}
#     ELSE IF    '${value}' == "Roles"
#         Mouse Over                                         ${Upfront.navigation.adminRoles}
#         Click Element                                      ${Upfront.navigation.adminRolesPage}
#         Wait Until Element Is Visible                      ${Upfront.navigation.adminRolesText}
#     END

# Go to Driver ${value}
#     [Documentation]                                        Go to Admin List Page 
#     Mouse Over                                             ${Upfront.navigation.drivers}

#     IF    '${value}' == "List"
#        Mouse Over                                          ${Upfront.navigation.driverList}
#        Click Element                                       ${Upfront.navigation.driverListPage}
#     ELSE IF    '${value}' == "Balance"
#         Mouse Over                                         ${Upfront.navigation.driverBalance}
#         Click Element                                      ${Upfront.navigation.driverBalancePage}
#     ELSE IF    '${value}' == "Location"
#         Mouse Over                                         ${Upfront.navigation.driverLocation}
#         Click Element                                      ${Upfront.navigation.driverLocPage}
#     ELSE IF    '${value}' == "Application"
#         Mouse Over                                         ${Upfront.navigation.driverApplication}
#         Click Element                                      ${Upfront.navigation.driverAppPage}
#     END

#     Wait Until Element Is Visible                          ${Upfront.navigation.driverText}

# Go to User ${value}
#     [Documentation]                                        Go to User Navigation Panel 
#     Mouse Over                                             ${Upfront.navigation.users}

#     IF    '${value}' == "List"
#         Wait Until Element Is Visible                      ${Upfront.navigation.userList}
#         Mouse Over                                         ${Upfront.navigation.userList}
#         Wait Until Element Is Visible                                      ${Upfront.navigation.userListPage}
#         Click Element                                      ${Upfront.navigation.userListPage}
#     ELSE IF    '${value}' == "Balance"
#         Wait Until Element Is Visible                      ${Upfront.navigation.userBalance}
#         Mouse Over                                         ${Upfront.navigation.userBalance}
#         Wait Until Element Is Visible                      ${Upfront.navigation.userBalPage}
#         Click Element                                      ${Upfront.navigation.userBalPage}
#     END

#     Wait Until Element Is Visible                          ${Upfront.navigation.driverText}

# Go to Deliveries List
#     [Documentation]                                        Go to Deliveries Navigation Panel
#     Wait Until Element Is Visible                          ${Upfront.navigation.deliveries}
#     Mouse Over                                             ${Upfront.navigation.deliveries}
#     Wait Until Element Is Visible                          ${Upfront.navigation.deliveriesList}
#     Mouse Over                                             ${Upfront.navigation.deliveriesList}
#     Wait Until Element Is Visible                          ${Upfront.navigation.deliveriesPage}
#     Click Element                                          ${Upfront.navigation.deliveriesPage}
#     Wait Until Element Is Visible                          ${Upfront.navigation.driverText}

# Go to Ticket List
#     [Documentation]                                        Go to Tickets Navigation Panel
#     Mouse over                                             ${Upfront.navigation.tickets}
#     Click Element                                          ${Upfront.navigation.tickets}
#     Wait Until Element Is Visible                          ${Upfront.navigation.driverText}

# Go to Settings ${value}
#     [Documentation]                                        Go to Settings Navigation Panel
#     Mouse over                                             ${Upfront.navigation.setting}

#     IF    '${value}' == "Config"
#         Mouse over                                         ${Upfront.navigation.settingconfig}
#         Click Element                                      ${Upfront.navigation.settingconfig}
#     ELSE IF     '${value}' == "Topup"
#         Mouse over                                         ${Upfront.navigation.settingtopup}
#         Click Element                                      ${Upfront.navigation.settingtopup}
#     ELSE IF     '${value}' == "Type & Category"
#         Mouse over                                         ${Upfront.navigation.settingtypecategory}
#         Click Element                                      ${Upfront.navigation.settingtypecategory}
#     ELSE IF     '${value}' == "Vehicles"
#         Mouse over                                         ${Upfront.navigation.settingvehicles}
#         Click Element                                      ${Upfront.navigation.settingvehicles}
#     END

#     Wait Until Element Is Visible                          ${Upfront.navigation.driverText}

# Admin list add new user
#     [Documentation]                                        Adds a user with valid inputs
#     Click Element                                          ${AdminList.addUser}
#     Wait Until Element Is Visible                          ${AdminList.modal}
#     Input Element Values                                   ${AdminList.name}
#         ...                                                ${AdminList.username}
#         ...                                                ${AdminList.password}
#     Click Element                                          ${AdminList.accounType}
#     Wait Until Element Is Visible                          ${AdminList.dropwindow}
#     Select one from dropdown
#     Wait Until Element Is Not Visible                      ${AdminList.modal}

# Select one from dropdown
#     [Documentation]                                        Counts Elements from dropdown Window
#     ${elements}                                            Get WebElements
#         ...                                                ${AdminList.typeDropdown}

#     ${length}                                              Get Length
#         ...                                                ${elements}
    
#     ${random_index}                                        Evaluate
#         ...                                                random.randint(0, ${length}-1)

#     ${random_element}                                      Get From List
#         ...                                                ${elements}
#         ...                                                ${random_index}

#     Click Element                                          ${random_element}
#     Wait Until Element Is Not Visible                      ${AdminList.dropwindow}
#     Click Element                                          ${AdminList.OKButton}

# Filter Account list With Arguments
#     [Documentation]                                        Adds a user with valid inputs
#     [Arguments]                                            ${filters}
#     @{current}                                            Create List
#         FOR  ${Filter}  IN  @{filters}
#             Wait Until Page Contains Element               ${Upfront.accountList.${filter}}
#             Input Text                                     ${Upfront.accountList.${filter}}           ${Upfront.data.${Filter}}
#             Sleep                                          1s
#             FOR    ${item}    IN    @{current}
#                 Clear Element Text                         ${item}
#             END
#             Append To List                                 ${current}                                ${Upfront.accountList.${Filter}}
#             Sleep                                          1s
#             Clear Element Text                             ${Upfront.accountList.${filter}}
#         END

# ${update} Update Balance
#     [Documentation]                                        Update App Balance; to do so make use of "Add" and "Deduct"
#     Wait Until Element Is Visible                          ${updateBalance.dropdown}
#     Click Element                                          ${updateBalance.dropdown}
#     Input Text                                             ${updateBalance.searchableTextField}    ${Upfront.data.numberFilter}
#     Wait Until Element Is Visible                          ${updateBalance.dropdownItem}
#     Click Element                                          ${updateBalance.dropdownItem}
#     Input Text                                             ${updateBalance.amount}              9
#     IF    '${update}' == 'Add'
#         Click Element                                      ${updateBalance.addCheckbox}
#     ELSE
#         Click Element                                      ${updateBalance.deductCheckbox}
#     END
#     Input Text                                             ${updateBalance.remarks}             Test
#     Click Element                                          ${updateBalance.updateButton}
#     # Sleep                                                  0.5s
#     Wait Until Element Is Visible                          ${Upfront.credentials.error_popup}
#     Capture Page Screenshot

# Add Admin
# # reden was here
#     ${name}                                                Fakerlibrary.Name
#     @{checkbox_list}                                       Create List
#         ...                                                dashboard
#         ...                                                add_balance
#         ...                                                add_bouser
#         ...                                                user_list
#         ...                                                driver_list
#         ...                                                driver_location
#         ...                                                online_application
#         ...                                                delivery_list
#         ...                                                ticket
#         ...                                                config
#         ...                                                topup_items
#         ...                                                ticket_types_and_categories
#         ...                                                vehicles
#     Wait Until Element Is Visible                          ${Upfront.adminRoles.AddAdmin}
#     Click Element                                          ${Upfront.adminRoles.AddAdmin}
#     Input Text                                             ${Upfront.adminRoles.modal.name}    ${name}
#     FOR    ${counter}    IN RANGE     5
#        ${check}                      Evaluate                                     random.choice(${checkbox_list})
#         ...                          modules=random
#         Select Checkbox              name:${check}
#         Remove Values From List      ${checkbox_list}                        ${check}
#     END
#     Click Element                                          ${Upfront.adminRoles.modal.save}
#     Wait Until Element Is Visible                            ${Upfront.credentials.error_popup}
#     Element Should Be Visible                                ${Upfront.credentials.error_popup}
#     # Click Element                    ${Upfront.adminRoles.modal.cancel}

# Global Keywords
Set Result Message
    [Arguments]                                            ${Keywords}
        ...                                                ${PassMsg}
        ...                                                ${FailedMsg}

    FOR    ${Keyword}    IN    @{Keywords}
        ${cond}=    Run Keyword And Return Status    ${Keyword}
        IF    ${cond}
            Set Test Message    ${PassMsg}
        ELSE
            Fail    ${FailedMsg}
        END
    END