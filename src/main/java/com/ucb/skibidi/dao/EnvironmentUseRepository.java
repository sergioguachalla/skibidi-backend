package com.ucb.skibidi.dao;

import com.ucb.skibidi.entity.EnvironmentUse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

public interface EnvironmentUseRepository extends JpaRepository<EnvironmentUse, Long> {

    @Query(value = "SELECT * FROM Environment_Use WHERE environment_id = :environmentId " +
            "AND (status = 1 OR status = 2) " +
            "AND ((clock_in BETWEEN :fromDate AND :toDate) " +
            "OR (clock_out BETWEEN :fromDate AND :toDate) " +
            "OR (:fromDate BETWEEN clock_in AND clock_out) " +
            "OR (:toDate BETWEEN clock_in AND clock_out))", nativeQuery = true)
    List<EnvironmentUse> findReservationsBetweenDates(int environmentId, Date fromDate, Date toDate);

    Page<EnvironmentUse> findAllByClientIdPersonIdKcUuidOrderByReservationDateAsc(String kcUuid, Pageable pageable);

    EnvironmentUse findByEnvironmentUse(Long environmentUseId);



    @Query(value = "SELECT * FROM Environment_Use WHERE (status = 1 OR status = 2) " +
            "AND clock_out < :now", nativeQuery = true)
    List<EnvironmentUse> findPast(LocalDateTime now);
}
