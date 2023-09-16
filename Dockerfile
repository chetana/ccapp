FROM eclipse-temurin:17-jre-alpine
ARG POSTGRESQL_DATABASE_URL=10.93.224.3:5432/cykt
COPY ./cykt-app/target/cykt-app.jar /
EXPOSE 8098
ENTRYPOINT exec java ${JAVA_OPTS} -jar /cykt-app.jar
