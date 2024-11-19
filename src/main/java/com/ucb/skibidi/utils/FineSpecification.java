package com.ucb.skibidi.utils;

import com.ucb.skibidi.entity.Fine;
import org.slf4j.Logger;
import org.springframework.data.jpa.domain.Specification;

import java.util.Date;

public class FineSpecification {
    private static final Logger log = org.slf4j.LoggerFactory.getLogger(FineSpecification.class);

    public static Specification<Fine> hasPaidDate() {
        return (root, query, cb) -> cb.isNotNull(root.get("paidDate"));
    }
    public static Specification<Fine> hasUserKcId(String userKcId) {
        return (root, query, cb) -> cb.equal(root.get("lendBook").get("clientId").get("personId").get("kcUuid"), userKcId);
    }

}
