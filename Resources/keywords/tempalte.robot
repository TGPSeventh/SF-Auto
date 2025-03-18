*** Settings ***
Resource                                                               ../core.robot

*** Keywords ***
Elements Should Be Visible
	[Documentation]                                                     Check if elements exists on the screen
	[Arguments]                                                         @{elements}
	FOR    ${element}    IN                                             @{elements}                               
        Element Should Be Visible                                       ${element}                                                 
	END

Go to ${Site} Page
    [Documentation]                                                    Opens Upfront Page
    ${username_status}                                                 Set Variable
    ...                                                                chrome
    Maximize Browser Window

Go to Home
    [Documentation]                                                    Redirect to Dashboard Home Page 
    Go To                                                              ${SShop.weburl}

Use Fake
    [Documentation]                                                     Auto generates fake credentials and inputs
    [Arguments]                                                         ${credentials/inputs}
    ${fake}                                                             Run Keyword
    ...                                                                 FakerLibrary.${credentials/inputs}
    [Return]                                                            ${fake}

#======================================================================================================
#==================================     Google Sheet Reporting     ====================================
#======================================================================================================
Set gsheet Variable Value
    [Documentation]                                                     Returns the index of the ogtable game.
    [Arguments]                                                         ${gtype}                                     
    ...                                                                 ${keyword_status}
    ...                                                                 ${ctestname}
    IF                                                %{GS_REPORT}
    ${last_period_index}                                                Evaluate
    ...                                                                 "${gtype}".rfind('.')
    ${Scenario}                                                         Get Substring
    ...                                                                 ${gtype}
    ...                                                                 ${last_period_index+1}
    ${Scenario}                                                         Evaluate
    ...                                                                 ((("${Scenario}".replace('/', '')).replace(' ', '').split('-'))[0]).lower()
    ${Case}                                                             Evaluate
    ...                                                                 ((("${ctestname}".replace('/', '')).replace(' ', '').split('-'))[0]).lower()
    ${rstatus}                                                          Evaluate
    ...                                                                 "✅" if "PASS" in "${keyword_status}" else "❌"
    Set List Value                                                      ${__gsheet_report}
    ...                                                                 ${applicationConfig.googleSheets.${Scenario}.${Case}}
    ...                                                                 ${rstatus}
    Set Test Variable                                                   ${__gsheet_report}
    ELSE
        Log                                                             Google Sheet Reporting is Disabled.
    END

Initiate Upfront Report Variable
    [Documentation]                                                     Initiates the __gsheet_report variable.
    [Arguments]                                                         ${length}
    IF                                                %{GS_REPORT}
        ${__gsheet_report}                                              Create List
        FOR        ${iter}                                IN RANGE                                     0            ${length}
            Append To List                                              ${__gsheet_report}                            -
        END
        Set Suite Variable                                              ${__gsheet_report}
        ${start_time}                                                   Get Current Date                             exclude_millis=True
        Set Suite Variable                                              ${start_time}
    END

Per Test Scenario Teardown
    [Documentation]                                                     Per Test Scenario Teardown.
    IF                                                %{GS_REPORT}
        Send Per Test Scenario Report To Google Sheets                  ${SUITE_NAME}
    END

Send Per Test Scenario Report To Google Sheets
    [Documentation]                                                     Sends the current test report to Google Sheets.
    ...                                                                 Requires the table name to be defined.
    ...                                                                 Test variable __gsheets_report must be set
    [Arguments]                                                         ${gtype}
    IF                                                %{GS_REPORT}
        ${last_period_index}                                            Evaluate
        ...                                                             "${gtype}".rfind('.')
        ${Scenario}                                                     Get Substring
        ...                                                             ${gtype}
        ...                                                             ${last_period_index+1}
        Set Test Scenario Run Time Report
        ${rsheetid}                                                     Get Sheet Id By Sheet Name                   ${Scenario}
        Insert Row                                                      2    3                                       ${rsheetid}
        ...                                                             inheritFromBefore=False
        ${wrap}                                                         Create List                                  ${__gsheet_report}
        &{rbody}                                                        Create Dictionary
        ...                                                             values=${wrap}
        ...                                                             majorDimension=ROWS
        Write To Range                                                  ${Scenario}!A3:J                             body=${rbody}
    END
Set Test Scenario Run Time Report
    [Documentation]                                                     Inserts the time excution of the table test run to the __gsheet_report
    ${end_time}                                                         Get Time                                     exclude_millis=True
    ${elapsed}                                                          Subtract Date From Date                      ${end_time}    ${start_time}
    ...                                                                 result_format=verbose                        exclude_millis=True
    ${start_time}                                                       Convert To String                            ${start_time}
    ${end_time}                                                         Convert To String                            ${end_time}
    #${elapsed}                                                         Convert To String                            ${elapsed}
    Set List Value                                                      ${__gsheet_report}                           0
    ...                                                                 ${start_time} - ${end_time.split(" ")}[1]

Verify_Test_Teardown
    [Documentation]                                                     Initialize the Teardown of All Test Cases
    # Set Test Message                                                    ${TEST_STATUS}
    IF    %{GS_REPORT}
        Set gsheet Variable Value                                       ${SUITE_NAME}
        ...                                                             ${TEST_STATUS}
        ...                                                             ${TEST_NAME}
    END
    IF    '${TEST_STATUS}' == 'FAIL'
        ${image}                                                        Capture Page Screenshot
        Send Photo                                                      ${image}                                     ${TEST_MESSAGE}
    END
    Append Test Report

#======================================================================================================
#==================================    Telegram Reporting    ==========================================
#======================================================================================================
Announce Test Launch
    [Documentation]                                                     Announce launch of the test
    ${hostname}                                                         Run                                          hostname
    IF    "%{TG_REPORT}" == "True" or "%{TG_REPORT}" == "Full"
        ${line}                                                         Evaluate                                     "\\= "*25
        Send Telegram Message                                           ${line}
        ${announcement_id}                                              Send Telegram Message
        ...                                                             Starting Upfront Web Automation\\.\\.\\.${\n}${\n}__${hostname}__
        Set Global Variable                                             \${announcement_id}                          ${announcement_id}
    END
    ${The_test_reports}                                                 Create Dictionary
    ${suite_report}                                                     Create Dictionary
    ${start_time}                                                       Get Current Date                             exclude_millis=True
    Set Global Variable                                                 \${The_test_reports}                         ${The_test_reports}
    Set Global Variable                                                 \${suite_report}                             ${suite_report}
    Set Global Variable                                                 \${start_time}                               ${start_time}
    Set Global Variable                                                 \${hostname}                                 ${hostname}

End Announcement
    [Documentation]                                                     Edits Telegram message and state that the test is finished.
    IF    "%{TG_REPORT}" == "True" or "%{TG_REPORT}" == "Full"
        Edit Telegram Message
        ...                                                             Upfront Web Automation Finished Testing${\n}${\n}__${hostname}__
        ...                                                             ${announcement_id}
    END

Update Announcement
    [Documentation]                                                      Update the message to current state of the test.
    [Arguments]                                                          ${curr_test_name}
    IF    "%{TG_REPORT}" == "True" or "%{TG_REPORT}" == "Full"
        Edit Telegram Message
        ...                                                              Start Testing: *${curr_test_name}*${\n}${\n}Starting Upfront Web Automation\\.\\.\\.${\n}${\n}__${hostname}__
        ...                                                              ${announcement_id}
    END

Append Suite Report
    [Documentation]                                                     Set Suite Status for Telegram
    ${last_period_index}                                                Evaluate                                     "${SUITE_NAME}".rfind('.')
    ${Scenario}                                                         Get Substring
    ...                                                                 ${SUITE_NAME}
    ...                                                                 ${last_period_index+1}
    Set To Dictionary                                                   ${suite_report}                               ${Scenario}
    ...                                                                 ${SUITE MESSAGE}
    
Setup Suite Test
    [Documentation]                                                     Set Test Report for each Test Scenario for Telegram
    ${test_report}                                                      Create List
    Set Suite Variable                                                  \${test_report}                              ${test_report}
    
Append Test Report
    [Documentation]                                                     Set Test Status for Telegram
    IF    "${TEST_STATUS}" == "PASS"
        ${passedk}                                                         Set Variable                                 ✅
    ELSE
        ${failed}                                                         Set Variable                                 ❌
    END
    Append To List                                                      ${test_report}                               ${TEST_NAME} : ${mark}*${TEST_STATUS}*
    ${last_period_index}                                                Evaluate                                     "${SUITE_NAME}".rfind('.')
    ${Scenario}                                                         Get Substring                                ${SUITE_NAME}
    ...                                                                 ${last_period_index+1}
    Set To Dictionary                                                   ${The_test_reports}                          ${Scenario}
    ...                                                                 ${test_report}

Send Test Report
    [Documentation]                                                     Send Test Report to Telegram
    IF    "%{TG_REPORT}" == "True" or "%{TG_REPORT}" == "Full"
        ${end_time}                                                    Get Time                                      exclude_millis=True
        ${elapsed}                                                     Subtract Date From Date                       ${end_time}
        ...                                                            ${start_time}
        ...                                                            result_format=verbose                         exclude_millis=True
        ${start_time}                                                  Convert To String                             ${start_time}
        ${end_time}                                                    Convert To String                             ${end_time}
        ${elapsed}                                                     Convert To String                             ${elapsed}
        ${log_output}                                                  Catenate                   
        ...            *--Testing Finished--*${\n}${\n}*-Summary-*${\n}Test Started: ${start_time}${\n}Test Ended: ${end_time}${\n}Time Elapsed: ${elapsed}${\n}${\n}
        ${log_output}                                                  Catenate                                      ${log_output}
        ...                                                            ${SUITE_MESSAGE}\n
        ${keys}                                                        Get Dictionary Keys                           ${The_test_reports}
        IF   "%{TG_REPORT}" == "Full"
            ${log_output}                                              Catenate                                      ${log_output}             
            ...                                                        ${\n}*--Full Report--*${\n}${\n}
            FOR    ${key}    IN    @{keys}
                ${log_output}                                          Catenate                                      ${log_output}
                ...                                                   *${\n}--${key}--${\n}*
                ${test_result}                                        Get From Dictionary                            ${suite_report}
                ...                                                   ${key}
                ${log_output}                                         Catenate                                       ${log_output}
                ...                                                   ${test_result}${\n}
                ${values}                                             Get From Dictionary                            ${The_test_reports}
                ...                                                   ${key}
                FOR    ${value}    IN    @{values}
                    ${log_output}                                     Catenate                                       ${log_output}
                    ...                                               ${value}${\n}
                END
            END
        END
        ${log_output}                                                 Catenate                                       ${log_output}
        ...                                                          ${\n}${\n}__${hostname}__
        Send Telegram Message                                        ${log_output}
    END
    