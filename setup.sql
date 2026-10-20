-- Run once in Supabase > SQL Editor. Replace the two placeholders first.
create table if not exists reports(
  report_date date primary key,            -- one report per date
  data jsonb not null,
  updated_at timestamptz default now());
alter table reports enable row level security;

-- Only the husband's signed-in account can read. Nobody can write directly.
create policy "husband reads" on reports for select to authenticated
  using ((auth.jwt()->>'email') = 'HUSBAND_EMAIL@example.com');

create table if not exists secret(k text primary key);
alter table secret enable row level security;   -- no policies = unreadable via API
insert into secret values ('A-LONG-RANDOM-PASSPHRASE') on conflict do nothing;

-- Wife's link carries the passphrase; this is the only write path (insert or update same date).
create or replace function submit_report(p_key text, p_date date, p_data jsonb)
returns void language plpgsql security definer set search_path=public as $$
begin
  if not exists(select 1 from secret where k=p_key) then raise exception 'denied'; end if;
  insert into reports(report_date,data) values(p_date,p_data)
  on conflict(report_date) do update set data=excluded.data, updated_at=now();
end $$;
revoke all on function submit_report from public;
grant execute on function submit_report to anon;
