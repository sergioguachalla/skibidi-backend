package com.ucb.skibidi.bl;

import com.ucb.skibidi.dao.FineRepository;
import com.ucb.skibidi.dao.LendBookRepository;
import com.ucb.skibidi.dao.TypeFineRepository;
import com.ucb.skibidi.dto.BookDetailsDto;
import com.ucb.skibidi.dto.ClientDebtDto;
import com.ucb.skibidi.dto.FineDetailDto;
import com.ucb.skibidi.dto.PaidFineDto;
import com.ucb.skibidi.entity.Fine;
import com.ucb.skibidi.entity.LendBook;
import com.ucb.skibidi.entity.TypeFines;
import com.ucb.skibidi.utils.FineSpecification;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class FineBl {
    private static final Logger log = org.slf4j.LoggerFactory.getLogger(FineBl.class);

    @Autowired
    private FineRepository fineRepository;
    @Autowired
    private LendBookRepository lendBookRepository;
    @Autowired
    private TypeFineRepository typeFineRepository;
    @Autowired
    private NotificationBl notificationBl;



    public Page<ClientDebtDto> findDebts(Pageable pageable, Boolean isPaid,
                                         String userKcId, Date startDate, Date endDate) {
        Specification<Fine> specification = Specification.where(null);
        if (isPaid != null) {
            specification = specification.and(FineSpecification.hasPaidDate());
        }
        if (userKcId != null) {
            specification = specification.and(FineSpecification.hasUserKcId(userKcId));
        }
        if (startDate != null || endDate != null) {
            specification = specification.and(FineSpecification.isBetweenDates(startDate, endDate));
        }
        Page<Fine> fines = fineRepository.findAll(specification, pageable);
        Page<ClientDebtDto> finesDto = fines.map(fine -> {
            ClientDebtDto clientDebtDto = new ClientDebtDto();
            clientDebtDto.setFineId(fine.getFineId());
            var delayedDays = (new Date().getTime() - fine.getEndDate().getTime()) / (1000 * 60 * 60 * 24);
            log.info("Delayed days: {}", delayedDays);
            clientDebtDto.setAmountPlusInterest(calculateFine(delayedDays, fine.getTypeFine().getAmount()));
            clientDebtDto.setAmount(fine.getTypeFine().getAmount());
            clientDebtDto.setTypeFine(fine.getTypeFine().getDescription());
            clientDebtDto.setUsername(fine.getLendBook().getClientId().getUsername());
            clientDebtDto.setUserKcId(fine.getLendBook().getClientId().getPersonId().getKcUuid());
            clientDebtDto.setStatus(fine.getPaidDate() == null ? "Pendiente" : "Pagada");
            clientDebtDto.setDueDate(fine.getEndDate());
            clientDebtDto.setPaidDate(Optional.ofNullable(fine.getPaidDate() == null ? "N/A" : fine.getPaidDate().toString()));
            return clientDebtDto;
        });
        return finesDto;
    }

    //@Scheduled(fixedRate = 60000)
    public void updateFines() {
        log.info("Updating fines");
        var bookLends = lendBookRepository.findAll();
        for (var lend : bookLends) {
            if (lend.getReturnDate().before(new Date())) {
                if (fineRepository.existsByLendBook(lend)) {
                    continue;
                }
                //TODO: refactor typefines to 'typeFine'
                TypeFines typeFine = typeFineRepository.findById(1L).get();
                Fine fine = new Fine();
                fine.setLendBook(lend);
                fine.setStartDate(new Date());
                fine.setEndDate(new Date());
                fine.setPaidDate(null);
                fine.setTypeFine(typeFine);
                fine.setStatus(1L);
                fineRepository.save(fine);
                log.info("Fine created for lend: {}", lend.getClientId().getUsername());
                Map<String, String> parameters = createFineNotif(lend);
                notificationBl.sendNotification(parameters, lend.getClientId().getPersonId().getPhoneNumber(), 5L);
            }
        }
    }

    public FineDetailDto getFineDetail(Long fineId) {
        var fine = fineRepository.findById(fineId).get();
        FineDetailDto fineDetailDto = new FineDetailDto();
        fineDetailDto.setFineId(fine.getFineId());
        fineDetailDto.setOriginalAmount(fine.getTypeFine().getAmount());
        fineDetailDto.setDueDate(fine.getEndDate());
        fineDetailDto.setStatus(fine.getPaidDate() == null ? "Pending" : "Paid");
        fineDetailDto.setUsername(fine.getLendBook().getClientId().getUsername());
        BookDetailsDto bookDetailsDto = new BookDetailsDto();
        bookDetailsDto.setBookId(fine.getLendBook().getBookId().getBookId());
        bookDetailsDto.setTitle(fine.getLendBook().getBookId().getTitle());
        bookDetailsDto.setImageUrl(fine.getLendBook().getBookId().getImageUrl());
        fineDetailDto.setBook(bookDetailsDto);
        fineDetailDto.setDelayDays((new Date().getTime() - fine.getEndDate().getTime()) / (1000 * 60 * 60 * 24));
        fineDetailDto.setTotalAmount(calculateFine(fineDetailDto.getDelayDays(), fineDetailDto.getOriginalAmount()));
        return fineDetailDto;

    }

    public Page<PaidFineDto> findPaidFines(Pageable pageable, String username) {
        Specification<Fine> specification = Specification.where(null);
        if (username != null) {
            specification = specification.and(FineSpecification.hasUsername(username));
        }
        specification = specification.and(FineSpecification.hasPaidDate());
        Page<Fine> fines = fineRepository.findAll(specification, pageable);
        return fines.map(fine -> {
            PaidFineDto paidFineDto = new PaidFineDto();
            paidFineDto.setFineId(fine.getFineId());
            paidFineDto.setAmount(fine.getTypeFine().getAmount());
            paidFineDto.setPaidDate(fine.getPaidDate());
            paidFineDto.setOverdue(fine.getEndDate().before(fine.getPaidDate()));
            paidFineDto.setTypeFine(fine.getTypeFine().getDescription());
            paidFineDto.setBookTitle(fine.getLendBook().getBookId().getTitle());
            paidFineDto.setUsername(fine.getLendBook().getClientId().getUsername());
            return paidFineDto;
        });
    }

    private Double calculateFine(Long delayDays, Double originalAmount) {
        return (delayDays * 0.15 ) +  originalAmount ;
    }

}
