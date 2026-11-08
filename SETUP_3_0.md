# KJuros 3.0 — Central do Proprietário

## 1. Local
Na pasta do projeto:

```bash
npm install
npm run dev
```

O `.env.local` deve conter `VITE_SUPABASE_URL` e `VITE_SUPABASE_ANON_KEY`.

## 2. Supabase
No SQL Editor do seu projeto Supabase, execute primeiro:

`supabase/schema.sql`

O schema é idempotente para as estruturas novas, mas faça backup antes de aplicar em um banco de produção.

## 3. Sua conta de proprietário
Abra `OWNER_SETUP.sql`, substitua `SEU_EMAIL` pelo e-mail exato da sua conta KJuros e execute no SQL Editor.

Depois saia e entre novamente no KJuros. A opção **Central do Proprietário** aparecerá somente para contas cadastradas em `platform_admins`.

## 4. O que a Central controla
- Dashboard da plataforma
- Usuários e bloqueio/liberação
- Planos
- Assinaturas
- Pagamentos
- Aprovações
- Suporte
- Logs de auditoria
- Configurações globais

## 5. Controle de acesso
Novos usuários recebem uma solicitação de assinatura de teste com status `pending`. O proprietário pode aprovar ou recusar. Somente assinaturas `active` e dentro do prazo liberam o sistema para usuários comuns. Administradores da plataforma têm acesso à Central do Proprietário.

## 6. Vercel/Netlify
Configure no ambiente do host:

- `VITE_SUPABASE_URL`
- `VITE_SUPABASE_ANON_KEY`

Depois faça um novo deploy.

Nunca publique uma `service_role` key no frontend.
