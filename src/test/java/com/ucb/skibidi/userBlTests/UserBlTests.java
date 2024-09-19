package com.ucb.skibidi.userBlTests;

import com.ucb.skibidi.bl.UserBl;
import com.ucb.skibidi.dto.PersonDto;
import com.ucb.skibidi.dto.UserDto;
import com.ucb.skibidi.dto.UserRegistrationDto;
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
        PersonDto personDto = new PersonDto();
        personDto.setName("Juan");
        personDto.setLastName("Perez");
        personDto.setAddress("Calle 1");
        personDto.setIdNumber(123456789);
        personDto.setExpedition("LP");

        UserDto userDto = new UserDto();
        userDto.setName("juancito");
        userDto.setEmail("email1@gmail.com");
        userDto.setPassword("password1");
        userDto.setIsBlocked(false);

        UserRegistrationDto userRegistrationDto = new UserRegistrationDto();
        userRegistrationDto.setPersonDto(personDto);
        userRegistrationDto.setUserDto(userDto);
        userBl.createUser(userRegistrationDto, "CLIENT");

    }




}
