package com.ucb.skibidi.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Data;

import java.util.Date;

@Entity(name = "book")
@Data
public class Book {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // O GenerationType.AUTO
    private Long BookId;
    private String title;
    private String isbn;
    private Date registrationDate = new Date();
    private Boolean status = true;
}
