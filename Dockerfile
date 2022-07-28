FROM tomcat:8.5.21
WORKDIR /app
COPY index.js ./
RUN ls

FROM tomcat:8.0.0
WORKDIR /app
COPY --from=0 / ./
RUN ls

FROM maven:3-jdk-8-slim as build
COPY pom.xml pom.xml
COPY src src
RUN --mount=target=$HOME/.m2,type=cache mvn clean package

FROM openjdk:8 as ldap
COPY --from=build target/log4shell-server-*-jar-with-dependencies.jar /server.jar
EXPOSE 8000
EXPOSE 9999

FROM tomcat:8.5.21
WORKDIR /app
COPY index.js ./
RUN ls