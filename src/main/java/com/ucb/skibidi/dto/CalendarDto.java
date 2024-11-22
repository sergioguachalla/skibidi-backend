package com.ucb.skibidi.dto;

import lombok.Data;

import java.util.List;

@Data
public class CalendarDto {
    public List<CalendarBookDto> books;
    public List<CalendarEnvironmentDto> environments;
}
