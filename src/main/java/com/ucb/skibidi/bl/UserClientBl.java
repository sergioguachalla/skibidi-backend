package com.ucb.skibidi.bl;

import com.ucb.skibidi.dao.UserClientRepository;
import com.ucb.skibidi.dto.UserClientDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class UserClientBl {
    @Autowired
    private UserClientRepository userClientRepository;

    // Otros métodos...

    public List<UserClientDto> getAllUsers() {
        return userClientRepository.findAll().stream()
                .map(user -> {
                    UserClientDto dto = new UserClientDto();
                    dto.setClientId(user.getClientId());
                    dto.setUsername(user.getUsername());
                    return dto;
                })
                .collect(Collectors.toList());
    }
}
