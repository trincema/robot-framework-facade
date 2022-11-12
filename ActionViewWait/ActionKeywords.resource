*** Settings ***
Library                 SeleniumLibrary

*** Keywords ***
Click
    [Documentation]     Click an element using the given locator.
    ...                 `elementSelector`   Element selector or locator (CSS, XPATH, etc).
    ...                 `timeout`           Timeout to wait until the page contains the element and the element reaches the ENABLED state to be clickable. Default to 30s.
    [Arguments]     ${elementSelector}      ${timeout}=30s
    Wait Until Page Contains Element        ${elementSelector}              timeout=${timeout}
    Wait Until Element Is Enabled           ${buttonSelector}               timeout=${timeout}
    Click Element   ${elementSelector}      timeout=${timeout}

Click at Coordinates
    [Documentation]     Clicking an element at given (x,y) coordinates, useful for elements that (potentially) have another element on top.
    ...                 `elementSelector`   Element selector or locator (CSS, XPATH, etc).
    ...                 `timeout`           Timeout to wait until the page contains the element and the element reaches the ENABLED state to be clickable. Default to 30s.
    [Arguments]     ${elementSelector}      ${x}    ${y}                    ${timeout}=30s
    Wait Until Page Contains Element        ${elementSelector}              timeout=${timeout}
    Wait Until Element Is Enabled           ${buttonSelector}               timeout=${timeout}
    Click Element At Coordinates            ${elementSelector}  ${x}  ${y}  timeout=${timeout}

Click And Wait For Element
    [Documentation]     Clicking an element identified by the given locator and wait for another element to appear on the page.
    ...                 `elementSelector`   Element selector or locator (CSS, XPATH, etc).
    ...                 `elementToWaitFor`  The selector or locator of the element to be waited for.
    ...                 `timeout`           Timeout to wait until the page contains the element and the element reaches the ENABLED state to be clickable. Default to 30s.
    [Arguments]     ${elementSelector}      ${elementToWaitFor}             ${timeout}=30s
    Wait Until Page Contains Element        ${elementSelector}              timeout=${timeout}
    Wait Until Element Is Enabled           ${elementSelector}              timeout=${timeout}
    Click Element                           ${elementSelector}
    Wait Until Page Contains Element        ${elementToWaitFor}             timeout=${timeout}

Click Element And Retry Until Success
    [Documentation]     Clicking on an element and if the click is not taken, retry until operation successful. Useful for elements that sometimes
    ...                 don't take the click (encountered in experience).
    ...                 `element`           Element selector/locator or element object itself.
    [Arguments]     ${element}              ${timeout}=30s
    Wait Until Element Is Enabled           ${element}                      timeout=${timeout}
    Wait Until Keyword Succeeds     5x      5 sec       Click Element       ${element}

Input Value
    [Documentation]     Set the given text to an <input> field element, replacing the current value.
    [Arguments]     ${locator}              ${value}                        ${timeout}=30s
    Wait Until Element Is Visible           ${locator}                      timeout=${timeout}
    Input Text      ${locator}              ${value}

Append Value
    [Documentation]     Append the given text to an <input> element current value.
    [Arguments]     ${locator}              ${value}                        ${timeout}=30s
    Wait Until Element Is Visible           ${locator}                      timeout=${timeout}
    Input Text      ${locator}              ${value}                        clear=False

Clear Value
    [Documentation]     Append the given text to an <input> element current value.
    [Arguments]     ${locator}              ${timeout}=30s
    Wait Until Element Is Visible           ${locator}                      timeout=${timeout}
    Clear Element Text                      ${locator}

Upload File
    [Documentation]     Uploading a file to a HTML element of type <file>.
    [Arguments]     ${resourceUrl}
    Choose File                             ${ImageUpload}                  ${resourceUrl}

Scroll To Element
    [Documentation]     Scroll to an element until the element is visible (into view).
    ...                 `element`           Element selector/locator or element object itself.
    ...                 `timeout`           Timeout to wait until the page contains the element and the element is visible. Default to 30s.
    [Arguments]     ${element}              ${timeout}=30s
    Wait Until Page Contains Element        ${element}                      timeout=${timeout}
    Run Keyword And Ignore Error            Scroll Element Into View        ${element}
    Sleep                                   3s
    Run Keyword And Ignore Error            Scroll Element Into View        ${element}
    Sleep                                   3s

Scroll To Bottom of Page
    [Documentation]     Scrolling all the way to the bottom of the page.
    Execute JavaScript                      window.scrollTo(0, document.body.scrollHeight)
    #Execute Javascript                     $(document).scrollTop(${x})
    Sleep                                   5s

Switch To New Opened Browser Tab
    [Documentation]     Switch to the newest opened browser tab.
    Switch Window                           NEW
    Sleep                                   2s

Switch To Main Browser Tab
    [Documentation]     Switch to the previously selected browser tab.
    Switch Window                           MAIN
    Sleep                                   2s

Close Selected Browser Tab
    [Documentation]     Closing the selected/current browser tab and switch to the previous selected tab.
    Close Window
    Switch To Main Browser Tab
    Sleep                                   2s
