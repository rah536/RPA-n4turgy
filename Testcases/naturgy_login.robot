*** Settings ***

Library    SeleniumLibrary
Library    string
Library    RPA.FTP
Resource    ../Resources/config.robot
Resource    ../Resources/naturgy_keywords.robot
Resource    ../Resources/secrets.robot
Library     ../Resources/email_lib.py


*** Tasks ***
Notificar Factura Naturgy Al usuario
    [Documentation]    Tarea para notificar la descarga de la factura de Naturgy
    Log in Naturgy    &{DATOS_NATURGY}
    ${archivo_pdf}=    Descargar Factura Naturgy
    IF    $archivo_pdf != $None
        Notificacion Al Usuario    ${archivo_pdf}
    ELSE
        Notificacion Al Usuario   fallo_descarga
        Log    No se pudo descargar la factura de Naturgy.
    END

    
