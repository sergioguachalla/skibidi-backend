package com.ucb.skibidi.dao;

import com.ucb.skibidi.entity.TypeFines;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TypeFineRepository  extends JpaRepository<TypeFines, Long> {
}
