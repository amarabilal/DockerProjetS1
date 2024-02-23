# Utiliser une image PHP avec Composer préinstallé
FROM composer:2 as composer

# Créer l'image PHP
FROM php:7.4-fpm

# Arguments définis dans le docker-compose
ARG user
ARG uid

# Installation des dépendances système
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip 

# Nettoyage du cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Installation des extensions PHP
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Création d'un utilisateur système si inexistant
RUN if ! id -u $user > /dev/null 2>&1; then useradd -m -s /bin/bash -u $uid $user; fi

# Configuration du répertoire de travail
WORKDIR /var/www

# Définition de l'utilisateur par défaut
USER $user
