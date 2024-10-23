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

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "environment_id")
    private Environment environmentId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "client_id")
    private UserClient clientId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "librarian_id", nullable = true)
    private UserLibrarian librarianId = null;

    private LocalDate reservationDate;

    private LocalDateTime clockIn;

    private LocalDateTime clockOut;

    private String purpose;

    private Boolean reservationStatus = false;

    private int status = 1;
}
