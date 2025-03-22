FROM openjdk:19
LABEL maintainer="chathurangat@gmail.com"
WORKDIR /app
COPY target/sample-api.jar /app/sample-api.jar
ENTRYPOINT ["java","-jar","sample-api.jar"]