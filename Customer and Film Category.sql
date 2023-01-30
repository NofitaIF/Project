
-- Judul film yang dimulai dengan huruf C atau G dengan total customer lebih dari 15 dan kurang dari 25
select f.title, count(r.customer_id) total_customer
from rental r
	inner join inventory i
	on r.inventory_id = i.inventory_id
	inner join film f 
	on i.film_id = f.film_id
where title like 'C%' or title like 'G%'
group by title
having count(r.customer_id) >= 15 and count(r.customer_id) <= 25
order by title

-- Total film berdasarkan kategorinya
select c.name, count(f.film_id) banyak_film
from category c
inner join film_category fc
on fc.category_id = c.category_id
inner join film f
on f.film_id = fc.film_id
group by name
order by count(fc.film_id) asc