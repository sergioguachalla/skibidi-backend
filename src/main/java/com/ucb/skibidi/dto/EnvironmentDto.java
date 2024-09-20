package com.ucb.skibidi.dto;

import lombok.Data;

@Data
public class EnvironmentDto {
    private Long environmentId;
    private String name;
    private int capacity;
    private Boolean isAvailable;
}
