
package com.ucb.skibidi.bl;

import com.ucb.skibidi.dao.GenreRepository;
import com.ucb.skibidi.entity.Genre;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class GenreBl {
    private static final Logger log = LoggerFactory.getLogger(GenreBl.class);

    @Autowired
    private GenreRepository genreRepository;

    public Genre createGenre(String genreName) {
        log.info("Creating genre...");
        try {
            Genre genre = new Genre();
            genre.setName(genreName);
            genre = genreRepository.save(genre);
            log.info("Genre created");
            return genre;
        } catch (Exception e) {
            log.error("Error creating genre: {}", e.getMessage());
            throw e;
        }
    }
}

