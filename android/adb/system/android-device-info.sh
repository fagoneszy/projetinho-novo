#!/usr/bin/env bash
# ============================================================
# BATLAB | android-device-info.sh | v1.0.0
# @desc      Info do celular via adb: modelo, Android, bateria e conectividade
# @category  system
# @platform  android
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
echo " BATLAB - Android Device Info"
echo "============================================"

if ! command -v adb >/dev/null 2>&1; then
  echo "[ERRO] adb nao encontrado."
  echo "Instale o Android platform-tools e coloque a pasta no PATH."
else
  adb start-server >/dev/null 2>&1
  n=$(adb devices 2>/dev/null | grep -cw device || true)
  if [ "$n" -eq 0 ]; then
    echo "Nenhum dispositivo conectado."
    echo "Ative a depuracao USB e aceite o aviso no celular."
  else
    echo "Dispositivos conectados: $n"
    echo "Modelo....: $(adb shell getprop ro.product.model 2>/dev/null | tr -d '\r')"
    echo "Android...: $(adb shell getprop ro.build.version.release 2>/dev/null | tr -d '\r')"
    echo "SDK.......: $(adb shell getprop ro.build.version.sdk 2>/dev/null | tr -d '\r')"
    echo "Serial....: $(adb shell getprop ro.serialno 2>/dev/null | tr -d '\r')"
    b=$(adb shell dumpsys battery 2>/dev/null | tr -d '\r' | awk '/level:/ {print $2}')
    echo "Bateria...: ${b:-?}%"
  fi
fi

echo
read -r -p "Pressione Enter para sair... " _
