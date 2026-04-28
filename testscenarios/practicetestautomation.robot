*** Settings ***
Documentation       A complete test suite for web login on Practice Test Automation.

Library             SeleniumLibrary


*** Variables ***
${URL}                  https://practicetestautomation.com/practice-test-login/
${BROWSER}              Chrome
${VALID_USER}           student
${VALID_PASSWORD}       Password123
${INVALID_USER}         incorrectUser
${INVALID_PASSWORD}     incorrectPassword


*** Test Cases ***
Valid Login Test
    [Documentation]    Test valid login with correct credentials.
    Open Homepage
    Input Username    ${VALID_USER}
    Input Login Password    ${VALID_PASSWORD}
    Click Submit Button
    Verify Successful Login
    [Teardown]    Close Browser

Invalid Username Login Test
    [Documentation]    Test login with an incorrect username but correct password.
    Open Homepage
    Input Username    ${INVALID_USER}
    Input Login Password    ${VALID_PASSWORD}
    Click Submit Button
    Verify Error Message    Your username is invalid!
    [Teardown]    Close Browser

Invalid Password Login Test
    [Documentation]    Test login with a correct username but incorrect password.
    Open Homepage
    Input Username    ${VALID_USER}
    Input Login Password    ${INVALID_PASSWORD}
    Click Submit Button
    Verify Error Message    Your password is invalid!
    [Teardown]    Close Browser


*** Keywords ***
Open Homepage
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    id:username

Input Username
    [Arguments]    ${username}
    Input Text    id:username    ${username}

Input Login Password
    [Arguments]    ${password}
    Input Password    id:password    ${password}

Click Submit Button
    Click Button    id:submit

Verify Successful Login
    Wait Until Page Contains    Congratulations student. You successfully logged in!
    Page Should Contain Element    link:Log out

Verify Error Message
    [Arguments]    ${expected_message}
    Wait Until Element Is Visible    id:error
    Element Should Contain    id:error    ${expected_message}

# robot --output original.xml tests    # first execute all tests
# robot --rerunfailed original.xml --output rerun.xml tests    # then re-execute failing
# rebot --merge original.xml rerun.xml    # finally merge results

# C:\Users\vinod\AppData\Local\Python\pythoncore-3.14-64\python.exe -m pabot.pabot --command C:\Users\vinod\AppData\Local\Python\pythoncore-3.14-64\python.exe -m robot --end-command "practicetestautomationSuiteA.robot" "practicetestautomationSuiteB.robot"
# C:\Users\vinod\AppData\Local\Python\pythoncore-3.14-64\python.exe -m pabot.pabot --command C:\Users\vinod\AppData\Local\Python\pythoncore-3.14-64\python.exe -m robot --end-command "test\practicetestautomationSuiteA.robot"
