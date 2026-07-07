select order_item_id, discount
from {{ ref('stg_local_bike_order_items') }}
where discount < 0 or discount > 1