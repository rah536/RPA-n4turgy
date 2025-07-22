*** Settings ***

Library    SeleniumLibrary
Library    string
Resource    config.robot

*** Variables ***

*** Keywords ***

Log in Naturgy
    [Arguments]    ${datos_usuario}
    Open Browser    ${Naturgy_SRL}    Chrome
    #Maximize Browser Window#
    RETURN   ${datos_usuario}
