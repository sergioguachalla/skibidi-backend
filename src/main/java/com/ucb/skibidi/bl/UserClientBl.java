package com.ucb.skibidi.bl;

import com.ucb.skibidi.dao.UserClientRepository;
import com.ucb.skibidi.dto.UserClientDto;
import com.ucb.skibidi.entity.UserClient;
import com.ucb.skibidi.service.EmailService;
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
    @Autowired
    private EmailService emailService;

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

    public boolean getStudyRoomStatus(String kcId) {
        UserClient user = userClientRepository.findByPersonIdKcUuid(kcId);
        if(user == null){
            throw new RuntimeException("User not found with kcId: " + kcId);
        }
        return user.getCanUseStudyRoom();
    }

    public boolean toggleStudyRoomStatus(String kcId) {
        UserClient user = userClientRepository.findByPersonIdKcUuid(kcId);
        if(user == null){
            throw new RuntimeException("User not found with kcId: " + kcId);
        }
        Boolean currentStatus = user.getCanUseStudyRoom();
        user.setCanUseStudyRoom(!currentStatus);
        userClientRepository.save(user);

        String email = user.getPersonId().getEmail();
        String subject;
        String text;

        if(user.getCanUseStudyRoom()){
            subject = "Skibidi Libros | Cuenta restablecida para reserva de salas de estudio";
            text = "Tu cuenta fue restablecida para la reserva de salas de estudio. \n Soporte Skibidi Libros";
        } else {
            subject = "Skibidi Libros | Cuenta restringida para reserva de salas de estudio";
            text = "Tu cuenta fue restringida para la reserva de salas de estudio. Ponte en contacto con un administrador para solucionar este problema.\n Soporte Skibidi Libros";
        }
        emailService.sendMail(email, subject, text);

        return user.getCanUseStudyRoom();
    }
}
