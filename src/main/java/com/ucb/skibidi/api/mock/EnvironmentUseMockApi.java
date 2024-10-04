package com.ucb.skibidi.api.mock;

import com.ucb.skibidi.bl.mock.EnvironmentMockService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.text.ParseException;

@RestController
@RequestMapping("/api/v1/mock/environment")
public class EnvironmentUseMockApi {

    @Autowired
    private EnvironmentMockService environmentMockService;


    @PostMapping("/use")
    public void processCsvAndSaveData(@RequestParam("file") MultipartFile file) throws ParseException {
        environmentMockService.processCsvAndSaveData(file);
    }
}
