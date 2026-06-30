select
    staff_id,
    first_name,
    last_name,
    email,
    phone,
    cast(active as bool)    as is_active,
    store_id,
    manager_id
from {{ source('local_bike', 'staffs') }}