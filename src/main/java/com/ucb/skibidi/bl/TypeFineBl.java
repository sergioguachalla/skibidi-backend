package com.ucb.skibidi.bl;

import com.ucb.skibidi.dao.TypeFineRepository;
import com.ucb.skibidi.dto.TypeFineDto;
import com.ucb.skibidi.entity.TypeFines;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class TypeFineBl {

    @Autowired
    private TypeFineRepository typeFineRepository;

    public List<TypeFineDto> findAll(){
        List<TypeFines> typeFineList = typeFineRepository.findAll();
        List<TypeFineDto> typeFineDtoList = new ArrayList<>();
        for(TypeFines typeFine : typeFineList){
            TypeFineDto typeFineDto = new TypeFineDto();
            typeFineDto.setId(typeFine.getTypeFineId());
            typeFineDto.setDescription(typeFine.getDescription());
            typeFineDto.setAmount(typeFine.getAmount());
            typeFineDtoList.add(typeFineDto);
        }
        return typeFineDtoList;
    }

    public void saveTypeFine(TypeFineDto typeFineDto){
        TypeFines typeFine = new TypeFines();
        typeFine.setDescription(typeFineDto.getDescription());
        typeFine.setAmount(typeFineDto.getAmount());
        typeFineRepository.save(typeFine);
    }

    public void updateTypeFine(TypeFineDto typeFineDto){
        TypeFines typeFine = new TypeFines();
        typeFine.setDescription(typeFineDto.getDescription());
        typeFine.setAmount(typeFineDto.getAmount());
        typeFineRepository.save(typeFine);
    }
}
