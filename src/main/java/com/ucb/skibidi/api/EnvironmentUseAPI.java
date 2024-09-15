package com.ucb.skibidi.api;

import com.ucb.skibidi.bl.EnvironmentUseBl;
import com.ucb.skibidi.dto.EnvironmentUseDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/environments")
public class EnvironmentUseAPI {
    @Autowired
    private EnvironmentUseBl environmentUseBl;

    @PostMapping("/")
    public String createEnvironmentUse(@RequestBody EnvironmentUseDto environmentUseDto) {
        try {
            environmentUseBl.createEnvironmentUse(environmentUseDto);
            return "Environment use created";
        } catch (Exception e) {
            return "Error creating environment use: " + e.getMessage();
        }
    }
}
