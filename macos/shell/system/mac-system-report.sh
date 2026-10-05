#!/usr/bin/env bash
# ============================================================
# BATLAB | mac-system-report.sh | v1.0.0
# @desc      Resumo do macOS: versao, hardware, uptime e armazenamento
# @category  system
# @platform  macos
# @admin     no
# @risk      low
# @writes none
# @deletes none
# @registry none
# @services none
# @tasks none
# @network none
# @restart none
# @undo      Somente leitura: nada a desfazer
# ============================================================

echo "============================================"
echo " BATLAB - Mac System Report"
echo "============================================"

echo "macOS.....: $(sw_vers -productVersion 2>/dev/null || echo '?') (build $(sw_vers -buildVersion 2>/dev/null || echo '?'))"
echo "Hardware..: $(sysctl -n hw.model 2>/dev/null || echo '?')"
echo "Processador: $(sysctl -n machdep.cpu.brand_string 2>/dev/null || echo '?')"
echo "Memoria...: $(echo "$(sysctl -n hw.memsize 2>/dev/null || echo 0) / 1024 / 1024 / 1024" | bc 2>/dev/null || echo '?') GB"
echo "Kernel....: $(uname -sr)"
uptime 2>/dev/null | sed 's/^/Uptime....: /'

echo
echo "Armazenamento (/):"
df -h / 2>/dev/null || echo "  (df indisponivel)"

echo
read -r -p "Pressione Enter para sair... " _
