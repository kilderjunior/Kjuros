# KJuros 6.0 — Premium Comercial

Esta versão foi reorganizada para continuar o projeto KJuros com foco em publicação, Supabase e uso comercial.

## Novidades da versão 6.0

- Tela premium de contratação para contas sem acesso ativo.
- Checkout manual via PIX com escolha de plano mensal/anual.
- Envio de link do comprovante e identificação do pagamento.
- Histórico dos pedidos e situação da análise para o usuário.
- Central do Proprietário exibe link do comprovante e permite aprovar ou recusar.
- Ao aprovar um pagamento, o sistema ativa a assinatura e calcula vencimento mensal/anual.
- Configuração da chave PIX, nome do recebedor e instruções pelo painel administrativo.
- Políticas e triggers no banco impedem que um usuário aprove o próprio pagamento ou libere a própria assinatura.

## Novidades herdadas da versão 5.0

- Registro de recebimentos por valor efetivamente pago, com data, método e observação.
- Pagamento parcial mantém a parcela aberta e recalcula automaticamente o saldo restante.
- Histórico de recebimentos por parcela, com ação para corrigir o valor lançado.
- Painel administrativo de pagamentos com totais aprovados/pendentes e filtros por usuário, plano e status.
- A correção de um recebimento recalcula o total pago e o status da parcela.

**Importante:** a aprovação de pagamentos dos planos continua manual nesta versão. Para checkout automático e confirmação por webhook, é necessário escolher um provedor (por exemplo, Mercado Pago ou Asaas) e configurar as credenciais no ambiente seguro do backend/Edge Functions. Não coloque tokens secretos no frontend.

## O que já existia

- Integração Supabase mais robusta, com validação das variáveis e teste de conexão dentro de Configurações.
- Botão **Abrir Supabase** que leva diretamente ao painel do projeto configurado.
- Login, cadastro e recuperação de senha por e-mail.
- Sessão persistente e renovação automática do token.
- Cadastro de clientes com editar e apagar (o sistema bloqueia apagar cliente que ainda possui contratos).
- Contratos com cancelamento seguro em vez de apagar contratos que possam ter histórico.
- Parcelas e recebimentos continuam isolados por organização via RLS.
- Configurações de WhatsApp e PIX salvas no navegador para cada operação.
- Notificações de vencimento e atraso.
- Exportação dos contratos para CSV.
- PWA com manifesto/service worker para instalação no celular.
- Layout responsivo para computador e celular.
- SQL idempotente atualizado em `supabase/schema.sql`.

## 1. Configurar localmente

Dentro de `KJuros_Profissional`:

```bash
npm install
npm run dev
```

Não abra `index.html` com duplo clique. Use o servidor do Vite.

## 2. Configurar o Supabase

No projeto Supabase, abra o **SQL Editor** e execute `supabase/schema.sql`.

Depois confira em Authentication → URL Configuration:

- Site URL: endereço final do KJuros.
- Redirect URLs: endereço final do KJuros e, se necessário, o endereço local do Vite.

O cadastro automático cria uma organização e um membro `owner` para cada novo usuário.

### Variáveis

Crie/ajuste `.env.local`:

```env
VITE_SUPABASE_URL=https://SEU-PROJETO.supabase.co
VITE_SUPABASE_ANON_KEY=SUA_CHAVE_PUBLICA
```

Use somente a chave pública `anon`/`publishable`. **Nunca coloque `service_role` ou chave secreta no navegador.**

O `.env.local` não deve ser enviado para GitHub.

## 3. Netlify

Em Site configuration → Environment variables, configure:

- `VITE_SUPABASE_URL`
- `VITE_SUPABASE_ANON_KEY`

Build command:

```bash
npm run build
```

Publish directory:

```text
dist
```

O `netlify.toml` já contém o redirecionamento SPA para `/index.html`.

## 4. Se o Supabase continuar sem conectar

1. Abra o KJuros.
2. Entre em **Configurações → Supabase**.
3. Clique em **Testar conexão**.
4. Se aparecer erro de variável, configure as duas variáveis no ambiente do site.
5. Se aparecer erro de tabela/policy, execute `supabase/schema.sql` no SQL Editor.
6. Se login funcionar mas os dados não carregarem, confira se a conta possui uma organização/membership no banco.

## 5. Publicação

Depois de alterar variáveis no Netlify/Vercel, faça um novo deploy para que o Vite incorpore as variáveis no build.

Para produção, recomenda-se manter o banco com backup e testar RLS com uma conta de teste antes de cadastrar dados reais.

## 6. Banco permanente + publicação automática

A partir desta estrutura, o KJuros não precisa recriar o banco quando o site é atualizado.

- O Supabase permanece como banco oficial e permanente.
- O Netlify publica automaticamente o código quando o GitHub recebe um push.
- As mudanças de banco ficam em `supabase/migrations/`. Para atualizar do banco 5.0, execute `supabase/migrations/202611080001_commercial_manual_checkout.sql` no SQL Editor do Supabase (ou rode o `supabase/schema.sql` completo em uma instalação nova).
- O workflow `.github/workflows/supabase-migrations.yml` aplica novas migrações automaticamente usando o segredo `SUPABASE_DB_URL`.
- O `.env.local` é ignorado pelo Git para não vazar credenciais públicas/configurações locais.

Antes da primeira migração automática em produção, faça um backup do banco e configure o segredo `SUPABASE_DB_URL` no GitHub.


## 7. Configurar o PIX manual (versão 6.0)

Na Central do Proprietário → Configurações da plataforma, preencha `public_payment_pix_key`, `public_payment_pix_name` e `public_payment_instructions`. Essas três configurações são exibidas na tela de contratação. O cliente informa um link acessível do comprovante; o administrador abre o comprovante, confere o valor e usa **Aprovar e liberar**. A aprovação libera a assinatura por um mês ou um ano conforme o valor selecionado.

**Atenção:** nesta entrega o comprovante é enviado como link (por exemplo, link compartilhado de arquivo/imagem); upload direto com armazenamento privado precisa de bucket e política Storage próprios. Teste o fluxo com usuários de teste antes de vender planos reais.
