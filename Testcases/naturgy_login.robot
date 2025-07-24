*** Settings ***

Library    SeleniumLibrary
Library    string
Resource    ../Resources/config.robot
Resource    ../Resources/naturgy_keywords.robot

*** Variables ***
${usuario}    raherrera@gmail.com
${contrasena}    RAHnaturgy536

*** Tasks ***

Descargar factura Naturgy
    Open Browser    ${Naturgy_SRL}    Chrome
    Maximize Browser Window
    #cerrando popup
    Wait Until Element Is Visible    css=#popmake-61817 > button    timeout=10s
    Click Element    css=#popmake-61817 > button

    #entrando en la oficina virtual
    ${url}=    Get Element Attribute    xpath=//a[span[text()="Oficina Virtual"]]    href
    Go To    ${url}
    
    Close Browser