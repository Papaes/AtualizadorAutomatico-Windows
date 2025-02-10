@echo off
setlocal enabledelayedexpansion

:: Definir local do log
set LOGFILE=C:\Logs\Atualizacao_Log.txt
echo. > "%LOGFILE%"

:: Notificação inicial
msg * "A atualização do sistema está começando. Por favor, aguarde."

echo ================================================== >> "%LOGFILE%"
echo Iniciando o processo de atualização do sistema... >> "%LOGFILE%"
echo ==================================================
echo.

:: Atualizar pacotes usando Winget
echo [1/5] Atualizando pacotes com Winget...
echo [1/5] Atualizando pacotes com Winget... >> "%LOGFILE%"
winget upgrade --all --silent >> "%LOGFILE%" 2>&1
if %errorlevel% neq 0 (
    echo Erro ao atualizar pacotes com Winget. Veja o log. >> "%LOGFILE%"
) else (
    echo Atualização concluída com sucesso! >> "%LOGFILE%"
)
echo.

:: Executar verificação de arquivos do sistema
echo [2/5] Verificando arquivos do sistema (sfc /scannow)...
echo [2/5] Verificando arquivos do sistema (sfc /scannow)... >> "%LOGFILE%"
sfc /scannow >> "%LOGFILE%" 2>&1
if %errorlevel% neq 0 (
    echo Erro na verificação de arquivos do sistema. >> "%LOGFILE%"
) else (
    echo Nenhum erro encontrado! >> "%LOGFILE%"
)
echo.

:: Verificar a integridade da imagem do Windows
echo [3/5] Verificando a integridade da imagem do sistema...
echo [3/5] Verificando a integridade da imagem do sistema... >> "%LOGFILE%"
dism /online /cleanup-image /CheckHealth >> "%LOGFILE%" 2>&1
if %errorlevel% neq 0 (
    echo Problemas detectados na imagem do sistema. >> "%LOGFILE%"
) else (
    echo Nenhum problema encontrado na integridade. >> "%LOGFILE%"
)
echo.

:: Restaurar a integridade da imagem do Windows
echo [4/5] Tentando reparar a integridade da imagem do sistema...
echo [4/5] Tentando reparar a integridade da imagem do sistema... >> "%LOGFILE%"
dism /online /cleanup-image /restorehealth >> "%LOGFILE%" 2>&1
if %errorlevel% neq 0 (
    echo Erro ao tentar restaurar a imagem do sistema. >> "%LOGFILE%"
) else (
    echo Restauração concluída com sucesso! >> "%LOGFILE%"
)
echo.

:: Notificação final
msg * "A atualização e verificação do sistema foram concluídas! Confira o log na Área de Trabalho."

:: Agendar execução automática (Opcional)
echo Deseja agendar esse script para rodar automaticamente? (S/N)
set /p resposta=
if /I "%resposta%"=="S" (
    schtasks /create /tn "Atualizacao_Sistema" /tr "%~f0" /sc weekly /d SUN /st 10:00 /rl highest /f
    echo Script agendado para rodar automaticamente todo domingo às 10h.
    msg * "O script foi agendado para rodar automaticamente todo domingo às 10h."
)

echo ================================================== >> "%LOGFILE%"
echo Processo concluído. Verifique o log em "%LOGFILE%" para detalhes. >> "%LOGFILE%"
echo ==================================================
echo Processo concluído. O log está salvo na Área de Trabalho.

timeout /t 5 /nobreak >nul
exit
