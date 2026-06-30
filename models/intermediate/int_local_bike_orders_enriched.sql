select
    o.order_id,
    o.customer_id,
    o.order_status,
    o.order_date,
    o.required_date,
    o.shipped_date,
    o.store_id,
    o.staff_id,
    c.city          as customer_city,
    c.state         as customer_state,
    s.store_name,
    s.city          as store_city,
    s.state         as store_state,
    st.first_name   as staff_first_name,
    st.last_name    as staff_last_name,
    date_diff(o.shipped_date, o.order_date, day)  as days_to_ship,
    (o.shipped_date > o.required_date) as is_late
from {{ ref('stg_local_bike_orders') }} as o
left join {{ ref('stg_local_bike_customers') }} as c on o.customer_id = c.customer_id
left join {{ ref('stg_local_bike_stores') }} as s on o.store_id = s.store_id
left join {{ ref('stg_local_bike_staffs') }} as st on o.staff_id = st.staff_id