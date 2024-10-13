package com.ucb.skibidi.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.Date;
import java.util.Set;

@Entity(name = "book")
@Data
@Table(name = "book")
public class Book {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // O GenerationType.AUTO
    private Long BookId;

    private String title;

    private String isbn;

    private Date registrationDate = new Date();

    private Boolean status = true;

    private String imageUrl;

    @ManyToOne
    @JoinColumn(name = "genre_id")
    private Genre genreId;

    @ManyToMany
    @JoinTable(
            name = "book_authors",
            joinColumns = @JoinColumn(name = "book_id"),
            inverseJoinColumns = @JoinColumn(name = "author_id")
    )
    private Set<Author> authors;

    @ManyToOne
    @JoinColumn(name = "id_language")
    private Language language;

}
