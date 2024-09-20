package com.ucb.skibidi.api;

import com.ucb.skibidi.bl.EnvironmentUseBl;
import com.ucb.skibidi.dto.EnvironmentReservationDto;
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
    public ResponseDto<EnvironmentReservationDto> createEnvironmentReservation(@RequestBody EnvironmentReservationDto environmentReservationDto) {
        ResponseDto<EnvironmentReservationDto> responseDto = new ResponseDto<>();
        try {
            environmentUseBl.createEnvironmentReservation(environmentReservationDto);
            responseDto.setData(environmentReservationDto);
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
