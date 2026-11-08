-- KJuros 6.0.1 — cadastrar a conta proprietária
-- IMPORTANTE: substitua o texto abaixo pelo e-mail EXATO usado para entrar no KJuros.
-- Execute no Supabase > SQL Editor. O resultado esperado é 1 linha com role = owner.

insert into public.platform_admins(user_id, role)
select id, 'owner'
from auth.users
where lower(email) = lower('COLOQUE_AQUI_O_EMAIL_DA_CONTA_PROPRIETARIA')
on conflict (user_id) do update set role = 'owner';

-- Conferência: deve retornar exatamente 1 linha para a conta proprietária.
select pa.user_id, pa.role, u.email
from public.platform_admins pa
join auth.users u on u.id = pa.user_id
where lower(u.email) = lower('COLOQUE_AQUI_O_EMAIL_DA_CONTA_PROPRIETARIA')
  and pa.role = 'owner';
