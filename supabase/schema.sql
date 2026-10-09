-- 나의 플래너: 두 기기 동기화용 테이블
-- Supabase 대시보드 → SQL Editor 에 붙여 넣고 Run 하세요.

create table if not exists public.planner_state (
  user_id uuid primary key references auth.users (id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.planner_state enable row level security;

drop policy if exists "planner_state_select_own" on public.planner_state;
drop policy if exists "planner_state_insert_own" on public.planner_state;
drop policy if exists "planner_state_update_own" on public.planner_state;
drop policy if exists "planner_state_delete_own" on public.planner_state;

create policy "planner_state_select_own" on public.planner_state
  for select to authenticated using ((select auth.uid()) = user_id);
create policy "planner_state_insert_own" on public.planner_state
  for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "planner_state_update_own" on public.planner_state
  for update to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "planner_state_delete_own" on public.planner_state
  for delete to authenticated using ((select auth.uid()) = user_id);

-- 다른 휴대폰의 변경을 실시간으로 받기
do $$
begin
  alter publication supabase_realtime add table public.planner_state;
exception when duplicate_object then null;
end $$;
