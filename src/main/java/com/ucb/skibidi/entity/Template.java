package com.ucb.skibidi.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.util.Date;
@Data
@Entity
@Table(name = "template")
public class Template {
    @Id
    @Column(name = "template_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long templateId;
    private String name;
    private String jsonBody;
    private Boolean status;
    private String metaContent;

}
