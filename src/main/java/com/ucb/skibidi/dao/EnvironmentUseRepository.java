package com.ucb.skibidi.dao;

import com.ucb.skibidi.entity.EnvironmentUse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

public interface EnvironmentUseRepository extends JpaRepository<EnvironmentUse, Long> {

    @Query(value = "SELECT * FROM Environment_Use WHERE environment_id = :environmentId " +
            "AND status = 2 " +
            "AND ((clock_in BETWEEN :fromDate AND :toDate) " +
            "OR (clock_out BETWEEN :fromDate AND :toDate) " +
            "OR (:fromDate BETWEEN clock_in AND clock_out) " +
            "OR (:toDate BETWEEN clock_in AND clock_out))", nativeQuery = true)
    List<EnvironmentUse> findReservationsBetweenDates(int environmentId, Date fromDate, Date toDate);

    List<EnvironmentUse> findAllByClientIdPersonIdKcUuid(String kcUuid);

    EnvironmentUse findByEnvironmentUse(Long environmentUseId);
}
