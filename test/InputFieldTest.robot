*** Settings ***
Library         SeleniumLibrary
Resource        ../ActionViewWait/ActionKeywords.resource

*** Test Cases ***
Input Field Test
    ${inputField} =  Set Variable   css=input[data-test="input-field"]
    ${textarea} =    Set Variable   css=textarea[data-test="textarea"]

    Open Browser    file:///home/emanuel/workspace/robot-framework-facade/test/index.html
    Input Value     ${inputField}       A       10
    Sleep           3s
    Input Value     ${inputField}       B       10
    Sleep           3s

    Append Value    ${inputField}       C       10
    Sleep           3s

    Input Value     ${textarea}         A       10
    Sleep           3s

    Clear Value     ${inputField}
    Clear Value     ${textarea}

    Close Browser