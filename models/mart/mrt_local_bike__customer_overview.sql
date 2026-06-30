{{ config(materialized='table') }}

select
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city,
    c.state,
    count(distinct o.order_id)      as total_orders,
    sum(os.order_total_amount)      as lifetime_value,
    avg(os.order_total_amount)      as avg_order_value,
    max(o.order_date)               as last_order_date,
    min(o.order_date)               as first_order_date
from {{ ref('stg_local_bike_customers') }} as c
left join {{ ref('stg_local_bike_orders') }} as o on c.customer_id = o.customer_id
left join {{ ref('int_local_bike_order_summary') }} as os on o.order_id = os.order_id
group by c.customer_id, c.first_name, c.last_name, c.city, c.state
order by lifetime_value desc