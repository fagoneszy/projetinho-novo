#!/usr/bin/env bash
# ============================================================
# BATLAB | linux-system-report.sh | v1.0.0
# @desc      Resumo do Linux: distro, kernel, uptime, carga e memoria
# @category  system
# @platform  linux
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
echo " BATLAB - Linux System Report"
echo "============================================"

if [ -r /etc/os-release ]; then
  # shellcheck disable=SC1091
  . /etc/os-release
  echo "Distro....: ${NAME:-?} ${VERSION_ID:-}"
fi
echo "Kernel....: $(uname -srm)"
echo "Hostname..: $(hostname 2>/dev/null || echo '?')"
uptime 2>/dev/null | sed 's/^/Uptime....: /' || echo "Uptime....: (indisponivel)"
echo "Carga.....: $(cut -d' ' -f1-3 /proc/loadavg 2>/dev/null || echo '?')"

if command -v free >/dev/null 2>&1; then
  echo
  echo "Memoria:"
  free -h
fi

if command -v who >/dev/null 2>&1; then
  echo
  echo "Sessoes ativas: $(who | wc -l)"
fi

echo
read -r -p "Pressione Enter para sair... " _
