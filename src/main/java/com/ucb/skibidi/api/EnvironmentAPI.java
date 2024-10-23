package com.ucb.skibidi.api;

import com.ucb.skibidi.bl.EnvironmentBl;
import com.ucb.skibidi.bl.EnvironmentUseBl;
import com.ucb.skibidi.dto.EnvironmentDto;
import com.ucb.skibidi.dto.EnvironmentReservationDto;
import com.ucb.skibidi.dto.ResponseDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/environment")
public class EnvironmentAPI {

    @Autowired
    private EnvironmentBl environmentBl;
    @Autowired
    private EnvironmentUseBl environmentUseBl;

    // Crear un nuevo ambiente
    @PostMapping("/")
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
    public ResponseDto<List<EnvironmentReservationDto>> getEnvironmentsAvailability(@PathVariable String kcid) {
        ResponseDto<List<EnvironmentReservationDto>> responseDto = new ResponseDto<>();
        try {
            List<EnvironmentReservationDto> environments = environmentUseBl.findReservationsByClientId(kcid);
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

    // Actualizar estado de un ambiente
    // En este momento 1 es pendiente, 2 es aceptado y 3 es rechazado
    @PutMapping("/reservations/{id}/status/{status}")
    public ResponseDto<EnvironmentReservationDto> updateReservationStatus(@PathVariable Long id, @PathVariable int status) {
        ResponseDto<EnvironmentReservationDto> responseDto = new ResponseDto<>();
        try {
            environmentUseBl.updateReservation(id, status);
            responseDto.setMessage("Reservation status updated successfully");
            responseDto.setSuccessful(true);
        } catch (Exception e) {
            responseDto.setData(null);
            responseDto.setMessage("Error updating reservation: " + e.getMessage());
            responseDto.setSuccessful(false);
        }
        return responseDto;
    }
}
