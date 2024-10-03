package com.ucb.skibidi.api;

import com.ucb.skibidi.bl.UserClientBl;
import com.ucb.skibidi.dto.ResponseDto;
import com.ucb.skibidi.dto.UserClientDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/api/v1/users")
public class UserClientApi {

    @Autowired
    private UserClientBl userClientBl;

    // Otros endpoints...

    @GetMapping("/clients")
    public ResponseDto<List<UserClientDto>> getAllClients() {
        List<UserClientDto> clients = userClientBl.getAllUsers();
        return new ResponseDto<>(clients, "Users fetched successfully", true);
    }


}
