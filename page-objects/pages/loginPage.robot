*** Settings ***
Resource    ../../config/settings.robot
Resource    ../locators/loginLocator.robot
Resource    ../locators/saleLocator.robot


*** Keywords ***
Log in
    Input Text    ${input_username}    maria
    Input Password    ${input_password}    thoushallnotpass
    Submit Form
    Wait Until Page Contains Element    ${form_sales}
