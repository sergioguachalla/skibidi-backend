package com.ucb.skibidi.entity;

import jakarta.persistence.*;

import java.util.Date;

@Entity
@Table(name = "fines")
public class Fine {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long fineId;

    @ManyToOne
    @JoinColumn(name = "type_fine_id")
    private TypeFines typeFine;

    @ManyToOne
    @JoinColumn(name = "lent_book_id")
    private LendBook lendBook;

    @Column(name = "start_date")
    private Date startDate;

    @Column(name = "due_date")
    private Date endDate;

    @Column(name = "paid_date")
    private Date paidDate;

    @Column(name = "status")
    private Long status;

}
