package com.ucb.skibidi.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "type_fines")
public class TypeFines {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long typeFineId;

    @Column(name = "description")
    private String description;

    @Column(name = "amount")
    private Double amount;
}
