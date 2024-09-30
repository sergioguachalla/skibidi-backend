package com.ucb.skibidi.api;

import com.ucb.skibidi.bl.UserBl;
import com.ucb.skibidi.dto.ResponseDto;
import com.ucb.skibidi.dto.UserDto;
import com.ucb.skibidi.dto.UserRegistrationDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api/v1/users")
public class UserApi {

    @Autowired
    private UserBl userBl;

    @PostMapping("/client")
    public ResponseDto<String> createClient(@RequestBody UserRegistrationDto userDto) {
        userBl.createUser(userDto, "CLIENT");
        return new ResponseDto<String>(null,"User created successfully", true);
    }

    @PostMapping("/librarian")
    public ResponseDto<String> createLibrarian(@RequestBody UserRegistrationDto userDto) {
        userBl.createUser(userDto, "LIBRARIAN");
        return new ResponseDto<String>(null,"User created successfully", true);
    }


    @GetMapping("/client")
    public ResponseDto<UserRegistrationDto> findUserByKcId(@RequestParam String kcId) {
        UserRegistrationDto response = userBl.findUserByKcId(kcId);
        return new ResponseDto<UserRegistrationDto>(response, "User found successfully", true);
    }


}