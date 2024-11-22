package com.ucb.skibidi.api;

import com.ucb.skibidi.bl.UserBl;
import com.ucb.skibidi.bl.UserClientBl;
import com.ucb.skibidi.dto.ResponseDto;
import com.ucb.skibidi.dto.UserClientDto;
import com.ucb.skibidi.dto.UserDto;
import com.ucb.skibidi.dto.UserRegistrationDto;
import jakarta.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.ws.rs.Path;
import javax.ws.rs.core.Response;
import java.util.List;
import java.util.UUID;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api/v1/users")
public class UserApi {

    @Autowired
    private UserBl userBl;

    @Autowired
    private UserClientBl userClientBl;

    private Logger log = LoggerFactory.getLogger(UserApi.class);

    @PostMapping("/clients")
    public ResponseDto<String> createClient(@RequestBody UserRegistrationDto userDto) {
        userBl.createUser(userDto, "CLIENT");
        return new ResponseDto<String>(null,"User created successfully", true);
    }

    @PostMapping("/librarian")
    public ResponseDto<String> createLibrarian(@RequestBody UserRegistrationDto userDto) {
        userBl.createUser(userDto, "LIBRARIAN");
        return new ResponseDto<String>(null,"User created successfully", true);
    }


    @GetMapping("/clients/{kcId}")
    public ResponseDto<UserRegistrationDto> findUserByKcId(@PathVariable String kcId) {
        UserRegistrationDto response = userBl.findUserByKcId(kcId);
        return new ResponseDto<>(response, "User found successfully", true);
    }

    @PutMapping("/clients")
    public ResponseDto<String> updateUser(@RequestBody UserRegistrationDto userDto, @RequestParam String kcId) {
        userBl.updateUserInformation(userDto, kcId);
        return new ResponseDto<String>(null,"User updated successfully", true);
    }

    @GetMapping("/password/forgot")
    public ResponseEntity<String> forgotPassword(@RequestParam String email){
        try{
            userBl.resetPassword(email);
            return ResponseEntity.ok("Se envio un correo de recuperacion de contraseña");
        } catch (Exception e){
            return ResponseEntity.badRequest().body("Ocurrio un error.");
        }

    }

    @PutMapping("/password/change")
    public ResponseEntity<ResponseDto<String>> changePassword(@RequestParam String passwordResetToken, @RequestParam String newPassword){
        ResponseDto<String> response = new ResponseDto<>();
        try {
            UUID parsedPasswordResetToken = UUID.fromString(passwordResetToken);
            userBl.changePassword(parsedPasswordResetToken, newPassword);
            response.setData("Contraseña actualizada exitosamente.");
            return ResponseEntity.ok(response);
//            return ResponseEntity.ok("Contraseña actualizada exitosamente.");
        } catch (Exception e) {
//            return ResponseEntity.ok("Algo pasó, pipipi.");
            response.setData("Algo pasó, pipipi.");
            return ResponseEntity.badRequest().body(response);
        }

    }

    @GetMapping("/clients")
    public ResponseDto<List<UserClientDto>> getAllClients(
            @RequestParam(required = false) String username
    ) {
        List<UserClientDto> clients = userClientBl.getAllUsers(username);
        return new ResponseDto<>(clients, "Users fetched successfully", true);
    }

    @GetMapping("{kcId}/studyroom/status")
    public ResponseEntity<ResponseDto<Boolean>> getStudyRoomStatus(
            @PathVariable String kcId
    ) {
        ResponseDto<Boolean> response = new ResponseDto<>();
        try {
            boolean status = userClientBl.getStudyRoomStatus(kcId);
            response.setData(status);
            response.setMessage("Study Room status fetched successfully.");
            response.setSuccessful(true);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.setMessage(e.getMessage());
            response.setSuccessful(false);
            return ResponseEntity.badRequest().body(response);
        }
    }

    @GetMapping("{kcId}/books/status")
    public ResponseEntity<ResponseDto<Boolean>> getBorrowingStatus(
            @PathVariable String kcId
    ) {
        ResponseDto<Boolean> response = new ResponseDto<>();
        try {
            boolean status = userClientBl.getBorrowingStatus(kcId);
            response.setData(status);
            response.setMessage("Borrow Books status fetched successfully.");
            response.setSuccessful(true);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.setMessage(e.getMessage());
            response.setSuccessful(false);
            return ResponseEntity.badRequest().body(response);
        }
    }

    @PutMapping("{kcId}/books/status")
    public ResponseEntity<ResponseDto<Boolean>> changeBorrowingStatus(
            @PathVariable String kcId
    ){
        ResponseDto<Boolean> response = new ResponseDto<>();
        try{
            log.info("actualizando status de prestamos");
            boolean currentStatus = userClientBl.changeBorrowingStatus(kcId);
            response.setSuccessful(true);
            response.setData(currentStatus);
            response.setMessage("Borrow Books status updated successfully.");
            return ResponseEntity.ok(response);
        } catch(Exception e) {
            log.info("error al actualizar status de prestamos");
            response.setSuccessful(false);
            response.setMessage("Error: " + e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }

    @GetMapping("{kcId}/blocked/status")
    public ResponseEntity<ResponseDto<Boolean>> getBlockedUserStatus(
            @PathVariable String kcId
    ){
        ResponseDto<Boolean> response = new ResponseDto<>();
        try{
            boolean status = userClientBl.getBlockedUserStatus(kcId);
            response.setSuccessful(true);
            response.setData(status);
            response.setMessage("Blocked User Status status fetched successfully.");
            return ResponseEntity.ok(response);
        } catch(Exception e) {
            response.setSuccessful(false);
            response.setMessage("Error: " + e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }

    @PutMapping("{kcId}/blocked/status")
    public ResponseEntity<ResponseDto<Boolean>> blockUser(
            @PathVariable String kcId
    ){
        ResponseDto<Boolean> response = new ResponseDto<>();
        try{
            boolean currentStatus = userClientBl.blockUser(kcId);
            response.setSuccessful(true);
            response.setData(currentStatus);
            response.setMessage("Blocked User status updated successfully.");
            log.info("User blocked status updated successfully.");
            return ResponseEntity.ok(response);
        } catch(Exception e) {
            log.error("Error al actualizar el estado de bloqueo del usuario");
            response.setSuccessful(false);
            response.setMessage("Error: " + e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }




    @PostMapping("{kcId}/studyroom/status")
    public ResponseEntity<ResponseDto<Boolean>> toggleStudyRoomStatus(
            @PathVariable String kcId
    ){
        ResponseDto<Boolean> response = new ResponseDto<>();
        try{
            boolean currentStatus = userClientBl.toggleStudyRoomStatus(kcId);
            response.setSuccessful(true);
            response.setData(currentStatus);
            response.setMessage("Study Room status updated successfully.");
            return ResponseEntity.ok(response);
        } catch(Exception e) {
            response.setSuccessful(false);
            response.setMessage("Error: " + e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }
}