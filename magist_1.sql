USE `magist`;
SELECT COUNT(*) FROM orders; 

SELECT count(*), order_status FROM orders group by order_status ;

SELECT COUNT(customer_id), YEAR(order_purchase_timestamp) AS fiancialyear, MONTH(order_purchase_timestamp)AS fiancialmonth
FROM orders GROUP BY fiancialyear , fiancialmonth 
ORDER BY fiancialyear, fiancialmonth; 

SELECT count(distinct(product_id)) As Product FROM products;

SELECT distinct count(product_id), product_category_name FROM products
GROUP BY product_category_name
ORDER BY count(product_id) DESC;

SELECT count(DISTINCT product_id) AS actual_transactions FROM order_items;

SELECT MAX(price) AS Most_expensive , MIN(price) AS Cheapest FROM order_items;

SELECT MAX(payment_value) AS Highest, MIN(payment_value) AS Lowest FROM order_payments;




#select count(distinct(product_category_name_english)) from product_category_name_translation;

select * , count(distinct(product_category_name)) AS Tech_product from products where 
product_category_name IN ("informatica_acessorios", "eletronicos","automotivo", "climatizacao" ,"eletrodomesticos", "eletrodomesticos_2");

select *, max(product_photos_qty) from products;

select round(avg(price), 3) AS avg_price from order_items;


SELECT  * ,count(distinct(product_category_name)) as tech_product
FROM products
JOIN order_items
ON products.product_id = order_items.product_id 
group by product_category_name= "informatica_acessorios" or product_category_name= "eletronicos";


SELECT *, min(order_approved_at) FROM orders ;

SELECT COUNT(pct.product_category_name_english) AS tech_products
 FROM product_category_name_translation pct
JOIN products p
ON pct.product_category_name = p.product_category_name
JOIN order_items oi
ON p.product_id = oi.product_id
WHERE product_category_name_english NOT IN ('computers', 'electronics', 'home_appliances', 'small_appliances', 'small_appliances_home_oven_and_coffee', 'tablets_prin