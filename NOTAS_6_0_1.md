# KJuros 6.0.1 — correção visual e acesso do proprietário

- Corrige a centralização e largura da tela de acesso pendente em desktop e celular.
- Mantém o bloqueio de assinatura para contas comuns sem plano ativo.
- A conta proprietária precisa estar cadastrada em `public.platform_admins` para não passar pelo checkout comercial.
- Use `OWNER_SETUP.sql` substituindo o e-mail de exemplo pelo e-mail exato da conta proprietária.
- Não execute `supabase/schema.sql` em banco de produção existente. A migração deve ser revisada contra o esquema atual antes de executar.

A compilação não foi confirmada neste ambiente porque `npm install` excedeu o tempo limite. Faça a validação em ambiente de teste antes do deploy de produção.
