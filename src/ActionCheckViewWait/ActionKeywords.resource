*** Settings ***
Library                 SeleniumLibrary

*** Keywords ***
Click
    [Documentation]     Click an element using the given locator.
    ...                 `locator`   Element selector or locator (CSS, XPATH, etc).
    ...                 `timeout`           Timeout to wait until the page contains the element and the element reaches the ENABLED state to be clickable. Default to 30s.
    [Arguments]     ${locator}      ${timeout}=30s
    Wait Until Page Contains Element        ${locator}              timeout=${timeout}
    Wait Until Element Is Enabled           ${buttonSelector}       timeout=${timeout}
    Click Element                           ${locator}              timeout=${timeout}

Click at Coordinates
    [Documentation]     Clicking an element at given (x,y) coordinates, useful for elements that (potentially) have another element on top.
    ...                 `locator`   Element selector or locator (CSS, XPATH, etc).
    ...                 `timeout`           Timeout to wait until the page contains the element and the element reaches the ENABLED state to be clickable. Default to 30s.
    [Arguments]     ${locator}      ${x}    ${y}                    ${timeout}=30s
    Wait Until Page Contains Element        ${locator}              timeout=${timeout}
    Wait Until Element Is Enabled           ${locator}              timeout=${timeout}
    Click Element At Coordinates            ${locator}  ${x}  ${y}  timeout=${timeout}

Click And Wait For Element
    [Documentation]     Clicking an element identified by the given locator and wait for another element to appear on the page.
    ...                 `locator`   Element selector or locator (CSS, XPATH, etc).
    ...                 `elementToWaitFor`  The selector or locator of the element to be waited for.
    ...                 `timeout`           Timeout to wait until the page contains the element and the element reaches the ENABLED state to be clickable. Default to 30s.
    [Arguments]     ${locator}      ${elementToWaitFor}             ${timeout}=30s
    Wait Until Page Contains Element        ${elementSelector}      timeout=${timeout}
    Wait Until Element Is Enabled           ${locator}              timeout=${timeout}
    Click Element                           ${locator}
    Wait Until Page Contains Element        ${elementToWaitFor}     timeout=${timeout}

Click Element And Retry Until Success
    [Documentation]     Clicking on an element and if the click is not taken, retry until operation successful. Useful for elements that sometimes
    ...                 don't take the click (encountered in experience).
    ...                 `element`           Element selector/locator or element object itself.
    [Arguments]     ${element}              ${timeout}=30s
    Wait Until Element Is Enabled           ${element}                      timeout=${timeout}
    Wait Until Keyword Succeeds     5x      5 sec       Click Element       ${element}

Set Input Field Value
    [Documentation]     Set the given value of an <input> or <textarea> field element, replacing the current value.
    ...                 If the input field is `readonly`, it will wait until `readonly` attribute will be removed
    ...                 (until the element is enabled).
    [Arguments]     ${locator}              ${value}                        ${timeout}=30s
    Wait Until Element Is Enabled           ${locator}                      timeout=${timeout}
    Input Text      ${locator}              ${value}

Append Input Field Value
    [Documentation]     Append the given value to an <input> or <textarea> element current value.
    [Arguments]     ${locator}              ${value}                        ${timeout}=30s
    Wait Until Element Is Visible           ${locator}                      timeout=${timeout}
    Input Text      ${locator}              ${value}                        clear=False

Clear Input Field Value
    [Documentation]     Append the given text to an <input> or  element current value.
    [Arguments]     ${locator}              ${timeout}=30s
    Wait Until Element Is Visible           ${locator}                      timeout=${timeout}
    Clear Element Text                      ${locator}

Selection List Option By Index
    [Documentation]     Selects an <option> from a <select> list by a given index.
    ...                 The index starts from 0.
    ...                 `locator` The selector of the <select> selection list.
    ...                 `index` The index of the corresponding <option> element to select.
    ...                 `timeout` 
    [Arguments]     ${locator}              ${index}                        ${timeout}=30s                  
    Wait Until Element Is Enabled           ${locator}                      timeout=${timeout}
    Select From List By Index               ${locator}                      ${index}

Selection List Option By Label
    [Documentation]     Selects an <option> from a <select> list by a given label.
    ...                 The label is the visible name of each <option>.
    ...                 `locator` The selector of the <select> selection list.
    ...                 `index` The index of the corresponding <option> element to select.
    ...                 `timeout` 
    [Arguments]     ${locator}              ${label}                        ${timeout}=30s                  
    Wait Until Element Is Enabled           ${locator}                      timeout=${timeout}
    Select From List By Label               ${locator}                      ${label}

Selection List Option By Value
    [Documentation]     Selects an <option> from a <select> list by a given value.
    ...                 The value is the `value` attribute of each <option>.
    ...                 `locator` The selector of the <select> selection list.
    ...                 `index` The index of the corresponding <option> element to select.
    ...                 `timeout` 
    [Arguments]     ${locator}              ${value}                        ${timeout}=30s                  
    Wait Until Element Is Enabled           ${locator}                      timeout=${timeout}
    Select From List By Value               ${locator}                      ${value}

Submit Form
    [Documentation]     Clicking the submit button of a <form>.
    [Arguments]     ${locator}=css=input[type="submit"]              ${timeout}=30s
    Click           ${locator}  timeout=${timeout}

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
