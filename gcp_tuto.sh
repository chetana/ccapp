# GCP tuto 

# CloudShell 

git clone \
    https://github.com/GoogleCloudPlatform/kubernetes-engine-samples
cd \
    kubernetes-engine-samples/hello-app

export \
    PROJECT_ID=YOUR_PROJECT_ID_GOES_HERE

echo ${PROJECT_ID}

# Crée un repot
# indiquer une région
gcloud artifacts locations list
export REGION=us-west1

# crée le dépot
gcloud artifacts repositories \
    create hello-repo \
    --repository-format=docker \
    --location=${REGION} \
    --description="Docker \
    repository"

# crée l'image
docker build -t \
    ${REGION}-docker.pkg.dev/${PROJECT_ID}/hello-repo/hello-app:v1 \
    .

# verifier
docker images
# l'image devrait être visible

# Transférer l'image Docker dans l'Artifac Registry
# Assuré vous que l'API est enable chez vous
gcloud services enable \
    artifactregistry.googleapis.com
# Configurez l'outil en ligne de cmd
gcloud auth configure-docker \
    ${REGION}-docker.pkg.dev

# Transféré l'image sur le dépot
docker push \
    ${REGION}-docker.pkg.dev/${PROJECT_ID}/hello-repo/hello-app:v1

# Crée un cluster GKE

# Définir l'id du projet pour l'outil
gcloud config set project \
    ${PROJECT_ID}

# Définir une zone
export COMPUTE_ZONE=us-west1-a
gcloud config set compute/zone \
    ${COMPUTE_ZONE}

# Création d'un cluster (dans notre cas hello-cluster)
gcloud container clusters create \
    hello-cluster

# afficher les noeuds crée
kubectl get nodes

# Déployer une application sur GKE
# vérifier que vous êtes connecté à votre cluster GKE
gcloud container clusters \
    get-credentials hello-cluster \
    --zone ${COMPUTE_ZONE}
# Crée un déploiement Kubernetes
kubectl create deployment \
    hello-app \
    --image=${REGION}-docker.pkg.dev/${PROJECT_ID}/hello-repo/hello-app:v1
# Définissez le nombre de référence d'instance dupliquées de déploiement sur 3
kubectl scale deployment hello-app \
    --replicas=3
# Créez une ressource HorizontalPodAutoscaler pour votre déploiement.
kubectl autoscale deployment \
    hello-app --cpu-percent=80 \
    --min=1 --max=5
# Vérifier les pods crée
kubectl get pods

# Exposer une app sur Internet
# Les Services Kubernetes regroupent les pods dans une adresse IP statique, accessible depuis n'importe quel pod du cluster.
# Le type de service par défaut dans GKE est appelé ClusterIP, où le service obtient une adresse IP accessible uniquement à partir du cluster.
# Pour exposer un service Kubernetes en dehors du cluster, créez un service de LoadBalancer. Ce type de service génère une adresse IP d'équilibreur de charge externe pour un ensemble dynamique de pods, accessible via Internet.
# Dans cette section, vous exposez le déploiement hello-app sur Internet à l'aide d'un service de type LoadBalancer.

# Générer un service Kube pour le déploiement
kubectl expose deployment \
    hello-app \
    --name=hello-app-service \
    --type=LoadBalancer --port 80 \
    --target-port 8080
# Ici, l'option --port spécifie le numéro de port configuré sur l'équilibreur de charge, et l'option --target-port spécifie le numéro de port sur lequel le conteneur hello-app écoute.
# Exécutez la commande suivante pour obtenir les détails du service pour hello-app-service :
kubectl get service
# Copiez l'adresse EXTERNAL_IP dans le presse-papiers (par exemple, 203.0.113.0).

# Supprimer le projet afin de ne pas être facturé (si vous ne voulez pas qu'il reste exposé)
gcloud projects delete ${PROJECT_ID}

# Supprimer le service : cette étape annule l'allocation de l'équilibreur de charge Cloud créé pour le service
kubectl delete service \
    hello-app-service

# Supprimer vos images de conteneurs : cette étape supprime les images Docker que vous avez transférées dans Artifact Registry. Remplacez PROJECT-ID par l'ID de votre projet :
gcloud artifacts docker images \
    delete \
    ${REGION}-docker.pkg.dev/${PROJECT_ID}/hello-repo/hello-app:v1 \
    --delete-tags --quiet
gcloud artifacts docker images \
    delete \
    ${REGION}-docker.pkg.dev/${PROJECT_ID}/hello-repo/hello-app:v2 \
    --delete-tags --quiet
