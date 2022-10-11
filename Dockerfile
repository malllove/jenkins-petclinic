FROM openjdk:8

COPY /target/*.jar /app/petclinic.jar

EXPOSE 8080

CMD ["java","-jar","/app/petclinic.jar"]
