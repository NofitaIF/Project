
/*Membuat query untuk divisi marketing.
menampilkan apakah pendapatan selama 3 bulan terakhir sudah mencapai target atau belum (target : 200.000)*/
	
select  date_part('year',created_at) tahun, date_part('month',created_at) bulan ,round(sum(sale_price)) omset
from order_items
group by date_part('year',created_at), date_part('month',created_at)
order by date_part('year',created_at) desc,date_part('month',created_at) desc
limit 3


/*Membuat query untuk divisi operasional.
menampilkan apakah rata-rata waktu pemrosesan selama 3 bulan terakhir sesuai target. Dari pesanan dibuat sampai pesanan dikirim adalah 12 jam.*/

select date_part('year',created_at) tahun,date_part('month',created_at) bulan, date_trunc('hour',(avg(shipped_at - created_at))) rata_rata_waktu_pengiriman
from order_items
group by date_part('year',created_at), date_part('month',created_at)
order by date_part('year',created_at) desc, date_part('month',created_at) desc
limit 3

