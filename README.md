# Our Daily Moments — setup (about 15 minutes, all free tier)

1. Supabase: create a free project. Authentication > Users > Add user (your email + password; disable public sign-ups under Auth settings).
2. SQL Editor: edit the two placeholders in setup.sql (your email, a long random passphrase) and run it.
3. Project Settings > API: copy the Project URL and the anon public key into CFG at the top of index.html (the anon key is designed to be public; never use the service_role key). Optionally set CFG.wa to your phone number with country code, no plus.
4. GitHub: new repository, upload index.html, Settings > Pages > deploy from main branch.
5. Her link:  https://YOURNAME.github.io/REPO/#k=YOUR-PASSPHRASE   (the part after # is never sent to GitHub's servers; send it only to her)
6. Your dashboard:  https://YOURNAME.github.io/REPO/#admin   — sign in with the email/password from step 1.

Stored: each day's answers as one JSON row per date, plus a copy on her phone. Only your signed-in account can read rows; her link can only submit.
Email alerts (optional): Supabase > Database > Webhooks on reports insert/update, pointed at a free service such as Resend or a Zapier/Make email step.
