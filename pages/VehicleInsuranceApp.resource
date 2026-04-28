*** Settings ***
Documentation    Page Object keywords for the Vehicle Insurance App.
Library    Browser
Variables  ../locators/Objectlocators.py

*** Keywords ***
Open Insurance Application
    [Documentation]    Launch the browser and navigate to the insurance app URL from Excel.
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Context    locale=en-GB
    New Page    ${BASE_URL}

Enter Vehicle Data for Automobile
    Click    ${NAV_AUTOMOBILE}
    Select Options By    ${MAKE_DROPDOWN}    text    Audi
    Fill Text    ${ENGINE_PERFORMANCE_INPUT}    110
    Fill Text    ${DATE_OF_MANUFACTURE_INPUT}    06/12/1980
    Select Options By    ${NUMBER_OF_SEATS_DROPDOWN}    text    5
    Select Options By    ${FUEL_TYPE_DROPDOWN}    text    Petrol
    Fill Text    ${LIST_PRICE_INPUT}    30000
    Fill Text    ${LICENSE_PLATE_INPUT}    DMK1234
    Fill Text    ${ANNUAL_MILEAGE_INPUT}    10000
    Click    ${NEXT_BUTTON}

Enter Insurant Data
    [Arguments]    ${firstname}=Max    ${lastname}=Mustermann
    Fill Text    ${FIRST_NAME_INPUT}    Max
    Fill Text    ${LAST_NAME_INPUT}    Mustermann
    Fill Text    ${BIRTH_DATE_INPUT}    01/31/1980
    Check Checkbox    ${GENDER_MALE_RADIO}
    Fill Text    ${STREET_ADDRESS_INPUT}    Test Street
    Select Options By    ${COUNTRY_DROPDOWN}    text    Germany
    Fill Text    ${ZIP_CODE_INPUT}    40123
    Fill Text    ${CITY_INPUT}    Essen
    Select Options By    ${OCCUPATION_DROPDOWN}    text    Employee
    Click    ${HOBBY_CLIFF_DIVING_CHECKBOX}
    Click    ${NEXT_BUTTON}

Enter Product Data
    Fill Text    ${START_DATE_INPUT}    06/01/2023
    Select Options By    ${INSURANCE_SUM_DROPDOWN}    text    7.000.000,00
    Select Options By    ${MERIT_RATING_DROPDOWN}    text    Bonus 1
    Select Options By    ${DAMAGE_INSURANCE_DROPDOWN}    text    No Coverage
    Check Checkbox    ${EURO_PROTECTION_CHECKBOX}
    Select Options By    ${COURTESY_CAR_DROPDOWN}    text    Yes
    Click    ${NEXT_BUTTON}

Select Price Option
    [Arguments]    ${price_option}=Silver
    Click    ${PRICE_OPTION_RADIO}
    Click    ${NEXT_BUTTON}

Send Quote
    Fill Text    ${EMAIL_INPUT}    max.mustermann@example.com
    Fill Text    ${PHONE_INPUT}    0049201123456
    Fill Text    ${USERNAME_INPUT}    max.mustermann
    Fill Text    ${PASSWORD_INPUT}    ${APP_PASSWORD}
    Fill Text    ${CONFIRM_PASSWORD_INPUT}    ${APP_PASSWORD}
    Fill Text    ${COMMENTS_TEXTAREA}    Some comments
    ${promise}=    Promise To
    ...    Wait For Response
    ...    matcher=http://sampleapp.tricentis.com/101/tcpdf/pdfs/quote.php
    ...    timeout=10
    Click    ${SEND_EMAIL_BUTTON}
    ${body}=    Wait For    ${promise}
    Log    ${body}[status]
    Log    ${body}[body]
    Wait For Elements State    ${SUCCESS_MESSAGE_TEXT}
    Click    ${OK_BUTTON}

End Test
    Close Context
    Close Browser
