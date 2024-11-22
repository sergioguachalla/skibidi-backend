package com.ucb.skibidi.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@Entity
@Table(name = "Reading_List")
public class ReadingList {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "reading_list_id")
    private Long readingListId;

    @ManyToOne
    @JoinColumn(name = "client_id")
    private UserClient client;

    @ManyToOne
    @JoinColumn(name = "book_id")
    private Book book;
}
