##artifact build stage
FROM maven AS buildstage
RUN mkdir /opt/devopsJava
WORKDIR /opt/devopsJava
COPY . .
RUN mvn clean install    ## artifact -- .war
### tomcat deploy stage
FROM tomcat
WORKDIR webapps
COPY --from=buildstage /opt/devopsJava/target/*.war .
RUN rm -rf ROOT && mv *.war ROOT.war
EXPOSE 8080
