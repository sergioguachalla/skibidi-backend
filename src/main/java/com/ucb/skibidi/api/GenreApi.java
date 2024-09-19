package com.ucb.skibidi.api;

import com.ucb.skibidi.bl.GenreBl;
import com.ucb.skibidi.dto.GenreDto;
import com.ucb.skibidi.dto.ResponseDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;


@RestController
@RequestMapping("/genre")
public class GenreApi {
    @Autowired GenreBl genreBl;

    @GetMapping("/all")
    public ResponseDto<List<GenreDto>> getAllGenres(){
        try{
            ResponseDto<List<GenreDto>> responseDto = new ResponseDto<>();
            responseDto.setData(genreBl.getAllGenres());
            responseDto.setMessage("Genres found");
            responseDto.setSuccessful(true);
            return responseDto;
        } catch (Exception e) {
            ResponseDto<List<GenreDto>> responseDto = new ResponseDto<>();
            responseDto.setData(null);
            responseDto.setMessage("Error finding genres: " + e.getMessage());
            responseDto.setSuccessful(false);
            return responseDto;
        }
    }

}
