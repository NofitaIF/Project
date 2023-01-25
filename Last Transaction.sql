select x.*
from
(select distinct u.id,u.first_name,u.email,p.category,
 	current_date - cast(oi.created_at as date) age_transaksi_terakhir,
	rank() over(partition by u.id order by oi.created_at desc) transaction_seq
from order_items oi
join users u
on oi.user_id = u.id
join products p
on oi.product_id = p.id
) x
where transaction_seq = 1 and  age_transaksi_terakhir <= 90




