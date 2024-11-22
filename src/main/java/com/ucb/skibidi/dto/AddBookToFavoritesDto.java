package com.ucb.skibidi.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class AddBookToFavoritesDto {
    private String kcId;
    private Long bookId;
}
