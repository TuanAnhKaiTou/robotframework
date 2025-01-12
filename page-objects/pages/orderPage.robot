*** Settings ***
Resource    ../../config/settings.robot
Resource    ../locators/orderLocator.robot
Resource    ../../devdata/env.robot


*** Variables ***
${order_file}       ${download}${/}orders.csv
${zip_file}         ${output}/pdf_archive.zip


*** Keywords ***

Get orders
    RPA.HTTP.Download    ${csv_url}    ${order_file}    overwrite=${True}
    ${orders}=    Read table from CSV    ${order_file}
    RETURN    ${orders}

Close the annoying modal
    Wait And Click Button    ${btn_yep}

Fill the form
    [Arguments]    ${row}
    Wait Until Element Is Visible    ${select_head}
    Wait Until Element Is Enabled    ${select_head}
    Select From List By Value    ${select_head}    ${row}[Head]
    Click Element    ${input_body}${row}[Body]
    Input Text    ${input_legs}    ${row}[Legs]
    Input Text    ${input_address}    ${row}[Address]

Preview the robot
    Click Button    ${btn_preview}
    Wait Until Element Is Visible    ${img_robot_preview}

Submit the order
    Mute Run On Failure    Page Should Contain Element
    Click Button    ${btn_order}
    Page Should Contain Element    ${lbl_receipt}

Store the order receipt as a PDF file
    [Arguments]    ${order_number}
    Wait Until Element Is Visible    ${lbl_receipt}
    Log To Console    Printing ${order_number}
    ${order_receipt_html}=    Get Element Attribute    ${lbl_receipt}    outerHTML
    Set Local Variable    ${file_path}    ${pdf_folders}${/}receipt_${order_number}.pdf
    Html To Pdf    ${order_receipt_html}    ${file_path}
    RETURN    ${file_path}

Embed robot preview screenshot to receipt PDF file
    [Arguments]    ${screenshot}    ${pdf}
    Open Pdf    ${pdf}
    ${img_file}=    Create List    ${screenshot}:align=center
    Add Files To Pdf    ${img_file}    ${pdf}    append=TRUE
    Close Pdf    ${pdf}

Take a screenshot of the robot image
    Wait Until Element Is Visible    ${img_robot_preview}
    Wait Until Element Is Visible    ${lbl_orderid}

    ${order_id}=    Get Text    ${lbl_orderid}
    Set Local Variable    ${full_qualified_img_fullname}    ${screenshot}${/}${order_id}.png
    Sleep    1s
    Log To Console    Capturing Screenshot to ${full_qualified_img_fullname}
    Capture Element Screenshot    ${img_robot_preview}    ${full_qualified_img_fullname}
    RETURN    ${order_id}    ${full_qualified_img_fullname}

Go to order another robot
    Click Button    ${btn_order_another_robot}

Create a Zip file of receipt PDF files
    Archive Folder With Zip    ${pdf_folders}    ${zip_file}    recursive=True    include=*.pdf

Close the browser
    Close Browser
