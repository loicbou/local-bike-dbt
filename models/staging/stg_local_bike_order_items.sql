select
    order_id,
    item_id,
    product_id,
    quantity,
    list_price,
    discount,
    ROUND(list_price * quantity * (1 - discount), 2) as total_amount,
    CONCAT(cast(order_id as string), '_', cast(item_id as string)) as order_item_id
from {{ source('local_bike', 'order_items') }}