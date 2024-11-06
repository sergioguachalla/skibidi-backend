package com.ucb.skibidi.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.Date;

@Data
@Entity
@Table(name = "lend_book")
public class LendBook {
    @Id
    @Column(name = "lent_book_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "book_id")
    private Book bookId;

    @ManyToOne
    @JoinColumn(name = "librarian_id")
    private UserLibrarian librarianId;

    @ManyToOne
    @JoinColumn(name = "client_id")
    private UserClient clientId;

    private Date lentDate = new Date();

    private Date returnDate;

    private int status = 1; // 1 = lent, 2 = returned, 3 = overdue

    private int request_extension;

    private String notes;
  
    private Boolean notification_check = false;


}