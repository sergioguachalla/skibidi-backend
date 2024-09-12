package com.ucb.skibidi.bl;

import com.ucb.skibidi.config.exceptions.InvalidInputException;
import com.ucb.skibidi.dto.UserDto;
import com.ucb.skibidi.utils.ValidationUtils;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.representations.idm.CredentialRepresentation;
import org.keycloak.representations.idm.UserRepresentation;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;

@Service
public class UserBl {
    @Autowired
    private Keycloak keycloak;



    public UserBl(Keycloak keycloak) {
        this.keycloak = keycloak;
    }

    private static final Logger log = org.slf4j.LoggerFactory.getLogger(UserBl.class);
    @Value("${keycloak.credentials.realm}")
    private String realm;

    public void createUser(UserDto userDto) {
        log.info("Creating user...");

        validateUser(userDto);
        ValidationUtils.validateEmail(userDto.getEmail());
        //TODO: add person dto
        ValidationUtils.validateAddress("address");
        var credential = preparePassword(userDto.getPassword());
        var user = prepareUser(userDto, credential);

        var response = keycloak.realm(realm).users().create(user);
        log.info("response: {}", response.getStatusInfo());
        String userKcId = response.getLocation().getPath().replaceAll(".*/([^/]+)$", "$1");


    }

    private void validateUser(UserDto userDto) {
        ValidationUtils.validateName(userDto.getName());
        ValidationUtils.validateEmail(userDto.getEmail());
    }









    private CredentialRepresentation preparePassword(String password) {
        CredentialRepresentation credential = new CredentialRepresentation();
        credential.setType(CredentialRepresentation.PASSWORD);
        credential.setValue(password);
        credential.setTemporary(false);
        return credential;
    }

    private UserRepresentation prepareUser(UserDto userDto, CredentialRepresentation password) {
        UserRepresentation user = new UserRepresentation();
        user.setUsername(userDto.getName());
        user.setEmail(userDto.getEmail());
        user.setFirstName(userDto.getName());
        user.setCredentials(List.of(password));
        user.setEnabled(true);
        return user;
    }
}
