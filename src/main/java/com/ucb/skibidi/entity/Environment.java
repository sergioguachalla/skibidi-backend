package com.ucb.skibidi.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "environment")
@Data
@NoArgsConstructor
public class Environment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long environmentId;

    private String name;

    private int capacity;

    private Boolean status = true;

}
