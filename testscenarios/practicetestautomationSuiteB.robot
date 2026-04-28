*** Settings ***
Test Setup              Log    Test Setup
Test Teardown           Log    Test Teardown

Suite Setup             Log    Suite B Setup
Suite Teardown          Log    Suite B Teardown


*** Test Cases ***
Valid Login Test
    Log    Test Case 1
    Sleep    10s

Invalid Username Login Test
    Log    Test Case 2
    Sleep    10s

Invalid Password Login Test
    Log    Test Case 3
    Sleep    10s
