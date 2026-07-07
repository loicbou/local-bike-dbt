select order_item_id, total_amount
from {{ ref('stg_local_bike_order_items') }}
where total_amount < 0