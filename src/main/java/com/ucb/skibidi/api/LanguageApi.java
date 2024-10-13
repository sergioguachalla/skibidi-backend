package com.ucb.skibidi.api;

import com.ucb.skibidi.bl.LanguageBl;
import com.ucb.skibidi.dto.LanguageDto;
import com.ucb.skibidi.dto.ResponseDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1/languages")
public class LanguageApi {

    @Autowired
    private LanguageBl languageBl;

    @GetMapping("/all")
    public ResponseDto<List<LanguageDto>> findAll() {
        return new ResponseDto<>(languageBl.findAll(), null, true);
    }
}
