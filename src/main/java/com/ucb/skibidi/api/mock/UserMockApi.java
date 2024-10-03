package com.ucb.skibidi.api.mock;

import com.ucb.skibidi.bl.mock.CsvService;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@RestController
@RequestMapping("/api/v1/users/mock")
public class UserMockApi {

    @Autowired
    private CsvService csvService;

    @PostMapping("/")
    public void readCsvAndSave(@RequestParam("file")MultipartFile file)  {
        this.csvService.processCsv(file);
    }
}
