package com.ucb.skibidi.dao;

import com.ucb.skibidi.entity.Language;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LanguageRepository extends JpaRepository<Language, Long> {
    Language findByLanguageId(Long languageId);
}
