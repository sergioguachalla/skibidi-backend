package com.ucb.skibidi.dao;

import com.ucb.skibidi.entity.Editorial;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EditorialRepository extends JpaRepository<Editorial, Long> {
    Editorial findByEditorialId(Long editorialId);

    Editorial findByEditorial(String name);

}
