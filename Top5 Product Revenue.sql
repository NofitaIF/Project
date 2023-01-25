select p.name, sum(oi.sale_price)
from order_items oi
inner join products p
on oi.product_id = p.id
where status = 'Complete'
group by p.name
order by sum(oi.sale_price) desc
limit 5