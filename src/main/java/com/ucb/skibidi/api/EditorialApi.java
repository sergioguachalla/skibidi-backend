package com.ucb.skibidi.api;

import com.ucb.skibidi.bl.EditorialBl;
import com.ucb.skibidi.dto.EditorialDto;
import com.ucb.skibidi.dto.ResponseDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/v1/editorials")
public class EditorialApi {

    @Autowired
    private EditorialBl editorialBl;

    @GetMapping("")
    public ResponseDto<List<EditorialDto>> findAllEditorials() {
        List<EditorialDto> editorialDtos = editorialBl.findAllEditorials();
        ResponseDto<List<EditorialDto>> responseDto = new ResponseDto<>();
        responseDto.setSuccessful(true);
        responseDto.setMessage("OK");
        responseDto.setData(editorialDtos);
        return responseDto;
    }
}
