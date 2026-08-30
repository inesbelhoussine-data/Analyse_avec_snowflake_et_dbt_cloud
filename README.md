# 📊 Analyse du profil sociodémographique des étudiants avec Snowflake, dbt et Power BI

## 📌 Présentation

Ce projet a été réalisé dans le cadre du parcours **Data Analyst OpenClassrooms**.

L'objectif est de construire un **pipeline ELT complet** permettant de transformer des données brutes en un jeu de données fiable, exploitable pour l'analyse et la prise de décision.

Le projet s'appuie sur **Snowflake** comme Data Warehouse, **dbt Cloud** pour les transformations SQL et **Power BI** pour la restitution des résultats sous forme de tableau de bord interactif.

---

# 🎯 Contexte

OpenClassrooms souhaite mieux comprendre le profil de ses étudiants inscrits dans les parcours Data.

L'objectif est de produire des indicateurs fiables afin de répondre notamment aux questions suivantes :

- Comment évolue le nombre d'étudiants au fil des années ?
- Quelles sont les tranches d'âge les plus représentées ?
- La répartition entre les genres est-elle équilibrée ?
- Quelles régions regroupent le plus d'étudiants ?
- Quels sont les parcours Data les plus suivis ?

Pour enrichir cette analyse, les données internes d'OpenClassrooms ont été croisées avec les données publiques de population de l'INSEE afin de calculer un indicateur rapporté à **100 000 habitants**.

---

# 🛠️ Technologies utilisées

- Snowflake
- dbt Cloud
- SQL
- Power BI
- Git / GitHub

---

# 🏗️ Architecture du projet

Le projet suit une architecture **ELT**.

```
Sources CSV
      │
      ▼
 Snowflake
(Data Warehouse)
      │
      ▼
   dbt Cloud
      │
      ├── Staging
      ├── Intermediate
      └── Mart
      │
      ▼
CSV final
      │
      ▼
Power BI Dashboard
```

---

# 📂 Structure du projet

```
Projet_P8

│
├── analyses/
│   ├── objectifs_analyse.md
│   ├── methodologie_rgpd.md
│   ├── analyse_doublons_user_id.sql
│   ├── analyse_region_insee.sql
│
├── models/
│   ├── staging/
│   ├── intermediate/
│   └── mart/
│
├── tests/
├── macros/
├── snapshots/
├── seeds/
│
├── dbt_project.yml
├── README.md
│
├── ines_belhoussine_fichier_csv_p8.csv
├── support_presentation_p8.pptx
```

---

# ❄️ Snowflake

Les deux jeux de données ont été importés dans **Snowflake**, qui joue le rôle de **Data Warehouse**.

Les données brutes sont conservées sans modification afin de garantir leur traçabilité.

Snowflake est utilisé pour :

- stocker les données ;
- exécuter les requêtes SQL ;
- héberger les modèles générés par dbt ;
- réaliser les contrôles qualité.

---

# 🌱 dbt Cloud

Les transformations ont été développées dans **dbt Cloud**.

Le projet est organisé en plusieurs couches :

## Staging

Préparation des données brutes :

- suppression des espaces inutiles ;
- harmonisation des valeurs ;
- conversion des types ;
- nettoyage des données.

## Intermediate

Préparation des données pour l'analyse :

- suppression des doublons ;
- conservation d'un seul étudiant par année.

## Mart

Création de la table finale destinée à l'analyse :

- agrégation des étudiants ;
- enrichissement avec les données INSEE ;
- calcul des étudiants pour 100 000 habitants.

Cette architecture permet d'obtenir un workflow clair, maintenable et reproductible.

---

# 🔎 Contrôles qualité

Plusieurs contrôles ont été réalisés afin de garantir la fiabilité des données :

- vérification de l'absence de valeurs nulles ;
- contrôle des doublons ;
- contrôle des années ;
- contrôle des populations ;
- vérification de la conservation des 4 647 étudiants ;
- vérification des jointures avec les données INSEE.

Des tests dbt ainsi que des requêtes SQL exécutées dans Snowflake ont permis de valider la qualité des données.

---

# 🔐 RGPD

Le projet respecte les principes de protection des données :

- USER_ID est pseudonymisé ;
- USER_ID est uniquement utilisé pour la déduplication ;
- USER_ID est supprimé du mart final ;
- les résultats sont agrégés ;
- aucune donnée nominative n'est exportée.

---

# 📊 Tableau de bord Power BI

Le mart final est exporté au format CSV puis utilisé dans Power BI.

Le dashboard permet notamment d'analyser :

- le nombre total d'étudiants ;
- l'évolution des effectifs ;
- la répartition par région ;
- la répartition par tranche d'âge ;
- la répartition par genre ;
- les étudiants pour 100 000 habitants.

> *(Ajouter ici une capture du dashboard)*

---

# 📈 Principaux résultats

L'analyse montre notamment que :

- 4 647 étudiants ont été analysés ;
- l'Île-de-France est la région la plus représentée ;
- la tranche d'âge 30-34 ans est la plus représentée ;
- les effectifs diminuent entre 2022 et 2025 ;
- le calcul pour 100 000 habitants apporte une lecture plus pertinente des disparités régionales.

---

# 🎓 Compétences développées

Au cours de ce projet, j'ai développé les compétences suivantes :

- conception d'un pipeline ELT ;
- utilisation de Snowflake ;
- développement d'un workflow dbt Cloud ;
- transformations SQL ;
- nettoyage et préparation des données ;
- déduplication ;
- agrégation de données ;
- enrichissement avec des données externes ;
- contrôles qualité ;
- création d'un tableau de bord Power BI ;
- documentation technique ;
- prise en compte des principes du RGPD.

---

