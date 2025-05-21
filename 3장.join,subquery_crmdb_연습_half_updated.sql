# -------------------------------------------------------------------------------------
# 판매 데이터베이스(crm database) 는 customer테이블, orders 테이블, product 테이블이 존재
select * from customer;
select * from orders;
select * from product;
# -------------------------------------------------------------------------------------

# 문제 1.  달콤비스킷(제품명)을 생산한 제조업체가 만든 제품들의 제품명과 단가를 검색하시오.
SELECT product_name, manufacturer, unit_price FROM product
WHERE manufacturer = (SELECT manufacturer FROM product WHERE product_name LIKE '%달콤비스킷%');

# 문제 2. 적립금(membership_points)이 가장 많은 고객의 고객이름과 적립금을 검색하시오.
SELECT cust_name, membership_points
FROM customer
WHERE membership_points = (SELECT MAX(membership_points) FROM customer);

# 문제 3. banana 고객이 주문한 제품의 제품명과 제조업체를 검색하시오. (IN 부속질의문을 사용)
SELECT product_name, manufacturer
FROM product 
WHERE product_id IN (SELECT product_id FROM orders WHERE cust_id LIKE 'banana');

# 문제 4. banana 고객이 주문한 제품의 제품명과 제조업체를 검색하시오. (조인문을 사용)
SELECT product_name, manufacturer
FROM product PRO JOIN orders ORD ON PRO.product_id = ORD.product_id
WHERE ORD.cust_id LIKE 'banana';

# 문제 5. banana 고객이 주문한 제품의 제품명과 제조업체를 검색하시오. (Exists 사용)
SELECT product_name, manufacturer FROM product PRO WHERE EXISTS
(SELECT product_id FROM orders ORD WHERE PRO.product_id = ORD.product_id AND ORD.cust_id='banana');

# 문제 6. banana 고객이 주문하지 않은 제품의 제품명과 제조업체를 검색하시오.
SELECT product_name, manufacturer
FROM product WHERE product_id NOT IN(SELECT product_id from orders WHERE cust_id ='banana');

# 문제 7. 대한식품이 제조한 모든 제품의 단가보다 비싼 제품의 제품명, 단가, 제조업체를 검색해보시오.
-- ALL을 사용하면 1행 이상의 연산이 가능하다 

SELECT product_name, unit_price, manufacturer
FROM product
WHERE unit_price > ALL (SELECT unit_price FROM product WHERE manufacturer LIKE '대한식품' );   

-- 그냥 IN쓰고  MAX(unit_price)만 비교해도 가능함 
SELECT product_name, unit_price, manufacturer
FROM product
WHERE unit_price > (SELECT MAX(unit_price) FROM product WHERE manufacturer LIKE '대한식품' );   

# 문제 8. 2022년 3월 15일에 제품을 주문한 고객의 고객이름을 검색하시오.
SELECT cust_name FROM customer WHERE cust_id in(
SELECT cust_id from orders WHERE order_date ='2022-03-15');

# 문제 9. 2022년 3월 15일에 제품을 주문하지 않은 고객의 고객이름을 검색하시오.

SELECT cust_name FROM customer WHERE cust_id NOT IN(
SELECT cust_id from orders WHERE order_date ='2022-03-15');

# 문제 10. 배송 주소가 경기도로 주문한 고객의 고객이름을 검색하시오.
SELECT cust_name FROM customer CUST WHERE EXISTS(
SELECT 1 FROM orders ORD WHERE CUST.cust_id = ORD.cust_id
AND substring_index(ORD.delivery_addr,' ',1) = '경기도');


# 문제 11. 고객명, 제품명별로 경기도로 총 구매 금액 산출 하시오.
SELECT CUST.cust_name, PRO.product_name, SUM(ORD.quantity*PRO.inventory) FROM customer CUST JOIN orders ORD ON CUST.cust_id = ORD.cust_id
JOIN product PRO ON PRO.product_id = ORD.product_id
WHERE ORD.delivery_addr LIKE '%경기도%' GROUP BY CUST.cust_name, PRO.product_name;



