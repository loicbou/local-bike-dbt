select
    customer_id,
    first_name,
    last_name,
    phone,
    email,
    street,
    city,
    state,
    cast(zip_code as string) as zip_code
from {{ source('local_bike', 'customers') }}