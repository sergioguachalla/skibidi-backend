package com.ucb.skibidi.bl;

import com.ucb.skibidi.dao.GenreRepository;
import com.ucb.skibidi.dto.GenreDto;
import com.ucb.skibidi.entity.Genre;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GenreBl {
    @Autowired GenreRepository genreRepository;

    public List<GenreDto> getAllGenres (){
        List<Genre> genres = genreRepository.findAll();
        return genres.stream().map(genre -> {
            GenreDto genreDto = new GenreDto();
            genreDto.setGenreId(genre.getGenreId());
            genreDto.setGenreName(genre.getName());
            return genreDto;
        }).toList();
    }
}
