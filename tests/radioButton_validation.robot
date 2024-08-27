*** Settings ***
Library    Browser
Suite Setup    Radio Button Suite Setup
Suite Teardown    Radio Button Suite Teardown

*** Variables ***
${BROWSER}    chromium
${URL}    https://testautomationpractice.blogspot.com/

${expected_page_title}    Automation Testing Practice

# Locators
${MALE_LABEL}    //input[@id="male"]/following-sibling::label[contains(., 'Male')]
${MALE_LOCATOR}    //input[@id="male"]
${FEMALE_LABEL}    //input[@id="female"]/following-sibling::label[contains(., 'Female')]
${FEMALE_LOCATOR}    //input[@id="female"]

*** Test Cases ***
Verify User Can Select Radio Button
    [Documentation]    Verify User Can Select Radio Button
    [Tags]    Testcase_1
    [Setup]    Radio Button Test Setup
    Given User Is On The Blog Page
    When User Selects Radio Button
    Then Radio Button is Selected Successfully
    [Teardown]    Radio Button Test Teardown

*** Keywords ***
Radio Button Suite Setup
    New Browser    ${BROWSER}
    New Page

Radio Button Test Setup
    Go To    ${URL}

User Is On The Blog Page
    ${page_title}=    Get Title
    Should Be Equal     ${page_title}   ${expected_page_title}

User Selects Radio Button
   Scroll To    ${MALE_LABEL}
   Wait For Elements State    ${MALE_LABEL}    visible
   Click    ${MALE_LOCATOR}

Radio Button is Selected Successfully
    ${selected}=    Get Property        ${MALE_LOCATOR}    checked
    Should Be True    '${selected}' == 'True'

    ${not_selected}=    Get Property        ${FEMALE_LOCATOR}    checked
    Should Be True    '${not_selected}' == 'False'

    Take Screenshot    Radio Button Selected

Radio Button Test Teardown
    Reload

Radio Button Suite Teardown
    Close Browser
