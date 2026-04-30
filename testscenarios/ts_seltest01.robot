*** Settings ***
Library    SeleniumLibrary
Resource   ../core/env.resource
Variables  ../locators/Objectlocators.py

Suite Setup    Load Environment Variables

*** Test Cases ***
My First Web Test
    Open Browser    ${GOOGLE_URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    ${GOOGLE_SEARCH_BOX}    timeout=${TIMEOUT}s
    Input Text      ${GOOGLE_SEARCH_BOX}      Robot Framework
    Press Keys      ${GOOGLE_SEARCH_BOX}      ENTER
    Sleep    10s
    Wait Until Page Contains    robotframework.org    timeout=${TIMEOUT}s
    Sleep    10s
    Close Browser

Read Excel Data Test
    [Documentation]    Gets the data from TestData.xlsx
    Log To Console    \n--- Excel Data Variables ---
    Log To Console    ENV: ${ENV}
    Log To Console    BASE_URL: ${BASE_URL}
    Log To Console    BROWSER: ${BROWSER}
    Log To Console    LOGIN_URL: ${LOGIN_URL}
    Log To Console    APP_USERNAME: ${APP_USERNAME}
    Log To Console    TIMEOUT: ${TIMEOUT}


#Get-ChildItem -Path c:\Vinodh\Work\Pythonbase\RobotFramework -Directory
#python -m robot testscenarios\ts_seltest01.robot
#
#robot --outputdir outputdir testscenarios\ts_seltest01.robot    --test MyFirstWebTest
