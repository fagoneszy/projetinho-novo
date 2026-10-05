#!/usr/bin/env bash
# ============================================================
# BATLAB | linux-update-check.sh | v1.0.0
# @desc      Verifica atualizacoes pendentes no apt, dnf ou pacman
# @category  system
# @platform  linux
# @admin     no
# @risk      low
# @writes none
# @deletes none
# @registry none
# @services none
# @tasks none
# @network read
# @restart none
# @undo      Somente leitura: nada a desfazer
# ============================================================

echo "============================================"
echo " BATLAB - Linux Update Check"
echo "============================================"

if command -v apt-get >/dev/null 2>&1; then
  echo "Gerenciador: apt (Debian/Ubuntu)"
  n=$(apt-get -s upgrade 2>/dev/null | grep -c '^Inst' || true)
  echo "Atualizacoes pendentes: $n"
  echo "Para aplicar: sudo apt update && sudo apt upgrade"

elif command -v dnf >/dev/null 2>&1; then
  echo "Gerenciador: dnf (Fedora/RHEL)"
  dnf check-update >/dev/null 2>&1
  rc=$?
  if [ "$rc" -eq 100 ]; then
    echo "Atualizacoes pendentes: SIM"
    echo "Para ver/aplicar: dnf check-update && sudo dnf upgrade"
  elif [ "$rc" -eq 0 ]; then
    echo "Atualizacoes pendentes: 0"
  else
    echo "Nao foi possivel consultar (rc=$rc). Tente: sudo dnf check-update"
  fi

elif command -v pacman >/dev/null 2>&1; then
  echo "Gerenciador: pacman (Arch)"
  n=$(pacman -Qu 2>/dev/null | wc -l)
  echo "Atualizacoes pendentes: $n"
  echo "Para aplicar: sudo pacman -Syu"

else
  echo "Nenhum gerenciador suportado (apt, dnf, pacman) encontrado."
fi

echo
read -r -p "Pressione Enter para sair... " _
