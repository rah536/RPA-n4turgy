*** Settings ***

Library    SeleniumLibrary
Library    string
Resource    ../Resources/config.robot
Resource    ../Resources/naturgy_keywords.robot




*** Tasks ***

Descargar factura Naturgy
    #[Arguments]    ${datos_usuario}
    #Log in Naturgy    ${datos_usuario}
    Click Element    xpath=//a[contains(@href, 'descargar-factura')]
    Wait Until Page Contains Element    xpath=//div[@class='factura-descargada']
    #Log To Console    Factura descargada correctamente para el usuario: ${datos_usuario}
