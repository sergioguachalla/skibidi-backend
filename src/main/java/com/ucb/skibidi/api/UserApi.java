package com.ucb.skibidi.api;

import com.ucb.skibidi.bl.UserBl;
import com.ucb.skibidi.bl.UserClientBl;
import com.ucb.skibidi.dto.ResponseDto;
import com.ucb.skibidi.dto.UserClientDto;
import com.ucb.skibidi.dto.UserDto;
import com.ucb.skibidi.dto.UserRegistrationDto;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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
    public ResponseEntity<String> changePassword(@RequestParam String passwordResetToken, @RequestParam String newPassword){
        try {
            UUID parsedPasswordResetToken = UUID.fromString(passwordResetToken);
            userBl.changePassword(parsedPasswordResetToken, newPassword);
            return ResponseEntity.ok("Contraseña actualizada exitosamente.");
        } catch (Exception e) {
            return ResponseEntity.ok("Algo pasó, pipipi.");
        }

    }

    @GetMapping("/clients")
    public ResponseDto<List<UserClientDto>> getAllClients() {
        List<UserClientDto> clients = userClientBl.getAllUsers();
        return new ResponseDto<>(clients, "Users fetched successfully", true);
    }
}