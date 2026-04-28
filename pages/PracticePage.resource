*** Settings ***
Documentation    Page Object keywords for the testautomationpractice.blogspot.com app.
Library    Browser
Variables  ../locators/PracticeLocators.py

*** Keywords ***
Open Practice Application
    [Documentation]    Launch the browser and navigate to the practice app URL.
    New Browser    browser=${BROWSER}    headless=${HEADLESS}
    New Context    locale=en-US    viewport={'width': 1280, 'height': 720}
    New Page    ${PRACTICE_URL}
    Wait For Elements State    ${NAME_INPUT}    visible    timeout=10s

Fill Form Details
    [Documentation]    Fill out basic text fields in the GUI Elements section.
    Fill Text    ${NAME_INPUT}    John Doe
    Fill Text    ${EMAIL_INPUT}    john.doe@example.com
    Fill Text    ${PHONE_INPUT}    1234567890
    Fill Text    ${ADDRESS_TEXTAREA}    123 Practice Street, Automation City, Testland

Select Gender And Days
    [Documentation]    Select radio buttons for gender and checkboxes for days.
    Check Checkbox    ${GENDER_MALE_RADIO}
    Check Checkbox    ${DAY_MONDAY_CHECKBOX}
    Check Checkbox    ${DAY_WEDNESDAY_CHECKBOX}
    Check Checkbox    ${DAY_FRIDAY_CHECKBOX}

Select Country And Color
    [Documentation]    Interact with country dropdown and color list.
    Select Options By    ${COUNTRY_DROPDOWN}    value    usa
    Select Options By    ${COLORS_LIST}    value    blue

Trigger And Accept JS Alert
    [Documentation]    Trigger an alert and accept it using Browser library dialog handling.
    Handle Future Dialogs    action=accept
    Click    ${ALERT_BUTTON}

Drag Element to Target
    [Documentation]    Perform drag and drop action.
    Drag And Drop    ${DRAG_SOURCE}    ${DROP_TARGET}
    # Validate the drop target text changes to "Dropped!"
    Get Text    ${DROP_TARGET}    ==    Dropped!
