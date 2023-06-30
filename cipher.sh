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

# Script de auditoria de segurança

# Solicita o host a ser verificado
echo "Digite o host a ser verificado:"
read host

# Verificação do whois do host
echo "Verificação WHOIS do host:"
whois $host

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

# Finalização da auditoria de segurança
echo "Auditoria de segurança concluída."



