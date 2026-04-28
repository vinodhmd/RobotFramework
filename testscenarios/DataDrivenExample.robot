*** Settings ***
Documentation    Demonstrate Data-Driven Testing (DDT) using native Robot FOR loops
...              reading dynamically from the TestData.xlsx 'TestScenarios' sheet.
...              This allows you to manage all test permutations directly in Excel!

Resource    ../core/env.resource

Suite Setup    Load Environment Variables

*** Test Cases ***
Execute Data Driven Logins
    [Documentation]    Dynamically fetches test scenarios from Excel and iterates over them.
    ...                Note: This entire loop runs as a single test case in the report.
    
    # Fetch rows from the TestScenarios sheet where TestSuite == "sp_BDD" and Active == "YES"
    ${scenarios}=    Get Test Scenarios    suite=sp_BDD    active_only=True
    
    # Iterate through the list of dictionaries
    FOR    ${scenario}    IN    @{scenarios}
        Log To Console    \n▶ Running test permutation: ${scenario}[TestCase]
        Run Keyword    Dynamic Login Test    ${scenario}[Username]    ${scenario}[Password]    ${scenario}[ExpectedResult]
    END

*** Keywords ***
Dynamic Login Test
    [Arguments]    ${username}    ${password}    ${expected_result}
    [Documentation]    The actual test steps using the dynamic data.
    Log To Console    Attempting login with Username: ${username} | Password: ${password}
    
    # Normally, you would call your POM keywords here, e.g.:
    # Enter Login Credentials    ${username}    ${password}
    # Click Login Button
    # Verify Login State       ${expected_result}
    
    # For demonstration, we just log and conditionally pass/fail
    IF    '${expected_result}' == 'Pass'
        Log To Console    Verified successful login.
    ELSE
        Log To Console    Verified expected login failure.
    END
