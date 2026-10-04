# TEMPLATE — padrão de script BATLAB

Todo `.bat` do BATLAB segue este esqueleto. Copie, preencha e mantenha.

## Esqueleto

```bat
:: ============================================================
:: BATLAB | NomeArquivo.bat | v1.0.0
:: @desc      Descrição em uma linha, PT-BR, sem ponto final
:: @category  files
:: @admin     no
:: @risk      medium
:: @undo      Descreva como desfazer (ou N/A)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
title BATLAB - NomeArquivo

:: ---- aviso (obrigatório para medium/high) ----
echo ============================================
echo  BATLAB - NomeArquivo
echo ============================================
echo O que este script faz:
echo  - acao 1
echo  - acao 2
echo.

:: ---- execucao ----
REM seu codigo aqui

echo.
pause
endlocal
```

## Reglas de estilo

1. **`@echo off` + `chcp 65001 >nul 2>&1` + `setlocal`** sempre no topo
   (após o cabeçalho `::`).
2. **UTF-8 sem BOM.** Nunca salve como ANSI/UTF-16.
3. Mensagens em **PT-BR**, sem acentos pesados em `choice /m` (evita bugs de
   codepage); acentos em `echo` normais são permitidos.
4. **Uma responsabilidade.** Se o script passar de ~120 linhas, divida.
5. Trate erros: `if errorlevel 1 (...)` com mensagem clara, nunca falha muda.
6. Termine com `pause` (UX de duplo clique) e `endlocal`.
7. Sem dependências externas: só comandos nativos + PowerShell nativo.

## Confirmação (obrigatória em `medium`/`high`)

```bat
echo [ATENCAO] Este script modifica arquivos.
choice /c SN /m "Continuar? (S/N)"
if errorlevel 2 (
    echo Cancelado pelo usuario.
    pause
    exit /b 0
)
```

Para `high`, use confirmação **dupla** (dois `choice` seguidos) e, quando
faz sentido, `/dryrun`:

```bat
if /i "%~1"=="/dryrun" (
    echo [DRYRUN] Apenas listando o que seria feito...
    REM lista sem alterar nada
    pause
    exit /b 0
)
```

## Verificação de administrador

```bat
net session >nul 2>&1
if errorlevel 1 (
    echo [ERRO] Este script precisa ser executado como Administrador.
    pause
    exit /b 1
)
```

## Metadados (`@meta`)

| Campo | Valores |
|---|---|
| `@desc` | uma linha, PT-BR |
| `@category` | `productivity` `files` `system` `network` `developer` `media` `customization` `games` `automation` `diagnostics` `everyday` |
| `@admin` | `no` \| `yes` |
| `@risk` | `low` \| `medium` \| `high` |
| `@undo` | como desfazer, ou `N/A` |

Esses campos são lidos por `tools/build-manifest.ps1` para gerar
`site/projects.json`. Não remova nem altere o formato `:: @chave   valor`.

## Codificação — como salvar

No editor (VS Code): `Ctrl+Shift+P` → *Change End of Line Sequence* → LF/CRLF
tanto faz; **Save with Encoding → UTF-8 (sem BOM)**.

O gerador de manifesto falha em avisar se o BOM existir — sempre confira.
