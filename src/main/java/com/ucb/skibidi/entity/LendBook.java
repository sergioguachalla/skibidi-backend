package com.ucb.skibidi.entity;

import jakarta.persistence.*;

import java.util.Date;

@Entity
@Table(name = "lend_book")
public class LendBook {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
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
    private Date lendDate;

    @Column(name = "return_date")
    private Date returnDate;

    @Column(name = "status")
    private Long status;

    @Column(name = "notes")
    private String notes;




}
