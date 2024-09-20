package com.ucb.skibidi.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
@Table(name = "book_authors")
public class BookAuthors {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "book_authors_id")
    private Long bookAuthorsId;

    @ManyToOne
    @JoinColumn(name = "author_id")  // Cambiado de "author_author_id" a "author_id"
    private Author authorId;

    @ManyToOne
    @JoinColumn(name = "book_id")    // Cambiado de "book_book_id" a "book_id"
    private Book bookId;
}
