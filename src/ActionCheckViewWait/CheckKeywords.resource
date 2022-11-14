*** Settings ***
Library                 SeleniumLibrary

*** Keywords ***
Expect To Be Equal
    [Documentation]     Expect the given values to be Equal.
    [Arguments]         ${first}            ${second}
    Should Be Equal     ${first}            ${second}
