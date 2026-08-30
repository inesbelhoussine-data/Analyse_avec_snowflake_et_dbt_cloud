-- Modèle : mart_student_profiles
-- Objectif :
-- Construire le jeu de données final destiné à l'analyse
-- du profil sociodémographique des étudiants.
-- Transformations réalisées :
-- - agrégation des étudiants
-- - préparation de la clé de jointure des régions
-- - jointure avec les données de population INSEE
-- - calcul du nombre d'étudiants
-- - calcul du nombre d'étudiants pour 100 000 habitants
-- Ce modèle est utilisé pour alimenter le tableau de bord
-- Power BI.

-- Préparation des données étudiants
with students as (

    select
        year_path_started,
        region,
        age_group,
        gender,
        path_category_name,

        upper(
            replace(
                replace(trim(region), ' ', ''),
                '-',
                ''
            )
        ) as region_join_key

    from {{ ref('int_students_clean') }}

),

-- Agrégation du nombre d'étudiants par profil
student_counts as (

    select
        year_path_started,
        region,
        age_group,
        gender,
        path_category_name,
        region_join_key,
        count(*) as student_count

    from students

    group by
        year_path_started,
        region,
        age_group,
        gender,
        path_category_name,
        region_join_key

),
-- Préparation des données de population INSEE
population_prepared as (

    select
        case
            when upper(trim(regions)) in (
                'GUADELOUPE',
                'MARTINIQUE',
                'GUYANE',
                'LA RÉUNION',
                'MAYOTTE'
            )
            then 'DROM'

            else upper(
                replace(
                    replace(trim(regions), ' ', ''),
                    '-',
                    ''
                )
            )
        end as region_join_key,

        population

    from {{ ref('stg_raw_POPULATION_REGION_INSEE') }}

    where upper(trim(regions)) not in (
        'FRANCE MÉTROPOLITAINE',
        'FRANCE ENTIÈRE'
    )

),
-- Agrégation de la population par région
population_by_region as (

    select
        region_join_key,
        sum(population) as population

    from population_prepared

    group by region_join_key

)
-- Construction du mart final
select
    students.year_path_started,
    students.region,
    students.age_group,
    students.gender,
    students.path_category_name,
    population.population,
    students.student_count,

    case
        when population.population is not null
             and population.population > 0
        then round(
            students.student_count * 100000.0
            / population.population,
            2
        )
        else null
    end as students_per_100k_inhabitants

from student_counts as students

left join population_by_region as population
    on students.region_join_key = population.region_join_key