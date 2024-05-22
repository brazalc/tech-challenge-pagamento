#gradle
FROM gradle:8.7.0-jdk-21-and-22 AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build --no-daemon

#container
MAINTAINER tech-challenge-pagamento
FROM openjdk:21-jdk
EXPOSE 8080
COPY --from=build /home/gradle/src/build/libs/*.jar /app/app.jar
ENTRYPOINT ["java","-jar","/app/app.jar"]