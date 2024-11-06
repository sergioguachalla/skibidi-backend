package com.ucb.skibidi.api;

import com.ucb.skibidi.bl.FineBl;
import com.ucb.skibidi.dto.ClientDebtDto;
import com.ucb.skibidi.dto.ResponseDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/debts")
public class FineApi {
    @Autowired
    private FineBl fineBl;

    @GetMapping("/")
    public ResponseDto<Page<ClientDebtDto>> getAllDebts(
            @RequestParam(defaultValue = "0") Integer page,
            @RequestParam(defaultValue = "4") Integer size,
            @RequestParam(required = false) Boolean isPaid
    ){
        Pageable pageable = Pageable.ofSize(size).withPage(page);
        var debts = fineBl.findDebts(pageable, null, null);
        ResponseDto<Page<ClientDebtDto>> responseDto = new ResponseDto<>();
        responseDto.setData(debts);
        responseDto.setMessage(null);
        responseDto.setSuccessful(true);
        return responseDto;
    }
}
