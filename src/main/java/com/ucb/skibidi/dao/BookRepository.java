package com.ucb.skibidi.dao;

import com.ucb.skibidi.entity.Book;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;

public interface BookRepository extends JpaRepository<Book, Long>, JpaSpecificationExecutor<Book> {
    Book findByIsbn(String isbn);

    @Transactional
    @Modifying(flushAutomatically = true)
    @Query(value = "UPDATE book b SET b.status = CASE WHEN b.status = true THEN false ELSE true END WHERE b.BookId = :bookId")
    void updateBookStatus(@Param("bookId") Long bookId);
    // Buscar libros por título (contiene la palabra clave)
    List<Book> findByTitleContainingIgnoreCase(String title);
    @Query("SELECT ba.bookId FROM BookAuthors ba WHERE ba.authorId.name = :authorName")
    List<Long> findBooksByAuthorName(@Param("authorName") String authorName);
    @Query("SELECT b.editorialId.editorial, b.idLanguage.language FROM book b WHERE b.BookId = :bookId")
    Object[] findEditorialAndLanguageByBookId(@Param("bookId") Long bookId);
}
