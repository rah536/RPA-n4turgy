*** Settings ***

Library    SeleniumLibrary
Library    string
Library    RPA.FTP
Resource    ../Resources/config.robot
Resource    ../Resources/naturgy_keywords.robot

*** Variables ***
&{datos_usuarios}
...    usuario=raherrera536@gmail.com
...    contrasena=RAHnaturgy536

*** Tasks ***
Notificar Factura Naturgy Al usuario
    [Documentation]    Tarea para notificar la descarga de la factura de Naturgy
    Log in Naturgy    ${datos_usuarios}
    Descargar Factura Naturgy
    Notificacion Al Usuario

    
