{{ config(materialized='table') }}

select
    product_id,
    product_name,
    brand_name,
    category_name,
    count(distinct order_id)    as times_ordered,
    sum(quantity)                as total_quantity_sold,
    sum(total_amount)            as total_revenue,
    avg(discount)                as avg_discount
from {{ ref('int_local_bike_order_items_enriched') }}
group by product_id, product_name, brand_name, category_name
order by total_revenue desc