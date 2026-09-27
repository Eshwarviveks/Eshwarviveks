create extension if not exists pgcrypto;

create table if not exists public.profile (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  headline text,
  summary text,
  location text,
  email text,
  phone text,
  linkedin text,
  github text,
  created_at timestamptz not null default now()
);

create table if not exists public.internships (
  id uuid primary key default gen_random_uuid(),
  role text not null,
  company text not null,
  period text,
  description text,
  sort_order int default 0,
  created_at timestamptz not null default now()
);

create table if not exists public.skills (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  category text,
  sort_order int default 0,
  created_at timestamptz not null default now()
);

create table if not exists public.projects (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  category text,
  description text,
  github_url text,
  live_url text,
  image_url text,
  sort_order int default 0,
  created_at timestamptz not null default now()
);

create table if not exists public.certificates (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  issuer text,
  year text,
  credential_url text,
  sort_order int default 0,
  created_at timestamptz not null default now()
);

create table if not exists public.contact (
  id uuid primary key default gen_random_uuid(),
  label text not null,
  value text not null,
  href text,
  sort_order int default 0,
  created_at timestamptz not null default now()
);

alter table public.profile enable row level security;
alter table public.internships enable row level security;
alter table public.skills enable row level security;
alter table public.projects enable row level security;
alter table public.certificates enable row level security;
alter table public.contact enable row level security;

-- Public visitors can read portfolio content.
create policy "public read profile" on public.profile for select using (true);
create policy "public read internships" on public.internships for select using (true);
create policy "public read skills" on public.skills for select using (true);
create policy "public read projects" on public.projects for select using (true);
create policy "public read certificates" on public.certificates for select using (true);
create policy "public read contact" on public.contact for select using (true);

-- Replace the placeholder email below with the Supabase Auth email of the portfolio owner.
-- Never store the password in this SQL file.
create policy "owner write profile" on public.profile for all to authenticated using (auth.jwt()->>'email' = 'YOUR_ADMIN_EMAIL') with check (auth.jwt()->>'email' = 'YOUR_ADMIN_EMAIL');
create policy "owner write internships" on public.internships for all to authenticated using (auth.jwt()->>'email' = 'YOUR_ADMIN_EMAIL') with check (auth.jwt()->>'email' = 'YOUR_ADMIN_EMAIL');
create policy "owner write skills" on public.skills for all to authenticated using (auth.jwt()->>'email' = 'YOUR_ADMIN_EMAIL') with check (auth.jwt()->>'email' = 'YOUR_ADMIN_EMAIL');
create policy "owner write projects" on public.projects for all to authenticated using (auth.jwt()->>'email' = 'YOUR_ADMIN_EMAIL') with check (auth.jwt()->>'email' = 'YOUR_ADMIN_EMAIL');
create policy "owner write certificates" on public.certificates for all to authenticated using (auth.jwt()->>'email' = 'YOUR_ADMIN_EMAIL') with check (auth.jwt()->>'email' = 'YOUR_ADMIN_EMAIL');
create policy "owner write contact" on public.contact for all to authenticated using (auth.jwt()->>'email' = 'YOUR_ADMIN_EMAIL') with check (auth.jwt()->>'email' = 'YOUR_ADMIN_EMAIL');

insert into public.profile (name, headline, summary, location, email, linkedin, github)
values ('SANAM ESHWAR VIVEK','Artificial Intelligence & Machine Learning','AI/ML undergraduate building practical intelligent applications across machine learning, deep learning, NLP and computer vision.','Hyderabad, Telangana, India','eshwarvivek@gmail.com','https://www.linkedin.com/in/eshwarvivek-sanam-291b55297','https://github.com/Eshwarviveks');

insert into public.internships (role,company,period,description,sort_order) values
('AI / ML Intern','VISWAM.AI','Aug 2025 – Sep 2025','Worked around LLMs, NLP and Computer Vision with systematic model evaluation and deployment workflows.',1),
('AI / ML Intern','InLighnX Global Pvt. Ltd.','Jul 2025 – Aug 2025','Worked on anomaly and fraud detection using XGBoost, Autoencoders and Isolation Forest.',2),
('AI & Data Analytics Intern','AICTE · Shell India · Edunet Foundation','Apr 2025','Four-week virtual internship focused on Artificial Intelligence and Data Analytics.',3);

insert into public.projects (title,category,description,github_url,sort_order) values
('Forest Fire Detection Using Deep Learning','Deep Learning · Computer Vision','Deep learning based forest fire detection project.','https://github.com/Eshwarviveks/forest_fire_detection-DL',1),
('Multilingual Context-Aware Virtual Assistant','NLP · Speech','Multilingual assistant combining contextual understanding with speech capabilities.','https://github.com/Eshwarviveks/Multilingual-Context-Aware-Assistant',2);

insert into public.certificates (title,issuer,year,sort_order) values
('OCI 2025 Certified AI Foundations Associate','Oracle Cloud Infrastructure','2025',1),
('Programming in Java – Elite','NPTEL','2025',2),
('AI & Data Analytics Virtual Internship','AICTE & Shell India','2025',3),
('Machine Learning Professional Certification','RapidMiner','2025',4),
('Data Engineering Master Certification','RapidMiner','2025',5);
