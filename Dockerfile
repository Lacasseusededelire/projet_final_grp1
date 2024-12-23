# Étape 1 : Utiliser une image de base légère
FROM python:3.6-alpine

# Étape 2 : Définir le répertoire de travail
WORKDIR /opt

# Étape 3 : Copier les fichiers de l'application dans le container
COPY . /opt

# Étape 4 : Installer Flask
RUN pip install flask

# Étape 5 : Définir les variables d'environnement
ENV ODOO_URL=https://www.odoo.com/ PGADMIN_URL=https://www.pgadmin.org/

# Étape 6 : Exposer le port utilisé par l'application Flask
EXPOSE 8080

# Étape 7 : Lancer l'application Flask
ENTRYPOINT ["python", "app.py"]

