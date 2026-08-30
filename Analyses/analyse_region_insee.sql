select distinct
    regions,
    population
from {{ ref('stg_raw_POPULATION_REGION_INSEE') }}
order by regions
