FROM openjdk:8-jdk-alpine
EXPOSE 8086
ADD target/*.war /
ENTRYPOINT ["java", "-jar", "Timesheet-spring-boot-core-data-jpa-mvc-REST-1-6.0.war"]

