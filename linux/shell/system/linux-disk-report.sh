#!/usr/bin/env bash
# ============================================================
# BATLAB | linux-disk-report.sh | v1.0.0
# @desc      Discos do Linux: espaco livre por montagem e uso de inodes
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
echo " BATLAB - Linux Disk Report"
echo "============================================"

echo "Espaco por montagem:"
if df -hT -x tmpfs -x devtmpfs -x squashfs 2>/dev/null; then
  :
else
  df -h 2>/dev/null || echo "  (df indisponivel)"
fi

echo
echo "Uso de inodes:"
if df -i -x tmpfs -x devtmpfs -x squashfs 2>/dev/null | head -15; then
  :
else
  echo "  (indisponivel)"
fi

echo
echo "Dica: inodes perto de 100% tambem enchem o disco."
echo "      Geralmente sao muitos arquivos pequenos (caches, logs)."

echo
read -r -p "Pressione Enter para sair... " _
