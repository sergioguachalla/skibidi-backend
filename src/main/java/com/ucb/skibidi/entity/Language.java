package com.ucb.skibidi.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
@Entity
@Table(name = "language")
public class Language {
    @Id
    @Column(name = "id_language")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long languageId;

    private String language;

    private Boolean status = true;

}
