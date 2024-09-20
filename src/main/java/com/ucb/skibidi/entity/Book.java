package com.ucb.skibidi.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.Date;

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


}
