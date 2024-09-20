package com.ucb.skibidi.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "user_client")
@Data
@NoArgsConstructor
public class UserClient {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long clientId;

    @ManyToOne
    @JoinColumn(name = "person_id")
    private Person personId;

    private String username;

    private Boolean isBlocked = false;

    @Column(name = "user_group")
    private String group;

    private Boolean status = true;

    private Integer infractionCount = 0;

}
