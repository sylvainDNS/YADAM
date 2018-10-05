# YADAM

**Y**et **A**nother **D**igital **A**sset **M**anagement

## Introduction

Un DAM, ou gestionnaire de ressource numériques, est un outil permettant de gérer différents types de contenu (image, vidéos, musiques, ...).
Le but du projet est d'en réaliser un sous forme d'**application web**, **open source**, et à l'aide de **technologies innovantes**.

## Description du projet

Le projet s'appuuie sur une architecture _backend **API**_ + _frontend_.

### Backend

Le backend s'appuiera sur une API réalisé à l'aide de **_PostgREST_**, et exploitera les données d'une base de données **_PostgreSQL_**.
Les traitements métiers spécifiques seront réalisés en _JavaScript_ via **[PLV8](https://plv8.github.io/)**.

Idées de fonctionnalités à implémenter :

- Gestion des rôles / droits
- JWT
- ...

### Frontend

Le frontend utilisera le framework _JavaScript **ReactJS**_, afin de réaliser une **SPA** (Single Page Application).

Idées de fonctionnalitées à implémenter :

- 2FA
- SSR
- ...

### Environnement de dévelopement

Pour réaliser ce projet, nous utiliserons des containers **_Docker_**, afin que chaque développeur dispose du même environnement pour développer, quelque soit l'OS qu'il affectionne.
Nous disposerons de **2 serveurs** sous _CentOS_, pour posséder un environnement de test, et un environnement de production.
Le projet possédera une intégration continue à l'aide d'un **_Jenkins_** installé sur un troisième serveur.

### Versioning

**_GitHub_** sera utilisé comme gestionnaire de versions.
Les principes de **GitFlow** seront mis en place pour améliorer la clareté du dépôt.
