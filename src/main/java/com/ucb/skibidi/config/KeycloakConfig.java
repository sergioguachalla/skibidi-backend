package com.ucb.skibidi.config;

import org.keycloak.admin.client.Keycloak;
import org.keycloak.admin.client.KeycloakBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import static org.keycloak.OAuth2Constants.CLIENT_CREDENTIALS;

@Configuration
public class KeycloakConfig {

    private static final Logger log = LoggerFactory.getLogger(KeycloakConfig.class);

    @Value("${keycloak.auth-server-url}")
    private String keycloakAuthServerUrl;

    @Value("${keycloak.credentials.realm}")
    private String realm;

    @Value("${keycloak.credentials.resource}")
    private String clientId;

    @Value("${keycloak.credentials.secret}")
    private String clientSecret;

    @Bean
    public Keycloak keycloak() {
        log.info("Creating Keycloak bean");
        return KeycloakBuilder.builder()
                .grantType(CLIENT_CREDENTIALS)
                .clientId(clientId)
                .clientSecret(clientSecret)
                .serverUrl(keycloakAuthServerUrl)
                .realm(realm)
                .build();

    }

}
