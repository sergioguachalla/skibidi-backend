package com.ucb.skibidi.bl;

import com.ucb.skibidi.dao.EditorialRepository;
import com.ucb.skibidi.dto.EditorialDto;
import com.ucb.skibidi.entity.Editorial;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class EditorialBl {
    @Autowired
    private EditorialRepository editorialRepository;


    public List<EditorialDto> findAllEditorials() {
        List<EditorialDto> editorialDtos = new ArrayList<>();
        List<Editorial> editorials = editorialRepository.findAll();
        for (Editorial editorial : editorials) {
            EditorialDto editorialDto = new EditorialDto();
            editorialDto.setId(editorial.getEditorialId());
            editorialDto.setEditorial(editorial.getEditorial());
            editorialDtos.add(editorialDto);

        }
        return editorialDtos;

    }
}
