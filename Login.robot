*** Settings ***
Library    OperatingSystem
Library    Selenium2Library

*** Keywords ***
Open Groupon
    [Documentation]    Go to groupon login webpage
    Open Browser    http://groupon.com/login    browser=firefox
Confirm Groupon
    [Documentation]    Make sure we're on the groupon webpage
    ${result} =    Get Title
    Title Should Be    Sign In
Login
    [Documentation]    Log in to Groupon
    Input Text    email-input    ${email}
    Input Password    password-input    ${genericPassword}
    Click Button    Sign In

Confirm Signin
    [Documentation]    Make sure we're on Groupon front page.
    Title Should Be    ${mainPage}


*** Test Cases ***
Setup
    [Tags]    Groupon
    Set Selenium Timeout    10 seconds
Open Groupon
    [Tags]    Groupon
    Open Groupon
    Confirm Groupon

Groupon Login
    [Tags]    Groupon
    Login

Confirm Login Success
    [Tags]    Groupon
    Wait Until Page Contains    search
    Confirm Signin


* Variables *
${mainPage}=    Groupon: Deals and Coupons for Restaurants, Fitness, Travel, Shopping, Beauty, and more.
${email}=    chris2pherheath@yahoo.com
${genericPassword}=    password1234
${notThePassword} =    wrong
