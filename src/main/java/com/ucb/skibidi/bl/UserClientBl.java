package com.ucb.skibidi.bl;

import com.ucb.skibidi.dao.UserClientRepository;
import com.ucb.skibidi.dto.UserClientDto;
import com.ucb.skibidi.entity.UserClient;
import com.ucb.skibidi.utils.ClientSpecification;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class UserClientBl {
    @Autowired
    private UserClientRepository userClientRepository;

    // Otros métodos...

    public List<UserClientDto> getAllUsers(String username) {
        if (username != null){
            Specification<UserClient> spec = Specification.where(ClientSpecification.hasUsername(username));
            return userClientRepository.findAll(spec).stream()
                    .map(user -> {
                        UserClientDto dto = new UserClientDto();
                        dto.setClientId(user.getClientId());
                        dto.setUsername(user.getUsername());
                        dto.setKcUuid(user.getPersonId().getKcUuid());
                        return dto;
                    })
                    .collect(Collectors.toList());
        }
        return userClientRepository.findAll().stream()
                .map(user -> {
                    UserClientDto dto = new UserClientDto();
                    dto.setClientId(user.getClientId());
                    dto.setUsername(user.getUsername());
                    dto.setKcUuid(user.getPersonId().getKcUuid());
                    return dto;
                })
                .collect(Collectors.toList());
    }
}
