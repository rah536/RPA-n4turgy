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
    #Click Element    xpath=//button[contains(text(), 'x')]
    Wait Until Element Is Visible    css=#popmake-61817 > button    timeout=10s
    # Hacer clic en el botón para cerrarlo
    Click Element    css=#popmake-61817 > button
   
    #Close Browser