select
    customer_id,
    first_name,
    last_name,
    phone,
    email,
    street,
    city,
    state,
    CAST(zip_code AS STRING) as zip_code
from {{ source('local_bike', 'customers') }}