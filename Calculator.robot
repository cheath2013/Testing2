*** Settings ***
Library    OperatingSystem
Library    Selenium2Library

*** Keywords ***



*** Test Cases ***
open
    ${proxy}= 	Evaluate 	sys.modules['selenium.webdriver'].Proxy() 	sys, selenium.webdriver
    ${proxy.http_proxy}= 	Set Variable 	localhost:8888
    Create Webdriver 	Firefox 	proxy=${proxy}
    Open Browser    http://access.fit.edu    browser=firefox
