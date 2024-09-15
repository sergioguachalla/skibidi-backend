package com.ucb.skibidi.api;

import com.ucb.skibidi.bl.EnvironmentUseBl;
import com.ucb.skibidi.dto.EnvironmentUseDto;
import com.ucb.skibidi.dto.ResponseDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/environments")
public class EnvironmentUseAPI {
    @Autowired
    private EnvironmentUseBl environmentUseBl;

    @PostMapping("/")
    public ResponseDto<EnvironmentUseDto> createEnvironmentUse(@RequestBody EnvironmentUseDto environmentUseDto) {
        ResponseDto<EnvironmentUseDto> responseDto = new ResponseDto<>();
        try {
            environmentUseBl.createEnvironmentUse(environmentUseDto);
            responseDto.setData(environmentUseDto);
            responseDto.setMessage("Environment use created");
            responseDto.setSuccessful(true);
            return responseDto;
        } catch (Exception e) {
            responseDto.setData(null);
            responseDto.setMessage("Error creating environment use: " + e.getMessage());
            responseDto.setSuccessful(false);
            return responseDto;
        }
    }
}
