{{ config(materialized='table') }}

select
    oi.product_id,
    oi.product_name,
    oi.brand_name,
    oi.category_name,
    count(distinct oi.order_id)     as times_ordered,
    sum(oi.quantity)                as total_quantity_sold,
    sum(oi.total_amount)            as total_revenue,
    avg(oi.discount)                as avg_discount
from {{ ref('int_local_bike_order_items_enriched') }} oi
group by
    oi.product_id,
    oi.product_name,
    oi.brand_name,
    oi.category_name
order by total_revenue desc