*** Settings ***
Documentation    Vehicle Insurance UI tests — browser, URL and credentials
...              are loaded from data/TestData.xlsx via env.resource.
...              Run with: --variable ENV:DEV  (default)
...                        --variable ENV:QA
...                        --variable ENV:PROD

Resource    ../core/env.resource
Resource    ../pages/VehicleInsuranceApp.resource

Suite Setup    Run Keywords
...            Load Environment Variables    AND
...            Open Insurance Application


*** Test Cases ***
Create Quote for Car
    [Documentation]    End-to-end quote creation for the Automobile vehicle type.
    [Tags]    smoke
    Enter Vehicle Data for Automobile
    Enter Insurant Data
    Enter Product Data
    Select Price Option
    Send Quote
    [Teardown]    End Test
