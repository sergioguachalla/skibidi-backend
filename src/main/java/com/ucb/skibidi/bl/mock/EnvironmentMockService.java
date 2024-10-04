package com.ucb.skibidi.bl.mock;

import com.ucb.skibidi.bl.UserBl;
import com.ucb.skibidi.dao.EnvironmentRepository;
import com.ucb.skibidi.dao.EnvironmentUseRepository;
import com.ucb.skibidi.dao.UserClientRepository;
import com.ucb.skibidi.dto.PersonDto;
import com.ucb.skibidi.dto.UserDto;
import com.ucb.skibidi.dto.UserRegistrationDto;
import com.ucb.skibidi.entity.Environment;
import com.ucb.skibidi.entity.EnvironmentUse;
import com.ucb.skibidi.entity.UserClient;
import jakarta.transaction.Transactional;
import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVRecord;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.text.DateFormat;
import java.text.ParseException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Date;
import java.util.Random;

@Service
public class EnvironmentMockService {
    @Autowired
    private UserBl userBl;
    @Autowired
    private UserClientRepository userClientRepository;
    @Autowired
    private EnvironmentRepository environmentRepository;
    @Autowired
    private EnvironmentUseRepository environmentUseRepository;

    private static final Logger log = org.slf4j.LoggerFactory.getLogger(EnvironmentMockService.class);

    private static final String[] HEADERS =
            {"environment_id", "client_id", "reservation_date", "clock_in",
                    "clock_out", "purpose", "status"};

    @Transactional
    public void processCsvAndSaveData(MultipartFile file) throws ParseException {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(file.getInputStream(), StandardCharsets.UTF_8));
             CSVParser csvParser = new CSVParser(reader,
                     CSVFormat.DEFAULT.withHeader(HEADERS).withSkipHeaderRecord(true))) {

            for (CSVRecord csvRecord : csvParser) {
                log.info("CSV Record: " + csvRecord.get("client_id"));
                UserClient userClient = this.userClientRepository.findById(Long.valueOf(csvRecord.get("client_id"))).orElseThrow();
                Environment environment = this.environmentRepository.findById(Long.valueOf(csvRecord.get("environment_id"))).get();
                LocalDate reservationDate = LocalDate.parse(csvRecord.get("reservation_date"));
                String parsedClockIn = formatTimeString(csvRecord.get("clock_in"));
                String parsedClockOut = formatTimeString(csvRecord.get("clock_out"));
                LocalDateTime clockIn = LocalDateTime.of(reservationDate, LocalTime.parse(parsedClockIn));
                LocalDateTime clockOut = LocalDateTime.of(reservationDate, LocalTime.parse(parsedClockOut));
                String purpose = csvRecord.get("purpose");
                int status = Integer.parseInt(csvRecord.get("status"));
                EnvironmentUse environmentUse = new EnvironmentUse();
                environmentUse.setClientId(userClient);
                environmentUse.setEnvironmentId(environment);
                environmentUse.setReservationDate(reservationDate);
                environmentUse.setClockIn(clockIn);
                environmentUse.setClockOut(clockOut);
                environmentUse.setPurpose(purpose);
                environmentUse.setStatus(status);
                this.environmentUseRepository.save(environmentUse);

            }


        } catch (IOException e) {
            throw new RuntimeException("Failed to process the CSV file: " + e.getMessage());
        }


    }

    private  String formatTimeString(String timeString) {
        if (timeString.length() == 4) {
            timeString = "0" + timeString;
        }
        return timeString;
    }

}
