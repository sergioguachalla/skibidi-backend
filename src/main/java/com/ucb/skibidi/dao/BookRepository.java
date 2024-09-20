package com.ucb.skibidi.dao;

import com.ucb.skibidi.entity.Book;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface BookRepository extends JpaRepository<Book, Long>, JpaSpecificationExecutor<Book> {
    Book findByIsbn(String isbn);

    @Transactional
    @Modifying(flushAutomatically = true)
    @Query(value = "UPDATE book b SET b.status = CASE WHEN b.status = true THEN false ELSE true END WHERE b.BookId = :bookId")
    void updateBookStatus(@Param("bookId") Long bookId);

}
