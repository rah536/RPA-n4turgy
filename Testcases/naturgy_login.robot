*** Settings ***

Library    SeleniumLibrary
Library    string
Library    RPA.FTP
Resource    ../Resources/config.robot
Resource    ../Resources/naturgy_keywords.robot

*** Variables ***
${usuario}    raherrera536@gmail.com
${contrasena}    RAHnaturgy536

*** Tasks ***

Descargar factura Naturgy
    Open Browser    ${Naturgy_SRL}    Chrome
    Maximize Browser Window

    #cerrando popup
    Wait Until Element Is Visible    css=#popmake-61817 > button    timeout=10s
    Click Element    css=#popmake-61817 > button

    #entrando en la oficina virtual -obtiene url dentro del <a>#
    ${url}=    Get Element Attribute    xpath=//a[span[text()="Oficina Virtual"]]    href
    Go To    ${url}
    
    # Ingresando credenciales
    Wait Until Element Is Visible    css=input[data-testid="unifiedAuth.form.email"]    timeout=10s
    Wait Until Element Is Visible    css=input[data-testid="unifiedAuth.form.password"]    timeout=10s
    
    Input Text   css=input[data-testid="unifiedAuth.form.email"]    ${usuario}
    Input Text    css=input[data-testid="unifiedAuth.form.password"]    ${contrasena}

    #click en ingresar#
    Click Button    css=button[data-testid="unifiedAuth.submit"]

    #click en el enlace de descarga de la factura#
    Wait Until Element Is Visible    xpath=//button[.//div[text()="Descargar factura"]]    timeout=10s
    Click Button    xpath=//button[.//div[text()="Descargar factura"]]
    Esperar Que Archivo Se Descargue    factura.pdf

    Sleep    10s
    Close Browser