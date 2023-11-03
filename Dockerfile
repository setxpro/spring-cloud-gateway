FROM ubuntu:latest AS build
LABEL authors="PATRICK-ANJOS"

RUN apt-get update
RUN apt-get install openjdk-17-jdk -y
COPY . .

RUN apt-get install maven -y

RUN mvn clean install

FROM openjdk:17-jdk-slim

EXPOSE 8880

COPY --from=build /target/gateway-0.0.1-SNAPSHOT.jar app_gateway.jar

ENTRYPOINT [ "java", "-jar", "app_gateway.jar" ]