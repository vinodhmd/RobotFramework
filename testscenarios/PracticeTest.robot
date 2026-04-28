*** Settings ***
Documentation    End-to-End sample test scenarios for testautomationpractice.blogspot.com
...              Demonstrating Form Filling, Interactions, and Validations.

Library    String

Resource    ../core/env.resource
Resource    ../pages/PracticePage.resource

Suite Setup    Run Keywords
...            Load Environment Variables    AND
...            Open Practice Application
Suite Teardown    Close Browser

*** Variables ***
${PRACTICE_URL}    https://testautomationpractice.blogspot.com/

*** Test Cases ***
Fill Out Practice Form
    [Documentation]    End-to-End scenario to fill out the main form elements including text, radio, and checkboxes.
    [Tags]    e2e    practice    form
    Fill Form Details
    Select Gender And Days
    Select Country And Color

Perform Drag And Drop
    [Documentation]    Test drag and drop functionality on the practice page.
    [Tags]    e2e    practice    interactions
    Drag Element to Target

Handle Alert Box
    [Documentation]    Test interaction with JavaScript alert box.
    [Tags]    e2e    practice    alerts
    Trigger And Accept JS Alert

