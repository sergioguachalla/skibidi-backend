package com.ucb.skibidi.dao;

import com.ucb.skibidi.entity.LendBook;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LendBookRepository extends JpaRepository<LendBook, Long> {
}
