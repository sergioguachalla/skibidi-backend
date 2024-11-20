package com.ucb.skibidi.utils;

import com.ucb.skibidi.entity.Fine;
import com.ucb.skibidi.entity.UserClient;
import org.slf4j.Logger;
import org.springframework.data.jpa.domain.Specification;

public class ClientSpecification {
    private static final Logger log = org.slf4j.LoggerFactory.getLogger(ClientSpecification.class);

    public static Specification<UserClient> hasUsername(String username) {
        return (root, query, cb) -> cb.like(root.get("personId").get("name"), "%" + username + "%");
    }


}
