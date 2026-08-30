-- Modèle : int_students_clean
-- Objectif : nettoyer et préparer les données étudiants.
-- Transformations réalisées :
-- - suppression des doublons (1 étudiant par année)
-- - conservation des colonnes utiles
-- - préparation des données pour le mart final.
with students as (

    select *
    from {{ ref('stg_raw__STUDENTS') }}

),

deduplicated as (

    select
        user_id,
        path_category_name,
        age_group,
        gender,
        region,
        year_path_started,

        row_number() over (
             partition by user_id, year_path_started
            order by user_id
        ) as row_num

    from students

)

select
    user_id,
    path_category_name,
    age_group,
    gender,
    region,
    year_path_started
from deduplicated
where row_num = 1
