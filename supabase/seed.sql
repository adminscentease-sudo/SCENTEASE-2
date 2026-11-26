-- SCENTEASE starter catalogue. Run after the initial schema migration.
-- These are fictional house-brand product concepts, not claims about third-party brands.
insert into public.categories(name,slug,description,is_active) values
 ('Eau de Parfum','eau-de-parfum','Longer-wearing fragrance concentration.',true),
 ('Eau de Toilette','eau-de-toilette','Fresh everyday fragrance concentration.',true)
on conflict (slug) do update set name=excluded.name,description=excluded.description,is_active=true;

insert into public.brands(name,description,is_active) values
 ('SCENTEASE Atelier','The house fragrance collection by SCENTEASE.',true)
on conflict (name) do update set description=excluded.description,is_active=true;

insert into public.products(name,slug,description,brand_id,category_id,price,stock_quantity,image_url,sku,is_active)
select v.name,v.slug,v.description,b.id,c.id,v.price,v.stock_quantity,v.image_url,v.sku,true
from (values
 ('Noir Reserve Eau de Parfum 100ml','noir-reserve-eau-de-parfum-100ml','A deep, evening-ready blend with warm woods, smooth amber and a subtle spice finish. Concentrated eau de parfum in a 100ml bottle.',1499::numeric,12,'https://images.unsplash.com/photo-1519669011783-4eaa95fa1b7d?auto=format&fit=crop&w=900&q=85','SEA-NR-100','Eau de Parfum'),
 ('Citrus Drift Eau de Toilette 100ml','citrus-drift-eau-de-toilette-100ml','A bright, clean everyday scent with sparkling citrus, aromatic herbs and a crisp musk dry-down. Eau de toilette in a 100ml bottle.',1199::numeric,18,'https://images.unsplash.com/photo-1655177475832-22f83e29c374?auto=format&fit=crop&w=900&q=85','SEA-CD-100','Eau de Toilette'),
 ('Amber Veil Eau de Parfum 50ml','amber-veil-eau-de-parfum-50ml','A softly sweet, comforting fragrance with amber, vanilla and gentle woods. Eau de parfum in a 50ml bottle.',1299::numeric,9,'https://zackwholesale.net/cdn/shop/collections/Untitled.png?v=1739374535&width=900','SEA-AV-050','Eau de Parfum')
) as v(name,slug,description,price,stock_quantity,image_url,sku,category_name)
cross join public.brands b
join public.categories c on c.name=v.category_name
where b.name='SCENTEASE Atelier'
on conflict (slug) do update set
 name=excluded.name,description=excluded.description,brand_id=excluded.brand_id,category_id=excluded.category_id,
 price=excluded.price,stock_quantity=excluded.stock_quantity,image_url=excluded.image_url,sku=excluded.sku,is_active=true;
