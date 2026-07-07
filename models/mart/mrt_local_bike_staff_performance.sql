{{ config(materialized='table') }}

select
    staff_id,
    count(distinct order_id)                                as total_orders_handled,
    sum(order_total_amount)                                 as total_revenue_generated,
    avg(order_total_amount)                                 as avg_order_value,
    avg(case when days_to_ship is not null 
        then days_to_ship end)                              as avg_days_to_ship,
    countif(is_late = true)                                 as late_orders_count
from {{ ref('int_local_bike_order_summary') }}
where order_total_amount is not null
group by staff_id
order by total_revenue_generated desc