{{ config(materialized='table') }}

select
    store_id,
    product_id,
    product_name,
    brand_name,
    category_name,
    current_stock,
    stock_level
from {{ ref('int_local_bike_stock_status') }}
where stock_level in ('out_of_stock', 'low_stock')
order by current_stock asc