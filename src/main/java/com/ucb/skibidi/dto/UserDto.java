package com.ucb.skibidi.dto;

import lombok.Data;

@Data
public class UserDto {
    private String name;
    private String email;
    private String password;
    private Boolean isBlocked;
}
