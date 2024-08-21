*** Settings ***
Library    Browser
Library    FakerLibrary
Suite Setup    Textbox Suite Setup
Suite Teardown    Textbox Suite Teardown

*** Variables ***
${BROWSER}    chromium
${URL}    https://testautomationpractice.blogspot.com/
${SCREENSHOTS_DIR}    screenshots

${expected_page_title}    Automation Testing Practice

# Locators
${LABEL_LOCATOR}        //label[normalize-space()="Name:"]
${TEXT_BOX_LOCATOR}    //input[@id="name"]

*** Test Cases ***
Verify User Can Add The Name in Text Field
    [Documentation]    Verify User Can Add The Name is Text Field
    [Tags]    Testcase_1
    [Setup]    Textbox Test Setup
    Given User Is On The Blog Page
    When User Enters Name
    Then Name is Entered Successfully
    [Teardown]    Textbox Test Teardown

Verify User Can Update The Name in Text Field
    [Documentation]    Verify User Can Update The Name is Text Field
    [Tags]    Testcase_2
    [Setup]    Textbox Test Setup
    Given User Is On The Blog Page
    And User Enters Name
    When User Updates Name
    Then Name is Updated Successfully
    [Teardown]    Textbox Test Teardown

Verify User Can Delete The Name is Text Field
    [Documentation]    Verify User Can Delete The Name is Text Field
    [Tags]    Testcase_3
    [Setup]    Textbox Test Setup
    Given User Is On The Blog Page
    And User Enters Name
    When User Clears Name
    Then Name is Cleared Successfully
    [Teardown]    Textbox Test Teardown

*** Keywords ***
Textbox Suite Setup
    New Browser    ${BROWSER}    headless=False
    New Page    ${URL}

Textbox Test Setup
    Go To    ${URL}

User Is On The Blog Page
    ${page_title}=    Get Title
    Should Be Equal     ${page_title}   ${expected_page_title}

User Enters Name
    Wait For Elements State    ${LABEL_LOCATOR}    visible
    Wait For Elements State    ${TEXT_BOX_LOCATOR}    visible
    ${name}=    FakerLibrary.First Name
    Fill Text        ${TEXT_BOX_LOCATOR}    ${name}
    Set Test Variable    ${TEST_USER_NAME}    ${name}

Name is Entered Successfully
    ${entered_name}=    Get Text        ${TEXT_BOX_LOCATOR}
    Should Be Equal    ${entered_name}    ${TEST_USER_NAME}
    Run Keyword And Ignore Error    Take Screenshot    ${SCREENSHOTS_DIR}/${TEST_USER_NAME}

User Updates Name
    ${name}=    FakerLibrary.First Name
    Clear Text    ${TEXT_BOX_LOCATOR}
    Fill Text        ${TEXT_BOX_LOCATOR}    ${name}
    Set Test Variable    ${TEST_USER_NAME}    ${name}

Name is Updated Successfully
    Name is Entered Successfully

User Clears Name
      Clear Text    ${TEXT_BOX_LOCATOR}

Name is Cleared Successfully
    ${entered_name}=    Get Text        ${TEXT_BOX_LOCATOR}
    Should Be Equal    ${entered_name}    ${EMPTY}
    Run Keyword And Ignore Error    Take Screenshot    ${SCREENSHOTS_DIR}/cleared_name

Textbox Test Teardown
    Reload

Textbox Suite Teardown
    Close Browser