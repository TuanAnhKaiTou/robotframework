*** Settings ***
Resource            ../devdata/env.robot
Resource            ../page-objects/pages/basePage.robot
Resource            ../page-objects/pages/orderPage.robot

Test Setup          Create directories
Test Teardown       Remove directories


*** Test Cases ***
Order robots from RobotSpareBin Industries Inc
    Open the website    ${order_url}
    ${orders}=    Get orders
    FOR    ${row}    IN    @{orders}
        Close the annoying modal
        Fill the form    ${row}
        Wait Until Keyword Succeeds    10x    2s    Preview the robot
        Wait Until Keyword Succeeds    10x    2s    Submit the order
        ${orderid}    ${img_filename}=    Take a screenshot of the robot image
        ${pdf_filename}=    Store the order receipt as a PDF file    ${order_id}
        Embed robot preview screenshot to receipt PDF file    ${img_filename}    ${pdf_filename}
        Go to order another robot
    END
    Create a Zip file of receipt PDF files
    Close the browser
