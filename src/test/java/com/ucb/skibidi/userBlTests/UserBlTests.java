package com.ucb.skibidi.userBlTests;

import com.ucb.skibidi.bl.UserBl;
import com.ucb.skibidi.dto.UserDto;
import org.apache.catalina.User;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.keycloak.OAuth2Constants;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.admin.client.KeycloakBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class UserBlTests {

    @Autowired
    private UserBl userBl;


    // TODO: Review the test
    @Test
    public void createUserTest() {
        UserDto userDto = new UserDto();
        userDto.setName("John Doe");
        userDto.setEmail("john@gmail.com");
        userDto.setPassword("123456");
        userDto.setIsBlocked(false);
        userBl.createUser(userDto.);


    }




}
