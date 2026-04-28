*** Settings ***
Documentation    Common resource file that loads Environment Variables from
...              data/TestData.xlsx via the ExcelConfig Python library.
...
...              Usage in any test suite:
...                  Resource    ../core/env.resource
...                  Suite Setup    Load Environment Variables
...
...              After Suite Setup, all keys from the Environments sheet are
...              available as Robot Framework suite variables, e.g:
...                  ${BASE_URL}   ${BROWSER}   ${HEADLESS}
...                  ${API_URL}    ${API_USERNAME}   ${APP_USERNAME}

Library    excel_config.ExcelConfig    ${ENV}


*** Variables ***
# Default environment — override at runtime with: --variable ENV:QA
${ENV}    DEV


*** Keywords ***
Load Environment Variables
    [Documentation]    Read all keys from the Environments sheet in TestData.xlsx
    ...                for the active ENV and expose them as Suite Variables.
    ...                Call this in Suite Setup of every test suite.
    Load Environment Variables As Suite Variables
    Log Environment Summary
