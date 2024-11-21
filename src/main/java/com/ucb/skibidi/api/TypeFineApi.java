package com.ucb.skibidi.api;

import com.ucb.skibidi.bl.TypeFineBl;
import com.ucb.skibidi.dto.ResponseDto;
import com.ucb.skibidi.dto.TypeFineDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/v1/typeFines")
public class TypeFineApi {

    @Autowired
    private TypeFineBl typeFineBl;


    @GetMapping("/")
    public ResponseDto<List<TypeFineDto>> findAll(){
        List<TypeFineDto> typeFineDtoList = typeFineBl.findAll();
        ResponseDto<List<TypeFineDto>> responseDto = new ResponseDto<>();
        responseDto.setSuccessful(true);
        responseDto.setMessage("OK");
        responseDto.setData(typeFineDtoList);
        return responseDto;
    }

    @PutMapping("/")
    public ResponseDto<TypeFineDto> updateFineDto(@RequestBody TypeFineDto typeFineDto){
        typeFineBl.updateTypeFine(typeFineDto);
        ResponseDto<TypeFineDto> responseDto = new ResponseDto<>();
        responseDto.setSuccessful(true);
        responseDto.setMessage("fine updated successfully");
        responseDto.setData(typeFineDto);
        return responseDto;
    }

    @PostMapping("/")
    public ResponseDto<TypeFineDto> saveFineDto(@RequestBody TypeFineDto typeFineDto){
        typeFineBl.saveTypeFine(typeFineDto);
        ResponseDto<TypeFineDto> responseDto = new ResponseDto<>();
        responseDto.setSuccessful(true);
        responseDto.setMessage("fine saved successfully");
        responseDto.setData(typeFineDto);
        return responseDto;
    }

    @DeleteMapping("/{id}")
    public ResponseDto<TypeFineDto> deleteFineDto(@PathVariable Long id){
        typeFineBl.deleteTypeFine(id);
        ResponseDto<TypeFineDto> responseDto = new ResponseDto<>();
        responseDto.setSuccessful(true);
        responseDto.setMessage("fine deleted successfully");
        return responseDto;
    }
}
