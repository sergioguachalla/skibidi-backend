FROM eclipse-temurin:17-jdk-alpine

EXPOSE 8091

VOLUME /tmp

ARG DEPENDENCY=target/dependency

COPY ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY ${DEPENDENCY}/META-INF /app/META-INF
COPY ${DEPENDENCY}/BOOT-INF/classes /app

ENV POSTGRES_URL "jdbc:postgresql://skibidi-db:5433/skibidi"
ENV POSTGRES_USERNAME "postgres"
ENV POSTGRES_PASSWORD "postgres"


ENV KEYCLOAK_AUTH_SERVER_URL "http://skibidi-keycloak:8080"
ENV KEYCLOAK_CLIENT_SECRET "6WPxzJN2CnFPajEbo6gVpqGrLZ5hsr0U"
ENV KEYCLOAK_REALM "skibidi-realm"
ENV KEYCLOAK_RESOURCE "sk-backend"

ENTRYPOINT ["java", "-cp", "app:app/lib/*", "com.ucb.skibidi.SkibidiApplication"]
