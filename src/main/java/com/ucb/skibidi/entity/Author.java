package com.ucb.skibidi.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.Set;

@Entity(name = "author")
@Data
public class Author {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long authorId;

    private String name;

    private Boolean status = true;

    @ManyToMany(mappedBy = "authors")
    private Set<Book> books;
}
