package com.ucb.skibidi.api;

import com.ucb.skibidi.bl.FineBl;
import com.ucb.skibidi.dto.ClientDebtDto;
import com.ucb.skibidi.dto.FineDetailDto;
<<<<<<< HEAD
import com.ucb.skibidi.dto.PaidFineDto;
=======
>>>>>>> 3428c51 (add fine details by fine id)
import com.ucb.skibidi.dto.ResponseDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/fines")
public class FineApi {
    @Autowired
    private FineBl fineBl;

    @GetMapping("/")
    public ResponseDto<Page<ClientDebtDto>> getAllDebts(
            @RequestParam(defaultValue = "0") Integer page,
            @RequestParam(defaultValue = "4") Integer size,
            @RequestParam(required = false) Boolean isPaid,
            @RequestParam(required = false) String userKcId,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date startDate,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date endDate
            ){
        Pageable pageable = Pageable.ofSize(size).withPage(page);
        var debts = fineBl.findDebts(pageable,  isPaid, userKcId, startDate, endDate);
        ResponseDto<Page<ClientDebtDto>> responseDto = new ResponseDto<>();
        responseDto.setData(debts);
        responseDto.setMessage(null);
        responseDto.setSuccessful(true);
        return responseDto;
    }

    @GetMapping("/details/{fineId}")
    public ResponseDto<FineDetailDto> getDebtDetails(@PathVariable Long fineId){
        var debt = fineBl.getFineDetail(fineId);
        ResponseDto<FineDetailDto> responseDto = new ResponseDto<>();
        responseDto.setData(debt);
        responseDto.setMessage(null);
        responseDto.setSuccessful(true);
        return responseDto;
    }
}
