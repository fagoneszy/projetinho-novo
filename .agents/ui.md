# UI

## Stack

Tailwind CSS + shadcn/ui + Motion (animação leve). Componentes prontos do shadcn são a
base; customizar com tokens Tailwind, nunca fork manual de componente.

## Direção visual

- Continuidade com o site estático v2 (`site/`): tema escuro como base, destaque para os
  chips de segurança (badge de risco: low/medium/high/critical) e busca. Antes de criar
  um novo sistema visual, ler `site/styles.css` e reaproveitar paleta/spacing.
- Contraste AA mínimo; texto nunca abaixo de 14px em corpo.
- Ícones: lucide (já padrão do shadcn).

## Padrões de catálogo

- **17 problemas** = porta de entrada principal (cards expansíveis como no v2).
- **Categorias** e **plataformas** = navegação secundária; plataforma inexistente fica
  desabilitada (mesmo comportamento do v2).
- Página de ferramenta: descrição → **tabela dos 7 campos de segurança** + `@admin` +
  `@risk` em destaque → versão/licença/sha256 → download.
- Filtros por risco/plataforma persistem na URL (`?risk=low&pl=windows`).

## UX

- Responsivo first (mobile ≥ 360px); grade de cards 1→2→3 colunas.
- Estados: loading (skeleton), vazio ("nenhuma ferramenta encontrada"), erro com retry.
- Acessibilidade: `aria-*` em accordions/chips, foco visível, navegação por teclado nos
  filtros, `prefed-color-scheme` respeitado pelo Motion (animações sutis).
- PT-BR em toda string visível; datas `pt-BR` via `Intl`.

## Motion

Só microinterações: expand/collapse de card, fade de filtro, hover de botão (≤200ms).
Nada que atrapalhe performance de página de catálogo com 957 itens (virtualizar lista se
necessário).
