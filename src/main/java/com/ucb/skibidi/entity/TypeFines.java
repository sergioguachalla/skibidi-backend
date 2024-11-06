package com.ucb.skibidi.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "type_fines")
@Data
public class TypeFines {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long typeFineId;

    @Column(name = "description")
    private String description;

    @Column(name = "amount")
    private Double amount;
}
