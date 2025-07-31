*** Settings ***

Library    SeleniumLibrary
Library    string
Library    OperatingSystem
Resource    config.robot

*** Variables ***
${DOWNLOAD_DIR}    ${OUTPUT DIR}${/}downloads

*** Keywords ***

Log in Naturgy
    [Arguments]    ${datos_usuario}
    Open Browser    ${Naturgy_SRL}    Chrome
    Maximize Browser Window
    RETURN   ${datos_usuario}

Abrir Navegador Con Descargas
    ${prefs}=    Create Dictionary    download.default_directory=${DOWNLOAD_DIR}    download.prompt_for_download=false    plugins.always_open_pdf_externally=true
    ${options}=  Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method  ${options}  add_experimental_option  prefs  ${prefs}
    Open Browser    https://ejemplo.com    chrome    options=${options}

Esperar Que Archivo Se Descargue
    [Arguments]    ${filename}    ${timeout}=30s
    ${path}=    Set Variable    ${DOWNLOAD_DIR}${/}${filename}
    Wait Until Keyword Succeeds    ${timeout}    1s    File Should Exist    ${path}