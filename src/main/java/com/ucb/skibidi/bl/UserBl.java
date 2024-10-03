package com.ucb.skibidi.bl;

import com.ucb.skibidi.config.exceptions.InvalidInputException;
import com.ucb.skibidi.dao.PersonRepository;
import com.ucb.skibidi.dao.UserClientRepository;
import com.ucb.skibidi.dto.PersonDto;
import com.ucb.skibidi.dto.UserDto;
import com.ucb.skibidi.dto.UserRegistrationDto;
import com.ucb.skibidi.entity.Person;
import com.ucb.skibidi.entity.UserClient;
import com.ucb.skibidi.utils.EntityMapper;
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
import java.util.Collections;
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
    public void createUser(UserRegistrationDto userDto, String group) {
        PersonDto personDto = userDto.getPersonDto();
        if (personRepository.existsByName(personDto.getName()) && personRepository.existsByLastname(personDto.getLastName())) {
            throw new InvalidInputException("Person already exists!");
        }
        validateUser(userDto);
        ValidationUtils.validateEmail(userDto.getUserDto().getEmail());
        ValidationUtils.validateAddress(userDto.getPersonDto().getAddress());

        Person person = new Person();
        person.setName(personDto.getName());
        person.setLastname(personDto.getLastName());
        person.setAddress(personDto.getAddress());
        person.setIdNumber(personDto.getIdNumber());
        person.setExpedition(personDto.getExpedition());
        person.setRegistrationDate(new Date());
        person.setEmail(userDto.getUserDto().getEmail());
        Person newPerson = personRepository.save(person);


        var userExists = keycloak.realm(realm).users().search(userDto.getUserDto().getEmail());
        if (!userExists.isEmpty()) {
            throw new InvalidInputException("User already exists!");
        }

        var credential = preparePassword(userDto.getUserDto().getPassword());
        var user = prepareUser(userDto, credential, group);
        var response = keycloak.realm(realm).users().create(user);
        log.info("Response status from keycloak: {}", response.getStatus());
        String userKcId = response.getLocation().getPath().replaceAll(".*/([^/]+)$", "$1");
        log.info("User created with id: {}", userKcId);
        UserClient userClient = new UserClient();
        userClient.setGroup(group);
        newPerson.setKcUuid(userKcId);
        userClient.setPersonId(newPerson);
        userClient.setUsername(userDto.getUserDto().getName());

        this.userClientRepository.save(userClient);
    }

    public UserRegistrationDto findUserByKcId(String kcId) {
        var user = keycloak.realm(realm).users().get(kcId).toRepresentation();
        var person = personRepository.findByKcUuid(kcId);
        if (user == null) {
            throw new InvalidInputException("User not found!");
        }
        PersonDto personDto = EntityMapper.toPersonDto(person);
        log.info("person: {}", personDto.toString());

        UserRegistrationDto userRegistrationDto = new UserRegistrationDto();
        userRegistrationDto.setPersonDto(personDto);
        UserDto userdto = new UserDto();
        userdto.setName(user.getUsername());
        userdto.setEmail(user.getEmail());

        userRegistrationDto.setUserDto(userdto);

        return userRegistrationDto;
    }

    public void updateUserInformation(UserRegistrationDto userDto, String kcId){
        var user = keycloak.realm(realm).users().get(kcId).toRepresentation();
        if (user == null) {
            throw new InvalidInputException("User not found!");
        }
        var newUserInformation = new UserRepresentation();

        newUserInformation.setUsername(userDto.getUserDto().getName());
        newUserInformation.setEmail(userDto.getUserDto().getEmail());
        newUserInformation.setFirstName(userDto.getPersonDto().getName());
        newUserInformation.setLastName(userDto.getPersonDto().getLastName());
        if(!userDto.getUserDto().getPassword().isEmpty()){
            var credential = preparePassword(userDto.getUserDto().getPassword());
            newUserInformation.setCredentials(List.of(credential));
        }

        keycloak.realm(realm).users().get(kcId).update(newUserInformation);
        log.info("keycloak user updated");

        var userEntity = userClientRepository.findByPersonIdKcUuid(kcId);
        userEntity.setUsername(userDto.getUserDto().getName());
        userClientRepository.save(userEntity);
        log.info("user entity updated");

    }

    private void validateUser(UserRegistrationDto userDto) {
        ValidationUtils.validateName(userDto.getPersonDto().getName());
        ValidationUtils.validateName(userDto.getPersonDto().getLastName());
        ValidationUtils.validateEmail(userDto.getUserDto().getEmail());
    }

    private CredentialRepresentation preparePassword(String password) {
        CredentialRepresentation credential = new CredentialRepresentation();
        credential.setType(CredentialRepresentation.PASSWORD);
        credential.setValue(password);
        credential.setTemporary(false);
        return credential;
    }
    private UserRepresentation prepareUser(UserRegistrationDto userDto, CredentialRepresentation password, String group) {
        UserRepresentation user = new UserRepresentation();
        user.setUsername(userDto.getUserDto().getName());
        user.setEmail(userDto.getUserDto().getEmail());
        user.setFirstName(userDto.getPersonDto().getName());
        user.setLastName(userDto.getPersonDto().getLastName());
        user.setCredentials(List.of(password));
        user.setEnabled(true);
        user.setGroups(Collections.singletonList(group));
        return user;
    }
}