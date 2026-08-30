-- Modèle : stg_raw_students
-- Objectif :
-- Préparer les données brutes des étudiants avant les
-- transformations métier.
-- Transformations réalisées :
-- - suppression des espaces inutiles
-- - standardisation de la variable genre
-- - conversion de l'année au format entier
-- - suppression des identifiants manquants

-- Chargement des données sources
with source as (

    select *
    from {{ source('raw', 'STUDENTS') }}

),
-- Nettoyage et standardisation des données
cleaned as (

    select
        trim(user_id) as user_id,
        trim(path_category_name) as path_category_name,
        trim(age_group) as age_group,

        case
            when upper(trim(gender)) = 'F' then 'F'
            when upper(trim(gender)) = 'M' then 'M'
            when gender is null or trim(gender) = '' then 'NON_RENSEIGNE'
            else 'AUTRE'
        end as gender,

        trim(region) as region,
        cast(year_path_started as integer) as year_path_started

    from source

    where user_id is not null
      and trim(user_id) <> ''

)
-- Jeu de données nettoyé
select *
from cleaned
