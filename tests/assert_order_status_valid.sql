select order_id, order_status
from {{ ref('stg_local_bike_orders') }}
where order_status not in (1, 2, 3, 4)