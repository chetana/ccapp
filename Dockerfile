#FROM eclipse-temurin:17-jre-alpine
#COPY ./cykt-app/target/cykt-app.jar /
#EXPOSE 8080
#ENTRYPOINT exec java ${JAVA_OPTS} -jar /cykt-app.jar

# Utilisez une image de base avec Java et Maven préinstallés
FROM maven:3.8.1-openjdk-17-slim as build

# Définissez le répertoire de travail dans le conteneur
WORKDIR /app

# Copiez le fichier pom.xml et le fichier src dans le répertoire de travail
COPY pom.xml .
COPY . .

# Exécutez la construction du projet avec Maven
RUN mvn clean package

# Utilisez une image plus légère pour exécuter l'application
FROM eclipse-temurin:17-jre-alpine

# Définissez le répertoire de travail dans le conteneur
WORKDIR /app

# Copiez le fichier JAR généré lors de la construction dans le répertoire de travail
COPY --from=build /app/cykt-app/target/cykt-app.jar ./app.jar

# Exposez le port sur lequel l'application écoutera (ajustez si nécessaire)
EXPOSE 8080

# Commande pour démarrer l'application lorsque le conteneur est lancé
CMD ["java", "-jar", "app.jar"]
