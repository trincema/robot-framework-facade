*** Settings ***
Documentation    Resource file for demo purposes.
...              This resource is only used in an example and it doesn't do anything useful.
Library         SeleniumLibrary

*** Keywords ***
Get Element Text
    [Documentation]     Aquiring and returning the text content (between the opening and closing tag) of an element
    ...                 located by the given selector/locator or even from the element object itself.
    ...                 Elements with text: `<div>`, `<span>`, etc.
    ...                 Elements without content: `<input>`, `<textarea>`
    [Arguments]         ${element}          ${timeout}=30s
    Wait Until Page Contains Element        ${element}                  timeout=${timeout}
    ${elementText} =    Get Text            ${element}
    [Return]                                ${elementText}

Get Element Value
    [Documentation]     Aquiring and returning the value of an element located by the given selector/locator or even from the element object itself.
    ...                 Elements with value: `<input>`,`<textarea>`
    ...                 Notes: <input> and <textarea> fields usually don't have text.
    [Arguments]         ${element}          ${timeout}=30s
    Wait Until Page Contains Element        ${element}                  timeout=${timeout}
    ${elementText} =    Get Value           ${element}
    [Return]                                ${elementText}

Get All Elements
    [Documentation]     Aquiring and returning a list with all elements found on the page with the given locator.
    [Arguments]         ${element}          ${expectedCount}=1          ${timeout}=60s
    Wait Until Page Contains Element        ${element}                  timeout=${timeout}
    ${elementList} =    Get WebElements     ${element}
    [Return]                                ${elementList}
