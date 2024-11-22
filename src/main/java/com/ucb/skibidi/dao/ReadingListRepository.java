package com.ucb.skibidi.dao;

import com.ucb.skibidi.entity.Book;
import com.ucb.skibidi.entity.ReadingList;
import com.ucb.skibidi.entity.UserClient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ReadingListRepository extends JpaRepository<ReadingList, Long> {
    ReadingList findReadingListByClientAndBook(UserClient userClient, Book book);
}
