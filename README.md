# BATLAB

> **Tiny tools. One job each. Open source. Free forever.**
> Microutilitários para Windows, Linux, macOS e Android — baixe, rode, use.

**PT-BR:** o manifesto atual do BATLAB contém **439 microutilitários** —
`.bat` para Windows 10/11 (434), além de scripts `.sh` para Linux (3),
macOS (1) e Android via `adb` (1). Cada arquivo resolve **uma coisa
específica**, pesa poucos KB, não precisa de instalação e declara no próprio
cabeçalho se precisa de administrador, qual o nível de risco e como desfazer.

**EN:** BATLAB is a collection of **439 tiny utilities** — `.bat` for
Windows 10/11 (434), plus `.sh` scripts for Linux (3), macOS (1) and Android
via `adb` (1). One file, one job, no install. Every script declares admin
needs, risk level and how to undo in its header.

## Sites

O repositório contém duas interfaces:

- **`web/`** — aplicação Next.js publicada na Vercel. A busca, o catálogo e
  os problemas usam os manifests versionados; catálogo e downloads exigem
  sessão.
- **`site/`** — versão estática legada, com navegação por problema, categoria
  e plataforma. Seus dados são `site/projects.json` e `site/problems.json`.

O manifesto atual contém 439 ferramentas e 17 problemas. A aplicação web
oferece busca e filtros por risco, categoria e plataforma, além de detalhes
com metadados de segurança, fonte e SHA-256. Veja `web/README.md` para a
aplicação Next.js.

Os geradores sincronizam cópias dos manifests para `web/src/data/`, a raiz
usada pela Vercel; atualize os dados executando os scripts de build, não
editando essas cópias. Ao fazer fork, confira o `owner`/`repo` em
`site/config.js`.

## Como usar

**Windows:** baixe o `.bat` (botão **Download** no site) e dê dois cliques.
Se precisar de administrador, o script avisa.

**Linux/macOS:** baixe o `.sh` e rode no terminal:

```bash
chmod +x linux-system-report.sh
./linux-system-report.sh
```

**Android:** o `.sh` precisa do `adb` (platform-tools) no PATH e da depuração
USB ativa no celular.

Scripts `medium`/`high` mostram **o que vão fazer antes de fazer**. Sempre que
possível, teste primeiro com o argumento `/dryrun`:

```cmd
MirrorFolder.bat /dryrun
```

## Níveis de risco (v2)

| Nível | Significado |
|---|---|
| 🟢 `low` | Só leitura/informação. |
| 🟡 `medium` | Modifica algo reversível — pede confirmação. |
| 🔴 `high` | Exclui dados ou altera o sistema — confirmação dupla + aviso. |
| ⚫ `critical` | Potencialmente irreversível — exige **digitar** a confirmação. |

Do `medium` em diante, o cabeçalho declara também **7 campos de segurança**
(`@writes`, `@deletes`, `@registry`, `@services`, `@tasks`, `@network`,
`@restart`) que o site exibe em chips antes do download. O build falha se
faltarem.

**Situação no manifesto atual:** 310 `low`, 120 `medium`, 9 `high`,
0 `critical`. Cada ferramenta também declara se pede administrador.

Detalhes em [`docs/RISCOS.md`](docs/RISCOS.md). Padrão de código (`.bat` e
`.sh`) em [`docs/TEMPLATE.md`](docs/TEMPLATE.md).

## Estrutura

```text
batlab/
├── windows/batch/<categoria>/*.bat   434 ferramentas Windows
├── linux/shell/<categoria>/*.sh        3 ferramentas Linux
├── macos/shell/<categoria>/*.sh        1 ferramenta macOS
├── android/adb/<categoria>/*.sh        1 ferramenta Android (adb)
├── problems/<id>.json                 17 problemas -> slugs das ferramentas
├── docs/                              TEMPLATE.md, RISCOS.md, catalogo
├── tools/                             builds (manifest, readmes, problems)
├── site/                              manifests + site estatico legado
├── web/                               aplicacao Next.js da Vercel
├── SHA256SUMS.txt                     hash de todos os arquivos (sha256sum -c)
└── .gitattributes                     .bat=CRLF, .sh/.json/.js=LF
```

## Categorias (Windows)

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
| `system-diagnosis/` | Diagnóstico de inicialização | 25 | BootTimeReport |
| `windows-update/` | Windows Update | 25 | UpdateServiceRepair |
| `storage-advanced/` | Saúde de discos | 23 | DriveHealthCheck |
| `privacy/` | Privacidade e telemetria | 1 | PrivacyAudit |
| `emergency/` | Ações de emergência | 1 | EmergencyDiskReport |
| `security-audit/` | Auditoria de segurança | 29 | SecurityPostureReport |
| `network-advanced/` | Rede avançada | 30 | Network diagnostics |

`system/` inclui ainda 3 ferramentas Linux, 1 macOS e 1 Android.

## Builds

```powershell
powershell -File tools\build-manifest.ps1   # projects.json + SHA256SUMS.txt
powershell -File tools\build-readmes.ps1    # README.md de cada categoria
powershell -File tools\build-problems.ps1   # site/problems.json (17 problemas)
```

O `build-manifest` valida todo o cabeçalho v2 (campos obrigatórios,
plataforma coerente com a pasta, enums de segurança, `@confirm typed` em
`critical`) e sai com erro se algo estiver fora do padrão.

## Roadmap

- [x] **Fase 0** — fundação: catálogo com dedupe (670 → 657 novos),
  migração para `windows/batch/`, metadata v2 de segurança, builds com
  SHA-256, taxonomia de 17 problemas, site com 3 portas, piloto de 10
  ferramentas multiplataforma e docs v2.
- [ ] **Fase 1** — continuar a expansão Windows a partir das 434 ferramentas
  no manifesto; recalcular itens restantes após deduplicar `docs/catalog-v2.csv`.
- [ ] **Fase 2** — expandir Linux/macOS/Android. Os números planejados
  (22 Linux, 19 macOS, 24 Android) são metas adicionais, não o inventário
  atual, que tem 3, 1 e 1, respectivamente.
- [ ] **Fase 3** — reconciliar a meta histórica de 957 ferramentas (incluindo
  os 300 originais) com o inventário e deduplicação finais antes de publicar
  uma contagem restante.

## Contribuindo

Veja [`CONTRIBUTING.md`](CONTRIBUTING.md). Segurança: [`SECURITY.md`](SECURITY.md).

## Licença

[MIT](LICENSE) © 2026 Fagoneszy — reutilize, modifique, redistribua.
