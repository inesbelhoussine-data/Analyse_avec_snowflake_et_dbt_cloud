select
    user_id,
    count(*) as nombre_lignes,
    count(distinct year_path_started) as nombre_annees,
    count(distinct age_group) as nombre_tranches_age,
    count(distinct gender) as nombre_genres,
    count(distinct region) as nombre_regions
from {{ ref('stg_raw__STUDENTS') }}
group by user_id
having count(*) > 1
order by nombre_lignes desc