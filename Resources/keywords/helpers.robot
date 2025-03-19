*** Settings ***
Resource                                                   ../core.robot

*** Keywords ***
Capture Screenshot On Failure
    [Arguments]    ${test_name}
    ${timestamp}=    Get Time    format=%Y%m%d_%H%M%S
    ${screenshot_path}=    Set Variable    logs/${test_name}_${timestamp}.png
    Capture Page Screenshot    ${screenshot_path}
    Log    Screenshot saved: ${screenshot_path}

Generate Random String
    [Arguments]    ${length}=10
    ${random_string}=    Generate Random String    ${length}
    [Return]    ${random_string}

Wait Until Element Is Visible
    [Arguments]    ${locator}    ${timeout}=10s
    Wait Until Element Is Visible    ${locator}    timeout=${timeout}

Log Info Message
    [Arguments]    ${message}
    Log    ${message}

Retry On Failure
    [Arguments]    ${keyword}    ${max_retries}=3    ${delay}=2s
    FOR    ${i}    IN RANGE    ${max_retries}
        TRY
            Run Keyword    ${keyword}
            RETURN
        EXCEPT
            Log    Attempt ${i+1} failed. Retrying...
            Sleep    ${delay}
        END
    END
    Log    ❌ Final attempt failed. No more retries.
    Fail    Keyword ${keyword} failed after ${max_retries} attempts.

Validate Text On Page
    [Arguments]    ${expected_text}
    ${page_source}=    Get Source
    Should Contain    ${page_source}    ${expected_text}    Text '${expected_text}' not found on page.

Extract Data From JSON
    [Arguments]    ${json_string}    ${json_path}
    ${parsed_json}=    Convert String To JSON    ${json_string}
    ${result}=    Get Value From JSON    ${parsed_json}    ${json_path}
    [Return]    ${result}

Set Result Message
    [Arguments]    ${Keywords}    ${PassMsg}    ${FailedMsg}

    FOR    ${Keyword}    IN    @{Keywords}
        Log    Executing keyword: ${Keyword}
        ${cond}=    Run Keyword And Return Status    ${Keyword}

        IF    ${cond}
            Log    ✅ ${Keyword} passed.
        ELSE
            Log    ❌ ${Keyword} failed.
            Set Test Message    ${FailedMsg}
            Fail    ${FailedMsg}
        END
    END

    Set Test Message    ${PassMsg}

Convert String To Title Case
    [Arguments]    ${input_string}
    ${title_case_string}=    Convert To Title Case    ${input_string}
    [Return]    ${title_case_string}

Get Current Date & Time
    [Arguments]    ${format}=%Y-%m-%d %H:%M:%S
    ${datetime}=    Get Time    format=${format}
    [Return]    ${datetime}
