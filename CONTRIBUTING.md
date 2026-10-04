# Contribuindo com o BATLAB

Obrigado por querer contribuir! O BATLAB é uma coleção de **microutilitários
`.bat`** para Windows — cada arquivo resolve **uma coisa específica** e deve
continuar pequeno, legível e seguro.

> **EN:** BATLAB is a collection of tiny Windows `.bat` utilities. Each file
> does one thing, stays small, and follows a strict header/style standard.

## Regras básicas

1. **Um arquivo = uma ferramenta.** Nada de "super scripts" com 20 funções.
2. **Sem dependências externas.** Só comandos nativos do Windows
   (`robocopy`, `schtasks`, `netsh`, `powershell`, `dir`, `forfiles`...).
3. **Mensagens e comentários em PT-BR.** Código universal, mensagens locais.
4. **UTF-8 sem BOM** + `chcp 65001 >nul 2>&1` na primeira linha executável.
5. **Nível de risco declarado** no cabeçalho (`@admin`, `@risk`, `@undo`).

## Cabeçalho obrigatório

Todo `.bat` começa exatamente assim (ver `docs/TEMPLATE.md`):

```bat
:: ============================================================
:: BATLAB | NomeArquivo.bat | v1.0.0
:: @desc      Descrição em uma linha
:: @category  productivity | files | system | network | developer
::             | media | customization | games | automation
::             | diagnostics | everyday
:: @admin     no | yes
:: @risk      low | medium | high
:: @undo      Como desfazer (ou N/A)
:: ============================================================
@echo off
chcp 65001 >nul 2>&1
setlocal
```

O script `tools/build-manifest.ps1` lê esses campos e gera o
`site/projects.json` — se o cabeçalho estiver errado, a ferramenta não
aparece no site.

## Política de risco (ver `docs/RISCOS.md`)

| `@risk` | O que fazer |
|---|---|
| `low` | Leitura/informação. Pode rodar direto. |
| `medium` | Modifica arquivos/config. Mostrar o plano + `choice` de confirmação. |
| `high` | Exclui ou altera o sistema. Confirmação **dupla** + `/dryrun` + aviso destacado. |

Scripts com `@admin yes` devem verificar a elevação e avisar
("Este script precisa de administrador") em vez de falhar em silêncio.

## Como adicionar uma ferramenta

1. Crie o `.bat` na pasta da categoria, seguindo `docs/TEMPLATE.md`.
2. Rode `powershell -File tools\build-manifest.ps1` e confira se a contagem subiu.
3. Teste: scripts `low` devem rodar sem erro; `medium/high` — teste o caminho
   de confirmação e o `/dryrun` (quando existir), **nunca** o caminho destrutivo
   sem querer.
4. Adicione a linha correspondente no `README.md` da categoria.
5. Abra um PR com o motivo da ferramenta.

## Commits

- `feat(files): add DuplicateFinder`
- `fix(network): corrige PublicIP sem internet`
- `docs: atualiza README de system`

## Licença

Ao contribuir, você concorda em licenciar sua contribuição sob MIT (ver `LICENSE`).
