{{ config(materialized='table') }}

select
    store_id,
    store_name,
    date_trunc(order_date, month)   as order_month,
    count(distinct order_id)        as total_orders,
    sum(order_total_amount)         as total_revenue,
    avg(order_total_amount)         as avg_order_value,
    sum(order_total_items)          as total_items_sold,
countif(is_late = true)                                 as late_orders,
round(countif(is_late = true) / count(*) * 100, 2)     as late_order_pct
from {{ ref('int_local_bike_order_summary') }}
group by store_id, store_name, order_month
order by order_month desc, total_revenue desc