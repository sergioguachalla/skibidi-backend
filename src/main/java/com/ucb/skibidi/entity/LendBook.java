package com.ucb.skibidi.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.Date;

@Entity
@Table(name = "lend_book")
@Data
public class LendBook {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "lent_book_id")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "book_id")
    private Book book;

    @ManyToOne
    @JoinColumn(name = "client_id")
    private UserClient client;

    @ManyToOne
    @JoinColumn(name = "librarian_id")
    private UserLibrarian librarian;

    @Column(name = "lent_date")
    private Date lendDate = new Date();

    @Column(name = "return_date")
    private Date returnDate;

    @Column(name = "status")
    private Long status = 1;

    @Column(name = "notes")
    private String notes;

    private Boolean notification_check = false; // ?



}

