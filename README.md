# zurzulu-recon

**zurzulu-recon** — Script de reconocimiento OSINT/Recon automatizado.  
Autor: Sebastián (zurzulu). Propósito: demostrar habilidades en automatización segura, recolección de información pública y generación de reportes. Usar únicamente con autorización.

## Características
- Recolecta: whois, DNS, subdominios (si está instalado `subfinder`/`amass`), escaneo básico con `nmap`, detección de tecnologías con `whatweb` (si presente).
- Genera salida en JSON y HTML simple.
- Modo `--dry-run`, logs, y confirmaciones para acciones críticas.
- Comprobaciones de dependencias y manejo de errores.
- Buenas prácticas: idempotencia, no uso de `curl | sh`, y mensajes claros sobre legalidad/uso.

## Requisitos
- Bash (>=4), `jq`, `nmap`, `whois`, `dig` (bind-utils), `whatweb` (opcional), `subfinder` o `amass` (opcional).
- GitHub Actions usa `shellcheck` para linter.

> Nota: El script funciona aunque algunas herramientas falten — las saltará y documentará lo que hace. 

## Uso
Clona y ejecuta (modo seguro):
```bash
git clone https://github.com/<tu_usuario>/zurzulu-recon.git
cd zurzulu-recon
chmod +x zurzulu-recon.sh
./zurzulu-recon.sh --target example.com --outdir output --dry-run
