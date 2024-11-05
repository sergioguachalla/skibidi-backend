package com.ucb.skibidi.api;

import com.ucb.skibidi.bl.EnvironmentBl;
import com.ucb.skibidi.bl.EnvironmentUseBl;
import com.ucb.skibidi.dto.EnvironmentDto;
import com.ucb.skibidi.dto.EnvironmentReservationDto;
import com.ucb.skibidi.dto.ResponseDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/environments")
public class EnvironmentAPI {

    @Autowired
    private EnvironmentBl environmentBl;
    @Autowired
    private EnvironmentUseBl environmentUseBl;

    @PostMapping("")
    public ResponseDto<EnvironmentDto> createEnvironment(@RequestBody EnvironmentDto environmentDto) {
        ResponseDto<EnvironmentDto> responseDto = new ResponseDto<>();
        try {
            EnvironmentDto createdEnvironment = environmentBl.createEnvironment(environmentDto);
            responseDto.setData(createdEnvironment);
            responseDto.setMessage("Environment created successfully");
            responseDto.setSuccessful(true);
        } catch (Exception e) {
            responseDto.setData(null);
            responseDto.setMessage("Error creating environment: " + e.getMessage());
            responseDto.setSuccessful(false);
        }
        return responseDto;
    }

    // Obtener un ambiente por ID
    @GetMapping("/{id}")
    public ResponseDto<EnvironmentDto> getEnvironmentById(@PathVariable Long id) {
        ResponseDto<EnvironmentDto> responseDto = new ResponseDto<>();
        try {
            EnvironmentDto environment = environmentBl.getEnvironmentById(id);
            responseDto.setData(environment);
            responseDto.setMessage("Environment fetched successfully");
            responseDto.setSuccessful(true);
        } catch (Exception e) {
            responseDto.setData(null);
            responseDto.setMessage("Error fetching environment: " + e.getMessage());
            responseDto.setSuccessful(false);
        }
        return responseDto;
    }

    // Listar todos los ambientes
    @GetMapping("/")
    public ResponseDto<List<EnvironmentDto>> getAllEnvironments() {
        ResponseDto<List<EnvironmentDto>> responseDto = new ResponseDto<>();
        try {
            List<EnvironmentDto> environments = environmentBl.getAllEnvironments();
            responseDto.setData(environments);
            responseDto.setMessage("Environments fetched successfully");
            responseDto.setSuccessful(true);
        } catch (Exception e) {
            responseDto.setData(null);
            responseDto.setMessage("Error fetching environments: " + e.getMessage());
            responseDto.setSuccessful(false);
        }
        return responseDto;
    }


    @GetMapping("{kcid}/reservations")
    public ResponseDto<Page<EnvironmentReservationDto>> getEnvironmentsAvailability(
            @PathVariable String kcid,
            @RequestParam(defaultValue = "0") Integer page,
            @RequestParam(defaultValue = "7") Integer size

    ) {
        Pageable pageable = PageRequest.of(page, size);
        ResponseDto<Page<EnvironmentReservationDto>> responseDto = new ResponseDto<>();
        try {
            Page<EnvironmentReservationDto> environments = environmentUseBl.findReservationsByClientId(kcid,pageable);
            responseDto.setData(environments);
            responseDto.setMessage("Environments fetched successfully");
            responseDto.setSuccessful(true);
        } catch (Exception e) {
            responseDto.setData(null);
            responseDto.setMessage("Error fetching environments: " + e.getMessage());
            responseDto.setSuccessful(false);
        }
        return responseDto;
    }


}
