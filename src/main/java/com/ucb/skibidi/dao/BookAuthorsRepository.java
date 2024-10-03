package com.ucb.skibidi.dao;

import com.ucb.skibidi.entity.Author;
import com.ucb.skibidi.entity.BookAuthors;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface BookAuthorsRepository extends JpaRepository<BookAuthors, Long> {

    @Query("SELECT ba.authorId.name FROM BookAuthors ba WHERE ba.bookId.BookId = :bookId")
    List<String> findAuthorsByBookId(@Param("bookId") Long bookId);
    @Query("SELECT b.BookId FROM BookAuthors ba JOIN ba.bookId b WHERE ba.authorId.name = :authorName")
    List<Long> findBooksByAuthorName(@Param("authorName") String authorName);
}
