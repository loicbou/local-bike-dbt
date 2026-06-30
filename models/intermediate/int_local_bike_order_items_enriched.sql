select
    oi.order_item_id,
    oi.order_id,
    oi.product_id,
    oi.quantity,
    oi.list_price,
    oi.discount,
    oi.total_amount,
    p.product_name,
    p.brand_id,
    p.category_id,
    p.model_year,
    b.brand_name,
    c.category_name
from {{ ref('stg_local_bike_order_items') }} as oi
left join {{ ref('stg_local_bike_products') }} as p on oi.product_id = p.product_id
left join {{ ref('stg_local_bike_brands') }} as b on p.brand_id = b.brand_id
left join {{ ref('stg_local_bike_categories') }} as c on p.category_id = c.category_id