🚀 Script de Atualização e Verificação do Windows

📌 Descrição

Este script automatiza a atualização de pacotes no Windows e realiza verificações de integridade do sistema, garantindo mais estabilidade e segurança .

⚡ Principais funcionalidades:

✅ Atualizar todos os pacotes via Winget

✅ Verificar e reparar arquivos do sistema com SFC e DISM

✅ Exibe notificações visuais para o usuário

✅ Gera logs automáticos para análise posterior

✅ Permite agendamento automático da execução


🔧 Como funciona o Script?

1. Definição do Arquivo de Log

set LOGFILE=%USERPROFILE%\Desktop\Atualizacao_Log.txt

set LOGFILE=%USERPROFILE%\Desktop\Atualizacao_Log.txt

📌 O log de execução será salvo na Área de Trabalho do usuário para facilitar a consulta.

🚨 Problema Resolvido:

inicialmente, alguns usuários enfrentaram erros do tipo "O sistema não pode encontrar o caminho especificado.".
Para corrigir isso, alteramos o caminho do log para C:\Logs , criando uma pasta manualmente, se necessário.

mkdir C:\Logs

set LOGFILE=C:\Logs\Atualizacao_Log.txt

🔄 2. Atualização de Pacotes com Winget

winget upgrade --all --silent >> "%LOGFILE%" 2>&1

🖥️ O Winget verifica e atualiza todos os programas instalados no sistema.

✔ Se houver falhas, o erro será salvo no log.

🛠 3. Verificação de Arquivos do Sistema (SFC)

sfc /scannow >> "%LOGFILE%" 2>&1

🔍 O comando SFC (System File Checker) analisa e repara arquivos relacionados do Windows.

🏗 4. Diagnóstico e Reparo de Imagem do Windows (DISM)

dism /online /cleanup-image /CheckHealth >> "%LOGFILE%" 2>&1

dism /online /cleanup-image /restorehealth >> "%LOGFILE%" 2>&1

🛡 DISM (Deployment Image Servicing and Management) é usado para verificar e corrigir arquivos essenciais do sistema operacional.

🔔 5. Notificações Visuais para o Usuário

msg * "A atualização do sistema está começando. Por favor, aguarde."

msg * "A atualização e verificação do sistema foram concluídas! Confira o log na Área de Trabalho."

📢 O usuário recebe alertas visuais no Windows informando o progresso e a conclusão da execução.

⏳ 6. Pergunta sobre Agendamento Automático

echo Deseja agendar esse script para rodar automaticamente? (S/N)

set /p resposta=

if /I "%resposta%"=="S" ( schtasks /create /tn "Atualizacao_Sistema" /tr "%~f0" /sc weekly /d SUN /st 10:00 /rl highest /f msg * "O script foi agendado para rodar automaticamente todo domingo às 10h.")

⏰ Se o usuário aceitar ( S), o script será executado automaticamente todo domingo às 10h .

🖥 Como usar?

1️⃣ Baixe o script: 

2️⃣ Clique com o botão direito e selecione "Executar como Administrador" 

3️⃣ Aguarde o processo ser concluído 

4️⃣ O log será salvo ematualiza_windows.bat

C:\Logs\Atualizacao_Log.txt

💡 Benefícios

✔ Mantenha o sistema atualizado automaticamente 🖥

✔ Previna erros e corrupções no Windows 🔧

✔ Melhore a estabilidade do PC 🚀

✔ Permite diagnóstico fácil com logs 📄

✔ Pode ser executado manualmente ou agendado ⏰
