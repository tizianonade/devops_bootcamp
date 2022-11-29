FROM openjdk:8-jdk-alpine

ARG USERNAME
ARG DATABASE
ARG HOSTNAME
ARG PASSWORD

ENV DB_USER=$USERNAME \
    DB_NAME=$DATABASE \
    DB_SERVER=$HOSTNAME \
    DB_PWD=$PASSWORD

RUN mkdir -p /app/
RUN sleep 60

COPY app.jar /app/app.jar

EXPOSE 8080

CMD ["java","-jar","/app/app.jar"]