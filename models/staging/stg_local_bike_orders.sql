{{ config(materialized='table') }}

select
    order_id,
    customer_id,
    order_status,
    safe_cast(order_date as date)                               as order_date,
    safe_cast(required_date as date)                            as required_date,
    safe_cast(nullif(cast(shipped_date as string), 'NULL') as date) as shipped_date,
    store_id,
    staff_id
from {{ source('local_bike', 'orders') }}