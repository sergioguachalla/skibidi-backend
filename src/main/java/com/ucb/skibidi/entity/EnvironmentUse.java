package com.ucb.skibidi.entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;

@Entity
@Table(name = "environment_use")
@Data
@NoArgsConstructor
public class EnvironmentUse {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long environmentUse;

    @ManyToOne
    @JoinColumn(name = "environment_id")
    private Environment environmentId;

    @ManyToOne
    @JoinColumn(name = "client_id")
    private UserClient clientId;

    @ManyToOne
    @JoinColumn(name = "librarian_id")
    private UserLibrarian librarianId;

    private LocalDate reservationDate;

    private LocalDateTime clockIn;

    private LocalDateTime clockOut;

    private String purpose;

    private int status = 1;
}
