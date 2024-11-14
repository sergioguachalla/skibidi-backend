package com.ucb.skibidi.dto;

import lombok.Data;

import java.util.Date;

@Data
public class PersonDto {
    private String name;
    private String lastName;
    private int idNumber;
    private String expedition;
    private Date registrationDate;
    private String address;
    private String phoneNumber;

}
