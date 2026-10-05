# BATLAB

> **Tiny tools. One job each. Open source. Free forever.**
> Microutilitários para Windows, Linux, macOS e Android — baixe, rode, use.

**PT-BR:** o BATLAB é uma coleção de **310 microutilitários** — na maioria
`.bat` para Windows 10/11 (305), além de scripts `.sh` para Linux (3),
macOS (1) e Android via `adb` (1). Cada arquivo resolve **uma coisa
específica**, pesa poucos KB, não precisa de instalação e declara no próprio
cabeçalho se precisa de administrador, qual o nível de risco e como desfazer.

**EN:** BATLAB is a collection of **310 tiny utilities** — mostly `.bat` for
Windows 10/11 (305), plus `.sh` scripts for Linux (3), macOS (1) and Android
via `adb` (1). One file, one job, no install. Every script declares admin
needs, risk level and how to undo in its header.

## Site

O site tem **três portas de entrada** — escolha a sua:

- **Por problema** — 17 situações reais ("Meu PC está lento", "Disco cheio",
  "Windows Update com erro"…), cada uma com as ferramentas que resolvem;
- **Por categoria** — navegação clássica por tema;
- **Por plataforma** — Windows, Linux, macOS, Android.

Com busca, filtro "esconder as que pedem admin", badge de risco (incluindo
`critical`), chips de segurança da ferramenta e **SHA-256 clicável** para
conferir o download. Tudo em HTML/JS puro lendo `site/projects.json` e
`site/problems.json` — sem build de frontend.

Antes de publicar, troque o `owner`/`repo` em `site/config.js`.

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

**Situação atual:** 217 `low`, 86 `medium`, 7 `high`, 0 `critical`.
34 pedem administrador.

Detalhes em [`docs/RISCOS.md`](docs/RISCOS.md). Padrão de código (`.bat` e
`.sh`) em [`docs/TEMPLATE.md`](docs/TEMPLATE.md).

## Estrutura

```text
batlab/
├── windows/batch/<categoria>/*.bat   305 ferramentas Windows
├── linux/shell/<categoria>/*.sh        3 ferramentas Linux
├── macos/shell/<categoria>/*.sh        1 ferramenta macOS
├── android/adb/<categoria>/*.sh        1 ferramenta Android (adb)
├── problems/<id>.json                 17 problemas -> slugs das ferramentas
├── docs/                              TEMPLATE.md, RISCOS.md, catalogo
├── tools/                             builds (manifest, readmes, problems)
├── site/                              site estatico (3 portas de entrada)
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
| `system-diagnosis/` | Diagnóstico de inicialização | 1 | BootTimeReport |
| `windows-update/` | Windows Update | 1 | UpdateServiceRepair |
| `storage-advanced/` | Saúde de discos | 1 | DriveHealthCheck |
| `privacy/` | Privacidade e telemetria | 1 | PrivacyAudit |
| `emergency/` | Ações de emergência | 1 | EmergencyDiskReport |

Linux/macOS/Android usam `system/` dentro das próprias raízes
(`linux/shell/system/`, `macos/shell/system/`, `android/adb/system/`).

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
- [ ] **Fase 1** — massa Windows: 582 ferramentas restantes do catálogo
  (`docs/catalog-v2.csv`), em lotes por categoria.
- [ ] **Fase 2** — Linux/macOS/Android: 65 `.sh`/adb restantes
  (22 Linux, 19 macOS, 24 Android).
- [ ] **Fase 3** — fechamento: contagens finais (**957 ferramentas** no
  total, incluindo os 300 originais), docs e site.

## Contribuindo

Veja [`CONTRIBUTING.md`](CONTRIBUTING.md). Segurança: [`SECURITY.md`](SECURITY.md).

## Licença

[MIT](LICENSE) © 2026 Fagoneszy — reutilize, modifique, redistribua.
