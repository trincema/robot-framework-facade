*** Settings ***
Library         SeleniumLibrary
Resource        ../ActionCheckViewWait/ActionKeywords.resource
Resource        ../ActionCheckViewWait/CheckKeywords.resource
Resource        ../ActionCheckViewWait/ViewKeywords.resource
Resource        ../ActionCheckViewWait/WaitKeywords.resource

*** Variables ***


*** Test Cases ***
Input Field Test
    ${inputField} =  Set Variable       css=input[data-test="textField"]
    ${passwordField} =  Set Variable    css=input[data-test="passwordInput"]
    ${readonlyField} =  Set Variable    css=input[data-test="readonlyInput"]
    ${disabledField} =  Set Variable    css=input[data-test="disabledInput"]
    ${textarea} =    Set Variable       css=textarea[data-test="textarea"]

    Open Browser                file:///home/emanuel/workspace/robot-framework-facade/test/index.html

    # TEXT INPUT FIELD
    Set Input Field Value       ${inputField}       A       10
    Set Input Field Value       ${inputField}       B       10
    Append Input Field Value    ${inputField}       C       10
    ${inputValue} =             Get Element Value   ${inputField}
    Expect To Be Equal          ${inputValue}       BC

    Clear Input Field Value     ${inputField}
    ${inputValue} =             Get Element Value   ${inputField}
    Expect To Be Equal          ${inputValue}       ${EMPTY}

    # PASSWORD INPUT FIELD
    Set Input Field Value       ${passwordField}    A       10
    Set Input Field Value       ${passwordField}    B       10
    Append Input Field Value    ${passwordField}    C       10
    ${inputValue} =             Get Element Value   ${passwordField}
    Expect To Be Equal          ${inputValue}       BC

    # READONLY INPUT FIELD
    Set Input Field Value       ${readonlyField}    A
    Set Input Field Value       ${readonlyField}    B
    Append Input Field Value    ${readonlyField}    C       10
    ${inputValue} =             Get Element Value   ${readonlyField}
    Expect To Be Equal          ${inputValue}       BC

    # DISABLED INPUT FIELD
    Set Input Field Value       ${disabledField}    A
    Set Input Field Value       ${disabledField}    B
    Append Input Field Value    ${disabledField}    C       10
    ${inputValue} =             Get Element Value   ${disabledField}
    Expect To Be Equal          ${inputValue}       BC

    # TEXT AREA INPUT FIELD
    Set Input Field Value       ${textarea}         A       10
    Set Input Field Value       ${textarea}         B       10
    Append Input Field Value    ${textarea}         C       10
    ${textareaValue} =          Get Element Value   ${textarea}
    Expect To Be Equal          ${textareaValue}    BC

    Clear Input Field Value     ${textarea}
    ${textareaValue} =          Get Element Value   ${textarea}
    Expect To Be Equal          ${textareaValue}    ${EMPTY}

    Close Browser