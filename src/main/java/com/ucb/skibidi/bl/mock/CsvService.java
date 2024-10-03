package com.ucb.skibidi.bl.mock;

import com.ucb.skibidi.bl.UserBl;
import com.ucb.skibidi.dao.PersonRepository;
import com.ucb.skibidi.dto.PersonDto;
import com.ucb.skibidi.dto.UserDto;
import com.ucb.skibidi.dto.UserRegistrationDto;
import com.ucb.skibidi.entity.Person;
import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVRecord;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.*;

@Service
public class CsvService {
    @Autowired
    private PersonRepository personRepository;

    @Autowired
    private UserBl userBl;

    private static final Logger log = org.slf4j.LoggerFactory.getLogger(CsvService.class);
    private final List<String> EXPEDITIONS =
            Arrays.asList("LP", "CB", "SC", "OR", "PT", "CH", "BN", "PA", "TJ", "SCZ");
    private static final String[] HEADERS =
            {"name", "lastname", "idNumber", "address",
                    "username", "email", "password"};
    private static final List<String> GROUPS = Arrays.asList("CLIENT", "ADMIN", "LIBRARIAN");

    public void processCsv(MultipartFile file) {
        List<PersonDto> personDtoList = new ArrayList<>();
        List<UserDto> userDtoList = new ArrayList<>();
        List<UserRegistrationDto> userRegistrationDtoList = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(file.getInputStream(), StandardCharsets.UTF_8));
             CSVParser csvParser = new CSVParser(reader,
                     CSVFormat.DEFAULT.withHeader(HEADERS).withSkipHeaderRecord(true))) {

            for (CSVRecord csvRecord : csvParser) {
                PersonDto personDto = new PersonDto();
                personDto.setName(csvRecord.get("name"));
                personDto.setLastName(csvRecord.get("lastname"));
                personDto.setIdNumber(Integer.parseInt(csvRecord.get("idNumber")));
                personDto.setAddress(csvRecord.get("address"));
                personDto.setExpedition(EXPEDITIONS.get(new Random().nextInt(EXPEDITIONS.size())));
                personDtoList.add(personDto);

                UserDto userDto = new UserDto();
                userDto.setName(csvRecord.get("username"));
                userDto.setEmail(csvRecord.get("email"));
                userDto.setPassword(csvRecord.get("password"));
                userDtoList.add(userDto);

            }
            for (int i = 0; i < personDtoList.size(); i++) {
                UserRegistrationDto userRegistrationDto = new UserRegistrationDto();
                userRegistrationDto.setPersonDto(personDtoList.get(i));
                userRegistrationDto.setUserDto(userDtoList.get(i));
                userRegistrationDtoList.add(userRegistrationDto);
            }

            for (UserRegistrationDto userRegistrationDto : userRegistrationDtoList) {
                userBl.createUser(userRegistrationDto, GROUPS.get(new Random().nextInt(GROUPS.size())));
            }
        } catch (IOException e) {
            throw new RuntimeException("Failed to process the CSV file: " + e.getMessage());
        }

    }
}