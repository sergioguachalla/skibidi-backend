package com.ucb.skibidi.dao;

import com.ucb.skibidi.entity.Fine;
import com.ucb.skibidi.entity.LendBook;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.stereotype.Repository;

@Repository
public interface FineRepository extends JpaRepository<Fine, Long>, JpaSpecificationExecutor<Fine> {

    Boolean existsByLendBook(LendBook lendBook);
}
