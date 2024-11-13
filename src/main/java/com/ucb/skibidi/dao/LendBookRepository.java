package com.ucb.skibidi.dao;

import com.ucb.skibidi.entity.LendBook;
import jakarta.persistence.Tuple;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface LendBookRepository extends JpaRepository<LendBook, Long> {
    @Query("SELECT l.lentBookId AS lendBookId, l.lentDate AS lendDate, l.returnDate AS returnDate, " +
            "l.notes AS notes, b.title AS title, string_agg(a.name, ', ') AS authors, l.status AS status, " +
            "CONCAT(p.name, ' ', p.lastname) AS clientName " +
            "FROM LendBook l " +
            "JOIN l.bookId b " +
            "JOIN BookAuthors ba ON ba.bookId.BookId = b.BookId " +
            "JOIN Author a ON a.authorId = ba.authorId.authorId " +
            "JOIN UserClient uc ON uc.clientId = l.clientId.clientId " +
            "JOIN Person p ON p.personId = uc.personId.personId " +
            "GROUP BY l.lentBookId, b.title, l.lentDate, l.returnDate, l.notes, l.status, p.name, p.lastname")
    Page<Tuple> findLendBooksWithDetails(Pageable pageable);

    @Query("SELECT l.lentBookId AS lendBookId, l.lentDate AS lendDate, l.returnDate AS returnDate, " +
            "l.notes AS notes, b.title AS title, string_agg(a.name, ', ') AS authors, l.status AS status " +
            "FROM LendBook l " +
            "JOIN l.bookId b " +
            "JOIN BookAuthors ba ON ba.bookId.BookId = b.BookId " +
            "JOIN Author a ON a.authorId = ba.authorId.authorId " +
            "JOIN UserClient uc ON uc.clientId = l.clientId.clientId " +
            "JOIN Person p ON p.personId = uc.personId.personId " +
            "WHERE p.kcUuid = :kcUuid " +  // Solo para el usuario específico
            "GROUP BY l.lentBookId, b.title, l.lentDate, l.returnDate, l.notes, l.status")
    Page<Tuple> findLendBooksWithDetailsByKcUuid(@Param("kcUuid") String kcUuid, Pageable pageable);



}