select
    store_id,
    product_id,
    quantity,
    CONCAT(CAST(store_id AS STRING), '_', CAST(product_id AS STRING)) as stock_id
from {{ source('local_bike', 'stocks') }}