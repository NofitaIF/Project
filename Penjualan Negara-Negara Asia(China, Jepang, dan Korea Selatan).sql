-- Persentase penjualan Negara China, Jepang, dan Korea Selatan selama 1 tahun terakhir (01-09-2021 s/d 30-09-2022)
select u.country, date_part('year',oi.created_at) tahun, date_part('month',oi.created_at) bulan,
	cast((100*(sum(sale_price)-lag(sum(sale_price),1) over(partition by u.country order by date_part('month',oi.created_at)asc)))
	/
	lag(sum(sale_price),1) over(partition by u.country order by date_part('month',oi.created_at)asc)as float) as persentase_penjualan
from users u
join order_items oi
on u.id = oi.user_id
where u.country in('Japan', 'South Korea', 'China') 
	and oi.created_at between('20210901') and ('20220930') AND oi.status = 'Complete' 
group by u.country,date_part('year',oi.created_at), date_part('month',oi.created_at)
order by date_part('year',oi.created_at) ASC, date_part('month',oi.created_at) ASC, u.country asc

-- Rata-rata waktu pengiriman Negara China, Jepang, dan Korea Selatan selama 3 bulan terakhir (01-07-2022 s/d 30-09-2022)
select u.country, date_part('year',oi.created_at) tahun,date_part('month',oi.created_at) bulan,date_trunc('hour',(avg(oi.shipped_at - oi.created_at))) rata_rata_waktu_pengiriman
from order_items oi
join users u
	  on oi.user_id = u.id
where oi.created_at between('20210901') and ('20220930') and u.country in ('Japan', 'South Korea', 'China')
group by date_part('year',oi.created_at), date_part('month',oi.created_at),u.country
order by date_part('year',oi.created_at) desc, date_part('month',oi.created_at) desc
limit 9

-- Total penjualan selama 1 tahun terakhir (01-09-2021 s/d 30-09-2022)
SELECT DISTINCT u.country, COUNT(oi.created_at) total_order
FROM users u
JOIN order_items oi
ON u.id = oi.user_id
WHERE oi.created_at BETWEEN('20210901') AND ('20220930') AND u.country in ('Japan', 'South Korea', 'China') AND oi.status NOT IN ('Shipped', 'Processing','Cancelled')
GROUP BY u.country

-- Jumlah barang dikembalikan selama 1 tahun terakhir (01-09-2021 s/d 30-09-2022)
select distinct u.country,oi.status ,count(oi.status) total
from users u
join order_items oi
on u.id = oi.user_id
where oi.created_at between('20210901') and ('20220930') and u.country in ('Japan', 'South Korea', 'China') and oi.status  in ('Returned')
group by u.country, oi.status