USE magist;
#1.What categories of tech products does Magist have?
SELECT DISTINCT( product_category_name) AS Tech_products FROM products WHERE 
product_category_name IN ("audio", "cine_foto","electronicos", "informatica_acessorios" ,"pcs", "relogios_presentes","tablets_impressao_imagem" ,"telefonia");

----------------------------------------------------------------------------------------------------------------------------------------------------
#2.How many products of these tech categories have been sold (within the time window of the database snapshot)?

SELECT COUNT(distinct p.product_category_name) AS Tech_products
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
WHERE product_category_name IN ("audio", "cine_foto","electronicos", "informatica_acessorios" ,"pcs", "relogios_presentes","tablets_impressao_imagem" ,"telefonia");

SELECT COUNT(distinct p.product_category_name) AS Tech_products
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
WHERE product_category_name NOT IN ("audio", "cine_foto","electronicos", "informatica_acessorios" ,"pcs", "relogios_presentes","tablets_impressao_imagem" ,"telefonia");

-#What percentage does that represent from the overall number of products sold?
SELECT (19085/93565)*100;
#16135796515 *100 = 20.3976 (20.39% of tech product are being sold)
---------------------------------------------------------------------------------------------------------------------------------------------------

#3.What’s the average price of the products being sold?
SELECT round(avg(price), 3) AS avg_price from order_items;

------------------------------------------------------------------------------------------------------------------------------------------------------
#4.Are expensive tech products popular? 
SELECT o.review_score,
CASE
    WHEN price < 10 THEN "very cheap"
    WHEN price >= 10 AND price <100 THEN "cheap"
    WHEN price >= 100 AND price <200 THEN "moderate"
    WHEN price >= 200 AND price <300 THEN "expensive"
    WHEN price >=300 AND price <600 THEN "most expensive"
    ELSE "super expensive"
END AS price_analysis
FROM order_items oi JOIN order_reviews o ON oi.order_id=o.order_id 
GROUP BY  o.review_score ORDER BY  o.review_score DESC;
# Most expensive tech products are not popular.

------------------------------------------------------------------------------------------------------------------------------------------------------

#5.How many months of data are included in the magist database?
SELECT MAX(order_purchase_timestamp) FROM orders; # 2018-10-17 19:30:18
SELECT Min(order_purchase_timestamp) FROM orders; # 2016-09-04 23:15:19

SELECT TIMESTAMPDIFF( MONTH , '2016-09-04' , '2018-10-17'); #25 

------------------------------------------------------------------------------------------------------------------------------------------------------

#6.How many sellers are there?  
SELECT count(DISTINCT seller_id) from sellers;

#How many Tech sellers are there?
SELECT COUNT( DISTINCT s.seller_id)
FROM products p 
JOIN order_items oi
ON p.product_id = oi.product_id
JOIN sellers s
ON oi.seller_id = s.seller_id
WHERE p.product_category_name IN("audio", "cine_foto","electronicos", "informatica_acessorios" ,"pcs", "relogios_presentes","tablets_impressao_imagem" ,"telefonia");

#What percentage of overall sellers are Tech sellers?
SELECT (468/3095)*100; #15.1212
------------------------------------------------------------------------------------------------------------------------------------------------------

#7.What is the total amount earned by all sellers? What is the total amount earned by all Tech sellers?

SELECT SUM(price) AS amount_earned FROM order_items;

SELECT SUM(oi.price) AS amount_earned
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
WHERE p.product_category_name IN("audio", "cine_foto","electronicos", "informatica_acessorios" ,"pcs", "relogios_presentes","tablets_impressao_imagem" ,"telefonia");

#8.Can you work out the average monthly income of all sellers? Can you work out the average monthly income of Tech sellers?

SELECT MAX(order_purchase_timestamp) FROM orders; # 2018-10-17 19:30:18
SELECT Min(order_purchase_timestamp) FROM orders; # 2016-09-04 23:15:19

SELECT TIMESTAMPDIFF( MONTH , '2016-09-04' , '2018-10-17'); #25

SELECT SUM(price) AS amount_earned
FROM order_items; # 13591643.701720357

SELECT COUNT(DISTINCT seller_id)
FROM sellers;  #3095

SELECT 13591643.701/ 3095 / 25; #175.65936931824 


------------------------------------------------------------------------------------------------------------------------------------------------------

#9.What’s the average time between the order being placed and the product being delivered?

SELECT MAX(order_purchase_timestamp) FROM orders; # 2018-10-17 19:30:18
SELECT Min(order_purchase_timestamp) FROM orders; # 2016-09-04 23:15:19
SELECT TIMESTAMPDIFF( HOUR , '2018-10-17 15:22:46' , '2018-10-17 19:30:18'); # 4

SELECT MAX(order_delivered_customer_date) FROM orders; # 2018-10-17 15:22:46
SELECT Min(order_delivered_customer_date) FROM orders; #2016-10-11 15:46:32
SELECT TIMESTAMPDIFF( HOUR , '2016-09-04 23:15:19' , '2016-10-11 15:46:32'); # 880

SELECT ((880+4)/2);#442
SELECT 442/24; #18

SELECT AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp))
FROM orders;
------------------------------------------------------------------------------------------------------------------------------------------------------

#10.How many orders are delivered on time vs orders delivered with a delay?
SELECT count(order_status) FROM orders WHERE order_status = "delivered";
SELECT count(order_status) FROM orders WHERE order_status = "shipped";

#SELECT count(*), order_status FROM orders group by order_status ;
#SELECT COUNT(order_status) FROM orders WHERE order_status = 'shipped' AND order_status != 'delivered';

------------------------------------------------------------------------------------------------------------------------------------------------------

#11.Is there any pattern for delayed orders, e.g. big products being delayed more often?

SELECT p.product_category_name, o.order_status , p.product_weight_g,
CASE
    WHEN product_weight_g < 1000 THEN "light"
    WHEN product_weight_g >= 1000 AND product_weight_g <3000 THEN "moderate"
    ELSE "big"
END AS weight_analysis
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
JOIN orders o
ON oi.order_id = o.order_id
GROUP BY o.order_status , weight_analysis
ORDER BY weight_analysis;


 








