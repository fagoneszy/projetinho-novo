# RISCOS — níveis, campos de segurança e política de confirmação (v2)

Cada script BATLAB declara `@risk low|medium|high|critical` no cabeçalho.
Do `medium` em diante, declara também 7 campos de segurança que descrevem
**exatamente o que ele toca**. O site exibe tudo antes do download.

## 🟢 low — leitura / inofensivo

- Só consulta, lista, mostra, abre janelas do próprio sistema.
- Ex.: `SystemInfo`, `PingTest`, `OpenServices`, `FolderTree`.
- Pode rodar direto, sem confirmação.

## 🟡 medium — modifica algo, mas é reversível

- Move/renomeia arquivos, altera configurações do registro do usuário,
  agenda tarefas, reinicia serviços.
- Ex.: `SortDownloads`, `DarkMode`, `ScheduledBackup`, `KillProcess`,
  `UpdateServiceRepair`.
- **Obrigatório:** listar o plano na tela + 1 `choice` de confirmação.
- Recomendável `/dryrun` quando a ação for sobre muitos arquivos.

## 🔴 high — exclusão ou alteração de sistema

- Apaga arquivos (mesmo que va para a lixeira), espelha pastas (`/MIR`),
  reseta rede, esvazia lixeira, apaga tarefas agendadas.
- Ex.: `MirrorFolder`, `CleanDownloads`, `EmptyRecycleBin`, `NetworkReset`,
  `TaskDelete`.
- **Obrigatório:**
  1. Aviso destacado no topo (`[ATENCAO] ...`).
  2. Listar exatamente o que será afetado.
  3. **Duas** confirmações (`choice` seguidos).
  4. `/dryrun` sempre que aplicável.
  5. `@undo` preenchido com o caminho real de reversão (ou `Irreversível`).

## ⚫ critical — potencialmente irreversível

- Ações que podem perder dados ou deixar o sistema inutilizável sem como
  voltar: formatar partição, apagar chaves do registro em massa, limpar
  BCD, `diskpart clean`, sobrescrever MBR/GPT.
- **Obrigatório:**
  1. Tudo do `high` (aviso, lista, confirmação dupla, `/dryrun`, `@undo`).
  2. `@confirm typed` no cabeçalho — o build **rejeita** sem ele.
  3. O usuário deve **digitar `SIM`** (`set /p` + comparação); `choice`
     não vale.
  4. Preferir exportar/backup automático antes de agir.

## Campos de segurança (`@writes` … `@restart`)

Obrigatórios para `medium`, `high` e `critical`. O site mostra cada valor
diferente de `none` como chip no card:

| Campo | O que declara | Valores |
|---|---|---|
| `@writes` | onde o script grava arquivos | `none` `temp` `user` `system` |
| `@deletes` | o que ele apaga | `none` `temp` `files` |
| `@registry` | acesso ao registro | `none` `read` `write` |
| `@services` | serviços do Windows | `none` `read` `write` |
| `@tasks` | tarefas agendadas | `none` `read` `write` |
| `@network` | tráfego de rede | `none` `read` `write` |
| `@restart` | o que ele reinicia | `none` `process` `explorer` `os` |

Como atribuir:

- `read` = consulta/relatório; `write` = cria, altera ou remove.
- Reiniciar um serviço conta como `@services write` (não `@restart`).
- `@restart os` só quando pede reinício — preferir avisar a exigir.
- Dúvida entre dois valores? **Escolha o mais grave** (honestidade vence).

## Admin (`@admin yes`)

- Verificar elevação com `net session >nul 2>&1` e **abortar com mensagem
  clara** se não for admin — nunca falhar em silêncio no meio.
- Preferir operações que funcionam sem admin; só exigir quando o comando
  nativo realmente exigir (`sfc`, `chkdsk /f`, `schtasks /create` em pasta
  protegida, chaves `HKLM`, etc).

## Dados sensíveis

- `WifiPasswordBackup` / `WifiProfileExport` geram senhas em texto plano:
  aviso no script + instrução de apagar o arquivo depois.

## Checklist do revisor

- [ ] Cabeçalho `@meta` v2 completo: 6 obrigatórios + 7 de segurança
      (`medium`+) + `@confirm typed` (`critical`).
- [ ] `@category` igual à pasta e `@platform` igual à raiz.
- [ ] `medium` com plano + 1 confirmação; `high` com 2; `critical` com
      digitação de `SIM`.
- [ ] `@undo` preenchido (ou `Irreversível` justificado em `critical`).
- [ ] Nenhum download externo, nenhuma janela oculta.
- [ ] Mensagens PT-BR, `pause`/`read` no final, `errorlevel` tratado.
- [ ] Testado com `/dryrun` (quando existir) e no caminho de cancelamento.
- [ ] `powershell -File tools\build-manifest.ps1` passa sem erros.
