select
    order_id,
    customer_id,
    order_status,
    CAST(order_date AS DATE)    as order_date,
    CAST(required_date AS DATE) as required_date,
    CAST(shipped_date AS DATE)  as shipped_date,
    store_id,
    staff_id
from {{ source('local_bike', 'orders') }}