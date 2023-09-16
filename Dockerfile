FROM eclipse-temurin:17-jre-alpine
COPY ./cykt-app/target/cykt-app.jar /
EXPOSE 8098
ENTRYPOINT exec java ${JAVA_OPTS} -jar /pay-app.jar
