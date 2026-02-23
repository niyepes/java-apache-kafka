# ---------- Build ----------
FROM eclipse-temurin:17-jdk-alpine AS build
WORKDIR /build
COPY pom.xml .
COPY src ./src
RUN ./mvnw package -DskipTests

# ---------- Runtime ----------
FROM eclipse-temurin:17-jre-alpine
WORKDIR /application
COPY --from=build /build/target/api-catalog-*.jar api-catalog.jar

EXPOSE 6070
CMD ["java","-jar","api-catalog.jar","--spring.config.location=classpath:/application-docker.yml"]