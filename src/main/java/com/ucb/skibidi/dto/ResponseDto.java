package com.ucb.skibidi.dto;

import lombok.Data;

@Data
public class ResponseDto<T> {
    private T data;
    private String message;
    private boolean successful;
}
