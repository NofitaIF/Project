-- List nama produk yang tidak sesuai aturan (dimulai dengan angka dan memiliki lebih dari 30 huruf)
select distinct name,
	case
	when name ~~* any(array['0%','1%','2%','3%','4%','5%','6%','7%','8%','9%'])
							then 'Nama produk tidak sesuai aturan'
							
	when length(name) > 30 	then 'Nama produk tidak sesuai aturan'				
	
	else 'Nama produk sesuai aturan'
	end status
from products 
order by 1



