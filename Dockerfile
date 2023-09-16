FROM eclipse-temurin:17-jre-alpine
COPY ./cykt-app/target/cykt-app.jar /
EXPOSE 8080
ENTRYPOINT exec java ${JAVA_OPTS} -jar /cykt-app.jar
