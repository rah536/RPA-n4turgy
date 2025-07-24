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
    #${ruta_captura}=    Capture Page Screenshot    google_screenshot.png
    #Log    Captura de pantalla guardada en: ${ruta_captura}
    #Close Browser