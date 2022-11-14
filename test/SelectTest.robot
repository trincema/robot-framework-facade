*** Settings ***
Library         SeleniumLibrary
Resource        ../ActionCheckViewWait/ActionKeywords.resource
Resource        ../ActionCheckViewWait/CheckKeywords.resource
Resource        ../ActionCheckViewWait/ViewKeywords.resource
Resource        ../ActionCheckViewWait/WaitKeywords.resource

*** Test Cases ***
Input Field Test
    ${selectDropdown} =  Set Variable   css=select[data-test="selectDropdown"]

    Open Browser                file:///home/emanuel/workspace/robot-framework-facade/test/index.html

    # SELECT DROPDOWN
    Selection List Option By Index      ${selectDropdown}       1
    Selection List Option By Label      ${selectDropdown}       Two
    Selection List Option By Value      ${selectDropdown}       3

    Sleep       1000s
    Close Browser