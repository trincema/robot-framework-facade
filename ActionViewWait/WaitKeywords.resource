*** Settings ***
Library         SeleniumLibrary

*** Keywords ***
Wait Until Visible
    [Documentation]     Waiting for the element to be visible in the browser.
    ...                 `element`           Element selector/locator or element object itself.
    ...                 `timeout`           Timeout to wait until the page contains the element and the element reaches the ENABLED state to be clickable. Default to 30s.
    [Arguments]         ${locator}          ${timeout}=30s
    Wait Until Element Is Visible           ${locator}          timeout=${timeout}

Wait Until Invisible
    [Documentation]     Waiting for the element to be invisible in the browser.
    ...                 `element`           Element selector/locator or element object itself.
    ...                 `timeout`           Timeout to wait until the page contains the element and the element reaches the ENABLED state to be clickable. Default to 30s.
    [Arguments]         ${locator}          ${timeout}=30s
    Wait Until Element Is Invisible         ${locator}          timeout=${timeout}

Wait Until Element Exists
    [Documentation]     Waiting for the element to be present in the browser.
    ...                 `element`           Element selector/locator or element object itself.
    ...                 `timeout`           Timeout to wait until the page contains the element and the element reaches the ENABLED state to be clickable. Default to 30s.
    [Arguments]         ${locator}          ${timeout}=30s
    Wait Until Page Contains Element        ${locator}          timeout=${timeout}

Wait Until Element Does Not Exist
    [Documentation]     Waiting for the element to be absent from the browser.
    ...                 `element`           Element selector/locator or element object itself.
    ...                 `timeout`           Timeout to wait until the page contains the element and the element reaches the ENABLED state to be clickable. Default to 30s.
    [Arguments]         ${locator}          ${timeout}=30s
    Wait Until Page Does Not Contain Element  ${locator}          timeout=${timeout}

Wait Until Clickable
    [Documentation]     Waiting for the element to be clickable.
    ...                 `element`           Element selector/locator or element object itself.
    ...                 `timeout`           Timeout to wait until the page contains the element and the element reaches the ENABLED state to be clickable. Default to 30s.
    [Arguments]         ${locator}          ${timeout}=30s
    Wait Until Element Is Enabled           ${locator}          timeout=${timeout}