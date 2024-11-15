package com.ucb.skibidi.dao;

import com.ucb.skibidi.entity.Parameter;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ParameterRepository extends JpaRepository<Parameter, Long> {

    @Query("SELECT p.value FROM Parameter p WHERE p.parameterId = :parameterId")
    String findValueByParameterId(@Param("parameterId") Integer parameterId);

}
