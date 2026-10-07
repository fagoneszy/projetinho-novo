# Segurança

## Aviso

Os scripts do BATLAB rodam com os **mesmos privilégios do usuário que os
executa**. Arquivos `.bat` podem modificar registros, apagar arquivos,
alterar configurações de rede e do sistema.

**EN:** `.bat` files run with the privileges of whoever double-clicks them.
Only download BATLAB files from this repository's official pages.

## Regras do projeto

- Nenhum script baixa conteúdo externo (sem `curl | bat`, sem `bitsadmin`).
- Nenhum script altera senhas, firewall ou conta de usuário sem confirmação
  explícita e `@risk high` declarado.
- Scripts `high` sempre: aviso no topo → mostra o que fará → `choice`
  (confirmação dupla quando há exclusão) → `/dryrun` quando aplicável.
- Nenhum script oculta janela (`Start-Transcript`/janelas invisíveis proibidas):
  tudo que acontece deve ficar visível na janela do console.

## Aplicação web

- `/tools`, os detalhes de ferramenta e `/api/tools/*` exigem uma sessão
  autenticada. Páginas redirecionam para o login preservando o destino interno;
  APIs recusam visitantes com `401`.
- `/problems` e `/api/problems` são públicos e expõem apenas descrições,
  palavras-chave e slugs relacionados, nunca o conteúdo dos scripts.
- Downloads exigem sessão. URLs do manifesto são aceitas somente via
  `https://raw.githubusercontent.com`; ferramentas publicadas pelo CMS são
  entregues a partir do conteúdo armazenado no banco.
- Ferramentas publicadas no banco são combinadas com o manifesto versionado.
  Se o banco falhar, o catálogo sinaliza que está degradado e registra o erro;
  não deve apresentar a falha como se o banco tivesse respondido com sucesso.
- Rotas administrativas e operações de escrita devem verificar a sessão e a
  autorização de administrador no servidor. Esconder links na interface não é
  controle de acesso.
- Credenciais OAuth e URLs privadas de banco ficam somente em variáveis de
  ambiente e nunca devem ser incluídas em commits, issues ou logs.

## Como reportar um problema

Abra uma **Issue** com a label `segurança` informando:

1. Nome do script e versão (cabeçalho `| v1.0.0`).
2. O que você esperava que acontecesse.
3. O que aconteceu de fato.
4. Saída do console (print ou texto).

Não publique payloads de exploração; descreva o comportamento.

## Uso responsável

- Leia o `README.md` da categoria antes de rodar qualquer coisa `medium`/`high`.
- Prefira `/dryrun` primeiro sempre que o script oferecer.
- Ferramentas que exportam dados sensíveis (ex.: `WifiPasswordBackup`)
  geram arquivos com **senhas em texto plano** — trate como segredo e apague
  depois de usar.
