# BATLAB

> **Tiny Windows tools. Open source. Free forever.**
> Microutilitários `.bat` para Windows — baixe, dê dois cliques, use.

**PT-BR:** o BATLAB é uma coleção de **300 microutilitários em Batch** para
Windows 10/11, organizados em 11 categorias. Cada arquivo resolve **uma coisa
específica**, pesa poucos KB, não precisa de instalação e declara no próprio
cabeçalho se precisa de administrador e qual o nível de risco.

**EN:** BATLAB is a collection of **300 tiny Batch utilities** for Windows
10/11. One file, one job, no install. Every script declares admin needs and
risk level in its header.

## Categorias

| Pasta | Categoria | Qtd | Exemplos |
|---|---|---|---|
| `productivity/` | Produtividade | 30 | Pomodoro, QuickNotes, ProjectStructure |
| `files/` | Arquivos e pastas | 30 | SortDownloads, SmartBackup, MirrorFolder |
| `system/` | Sistema e manutenção | 30 | SystemInfo, ClearTemp, CheckDisk |
| `network/` | Rede e Internet | 30 | PingTest, WifiInfo, PublicIP |
| `developer/` | Desenvolvimento | 30 | GitStatus, ProjectInit, CountCodeLines |
| `media/` | Downloads e mídia | 25 | ImageOrganizer, MediaBackup, CreatorMode |
| `customization/` | Customização | 25 | DarkMode, ShowHiddenFiles, OpenHostsFile |
| `games/` | Jogos e diversão | 30 | Dice, Snake, MatrixEffect, TicTacToe |
| `automation/` | Automação | 30 | ScheduledBackup, TaskManager, AutoGitBackup |
| `diagnostics/` | Segurança e diagnóstico | 20 | FirewallStatus, InstalledPrograms, FullDiagnostic |
| `everyday/` | Usuários comuns | 20 | ShutdownTimer, EmptyRecycleBin, OpenSoundSettings |

**Total: 300 ferramentas.** 208 são somente leitura (`low`), 85 pedem
confirmação (`medium`) e 7 são de risco alto (exclusão/rede) com confirmação
dupla. 32 precisam de administrador.

## Como usar

1. Baixe o `.bat` (botão **Download** no site, ou `raw.githubusercontent.com`).
2. Coloque em qualquer pasta (ou deixe na pasta da categoria do repo).
3. Dê dois cliques. Se precisar de administrador, o script avisa.

Scripts `medium`/`high` mostram **o que vão fazer antes de fazer**. Sempre que
possível, teste primeiro com o argumento `/dryrun`:

```cmd
MirrorFolder.bat /dryrun
```

## Níveis de risco

| Nível | Significado |
|---|---|
| 🟢 `low` | Só leitura/informação. |
| 🟡 `medium` | Modifica arquivos ou configurações — pede confirmação. |
| 🔴 `high` | Exclui dados ou altera o sistema — confirmação dupla + aviso. |

Detalhes em [`docs/RISCOS.md`](docs/RISCOS.md). Padrão de código em
[`docs/TEMPLATE.md`](docs/TEMPLATE.md).

## Estrutura

```text
batlab/
├── <categoria>/*.bat        300 ferramentas (layout flat)
├── <categoria>/README.md    ficha de cada ferramenta da categoria
├── docs/                    TEMPLATE.md e RISCOS.md
├── tools/build-manifest.ps1 gera site/projects.json
└── site/                    site estático (busca, cards, download direto)
```

## Site

`site/` é um site estático (HTML/JS puro) que lê `site/projects.json`
(gerado por `powershell -File tools\build-manifest.ps1`), mostra busca,
categorias, badges de admin/risco e baixa direto via
`raw.githubusercontent.com` — sem passar por página intermediária.

Antes de publicar, troque o `owner`/`repo` em `site/config.js`.

## Contribuindo

Veja [`CONTRIBUTING.md`](CONTRIBUTING.md). Segurança: [`SECURITY.md`](SECURITY.md).

## Licença

[MIT](LICENSE) © 2026 Fagoneszy — reutilize, modifique, redistribua.
