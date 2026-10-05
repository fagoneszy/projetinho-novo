# Contribuindo com o BATLAB

Obrigado por querer contribuir! O BATLAB é uma coleção de **microutilitários
multiplataforma** — `.bat` para Windows, `.sh` para Linux/macOS e scripts
`adb` para Android. Cada arquivo resolve **uma coisa específica** e deve
continuar pequeno, legível e seguro.

> **EN:** BATLAB is a collection of tiny cross-platform utilities — `.bat`
> for Windows, `.sh` for Linux/macOS and `adb` scripts for Android. Each
> file does one thing, stays small, and follows a strict header/style
> standard.

## Regras básicas

1. **Um arquivo = uma ferramenta.** Nada de "super scripts" com 20 funções.
2. **Sem dependências externas.** Só comandos nativos da plataforma
   (`robocopy`, `schtasks`, `netsh`, `powershell`, `df`, `system_profiler`,
   `adb`...).
3. **Mensagens e comentários em PT-BR.** Código universal, mensagens locais.
4. **UTF-8 sem BOM.** `.bat` em CRLF, `.sh` em LF (o `.gitattributes`
   normaliza no repositório).
5. **Nível de risco declarado** no cabeçalho (`@admin`, `@risk`, `@undo`) —
   e do `medium` em diante os 7 campos de segurança.

## Cabeçalho obrigatório (v2)

Todo script começa exatamente assim (ver `docs/TEMPLATE.md`):

```bat
:: ============================================================
:: BATLAB | NomeArquivo.bat | v1.0.0
:: @desc      Descrição em uma linha
:: @category  productivity (igual à pasta)
:: @platform  windows (igual à raiz: windows|linux|macos|android)
:: @admin     no | yes
:: @risk      low | medium | high | critical
:: @writes    none | temp | user | system
:: @deletes   none | temp | files
:: @registry  none | read | write
:: @services  none | read | write
:: @tasks     none | read | write
:: @network   none | read | write
:: @restart   none | process | explorer | os
:: @undo      Como desfazer (ou N/A)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
```

Em `.sh`, o mesmo com `#` no lugar de `::` e o `#!/usr/bin/env bash` acima.

O script `tools/build-manifest.ps1` lê esses campos e gera o
`site/projects.json` — cabeçalho errado = build falha com o motivo e a
ferramenta não aparece no site.

## Política de risco (ver `docs/RISCOS.md`)

| `@risk` | O que fazer |
|---|---|
| `low` | Leitura/informação. Pode rodar direto. |
| `medium` | Modifica algo reversível. Plano na tela + 1 `choice`. |
| `high` | Exclui/altera o sistema. Confirmação **dupla** + `/dryrun` + aviso. |
| `critical` | Potencialmente irreversível. Tudo do `high` + `@confirm typed` (usuário digita `SIM`). |

Scripts com `@admin yes` devem verificar a elevação e avisar
("Este script precisa de administrador") em vez de falhar em silêncio.

## Como adicionar uma ferramenta

1. Confira no `docs/catalog-v2.csv` se a ferramenta já está planejada
   (e note se já foi implementada com `impl-piloto-v2`).
2. Crie o arquivo na pasta/categoria certa, seguindo `docs/TEMPLATE.md`.
3. Rode `powershell -File tools\build-manifest.ps1` e confira se a contagem
   subiu sem erros de cabeçalho.
4. Rode `powershell -File tools\build-readmes.ps1` (atualiza a ficha da
   categoria) e, se a ferramenta resolver um problema da taxonomia,
   adicione o slug em `problems/<id>.json` + `tools\build-problems.ps1`.
5. Teste: `low` roda sem erro; `medium/high/critical` — teste o caminho de
   cancelamento e o `/dryrun` (quando existir), **nunca** o caminho
   destrutivo sem querer.
6. Abra um PR com o motivo da ferramenta.

## Commits

- `feat(files): add DuplicateFinder`
- `fix(network): corrige PublicIP sem internet`
- `docs: atualiza README de system`

## Licença

Ao contribuir, você concorda em licenciar sua contribuição sob MIT (ver `LICENSE`).
