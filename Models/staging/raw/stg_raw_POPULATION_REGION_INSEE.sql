-- Modèle : stg_raw_population_region_insee
-- Objectif :
-- Préparer les données de population de l'INSEE avant
-- leur utilisation dans le mart.
-- Transformations réalisées :
-- - sélection des colonnes utiles
-- - conservation des données brutes

-- Chargement des données INSEE
select
    REGIONS,
    POPULATION
from {{ source('raw', 'POPULATION_REGION_INSEE') }}
