FROM tomcat:9.0

ENV TEZ_VERSION=0.9.2
ENV TEZ_UI_URL https://repository.apache.org/content/repositories/releases/org/apache/tez/tez-ui/${TEZ_VERSION}/tez-ui-${TEZ_VERSION}.war
RUN curl -fSL "$TEZ_UI_URL" -o /tmp/tez-ui.war

RUN rm -rf /$(CATALINA_HOME)/webapps
RUN mkdir -p ${CATALINA_HOME}/webapps/tez-ui
RUN mv /tmp/tez-ui.war ${CATALINA_HOME}/webapps/tez-ui
RUN (cd ${CATALINA_HOME}/webapps/tez-ui && jar -xvf tez-ui.war && rm tez-ui.war && cd -)

COPY config/configs.env $CATALINA_HOME/webapps/tez-ui/configs

EXPOSE 8080

