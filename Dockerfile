FROM unicon/shibboleth-idp

COPY container_files/idp/ /opt/shibboleth-idp/

RUN ln -s /run/secrets/idp_secrets_properties /opt/shibboleth-idp/conf/secrets.properties
