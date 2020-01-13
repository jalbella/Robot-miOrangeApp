*** Settings ***
Documentation    Ejemplo sencillo de automatizacion de pruebas con robotframework y la libreria de selenium
Library    SeleniumLibrary
#https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html#Capture%20Page%20Screenshot
Library    ExcelLibrary
#https://rawgit.com/peterservice-rnd/robotframework-excellib/master/docs/ExcelLibrary.html
Library    DateTime
Suite Setup    NONE
Test Setup    NONE
Test Teardown    Run Keyword If Test Failed    Close Browser
Suite Teardown    Close All Browsers
Default Tags    All Regression Tests

*** Variables ***
${LOGIN URL}    https://areaprivada.orange.es/movilizado/index.html
${BROWSER}      chrome
${Toggle_Capturas_Evidencias}    false
#Si se activa el Toggle_Capturas_Evidencias, realiza capturas de evidencias de todos los tests.

*** Test Cases ***    
Login_CLU_OK
    [Tags]    Login
    ${Hoja_excel}=    Set Variable    LoginCLU_Tests_OK
    @{datos}=    Leer_Datos_Excel   hoja=${Hoja_excel}
    ${fecha}=    Set fecha test
    Run Keyword If    '${Toggle_Capturas_Evidencias}'=='true'    
    ...    Set Screenshot Directory    test/results/LoginCLU/OK/${fecha}
    FOR    ${usuario}   ${password}  ${mercado}    ${resultado_esperado}    IN    @{datos}
        Abrir miOrangeApp Movilizado
        log    Ejecutando Test...
        log    Msisdn: ${usuario}
        log    Password: ${password}
        log    Mercado: ${mercado}
        log    Resultado esperado: ${resultado_esperado}
        Login    ${usuario}    ${password}    ${Hoja_excel}    ${mercado}
        Close Browser
    END
Login_CLU_KO
    [Tags]    Login
    ${Hoja_excel}=    Set Variable    LoginCLU_Tests_KO
    @{datos}=    Leer_Datos_Excel   hoja=${Hoja_excel}
    ${fecha}=    set fecha test
    Run Keyword If    '${Toggle_Capturas_Evidencias}'=='true'    
    ...    Set Screenshot Directory    test/results/LoginCLU/KO/${fecha}
    FOR    ${usuario}   ${password}  ${mercado}    ${resultado_esperado}    IN    @{datos}
        Abrir miOrangeApp Movilizado
        log    Ejecutando Test...
        log    Msisdn: ${usuario}
        log    Password: ${password}
        log    Mercado: ${mercado}
        log    Resultado esperado: ${resultado_esperado}
        Login    ${usuario}    ${password}    ${Hoja_excel}    ${mercado}
        Close Browser
    END
Consulta MiLinea
    [Tags]    Consultas
    ${Hoja_excel}=    Set Variable    Consulta_MiLinea
    @{datos}=    Leer_Datos_Excel   hoja=${Hoja_excel}
    ${fecha}=    Set fecha test
    Run Keyword If    '${Toggle_Capturas_Evidencias}'=='true'    
    ...    Set Screenshot Directory    test/results/Milinea/${fecha}
    FOR    ${usuario}   ${password}  ${mercado}    ${resultado_esperado}    IN    @{datos}
        Abrir miOrangeApp Movilizado
        log    Ejecutando Test...
        log    Msisdn: ${usuario}
        log    Password: ${password}
        log    Mercado: ${mercado}
        log    Resultado esperado: ${resultado_esperado}
        Login    ${usuario}    ${password}    ${Hoja_excel}    ${mercado}
        Pagina_MiLinea
        Close Browser
    END 
Consulta_Bola_Facturas
    [Tags]    Consultas
    ${Hoja_excel}=    Set Variable    Consulta_Factura
    @{datos}=    Leer_Datos_Excel   hoja=${Hoja_excel}
    ${fecha}=    Set fecha test
    Run Keyword If    '${Toggle_Capturas_Evidencias}'=='true'    
    ...    Set Screenshot Directory    test/results/Facturas/${fecha}
    FOR    ${usuario}   ${password}  ${mercado}    ${resultado_esperado}    IN    @{datos}
        Abrir miOrangeApp Movilizado
        log    Ejecutando Test...
        log    Msisdn: ${usuario}
        log    Password: ${password}
        log    Mercado: ${mercado}
        log    Resultado esperado: ${resultado_esperado}
        Login    ${usuario}    ${password}    ${Hoja_excel}    ${mercado}
        Pagina_Facturas
        Close Browser
    END 
Consulta_CPs
    [Tags]    Consultas
    ${Hoja_excel}=    Set Variable    Consulta_CPs
    @{datos}=    Leer_Datos_Excel   hoja=${Hoja_excel}
    ${fecha}=    Set fecha test
    Run Keyword If    '${Toggle_Capturas_Evidencias}'=='true'    
    ...    Set Screenshot Directory    test/results/Milinea/CPs/${fecha}
    FOR    ${usuario}   ${password}  ${mercado}    ${resultado_esperado}    IN    @{datos}
        Abrir miOrangeApp Movilizado
        log    Ejecutando Test...
        log    Msisdn: ${usuario}
        log    Password: ${password}
        log    Mercado: ${mercado}
        log    Resultado esperado: ${resultado_esperado}
        Login    ${usuario}    ${password}    ${Hoja_excel}    ${mercado}
        Pagina_Milinea
        Pagina_CPs
        Close Browser
    END
Consulta_Datos_Contrato
    [Tags]    Consultas
    ${Hoja_excel}=    Set Variable    Consulta_Contrato
    @{datos}=    Leer_Datos_Excel   hoja=${Hoja_excel}
    ${fecha}=    Set fecha test
    Run Keyword If    '${Toggle_Capturas_Evidencias}'=='true'    
    ...    Set Screenshot Directory    test/results/Milinea/DatosContrato/${fecha}
    FOR    ${usuario}   ${password}  ${mercado}    ${resultado_esperado}    IN    @{datos}
        Abrir miOrangeApp Movilizado
        log    Ejecutando Test...
        log    Msisdn: ${usuario}
        log    Password: ${password}
        log    Mercado: ${mercado}
        log    Resultado esperado: ${resultado_esperado}
        Login    ${usuario}    ${password}    ${Hoja_excel}    ${mercado}
        Pagina_Milinea
        Pagina_Contrato
        Close Browser
    END
 
*** Keywords ***
Set fecha test
    ${fecha}=    Get Current Date    local
    ${fecha}=    Convert Date    ${fecha}    result_format=%Y-%m-%d
    [return]    ${fecha}   
Leer_Datos_Excel
    [Arguments]    @{datos}    ${hoja}
    Open Excel Document    filename=testcases.xlsx    doc_id=tests  
    @{datos}=    Read Excel Column    col_num=2    sheet_name=${hoja}
    Close All Excel Documents
    [Return]    @{datos}
Abrir miOrangeApp Movilizado
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Set Window Size    400    800
    Set Window Position    0    0
    Set Browser Implicit Wait    30
Login
    [arguments]    ${usuario}    ${password}    ${Hoja_excel}    ${mercado}
    Run Keyword If    '${usuario}'!='None'
    ...    Input Text    name=msisdn    ${usuario}
    Run Keyword If    '${password}'!='None'    
    ...    input text    id=tealeaf_user_password    ${password}
    Run Keyword If    '${Hoja_excel}'=='LoginCLU_Tests_KO'    
    ...    Run Keyword If    '${Toggle_Capturas_Evidencias}'=='true'    
    ...        Pantallazo_LoginCLU_KO    ELSE    
    ...            Pantallazo_LoginCLU_OK 
    Press Keys    id=tealeaf_user_password    ENTER
    sleep    1
    Run Keyword If    '${Hoja_excel}'=='LoginCLU_Tests_KO'    
    ...    Run Keyword If    '${Toggle_Capturas_Evidencias}'=='true'    
    ...        Pantallazo_LoginCLU_KO    ELSE    
    ...            sleep    10 
    Run Keyword If    '${Hoja_excel}'!='LoginCLU_Tests_KO'    
    ...    Run Keyword If    '${mercado}'=='Residencial Pospago'    
    ...        Click Button    //*[contains(text(),'Ahora no')]
    Run Keyword If    '${Hoja_excel}'!='LoginCLU_Tests_KO'    
    ...    Sleep    1 
    Run Keyword If    '${Hoja_excel}'!='LoginCLU_Tests_KO'    
    ...    Run Keyword If    '${Toggle_Capturas_Evidencias}'=='true'    
    ...        Pantallazo_LoginCLU_OK
Pagina_Milinea
    Wait Until Element Is Enabled    id=accesoLinea
    Wait Until Element Is Visible    id=accesoLinea
    Click Element    id=accesoLinea
    Sleep    10
    Run Keyword If    '${Toggle_Capturas_Evidencias}'=='true'    
    ...    Pantallazo_Pagina_MiLinea
    Wait Until Page Contains Element    //module-link[@link-module="cmsPagina.modules[22]"]
    Wait Until Element Is Enabled    //module-link[@link-module="cmsPagina.modules[22]"] 
    Scroll Element Into View    //module-link[@link-module="cmsPagina.modules[22]"] 
    Run Keyword If    '${Toggle_Capturas_Evidencias}'=='true'    
    ...    Pantallazo_Pagina_MiLinea
    Wait Until Page Contains Element    //module-link[@link-module="cmsPagina.modules[33]"]
    Wait Until Element Is Enabled    //module-link[@link-module="cmsPagina.modules[33]"] 
    Scroll Element Into View    //module-link[@link-module="cmsPagina.modules[33]"] 
    Run Keyword If    '${Toggle_Capturas_Evidencias}'=='true'    
    ...    Pantallazo_Pagina_MiLinea 
Pagina_Facturas
    Wait Until Element Is Enabled    id=accesoFacturas
    Wait Until Element Is Visible    id=accesoFacturas   
    Click Element                    id=accesoFacturas
    sleep    1
    Wait Until Page Contains Element    //module-link[@link-module="cmsPagina.modules[18]"]
    Wait Until Element Is Enabled    //module-link[@link-module="cmsPagina.modules[18]"] 
    Run Keyword If    '${Toggle_Capturas_Evidencias}'=='true'    
    ...    Pantallazo_Pagina_Facturas    
Pagina_CPs
    Wait Until Page Contains Element    //module-link[@link-module="cmsPagina.modules[22]"]
    Wait Until Element Is Enabled    //module-link[@link-module="cmsPagina.modules[22]"] 
    Scroll Element Into View    //permanenceagreement[@permanence-agreement='cmsPagina.modules[24]'] 
    Run Keyword If    '${Toggle_Capturas_Evidencias}'=='true'    
    ...    Pantallazo_Pagina_Milinea
    ${cp}=    Get Text    //span[@class="text-grey_APP15 ng-binding"]
    Run Keyword If    '${cp}'!='Actualmente no tienes permanencia'    
    ...    Click Element    //div[@class="padding-x_APP15 padding-top_APP15"]   
    Run Keyword If    '${cp}'!='Actualmente no tienes permanencia'    
    ...        Wait Until Page Contains Element    //*[contains(text(),'Fecha inicio')]
    Run Keyword If    '${cp}'!='Actualmente no tienes permanencia'
    ...        sleep    1
    Run Keyword If    '${Toggle_Capturas_Evidencias}'=='true'    
    ...    Run Keyword If    '${cp}'!='Actualmente no tienes permanencia'    
    ...        Pantallazo_Pagina_CPs
Pagina_Contrato
    Wait Until Page Contains Element    //module-link[@link-module="cmsPagina.modules[22]"]
    Wait Until Element Is Enabled    //module-link[@link-module="cmsPagina.modules[22]"] 
    Wait Until Page Contains Element    //module-link[@link-module="cmsPagina.modules[27]"]
    Wait Until Element Is Enabled    //module-link[@link-module="cmsPagina.modules[27]"]
    Scroll Element Into View    //module-link[@link-module="cmsPagina.modules[29]"]
    Click Element    //module-link[@link-module="cmsPagina.modules[29]"]
    sleep    2
    Wait Until Page Contains Element    //userdata[@datos-contrato="cmsPagina.modules[3]"]
    Wait Until Element Is Enabled    //userdata[@datos-contrato="cmsPagina.modules[3]"]
    Run Keyword If    '${Toggle_Capturas_Evidencias}'=='true'    
    ...    Pantallazo_Pagina_Contrato
    Run Keyword If    '${Toggle_Capturas_Evidencias}'=='true'    
    ...    Scroll Element Into View    //userdata[@datos-contrato="cmsPagina.modules[3]"]
    Run Keyword If    '${Toggle_Capturas_Evidencias}'=='true'    
    ...    Pantallazo_Pagina_Contrato
Pantallazo_LoginCLU_OK
    Capture Page Screenshot    LoginCLU_OK-{index}.png
Pantallazo_LoginCLU_KO
    Capture Page Screenshot    LoginCLU_KO-{index}.png
Pantallazo_Pagina_Facturas
    Capture Page Screenshot    Bola_Facturas_OK-{index}.png
Pantallazo_Pagina_Milinea
    Capture Page Screenshot    Milinea_OK-{index}.png
Pantallazo_Pagina_CPs
    Capture Page Screenshot    CPs_OK-{index}.png
Pantallazo_Pagina_Contrato
    Capture Page Screenshot    Contrato_OK-{index}.png