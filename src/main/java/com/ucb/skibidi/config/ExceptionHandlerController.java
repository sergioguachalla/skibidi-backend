package com.ucb.skibidi.config;

import com.ucb.skibidi.config.exceptions.InvalidInputException;
import com.ucb.skibidi.dto.ResponseDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.io.InvalidClassException;

@ControllerAdvice
public class ExceptionHandlerController {

    private static final Logger log = LoggerFactory.getLogger(ExceptionHandlerController.class);

    @ExceptionHandler(InvalidInputException.class)
    public ResponseEntity<ResponseDto<String>> handleInvalidInputException(InvalidInputException e) {
        log.error("Invalid input exception", e);
        ResponseDto<String> responseDto = new ResponseDto<>();
        responseDto.setData(null);
        responseDto.setMessage(e.getMessage());
        responseDto.setSuccessful(false);
        return ResponseEntity.badRequest().body(responseDto);
    }


}
