package com.ucb.skibidi.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity(name = "book_authors")
@Data
public class BookAuthors {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long bookAuthorsId;

    @ManyToOne
    @JoinColumn(name = "author_id")
    private Author authorId;

    @ManyToOne
    @JoinColumn(name = "book_id")
    private Book bookId;

}
