# -*- coding: utf-8 -*-
# * Copyright (C) 2023 IT Americano Inc.
# *
# * This file is part of the Upfront Web Automation Project.
# *
# * Upfront Web Automation can not be copied and/or distributed without the express
# * permission of IT Americano Inc.
*** Settings ***
# |--------------------------------------------------------------------------------------
# | Import the robotframework-GoogleSheetsLibrary.
# | Refer to https://mainsystemdev.github.io/GoogleSheetsLibrary for the Keyword Documentation.
Library                                                              GoogleSheetsLibrary
    ...                                                              scopes=['https://www.googleapis.com/auth/spreadsheets']

Variables                                                            config.yaml

*** Keywords ***
Load Configuration Sheet
    [Documentation]                                                  Helper Keyword for GoogleSheets for initializing Spreadsheets.
    [Arguments]                                                      ${sID}
    Initialize Spreadsheet                                           spreadsheetId=${sID}
        ...                                                          tokenFile=${EXECDIR}/credentials/token.json
    Log To Console                                                   \n\nSuccessfully Loaded ${sID} Configuration....\n

Initialize Upfront Sheet
    [Documentation]                                                  Loads Operator's Translation Sheet.
        ...                                                          ${operatorConfig.googleSheets.Upfront} should be set.
    IF                                                               %{GS_REPORT}
        Load Configuration Sheet                        ${applicationConfig.googleSheets.Upfront}
    ELSE
        Log                                             Google Sheet Reporting is Disabled.
    END
