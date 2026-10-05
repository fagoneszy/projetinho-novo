# Desenvolvimento / Development

> 30 ferramentas • Git, projetos, terminais e atalhos de programacao. / Git, projects, terminals and developer shortcuts.

| Arquivo / File | Descricao | Admin | Risco / Risk | Desfazer / Undo |
|---|---|---|---|---|
| [ActivateVenv.bat](ActivateVenv.bat) | Abre um prompt com o ambiente virtual .venv ativo | no | 🟢 `low` | N/A |
| [BuildProject.bat](BuildProject.bat) | Detecta e roda o build do projeto (make, npm, cargo, cmake) | no | 🟢 `low` | N/A |
| [CleanBuild.bat](CleanBuild.bat) | Remove pastas de build e dependencias do projeto | no | 🟡 `medium` | Recriado no proximo build |
| [CountCodeLines.bat](CountCodeLines.bat) | Conta as linhas de codigo por extensao no projeto | no | 🟢 `low` | N/A |
| [CppProject.bat](CppProject.bat) | Cria estrutura C++ com src, include e Makefile | no | 🟢 `low` | N/A |
| [CProject.bat](CProject.bat) | Cria estrutura C com src, include e Makefile | no | 🟢 `low` | N/A |
| [CreateVenv.bat](CreateVenv.bat) | Cria um ambiente virtual Python na pasta .venv | no | 🟢 `low` | N/A |
| [DevEnvironment.bat](DevEnvironment.bat) | Abre editor, terminal e navegador do projeto atual | no | 🟢 `low` | N/A |
| [DevServer.bat](DevServer.bat) | Detecta e inicia o servidor de desenvolvimento do projeto | no | 🟢 `low` | N/A |
| [FindTODO.bat](FindTODO.bat) | Procura marcadores TODO e FIXME em todos os arquivos | no | 🟢 `low` | N/A |
| [GitBackup.bat](GitBackup.bat) | Faz add, commit e push em um unico passo | no | 🟡 `medium` | git reset --soft HEAD~1 e git push --force apenas se necessario |
| [GitBranchCreator.bat](GitBranchCreator.bat) | Cria e entra em uma nova branch com git checkout -b | no | 🟢 `low` | N/A |
| [GitCommit.bat](GitCommit.bat) | Pede uma mensagem e cria um commit no repositorio | no | 🟢 `low` | N/A |
| [GitPull.bat](GitPull.bat) | Atualiza o repositorio com git pull e reporta erro claro | no | 🟢 `low` | N/A |
| [GitPush.bat](GitPush.bat) | Envia os commits locais com git push e reporta erro claro | no | 🟢 `low` | N/A |
| [GitQuickCommit.bat](GitQuickCommit.bat) | Adiciona todos os arquivos e cria um commit automatico | no | 🟡 `medium` | git reset --soft HEAD~1 para desfazer o commit |
| [GitStatus.bat](GitStatus.bat) | Mostra o status e o resumo de diferencas do repositorio | no | 🟢 `low` | N/A |
| [GoProject.bat](GoProject.bat) | Cria um modulo Go com go mod init e main.go | no | 🟢 `low` | N/A |
| [InstallRequirements.bat](InstallRequirements.bat) | Instala as dependencias Python do requirements.txt com pip | no | 🟡 `medium` | pip uninstall -r requirements.txt para remover os pacotes |
| [JavaProject.bat](JavaProject.bat) | Cria a estrutura de projeto Java com src e Main.java | no | 🟢 `low` | N/A |
| [NodeProject.bat](NodeProject.bat) | Cria um projeto Node.js com npm init, src e index.js | no | 🟢 `low` | N/A |
| [OpenGitBashHere.bat](OpenGitBashHere.bat) | Abre o Git Bash na pasta atual | no | 🟢 `low` | N/A |
| [OpenProjectTerminal.bat](OpenProjectTerminal.bat) | Abre um terminal na pasta do projeto com git status | no | 🟢 `low` | N/A |
| [OpenTerminalHere.bat](OpenTerminalHere.bat) | Abre um terminal (wt ou cmd) na pasta atual | no | 🟢 `low` | N/A |
| [OpenVSCode.bat](OpenVSCode.bat) | Abre o VS Code na pasta atual ou na pasta informada | no | 🟢 `low` | N/A |
| [ProjectInit.bat](ProjectInit.bat) | Inicializa um repo Git com estrutura basica e README | no | 🟢 `low` | N/A |
| [ProjectTree.bat](ProjectTree.bat) | Mostra a arvore de arquivos do projeto com tree /f | no | 🟢 `low` | N/A |
| [PythonProject.bat](PythonProject.bat) | Cria estrutura Python com requirements.txt e main.py | no | 🟢 `low` | N/A |
| [RunTests.bat](RunTests.bat) | Detecta e roda os testes do projeto (pytest, npm, cargo, go) | no | 🟢 `low` | N/A |
| [RustProject.bat](RustProject.bat) | Cria um projeto Rust com cargo new | no | 🟢 `low` | N/A |

## Legenda / Legend

* **Admin** — `sim`: rode como Administrador / run as Administrator.
* **Risco / Risk** — 🟢 `low`: somente leitura / read-only. 🟡 `medium`:
  modifica algo e pede confirmacao / changes something and asks first.
  🔴 `high`: exclui ou altera o sistema com confirmacao dupla / destructive,
  double confirmation. ⚫ `critical`: exige digitar a confirmacao /
  requires typed confirmation.
* **Desfazer / Undo** — como reverter / how to revert.

Veja tambem / see also: [RISCOS.md](../../docs/RISCOS.md) •
[TEMPLATE.md](../../docs/TEMPLATE.md) • [indice geral](../../README.md)