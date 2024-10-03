package com.ucb.skibidi.dao;

import com.ucb.skibidi.entity.Person;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PersonRepository extends JpaRepository<Person, Long> {

    Boolean existsByName(String name);
    Boolean existsByLastname(String lastname);

    Person findByKcUuid(String kcUuid);
}
