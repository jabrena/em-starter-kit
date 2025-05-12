FROM eclipse-temurin:24-jdk-alpine

RUN apk add --no-cache graphviz maven tree

WORKDIR /app

COPY .mvn/ .mvn/
COPY mvnw ./
COPY mvnw.cmd ./

RUN chmod +x mvnw

COPY pom.xml .

RUN ./mvnw --batch-mode --no-transfer-progress dependency:resolve

COPY src src/

RUN ./mvnw --batch-mode --no-transfer-progress clean package

VOLUME /app/src-gen
