package com.ucb.skibidi.api;

import com.ucb.skibidi.bl.UserBl;
import com.ucb.skibidi.dto.UserDto;
import com.ucb.skibidi.dto.UserRegistrationDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/users")
public class UserApi {

    @Autowired
    private UserBl userBl;

    @PostMapping()
    public String createUser(@RequestBody UserRegistrationDto userDto) {
        userBl.createUser(userDto);
        return "User created";
    }



}
