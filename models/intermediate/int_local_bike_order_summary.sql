{{ config(materialized='table') }}

select
    oe.order_id,
    oe.customer_id,
    oe.order_status,
    oe.order_date,
    oe.store_id,
    oe.store_name,
    oe.staff_id,
    case
        when oe.days_to_ship is null then null
        else oe.days_to_ship
    end                             as days_to_ship,
    oe.is_late,
    sum(oi.total_amount)            as order_total_amount,
    sum(oi.quantity)                as order_total_items,
    count(distinct oi.product_id)   as order_distinct_products
from {{ ref('int_local_bike_orders_enriched') }} as oe
left join {{ ref('int_local_bike_order_items_enriched') }} as oi
    on oe.order_id = oi.order_id
where oe.order_date is not null
group by
    oe.order_id,
    oe.customer_id,
    oe.order_status,
    oe.order_date,
    oe.store_id,
    oe.store_name,
    oe.staff_id,
    oe.days_to_ship,
    oe.is_late