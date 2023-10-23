#!/bin/sh

# Arte ASCII
echo "                                                         
                            ::::.                           
                            @@@@=                           
                            @@@@-                           
                            @@@@:                           
                            %@@@.                           
                         ..:%@@@:::                         
                         --==+*----                         
                            .#*-                            
                           :#  ++                           
                          =*    =*                          
                         +=      :#                         
       .:               *-        .#.              .:       
     .*+@=-#          .#: :...:..:. #:          *=-%**-     
      +#%@=          .#.:.   :+    ..*-          :@%%*.     
        .@.         -# -     =*      :++          %=        
         @:        =+   :    -*    .:  -*         @:        
         **    .:=*=     ....:-....     :#=-:    =%         
          =****+=%-         .  .         .%==+***+.         
               .#:                        .#:               
              :#.  .      +=. ..=*      .   *-              
             -#           #@%+=#@@           ++             
            =*          . :.     : .          -*            
           *+      .          .         .      :#           
          +#============++=========+============+*          
                       =@:         %#                       
                      :@-          :@+                      
                      ##            *@                      
                      @+   -%:      :@-                     
                      -#%%#*@= @#=. =@:                     
                           .@-.@*=*#*:                      
                            .  %-                           
                                                                                           "

# Função para exibir a mensagem de saída
sair() {
  echo "
=============================================
   Oh não! Bill Cipher! Por favor, deixe-me em paz!
=============================================
"
  exit 0
}

# Função para realizar a auditoria de segurança
auditar_seguranca() {
  # Solicita o host a ser verificado
  echo "Digite o host a ser verificado:"
  read host

  # Verificação do whois do host
  echo "Verificação WHOIS do host:"
  whois $host

  # Obtenção das coordenadas geográficas
  coordenadas=$(curl -s https://ipinfo.io/$host/loc)

  if [ -n "$coordenadas" ]; then
    echo "Coordenadas geográficas do host: $coordenadas"
  else
    echo "Não foi possível obter as coordenadas geográficas do host."
  fi

  # Verificação de conexões de rede ativas
  echo "Verificando conexões de rede ativas:"
  netstat -tuln

  # Verificação de processos em execução
  echo "Verificando processos em execução:"
  ps aux

  # Verificação de portas abertas
  echo "Verificando portas abertas:"
  nmap -p 1-65535 $host

  # Verificação de permissões de arquivos
  echo "Verificando permissões de arquivos:"
  find / -type f -perm /o+w

  # Verificação de vulnerabilidades conhecidas
  echo "Verificando vulnerabilidades conhecidas:"
  nikto -h $host

  # Verificação de senhas fracas
  echo "Verificando senhas fracas:"
  john --users=usuarios.txt --wordlist=dicionario.txt

  # Verificação de logs do sistema
  echo "Verificando logs do sistema:"
  cat /var/log/syslog

  # Verificação de configurações de segurança
  echo "Verificando configurações de segurança:"
  grep "PermitRootLogin" /etc/ssh/sshd_config
  grep "PasswordAuthentication" /etc/ssh/sshd_config

  # Verificação de diretórios e arquivos suspeitos
  echo "Verificando diretórios e arquivos suspeitos:"
  find / -type d \( -name ".git" -o -name ".svn" -o -name ".DS_Store" \) -print

  # Verificação de vulnerabilidades de software
  echo "Verificando vulnerabilidades de software:"
  checksec --all

  # Verificação de privilégios de usuário
  echo "Verificando privilégios de usuário:"
  id

  # Escaneamento de diretórios
  echo "Escaneando diretórios do host:"
  dirb http://$host /usr/share/dirb/wordlists/common.txt

  # Finalização da auditoria de segurança
  echo "Auditoria de segurança concluída."
}

# Loop principal do script
while true; do
  echo "
  === Script de Auditoria de Segurança ===

  Opções:
  1. Realizar auditoria de segurança
  2. Sair

  Digite a opção desejada:"
  read opcao

  case $opcao in
    1)
      auditar_seguranca
      ;;
    2)
      sair
      ;;
    *)
      echo "Opção inválida. Tente novamente."
      ;;
  esac
done
