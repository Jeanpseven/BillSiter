import subprocess

def print_ascii_art():
    ascii_art = """
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
"""
    print(ascii_art)

def perform_security_audit():
    host = input("Digite o host a ser verificado: ")

    print("Verificação WHOIS do host:")
    subprocess.run(["whois", host])

    print("Obtenção das coordenadas geográficas do host:")
    try:
        subprocess.run(["curl", "-s", f"https://ipinfo.io/{host}/loc"], check=True)
    except subprocess.CalledProcessError:
        print("Não foi possível obter as coordenadas geográficas do host.")

    print("Verificando portas abertas e versões de serviços:")
    subprocess.run(["nmap", "-p", "1-65535", "-sV", host])

    nmap_result = subprocess.run(["nmap", "-p", "1-65535", "--open", "--min-rate=1000", "--max-retries=2", "-oG", "-", host],
                                 stdout=subprocess.PIPE, text=True, check=True)

    for line in nmap_result.stdout.splitlines():
        if "/open/" in line:
            port = line.split("/")[0]
            service_version = line.split(" ")[-1]
            print(f"Procurando exploits para {service_version} na porta {port}:")
            subprocess.run(["searchsploit", service_version])

    print("Verificando permissões de arquivos:")
    subprocess.run(["find", "/", "-type", "f", "-perm", "/o+w"])

    print("Verificando vulnerabilidades conhecidas:")
    subprocess.run(["nikto", "-h", host])

    print("Verificando senhas fracas:")
    subprocess.run(["john", "--users=usuarios.txt", "--wordlist=dicionario.txt"])

    print("Verificando logs do sistema:")
    subprocess.run(["cat", "/var/log/syslog"])

    print("Verificando configurações de segurança:")
    subprocess.run(["grep", "PermitRootLogin", "/etc/ssh/sshd_config"])
    subprocess.run(["grep", "PasswordAuthentication", "/etc/ssh/sshd_config"])

    print("Verificando diretórios e arquivos suspeitos:")
    subprocess.run(["find", "/", "-type", "d", "-name", ".git", "-o", "-name", ".svn", "-o", "-name", ".DS_Store", "-print"])

    print("Verificando vulnerabilidades de software:")
    subprocess.run(["checksec", "--all"])

    print("Verificando privilégios de usuário:")
    subprocess.run(["id"])

    print("Escaneando diretórios do host:")
    subprocess.run(["dirb", f"http://{host}", "/usr/share/dirb/wordlists/common.txt"])

    # ... (additional security checks if needed)

    print(f"Auditoria de segurança concluída para o host {host}.")

def main():
    while True:
        print("""
  === Script de Auditoria de Segurança ===

  Opções:
  1. Realizar auditoria de segurança
  2. Sair
        """)
        opcao = input("Digite a opção desejada: ")

        if opcao == "1":
            perform_security_audit()
        elif opcao == "2":
            print("Saindo do script. Até logo!")
            break
        else:
            print("Opção inválida. Tente novamente.")

if __name__ == "__main__":
    print_ascii_art()
    main()
    
