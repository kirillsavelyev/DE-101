/*
Overview (обзор ключевых метрик)
Total Sales
Total Profit
Profit Ratio
Avg. Discount
*/

SELECT 
	round(SUM(sales), 2) AS total_sales
	,round(SUM(profit), 2) AS total_profit
	,round(SUM(profit) / SUM(sales), 3) as profit_ratio
	,round(avg(discount), 3) AS avg_discount
FROM public.orders o
left join public.returns r
	on o.order_id = r.order_id
where r.order_id is null

--Profit per Order

SELECT 
	order_id
	,round(SUM(profit), 2) AS profit_per_order
FROM public.orders
group by order_id

--Sales per Customer

SELECT 
	customer_id, customer_name
	,round(SUM(sales), 2) AS sales_per_customer
FROM public.orders
group by customer_id, customer_name

--Monthly Sales by Segment ( табличка и график)

SELECT 	
	EXTRACT(YEAR FROM order_date) as sale_month
	,EXTRACT(MONTH FROM order_date) as sale_month
	,category
	,round(SUM(sales), 2) AS sales
FROM public.orders
group by 1,2,3
order by 1,2

--will be later
/*
Monthly Sales by Product Category (табличка и график)
Product Dashboard (Продуктовые метрики)
Sales by Product Category over time (Продажи по категориям)
Customer Analysis
Sales and Profit by Customer
Customer Ranking
Sales per region
*/
