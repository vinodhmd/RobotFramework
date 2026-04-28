*** Settings ***
Documentation    BDD-style login tests driven by credentials from data/TestData.xlsx.
...              Environment is selected at runtime via --variable ENV:DEV|QA|PROD.

Resource    ../core/env.resource
Resource    sp_impl_BDD.robot

Suite Setup    Load Environment Variables


*** Test Cases ***
Login With Admin
    [Documentation]    Verify successful login with valid admin credentials from Excel.
    [Tags]    smoke    regression
    Given I am on the login page
    When I login with username "${APP_USERNAME}" and password "${APP_PASSWORD}"
    Then I should see the welcome page

Login With Invalid User
    [Documentation]    Verify login fails and shows error with invalid credentials.
    [Tags]    regression
    Given I am on the login page
    When I login with username "invalid" and password "invalid"
    Then I should see the error message
    And I should be able to login again
