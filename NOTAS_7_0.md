# KJuros 7.0 — atualização inicial

## Novidades incluídas
- Navegação separada para Visão geral, Clientes, Empréstimos, Recebimentos, Dívidas em atraso, Cobranças WhatsApp, Relatórios e Configurações.
- Central de inadimplência com totais e lista priorizada de parcelas vencidas.
- Central de cobranças com preparação de mensagem via WhatsApp; o envio permanece manual, após revisão do operador.
- Configuração por contrato de juros de mora: desativado, percentual diário ou valor fixo diário.
- Juros simples, sem capitalização: a estimativa usa como base o valor original da parcela e não incide sobre juros acumulados.
- Carência configurável em dias.
- Migração aditiva; contratos existentes recebem `none`, taxa zero e carência zero.

## Instalação segura
1. Faça backup do banco Supabase e mantenha o deploy atual disponível para rollback.
2. Execute somente `supabase/migrations/202611080002_kjuros_7_late_interest.sql` no SQL Editor.
3. Publique o conteúdo da pasta `KJuros_Profissional` no Netlify Drop ou no método de deploy atual.
4. Teste primeiro em uma conta/contrato de teste antes de usar em contratos reais.

## Observações importantes
- A tela apresenta encargos de atraso como estimativa calculada no navegador. O registro contábil e a cobrança efetiva desses encargos exigem validação contratual, jurídica e testes adicionais antes de ativar em produção.
- A base de cálculo é o valor original da parcela, não o saldo acrescido de juros; pagamentos parciais não recalculam retroativamente essa base nesta versão.
- Não há disparo automático de WhatsApp: o operador revisa e confirma o envio.
- Esta versão não altera nem recalcula parcelas antigas automaticamente.
