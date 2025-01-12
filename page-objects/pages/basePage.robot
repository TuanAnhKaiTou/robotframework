*** Settings ***
Resource    ../../config/settings.robot
Resource    ../../devdata/env.robot
Library     RPA.FileSystem


*** Keywords ***
Open the website
    [Arguments]    ${url}
    Open Available Browser    ${url}

Create directory if exist
    [Arguments]    ${dir_path}
    ${is_path_exist}=    Does Directory Not Exist    ${dir_path}
    IF    ${is_path_exist}    RPA.FileSystem.Create Directory    ${dir_path}

Empty directory
    [Arguments]    ${dir_path}
    ${is_empty}=    Is Directory Not Empty    ${dir_path}
    IF    ${is_empty}    RPA.FileSystem.Empty Directory    ${dir_path}

Remove directory if exist
    [Arguments]    ${dir_path}
    ${is_path_exist}=    Does Directory Exist    ${dir_path}
    IF    ${is_path_exist}
        Empty directory    ${dir_path}
        RPA.FileSystem.Remove Directory    ${dir_path}    recursive=${True}
    END

Create directories
    Create directory if exist    ${screenshot}
    Create directory if exist    ${pdf_folders}
    Create directory if exist    ${output}
    Create directory if exist    ${download}
    Create directory if exist    ${report}

Remove directories
    Remove directory if exist    ${screenshot}
    Remove directory if exist    ${pdf_folders}
    Remove directory if exist    ${output}
    Remove directory if exist    ${download}
    Remove directory if exist    ${report}
