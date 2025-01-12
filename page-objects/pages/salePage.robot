*** Settings ***
Resource    ../../config/settings.robot
Resource    ../locators/saleLocator.robot
Resource    ../locators/commonLocator.robot
Resource    ../../devdata/env.robot


*** Keywords ***
Fill and submit the form for one person
    [Arguments]    ${sales_rep}
    Wait Until Element Is Visible    ${input_first_name}
    Input Text    ${input_first_name}    ${sales_rep}[First Name]
    Input Text    ${input_last_name}    ${sales_rep}[Last Name]
    Input Text    ${input_sales_result}    ${sales_rep}[Sales]
    Select From List By Value    ${input_sales_target}    ${sales_rep}[Sales Target]
    Click Button    ${button_submit}

Download the Excel file
    [Arguments]    ${url_excel}
    RPA.HTTP.Download    ${url_excel}    ${download}    overwrite=True

Fill the form using the data from the Excel file
    Open Workbook    ${download}${/}SalesData.xlsx
    ${sales_reps}=    Read Worksheet As Table    header=True
    Close Workbook
    FOR    ${sales_rep}    IN    @{sales_reps}
        Fill and submit the form for one person    ${sales_rep}
    END

Collect the results
    Screenshot    ${stack_sales_result}    ${screenshot}${/}sales_summary.png

Export the table as a PDF
    Wait Until Element Is Visible    ${form_sales}
    ${sales_results_html}=    Get Element Attribute    ${form_sales}    outerHTML
    Html To Pdf    ${sales_results_html}    ${pdf_folders}${/}sales_results.pdf

Log out and close the browser
    Click Button    ${button_log_out}
    Close Browser
