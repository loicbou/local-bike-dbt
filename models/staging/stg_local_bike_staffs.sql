select
    staff_id,
    first_name,
    last_name,
    email,
    phone,
    CAST(active AS BOOL)    as is_active,
    store_id,
    manager_id
from {{ source('local_bike', 'staffs') }}