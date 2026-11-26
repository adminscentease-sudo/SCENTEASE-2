# SCENTEASE — Cologne Ordering Management System

A static HTML/CSS/vanilla JavaScript storefront and admin console backed by Supabase. No framework, build step, npm install, or application server is required.

## Live Supabase project

- Project: scentease
- Project ref: gtaegfhznebmykivcqyo
- Region: Singapore (ap-southeast-1)
- URL: https://gtaegfhznebmykivcqyo.supabase.co
- Frontend key: publishable key in config.js (safe to expose when RLS is enabled)
- Database: initialized with three SCENTEASE Atelier starter fragrances. Customer accounts, carts, orders and sales records start empty.

Never put a Supabase service_role or secret key in frontend files, GitHub, or GitHub Pages.

## Run locally

Open index.html through a static local server (for example VS Code Live Server). No build tool is required.

## First administrator setup

1. In Supabase Dashboard → Authentication → Users, create/register the owner account.
2. Open that user's record and set trusted app_metadata to {"role":"admin"}. Do not use user_metadata; customers can edit that.
3. Sign in at admin.html. If already signed in before the role change, sign out and sign back in.
4. The starter catalogue is already loaded: Noir Reserve, Citrus Drift and Amber Veil. Add, edit, hide, publish or delete products from the Products tab.

## GitHub Pages deployment

1. In GitHub → Settings → Pages, select Deploy from a branch, choose main and /(root), then Save.
2. Site: https://adminscentease-sudo.github.io/SCENTEASE-2/
3. Admin: https://adminscentease-sudo.github.io/SCENTEASE-2/admin.html

GitHub Pages is static hosting. Supabase provides the backend. The browser key is public by design; RLS and database functions are the security boundary.

## Included functionality

- Responsive luxury-inspired storefront (existing visual design retained), live catalogue, product details, search, category and brand filters
- Supabase Auth customer registration, login, logout, profile updates and password changes; customer order history
- Persistent database-backed cart with quantity, stock and subtotal validation
- Cash-on-delivery checkout via a single database transaction with stock validation/deduction
- Admin dashboard, product/category/brand management, product image uploads, confirmation-protected product deletion, order status management, customer listing and sales CSV/print reports
- Realtime product/order updates
- RLS on application tables; trusted app_metadata.role=admin checks
- Cancellation restores stock once; delivered orders create a unique sales record

## Production checklist

- Configure Auth email confirmation, SMTP and Site URL/redirect URLs for GitHub Pages.
- Add shipping policy/fees, privacy policy, terms and support details before public launch.
- Product photos use the public product-images bucket; uploads are admin-only and limited to 5 MB.
- Grant admin role only through Supabase Dashboard or a trusted server-side administrative workflow.
- Test signup, cart, checkout, status transitions, cancellation/restock and RLS using separate customer/admin accounts before accepting real orders.

## Database migration

supabase/migrations/202611260001_initial_schema.sql contains the initial schema migration applied to the linked Supabase project. The deployed database has no seeded catalogue/customer/order data.
