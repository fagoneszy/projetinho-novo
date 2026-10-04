# RISCOS — níveis e política de confirmação

Cada script BATLAB declara `@risk low|medium|high` no cabeçalho. O site exibe
o badge correspondente antes do download.

## 🟢 low — leitura / inofensivo

- Só consulta, lista, mostra, abre janelas do próprio sistema.
- Ex.: `SystemInfo`, `PingTest`, `OpenServices`, `FolderTree`.
- Pode rodar direto, sem confirmação.

## 🟡 medium — modifica algo, mas é reversível

- Move/renomeia arquivos, altera configurações do registro do usuário,
  agenda tarefas, reinicia serviços.
- Ex.: `SortDownloads`, `DarkMode`, `ScheduledBackup`, `KillProcess`.
- **Obrigatório:** listar o plano na tela + `choice` de confirmação.
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

- [ ] Cabeçalho `@meta` completo e no formato exato.
- [ ] `medium`/`high` com plano + confirmação.
- [ ] `high` com confirmação dupla e `@undo` preenchido.
- [ ] Nenhum download externo, nenhuma janela oculta.
- [ ] Mensagens PT-BR, `pause` no final, `errorlevel` tratado.
- [ ] Testado com `/dryrun` (quando existir) e no caminho de cancelamento.
