FROM unicon/shibboleth-idp

COPY container_files/idp/ /opt/shibboleth-idp/
COPY backchannel.ini /opt/shib-jetty-base/start.d/backchannel.ini

RUN ln -sf /run/secrets/idp_secrets_properties /opt/shibboleth-idp/conf/secrets.properties
