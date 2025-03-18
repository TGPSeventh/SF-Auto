*** Settings ***
Library                                        TelegramLibrary.py
...                                            token=6214235530:AAH4HC9z4ROL8lxABgaPwU8O0DQH-6Fqv6s
...                                            channel_id=@UpfrontAuto


*** Keywords ***
# |--------------------------------------------------------------------------------------
# | Import the robotframework-GoogleSheetsLibrary.
# | for Telegram API refer to: https://docs.python-telegram-bot.org/en/stable/ for the Keyword Documentation.
Send Telegram Message
    [Documentation]                            Sends Telegram Message
    [Arguments]                                ${message}
    [Return]                                   ${id}
    IF                                         "%{TG_REPORT}" == "True" or "%{TG_REPORT}" == "Full"
            ${id}                              Send Message                    ${message.replace("-","\\-")}
    END

Send Telegram Photo
    [Documentation]                            Sends Telegram Message
    [Arguments]                                ${photo_path}                    ${message}
    IF                                         "%{TG_REPORT}" == "True" or "%{TG_REPORT}" == "Full"
        Send Photo    ${photo_path}            ${message}
    END

Edit Telegram Message
    [Documentation]                             Edit Telegram Message
    [Arguments]                                 ${message}        ${message_id}
    IF                                          "%{TG_REPORT}" == "True" or "%{TG_REPORT}" == "Full"
        Edit Message                            ${message.replace("-","\\-")}        ${message_id}
    END
