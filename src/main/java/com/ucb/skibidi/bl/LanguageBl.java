package com.ucb.skibidi.bl;

import com.ucb.skibidi.dao.LanguageRepository;
import com.ucb.skibidi.dto.LanguageDto;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class LanguageBl {
    private static final Logger log = org.slf4j.LoggerFactory.getLogger(LanguageBl.class);

    @Autowired
    private LanguageRepository languageRepository;

    public List<LanguageDto> findAll() {
        log.info("Finding all languages");
        List<LanguageDto> languageDtoList = new ArrayList<>();
        languageRepository.findAll().forEach(language -> {
            LanguageDto languageDto = new LanguageDto();
            languageDto.setId(language.getLanguageId().intValue());
            languageDto.setLanguage(language.getLanguage());
            languageDtoList.add(languageDto);
        });
        log.info("Languages found: {}", languageDtoList.size());
        return languageDtoList;
    }


}
