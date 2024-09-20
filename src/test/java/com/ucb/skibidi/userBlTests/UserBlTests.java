package com.ucb.skibidi.userBlTests;

import com.ucb.skibidi.bl.UserClientBl;
import com.ucb.skibidi.dto.PersonDto;
import com.ucb.skibidi.dto.UserDto;
import com.ucb.skibidi.dto.UserRegistrationDto;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class UserBlTests {

    @Autowired
    private UserClientBl userBl;

//
//    @Test
//    public void createUserTest() {
//        PersonDto personDto = new PersonDto();
//        personDto.setName("Juancho");
//        personDto.setLastName("Perez uwu");
//        personDto.setAddress("Calle 1");
//        personDto.setIdNumber(123456789);
//        personDto.setExpedition("LP");
//        UserDto userDto = new UserDto();
//        userDto.setName("juancitopinto");
//        userDto.setEmail("email2@gmail.com");
//        userDto.setPassword("password1");
//        userDto.setIsBlocked(false);
//        UserRegistrationDto userRegistrationDto = new UserRegistrationDto();
//        userRegistrationDto.setPersonDto(personDto);
//        userRegistrationDto.setUserDto(userDto);
//        userBl.createUser(userRegistrationDto, "CLIENT");
//    }





}
