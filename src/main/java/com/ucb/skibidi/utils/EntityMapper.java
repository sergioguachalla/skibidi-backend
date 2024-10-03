package com.ucb.skibidi.utils;

import com.ucb.skibidi.dto.PersonDto;
import com.ucb.skibidi.dto.UserDto;
import com.ucb.skibidi.entity.Person;
import com.ucb.skibidi.entity.UserClient;

public class EntityMapper {

        public static UserDto toDto(UserClient user) {
            if (user == null) {
                return null;
            }

            UserDto userdto = new UserDto();
            userdto.setName(user.getUsername());
            return userdto;
        }

        public static PersonDto toPersonDto(Person person) {
            if (person == null) {
                return null;
            }

            PersonDto personDto = new PersonDto();
            personDto.setName(person.getName());
            personDto.setLastName(person.getLastname());
            personDto.setAddress(person.getAddress());
            personDto.setIdNumber(person.getIdNumber());
            personDto.setExpedition(person.getExpedition());
            return personDto;
        }

}
