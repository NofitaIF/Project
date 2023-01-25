select u.country, sum(oi.sale_price)
from order_items oi
inner join users u
on oi.user_id = u.id
where oi.product_id in (
	select oi.product_id
	from order_items oi 
	where status = 'Complete'
	group by oi.product_id
	order by sum(oi.sale_price) desc
	limit 5
) 
group by u.country
order by sum(oi.sale_price) desc
limit 5