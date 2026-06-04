FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

FROM tomcat:10.1-jdk21-temurin
WORKDIR /usr/local/tomcat
RUN rm -rf webapps/*
COPY --from=build /app/target/root.war webapps/ROOT.war
EXPOSE 8080

ENV JAVA_OPTS="-Djakarta.persistence.jdbc.url=jdbc:mysql://${MYSQLHOST}:${MYSQLPORT}/${MYSQLDATABASE}?createDatabaseIfNotExist=true -Djakarta.persistence.jdbc.user=${MYSQLUSER} -Djakarta.persistence.jdbc.password=${MYSQLPASSWORD}"

CMD ["catalina.sh", "run"]