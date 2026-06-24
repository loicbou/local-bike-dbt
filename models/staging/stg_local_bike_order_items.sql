select
    order_id,
    item_id,
    product_id,
    quantity,
    list_price,
    discount,
    ROUND(list_price * quantity * (1 - discount), 2) as total_amount,
    CONCAT(CAST(order_id AS STRING), '_', CAST(item_id AS STRING)) as order_item_id
from {{ source('local_bike', 'order_items') }}