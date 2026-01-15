*** Settings ***

Library    SeleniumLibrary
Library    string
Library    OperatingSystem
Resource    config.robot

*** Variables ***
${DOWNLOAD_DIR}    ${OUTPUT DIR}${/}downloads
${PATRON}    238050_*.pdf
${RUTA_DESCARGAS}    ${OUTPUT DIR}${/}temp_downloads

*** Keywords ***
Log in Naturgy
    [Arguments]    ${datos_usuario}
    TRY
        # 1. Crear el directorio si no existe (y limpiarlo si quieres empezar de cero)
        Create Directory    ${RUTA_DESCARGAS}
        Empty Directory     ${RUTA_DESCARGAS}
        
        # 2. Normalizar la ruta para que funcione bien en Windows/Linux (evita problemas de barras)
        ${ruta_absoluta}=    Normalize Path    ${RUTA_DESCARGAS}
        
        # 3. Definir las preferencias de Chrome
        ${prefs}=    Create Dictionary
        ...    download.default_directory=${ruta_absoluta}
        ...    download.prompt_for_download=${False}
        ...    download.directory_upgrade=${True}
        ...    safebrowsing.enabled=${True}
        ...    plugins.always_open_pdf_externally=${True}    # CRÍTICO: Fuerza la descarga del PDF en lugar de abrirlo
        
        # 4. Agregar las preferencias a las opciones del navegador
        ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
        Call Method    ${chrome_options}    add_experimental_option    prefs    ${prefs}
            
        Open Browser    ${Naturgy_SRL}    Chrome    options=${chrome_options}
        Maximize Browser Window
        Cerrar Popup

        #entrando en la oficina virtual -obtiene url dentro del <a>
        ${url}=    Get Element Attribute    xpath=//a[span[text()="Oficina Virtual"]]    href
        Go To    ${url}

        #Ingresando credenciales
        Wait Until Element Is Visible    css=input[data-testid="unifiedAuth.form.email"]    timeout=10s
        Wait Until Element Is Visible    css=input[data-testid="unifiedAuth.form.password"]    timeout=10s
        
        Input Text   css=input[data-testid="unifiedAuth.form.email"]    ${datos_usuario['usuario']}
        Input Text    css=input[data-testid="unifiedAuth.form.password"]    ${datos_usuario['contrasena']}
    
        #Click ingreso
        Click Button    css=button[data-testid="unifiedAuth.submit"]
        
        #check de login correcto
        Wait Until Element Is Visible   css=[data-testid="topbar.title"]   timeout=30s
        Log   Se ingresa correctamente al sitio

    EXCEPT   AS    ${error}
        Log    Ocurrió un error: ${error}
        Fail    No se pudo iniciar sesión, se detiene la ejecución.
    END
    RETURN

Descargar Factura Naturgy
    TRY
        #click en el enlace de descarga de la factura
        Sleep   3s
        Wait Until Element Is Visible    css=button[data-testid="cuentas.resumen.billsList.billsListDownloadBill"]    timeout=10s
        Click Button    css=button[data-testid="cuentas.resumen.billsList.billsListDownloadBill"]
        Sleep    5s
        ${archivo_pdf}=    Confirmar Archivo Descargado    ${RUTA_DESCARGAS}    238050_
        Close Browser
        RETURN    ${archivo_pdf}
    EXCEPT    AS    ${error}
        Log    Ocurrió un error al descargar: ${error}
        Close Browser
    END 

Cerrar Popup
    #cerrando popup
    Wait Until Element Is Visible    css=#popmake-61817 > button    timeout=10s
    Click Element    css=#popmake-61817 > button
    Log   Popup cerrado con éxito!

Confirmar Archivo Descargado
    [Arguments]    ${directorio}    ${patron_fijo}
    ${patron_completo}=    Set Variable    ${patron_fijo}*.pdf
    ${ruta_archivo}=    Wait Until Keyword Succeeds    30s    2s    Verificar Y Obtener Archivo    ${directorio}    ${patron_completo}
    Log    Archivo encontrado en: ${ruta_archivo}
    RETURN    ${ruta_archivo}


Verificar Y Obtener Archivo
    [Arguments]    ${directorio}    ${patron}
    @{archivos}=    List Files In Directory    ${directorio}    ${patron}
    Should Not Be Empty    @{archivos}    No se encontró el archivo ${patron} en ${directorio}
    ${nombre_archivo}=    Set Variable    ${archivos}[0]
    ${ruta_completa}=    Join Path    ${directorio}    ${nombre_archivo}
    RETURN    ${ruta_completa}
Notificacion Al Usuario
    [Arguments]    ${archivo_pdf}

    IF  $archivo_pdf == 'fallo_descarga'
        Log    Se envia notificación al usuario, no se pudo descargar la factura de Naturgy.

        RETURN
    END

    Log    Notificación enviada al usuario sobre la descarga de la factura.