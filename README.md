# SF-Auto

Project dependencies
- robotframework-seleniumlibrary
- robotframework-faker

## To Start Env
Use `source venv/bin/activate`

** Install project dependencies **
git `pip install -r requirements.txt --use-deprecated=legacy-resolver`

## Enable Google Sheet Reporting 
`export GS_REPORT=True`
url link: 
https://docs.google.com/spreadsheets/d/1l1JWbs8pHKjgKzShzFHLEsABNoaYyo3BHrSpIyktbsc/edit#gid=0
## Enable Telegram Reporting 
Use `export TG_REPORT=True`

Use `export TG_REPORT=Full` to display full result in the Telegram

channel_id: `@SFAuto`

## Run Scipt
git `robot -d result -i SF-AUTO testsuites/`

## To Run a Singular Test Case
## Exact Match: The name you provide after --test must match the test case name exactly, including spaces and capitalization.
   ## robot --test "(Name of Test Case)"  (Filename).robot
## Partial Match: If you use a partial name, you can enclose it in wildcards (*). For example:
   ## robot --test "*valid password" LoginTests.robot
