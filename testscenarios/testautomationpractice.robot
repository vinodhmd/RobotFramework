*** Settings ***
Documentation    Practice test automation — LOGIN_URL and BROWSER are loaded
...              from data/TestData.xlsx via env.resource.

Library    String
Library    SeleniumLibrary

Resource    ../core/env.resource

Suite Setup    Load Environment Variables


*** Test Cases ***
My First Test
    [Documentation]    Basic smoke test — logs a message.
    [Tags]    smoke
    Log To Console    Hello, Robot Framework!

Create A Random String
    [Documentation]    Generate and log a random 10-character string.
    [Tags]    regression
    Log To Console    We are going to generate a random string
    Generate Random String    10
    Log To Console    We finished generating a random string
