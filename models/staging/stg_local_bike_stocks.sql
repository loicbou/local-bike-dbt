select
    store_id,
    product_id,
    quantity,
    CONCAT(cast(store_id as string), '_', cast(product_id as string)) as stock_id
from {{ source('local_bike', 'stocks') }}