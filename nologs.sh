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

# Função para realizar a auditoria de segurança
auditar_seguranca() {
  # Solicita o host a ser verificado
  echo "Digite o host a ser verificado:"
  read host

  # Verificação WHOIS do host
  echo "Verificação WHOIS do host:"
  whois $host

  # Obtenção das coordenadas geográficas
  coordenadas=$(curl -s https://ipinfo.io/$host/loc)
  if [ -n "$coordenadas" ]; then
    echo "Coordenadas geográficas do host: $coordenadas"
  else
    echo "Não foi possível obter as coordenadas geográficas do host."
  fi

  # Verificação de portas abertas e versões de serviços
  echo "Verificando portas abertas e versões de serviços:"
  nmap -p 1-65535 -sV $host

  # Obtenha as versões dos serviços e procure por exploits usando searchsploit
  while read line; do
    port=$(echo $line | cut -d'/' -f1)
    service_version=$(echo $line | cut -d' ' -f3-)
    echo "Procurando exploits para $service_version na porta $port:"
    searchsploit "$service_version"
  done < <(nmap -p 1-65535 --open --min-rate=1000 --max-retries=2 -oG - $host | grep "/open/")

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

  # ... (additional security checks if needed)

  # Mensagem de conclusão da auditoria de segurança
  echo "Auditoria de segurança concluída para o host $host."
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
