*** Settings ***
Resource            ../page-objects/pages/salePage.robot
Resource            ../page-objects/pages/loginPage.robot
Resource            ../devdata/env.robot
Resource            ../page-objects/pages/basePage.robot

Test Setup          Create directories
Test Teardown       Remove directories


*** Test Cases ***
Insert the sales data for the week and export it as a PDF
    Open the website    ${url}
    Log in
    Download the Excel file    ${excel_url}
    Fill the form using the data from the Excel file
    Collect the results
    Export the table as a PDF
    Log out and close the browser
