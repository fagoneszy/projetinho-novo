# TEMPLATE — padrão de script BATLAB (v2)

Todo script do BATLAB segue este esqueleto. Copie, preencha e mantenha.

## Esqueleto `.bat` (Windows)

```bat
:: ============================================================
:: BATLAB | NomeArquivo.bat | v1.0.0
:: @desc      Descrição em uma linha, PT-BR, sem ponto final
:: @category  files
:: @platform  windows
:: @admin     no
:: @risk      medium
:: @writes user
:: @deletes none
:: @registry none
:: @services none
:: @tasks none
:: @network none
:: @restart none
:: @undo      Descreva como desfazer (ou N/A)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - NomeArquivo

:: ---- aviso (obrigatório para medium/high/critical) ----
echo ============================================
echo  BATLAB - NomeArquivo
echo ============================================
echo O que este script faz:
echo  - acao 1
echo  - acao 2
echo.

:: ---- execucao ----
REM seu codigo aqui

:fim
echo.
pause
endlocal
```

## Esqueleto `.sh` (Linux/macOS/Android)

```bash
#!/usr/bin/env bash
# ============================================================
# BATLAB | nome-arquivo.sh | v1.0.0
# @desc      Descrição em uma linha, PT-BR, sem ponto final
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
echo " BATLAB - Nome do script"
echo "============================================"

# seu codigo aqui

echo
read -r -p "Pressione Enter para sair... " _
```

## Regras de estilo

### `.bat`

1. **`@echo off` + `chcp 65001 >nul 2>&1` + `setlocal`** sempre no topo
   (após o cabeçalho `::`).
2. **UTF-8 sem BOM, CRLF** (o `.gitattributes` força no repositório).
3. Mensagens em **PT-BR**, sem acentos pesados em `choice /m`; acentos em
   `echo` normais são permitidos.
4. **Uma responsabilidade.** Se o script passar de ~120 linhas, divida.
5. Trate erros: `if errorlevel 1 (...)` com mensagem clara, nunca falha muda.
6. Termine com `:fim` + `echo.` + `pause` (UX de duplo clique) + `endlocal`.
7. Sem dependências externas: só comandos nativos + PowerShell nativo.

### `.sh`

1. `#!/usr/bin/env bash` na primeira linha; **UTF-8 sem BOM, LF**.
2. Cabecalho `# @meta` logo abaixo do shebang (dentro das 30 primeiras
   linhas — o build só le a janela inicial).
3. `command -v` para checar dependências antes de usar (`adb`, `free`…).
4. Termine com `read -r -p "Pressione Enter para sair... " _`.
5. Nada de `sudo` automático: pedir com mensagem quando precisar.
6. PT-BR nas mensagens; nome do arquivo em **kebab-case**
   (`linux-system-report.sh`).

## Confirmação por nível de risco

### `medium` — 1 confirmação

```bat
echo [ATENCAO] Vai modificar arquivos da pasta atual.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
```

### `high` — 2 confirmações + `/dryrun`

```bat
if /i "%~1"=="/dryrun" (
    echo [DRYRUN] Apenas listando o que seria feito...
    REM lista sem alterar nada
    goto :fim
)
echo [ATENCAO] Acao destrutiva e irreversivel.
choice /c SN /m "Primeira confirmacao. Continuar? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
choice /c SN /m "Segunda confirmacao. Tem certeza? (S/N)"
if errorlevel 2 (echo Cancelado pelo usuario. & goto :fim)
```

### `critical` — digitação obrigatória (`@confirm typed`)

```bat
echo [CRITICO] Esta acao pode ser irreversivel.
echo Digite SIM (em maiusculas) para continuar:
set /p "CONF="
if /i not "%CONF%"=="SIM" (echo Cancelado pelo usuario. & goto :fim)
```

O build **rejeita** qualquer script com `@risk critical` sem
`@confirm typed` no cabeçalho.

## Verificação de administrador

```bat
net session >nul 2>&1
if errorlevel 1 (
    echo [ERRO] Este script precisa ser executado como Administrador.
    goto :fim
)
```

## Metadados (`@meta` v2)

| Campo | Valores | Obrigatório |
|---|---|---|
| `@desc` | uma linha, PT-BR | sim |
| `@category` | deve ser **igual ao nome da pasta** | sim |
| `@platform` | `windows` \| `linux` \| `macos` \| `android` | sim (igual à raiz) |
| `@admin` | `no` \| `yes` | sim |
| `@risk` | `low` \| `medium` \| `high` \| `critical` | sim |
| `@undo` | como desfazer, ou `N/A` | sim |
| `@writes` | `none` \| `temp` \| `user` \| `system` | medium+ |
| `@deletes` | `none` \| `temp` \| `files` | medium+ |
| `@registry` | `none` \| `read` \| `write` | medium+ |
| `@services` | `none` \| `read` \| `write` | medium+ |
| `@tasks` | `none` \| `read` \| `write` | medium+ |
| `@network` | `none` \| `read` \| `write` | medium+ |
| `@restart` | `none` \| `process` \| `explorer` \| `os` | medium+ |
| `@confirm` | `typed` | só `critical` |

Formatação: `:: @chave` + espaços + valor (`# @chave` em `.sh`). Os campos de
segurança são **obrigatórios a partir de `medium`** — o build falha se
faltarem ou tiverem valor fora do enum.

O `platform` precisa bater com a pasta (raiz `windows/batch` → `windows`,
`linux/shell` → `linux`…) e o `category` com o nome da subpasta.

## Codificação — como salvar

No editor (VS Code): **Save with Encoding → UTF-8 (sem BOM)**. Fim de linha
(.bat CRLF / .sh LF) é normalizado pelo `.gitattributes` — não precisa
se preocupar depois do primeiro checkout.
