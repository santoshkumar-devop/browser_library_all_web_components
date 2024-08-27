*** Settings ***
Library    Browser
Suite Setup    Checkbox Suite Setup
Suite Teardown    Checkbox Suite Teardown

*** Variables ***
${BROWSER}    chromium
${URL}    https://testautomationpractice.blogspot.com/

${expected_page_title}    Automation Testing Practice

@{CHECKBOX_VALUES}    Sunday    Monday    Tuesday    Wednesday    Thursday    Friday    Saturday

# Locators
${CHECK_BOX_LABEL}    //label[@class='form-check-label' and contains(., 'Sunday')]
${CHECK_BOX_LOCATOR_SUNDAY}    //input[@id="sunday"]
${CHECK_BOX_LOCATOR_MONDAY}    //input[@id="monday"]
${CHECK_BOX_LOCATOR_TUESDAY}    //input[@id="tuesday"]
${CHECK_BOX_LOCATOR_WEDNESDAY}    //input[@id="wednesday"]
${CHECK_BOX_LOCATOR_THURSDAY}    //input[@id="thursday"]
${CHECK_BOX_LOCATOR_FRIDAY}    //input[@id="friday"]
${CHECK_BOX_LOCATOR_SATURDAY}    //input[@id="saturday"]

@{CHECKBOX_LOCATORS}    ${CHECK_BOX_LOCATOR_SUNDAY}    ${CHECK_BOX_LOCATOR_MONDAY}    ${CHECK_BOX_LOCATOR_TUESDAY}    ${CHECK_BOX_LOCATOR_WEDNESDAY}    ${CHECK_BOX_LOCATOR_THURSDAY}    ${CHECK_BOX_LOCATOR_FRIDAY}    ${CHECK_BOX_LOCATOR_SATURDAY}

*** Test Cases ***
Verify All The Checkbox Values are displayed
    [Documentation]    Verify All The Checkbox Values are displayed
    [Tags]    Testcase_1
    [Setup]    Checkbox Test Setup
    Given User Is On The Blog Page
    Then All The Checkbox Values are displayed
    [Teardown]    Checkbox Test Teardown

Verify Checkbox Values are Selected
    [Documentation]    Verify Checkbox Values are Selected
    [Tags]    Testcase_2
    [Setup]    Checkbox Test Setup
    Given User Is On The Blog Page
    When User Selects Checkbox Values
    Then Checkbox Values are Selected Successfully
    And User UnSelects Checkbox Values
    Then Checkbox Values are UnSelected Successfully
    [Teardown]    Checkbox Test Teardown
       
*** Keywords ***
Checkbox Suite Setup
    New Browser    ${BROWSER}
    New Page    ${URL}

Checkbox Test Setup
    Go To    ${URL}

Checkbox Values are UnSelected Successfully
    FOR    ${CHECKBOX_LOCATOR}    IN    @{CHECKBOX_LOCATORS}
        ${selected}=    Get Property        ${CHECKBOX_LOCATOR}    checked
        Should Be True    '${selected}' == 'False'
    END
    Take Screenshot    Checkbox Values UnSelected Successfully

User UnSelects Checkbox Values
    FOR    ${value}    IN    @{CHECKBOX_VALUES}
        ${CHECK_BOX_LABEL}=    Set Variable    //label[@class='form-check-label' and contains(., '${value}')]
        Scroll To    ${CHECK_BOX_LABEL}
        Wait For Elements State    ${CHECK_BOX_LABEL}    visible
        Click    ${CHECK_BOX_LABEL}
    END
    Take Screenshot    Checkbox Values UnSelected

Checkbox Values are Selected Successfully
    FOR    ${CHECKBOX_LOCATOR}    IN    @{CHECKBOX_LOCATORS}
        ${selected}=    Get Property        ${CHECKBOX_LOCATOR}    checked
        Should Be True    '${selected}' == 'True'
    END
    Take Screenshot    Checkbox Values Selected Successfully
    
User Selects Checkbox Values
    FOR    ${value}    IN    @{CHECKBOX_VALUES}
        ${CHECK_BOX_LABEL}=    Set Variable    //label[@class='form-check-label' and contains(., '${value}')]
        Scroll To    ${CHECK_BOX_LABEL}
        Wait For Elements State    ${CHECK_BOX_LABEL}    visible
        Click    ${CHECK_BOX_LABEL}
    END
    Take Screenshot    Checkbox Values Selected
    
User Is On The Blog Page
    ${page_title}=    Get Title
    Should Be Equal     ${page_title}   ${expected_page_title}

All The Checkbox Values are displayed
    FOR    ${value}    IN    @{CHECKBOX_VALUES}
        ${CHECK_BOX_LABEL}=    Set Variable    //label[@class='form-check-label' and contains(., '${value}')]
        Scroll To    ${CHECK_BOX_LABEL}
        Wait For Elements State    ${CHECK_BOX_LABEL}    visible
    END
    Take Screenshot    All Checkbox values Visible
        
Checkbox Test Teardown
    Reload

Checkbox Suite Teardown
    Close Browser