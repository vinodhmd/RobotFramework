*** Settings ***
Documentation    Restful Booker API tests — base URL and credentials are
...              loaded from data/TestData.xlsx via env.resource.
...              Run with: --variable ENV:DEV  (default)
...                        --variable ENV:QA
...                        --variable ENV:PROD

Library    RequestsLibrary
Library    Collections

Resource    ../core/env.resource

Suite Setup    Run Keywords
...            Load Environment Variables    AND
...            Authenticate as Admin


*** Test Cases ***
Get Bookings from Restful Booker
    [Documentation]    Retrieve booking list and spot-check first 3 items.
    [Tags]    smoke    api
    ${body}    Create Dictionary    firstname=John
    ${response}    GET    ${API_URL}/booking    ${body}
    Status Should Be    200
    Log List    ${response.json()}
    ${bookings}=    Set Variable    ${response.json()}
    FOR    ${booking}    IN    @{bookings[:3]}
        ${response}    GET    ${API_URL}/booking/${booking}[bookingid]
        TRY
            Log    ${response.json()}
        EXCEPT
            Log    Cannot retrieve JSON due to invalid data
        END
    END

Create a Booking at Restful Booker
    [Documentation]    POST a new booking and verify it was persisted.
    [Tags]    smoke    api
    ${booking_dates}    Create Dictionary    checkin=2022-12-31    checkout=2023-01-01
    ${body}    Create Dictionary
    ...    firstname=Hans
    ...    lastname=Gruber
    ...    totalprice=200
    ...    depositpaid=false
    ...    bookingdates=${booking_dates}
    ${response}    POST    url=${API_URL}/booking    json=${body}
    ${id}    Set Variable    ${response.json()}[bookingid]
    Set Suite Variable    ${id}
    ${response}    GET    ${API_URL}/booking/${id}
    Log    ${response.json()}
    Should Be Equal    ${response.json()}[lastname]    Gruber
    Should Be Equal    ${response.json()}[firstname]    Hans
    Should Be Equal As Numbers    ${response.json()}[totalprice]    200
    Dictionary Should Contain Value    ${response.json()}    Gruber

Delete Booking
    [Documentation]    Delete the booking created in the previous test.
    [Tags]    api
    ${header}    Create Dictionary    Cookie=token\=${token}
    ${response}    DELETE    url=${API_URL}/booking/${id}    headers=${header}
    Status Should Be    201    ${response}


*** Keywords ***
Authenticate as Admin
    [Documentation]    POST to /auth with API_USERNAME / API_PASSWORD from Excel and
    ...                store the token as a suite variable.
    ${body}    Create Dictionary    username=${API_USERNAME}    password=${API_PASSWORD}
    ${response}    POST    url=${API_URL}/auth    json=${body}
    Log    ${response.json()}
    ${token}    Set Variable    ${response.json()}[token]
    Log    ${token}
    Set Suite Variable    ${token}
