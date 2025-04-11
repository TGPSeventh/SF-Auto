# -*- coding: utf-8 -*-
# ***************************************************************************************************
# * Copyright (C) 2025 RAM GROUP
# *
# * This file is part of the SF Web Automation Project.
# *
# * SF web automation can not be copied and/or distributed without the express
# * permission of RAM GROUP
# ***************************************************************************************************

*** Settings ***

# |--------------------------------------------------------------------------------------
# | Import Library
# | For Collection refer to https://robotframework.org/robotframework/2.1.2/libraries/Collections.html for the Keyword Documentation.
# | For OperatingSystem refer to https://robotframework.org/robotframework/2.1.2/libraries/OperatingSystem.html for the Keyword Documentation.
# | For Faker refer to https://guykisel.github.io/robotframework-faker/ for the Keyword Documentation.
# | For String refer to https://robotframework.org/robotframework/latest/libraries/String.html for the Keyword Documentation.
# | For DateTime refer to https://robotframework.org/robotframework/latest/libraries/DateTime.html for the Keyword Documentation.
Library                                                    Collections
Library                                                    OperatingSystem
# Library                                                    FakerLibrary
Library                                                    random
Library                                                    String
Library                                                    DateTime
Library                                                    BuiltIn

# |--------------------------------------------------------------------------------------
# | Import Resources: 
# | for Telegram API refer to: https://docs.python-telegram-bot.org/en/stable/ for the Keyword Documentation.
Resource                                                   lib/lib.robot

# |--------------------------------------------------------------------------------------
# | Import Main Keywords
# | This Variables will be used to import other keywords into the test cases
Resource                                                   keywords/helpers.robot

# |--------------------------------------------------------------------------------------
# | Import Template Keywords
Resource                                                   keywords/template.robot

# |--------------------------------------------------------------------------------------
# | Import Validator Keywords
Resource                                                   keywords/validators.robot

# |----------------- ---------------------------------------------------------------------
# | Import Custom Py Codes
Library                                                   keywords/rand.py

# |--------------------------------------------------------------------------------------
# | Import Resources 
Variables                                                  ../config/locators.yaml
Variables                                                  ../config/keypress.yaml
Variables                                                  ../config/creds.yaml
