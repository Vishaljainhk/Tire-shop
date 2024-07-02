
FROM alpine:latest as build
RUN apk update
RUN apk add --no-cache openjdk11
RUN apk add maven
RUN rm -rf /var/cache/apk/*
WORKDIR /java
COPY . .
RUN mvn clean
RUN mvn install


FROM tomcat:9.0-alpine
COPY --from=build /java/target/*.war /usr/local/tomcat/webapps/app.war
EXPOSE 8080
