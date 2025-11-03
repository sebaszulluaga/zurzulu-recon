#!/bin/bash
# ---------------------------------------------------------
# ZURZULU RECON TOOL v1.0
# Autor: Sebastián Zuluaga (Zurzulu)
# Descripción: Script automatizado de reconocimiento para pentesting y OSINT
# ---------------------------------------------------------

# Colores para el output
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
RESET="\e[0m"

# Banner
echo -e "${GREEN}"
echo "███████╗██╗   ██╗██████╗ ███████╗██╗   ██╗██╗     ██╗     ██╗"
echo "██╔════╝██║   ██║██╔══██╗██╔════╝██║   ██║██║     ██║     ██║"
echo "███████╗██║   ██║██████╔╝█████╗  ██║   ██║██║     ██║     ██║"
echo "╚════██║██║   ██║██╔══██╗██╔══╝  ██║   ██║██║     ██║     ██║"
echo "███████║╚██████╔╝██║  ██║███████╗╚██████╔╝███████╗███████╗██║"
echo "╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚══════╝╚══════╝╚═╝"
echo -e "${RESET}"
echo -e "${YELLOW}[*] ZURZULU RECON v1.0 - Herramienta de reconocimiento automatizado${RESET}"
echo ""

# Verifica si se pasó un dominio
if [ -z "$1" ]; then
    echo -e "${RED}Uso: $0 -d <dominio>${RESET}"
    exit 1
fi

# Obtiene el dominio
while getopts "d:" opt; do
  case $opt in
    d) domain=$OPTARG ;;
    *) echo "Uso: $0 -d <dominio>"; exit 1 ;;
  esac
done

# Crea carpeta de resultados
mkdir -p results/$domain
output_dir="results/$domain"

echo -e "${YELLOW}[+] Iniciando reconocimiento para: ${GREEN}$domain${RESET}"
sleep 2

# WHOIS
echo -e "${YELLOW}[+] WHOIS...${RESET}"
whois $domain > $output_dir/whois.txt

# DNS
echo -e "${YELLOW}[+] DNS info...${RESET}"
dig $domain ANY +noall +answer > $output_dir/dns.txt

# Subdominios
echo -e "${YELLOW}[+] Enumerando subdominios...${RESET}"
subfinder -d $domain -silent > $output_dir/subdomains.txt

# Puertos abiertos
echo -e "${YELLOW}[+] Escaneo de puertos con nmap...${RESET}"
nmap -Pn -T4 -p- --min-rate=1000 $domain -oN $output_dir/ports.txt

# Tecnologías detectadas
echo -e "${YELLOW}[+] Identificando tecnologías...${RESET}"
whatweb $domain > $output_dir/whatweb.txt

# Final
echo -e "\n${GREEN}[✔] Reconocimiento completo. Resultados guardados en: ${output_dir}${RESET}"
