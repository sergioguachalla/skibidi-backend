package com.ucb.skibidi.api;

import com.ucb.skibidi.bl.EnvironmentUseBl;
import com.ucb.skibidi.dto.EnvironmentDto;
import com.ucb.skibidi.dto.EnvironmentReservationDto;
import com.ucb.skibidi.dto.ResponseDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

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

    @PutMapping("/{id}")
    public ResponseDto<EnvironmentReservationDto> updateEnvironmentReservation(@PathVariable Integer id, @RequestBody EnvironmentReservationDto environmentReservationDto) {
        ResponseDto<EnvironmentReservationDto> responseDto = new ResponseDto<>();
        try {
            environmentUseBl.updateEnvironmentReservation(id, environmentReservationDto);
            responseDto.setData(environmentReservationDto);
            responseDto.setMessage("Environment use updated");
            responseDto.setSuccessful(true);
        } catch (Exception e) {
            responseDto.setData(null);
            responseDto.setMessage("Error updating environment use: " + e.getMessage());
            responseDto.setSuccessful(false);
        }
        return responseDto;
    }

    // disponibilidad
    @GetMapping("/availability")
    public ResponseDto<List<EnvironmentDto>> getEnvironmentsAvailability(
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss") Date from,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss") Date to
    ) {
        ResponseDto<List<EnvironmentDto>> responseDto = new ResponseDto<>();
        try {
            List<EnvironmentDto> environments = environmentUseBl.getEnvironmentsAvailability(from,to);
            responseDto.setData(environments);
            responseDto.setMessage("Environments availability fetched successfully");
            responseDto.setSuccessful(true);
            return responseDto;
        } catch (Exception e) {
            responseDto.setData(null);
            responseDto.setMessage("Error fetching environments availability: " + e.getMessage());
            responseDto.setSuccessful(false);
            return responseDto;
        }
    }
    @GetMapping("/history-reservation")
    public ResponseDto<List<EnvironmentReservationDto>> getAllReservations() {
        ResponseDto<List<EnvironmentReservationDto>> responseDto = new ResponseDto<>();
        try {
            List<EnvironmentReservationDto> reservations = environmentUseBl.findAllReservations();
            responseDto.setData(reservations);
            responseDto.setMessage("All reservations fetched successfully");
            responseDto.setSuccessful(true);
        } catch (Exception e) {
            responseDto.setData(null);
            responseDto.setMessage("Error fetching reservations: " + e.getMessage());
            responseDto.setSuccessful(false);
        }
        return responseDto;
    }
}
