package com.ucb.skibidi.bl;

import com.ucb.skibidi.config.exceptions.InvalidInputException;
import com.ucb.skibidi.dao.PersonRepository;
import com.ucb.skibidi.dao.UserClientRepository;
import com.ucb.skibidi.dto.PersonDto;
import com.ucb.skibidi.dto.UserDto;
import com.ucb.skibidi.dto.UserRegistrationDto;
import com.ucb.skibidi.entity.Person;
import com.ucb.skibidi.entity.UserClient;
import com.ucb.skibidi.utils.ValidationUtils;
import jakarta.transaction.Transactional;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.representations.idm.CredentialRepresentation;
import org.keycloak.representations.idm.UserRepresentation;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

@Service
public class UserBl {
    @Autowired
    private Keycloak keycloak;
    @Autowired
    private PersonRepository personRepository;
    @Autowired
    private UserClientRepository userClientRepository;

    public UserBl(@Autowired  Keycloak keycloak,
                  @Autowired PersonRepository personRepository,
                  @Autowired UserClientRepository userClientRepository) {
        this.keycloak = keycloak;
        this.personRepository = personRepository;
        this.userClientRepository = userClientRepository;
    }

    private static final Logger log = org.slf4j.LoggerFactory.getLogger(UserBl.class);
    @Value("${keycloak.credentials.realm}")
    private String realm;

    @Transactional
    public void createUser(UserRegistrationDto userDto) {
        PersonDto personDto = userDto.getPersonDto();
        if (personRepository.existsByName(personDto.getName()) && personRepository.existsByLastname(personDto.getLastName())) {
            throw new InvalidInputException("Person already exists!");
        }
        validateUser(userDto.getUserDto());
        ValidationUtils.validateEmail(userDto.getUserDto().getEmail());
        ValidationUtils.validateAddress(userDto.getPersonDto().getAddress());

        Person person = new Person();
        person.setName(personDto.getName());
        person.setLastname(personDto.getLastName());
        person.setAddress(personDto.getAddress());
        person.setIdNumber(personDto.getIdNumber());
        person.setExpedition(personDto.getExpedition());
        person.setRegistrationDate(new Date());
        Person newPerson = personRepository.save(person);



        var credential = preparePassword(userDto.getUserDto().getPassword());
        var user = prepareUser(userDto.getUserDto(), credential);

        var response = keycloak.realm(realm).users().create(user);
        log.info("Response status: {}", response.getStatus());
        String userKcId = response.getLocation().getPath().replaceAll(".*/([^/]+)$", "$1");
        log.info("User created with id: {}", userKcId);
        UserClient userClient = new UserClient();
        userClient.setGroup("CLIENT");
        userClient.setPersonId(newPerson);
        userClient.setUsername(userDto.getUserDto().getName());
        this.userClientRepository.save(userClient);
    }

    private void validateUser(UserDto userDto) {
        ValidationUtils.validateName(userDto.getName());
        ValidationUtils.validateEmail(userDto.getEmail());
    }

    private CredentialRepresentation preparePassword(String password) {
        CredentialRepresentation credential = new CredentialRepresentation();
        credential.setType(CredentialRepresentation.PASSWORD);
        credential.setValue(password);
        credential.setTemporary(false);
        return credential;
    }
    private UserRepresentation prepareUser(UserDto userDto, CredentialRepresentation password) {
        UserRepresentation user = new UserRepresentation();
        user.setUsername(userDto.getName());
        user.setEmail(userDto.getEmail());
        user.setFirstName(userDto.getName());
        user.setCredentials(List.of(password));
        user.setEnabled(true);
        //TODO: set group according to user type
        user.setGroups(Arrays.asList("CLIENT"));
        return user;
    }
}
