    # Verificação de permissões de arquivos
    executar_comando_e_registrar_saida("find / -type f -perm /o+w", "Verificando permissões de arquivos")

    # Verificação de vulnerabilidades conhecidas
    executar_comando_e_registrar_saida(f"nikto -h {host}", "Verificando vulnerabilidades conhecidas")

    # Verificação de senhas fracas
    executar_comando_e_registrar_saida("john --users=usuarios.txt --wordlist=dicionario.txt", "Verificando senhas fracas")

    # Verificação de logs do sistema
    executar_comando_e_registrar_saida("cat /var/log/syslog", "Verificando logs do sistema")

    # Verificação de configurações de segurança
    executar_comando_e_registrar_saida("grep 'PermitRootLogin' /etc/ssh/sshd_config", "Verificando configurações de segurança (PermitRootLogin)")
    executar_comando_e_registrar_saida("grep 'PasswordAuthentication' /etc/ssh/sshd_config", "Verificando configurações de segurança (PasswordAuthentication)")

    # Verificação de diretórios e arquivos suspeitos
    executar_comando_e_registrar_saida("find / -type d \( -name '.git' -o -name '.svn' -o -name '.DS_Store' \) -print", "Verificando diretórios e arquivos suspeitos")

    # Verificação de vulnerabilidades de software
    executar_comando_e_registrar_saida("checksec --all", "Verificando vulnerabilidades de software")

    # Verificação de privilégios de usuário
    executar_comando_e_registrar_saida("id", "Verificando privilégios de usuário")

    # Escaneamento de diretórios
    executar_comando_e_registrar_saida(f"dirb http://{host} /usr/share/dirb/wordlists/common.txt", "Escaneando diretórios do host")

    # Finalização da auditoria de segurança
    with open(log_file, "a") as log:
        log.write(f"Auditoria de segurança concluída para o host {host}.\n")

# Loop principal do script
while True:
    print("""
  === Script de Auditoria de Segurança ===

  Opções:
  1. Realizar auditoria de segurança
  2. Sair
    """)

    opcao = input("Digite a opção desejada: ")

    if opcao == "1":
        auditar_seguranca()
    elif opcao == "2":
        sair()
    else:
        print("Opção inválida. Tente novamente.")
