{{ config(materialized='table') }}

select
    s.store_id,
    s.product_id,
    s.quantity         as current_stock,
    p.product_name,
    p.list_price,
    b.brand_name,
    c.category_name,
    case
        when s.quantity = 0 then 'out_of_stock'
        when s.quantity < 10 then 'low_stock'
        else 'in_stock'
    end as stock_level
from {{ ref('stg_local_bike_stocks') }} as s
left join {{ ref('stg_local_bike_products') }} as p on s.product_id = p.product_id
left join {{ ref('stg_local_bike_brands') }} as b on p.brand_id = b.brand_id
left join {{ ref('stg_local_bike_categories') }} as c on p.category_id = c.category_id