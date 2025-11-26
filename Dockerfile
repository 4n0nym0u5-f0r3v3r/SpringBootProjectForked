FROM maven:3.9.11-eclipse-temurin-21-alpine AS BUILD
WORKDIR /app
COPY . . 
RUN mvn package -DskipTests 


FROM eclipse-temurin:21-jre-alpine
WORKDIR /run
COPY --from=BUILD /app/target/sysfoo*.jar sysfoo.jar
EXPOSE 8080
CMD java -jar /run/sysfoo.jar 
