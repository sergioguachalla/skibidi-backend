package com.ucb.skibidi.bl;

import com.ucb.skibidi.dao.EnvironmentRepository;
import com.ucb.skibidi.dto.EnvironmentDto;
import com.ucb.skibidi.entity.Environment;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class EnvironmentBl {
    private static final Logger log = LoggerFactory.getLogger(EnvironmentBl.class);

    @Autowired
    private EnvironmentRepository environmentRepository;

    public EnvironmentDto createEnvironment(EnvironmentDto environmentDto) {
        log.info("Creating environment...");
        Environment environment = new Environment();
        environment.setName(environmentDto.getName());
        environment.setCapacity(environmentDto.getCapacity());
        environment.setStatus(environmentDto.getIsAvailable());

        environment = environmentRepository.save(environment);
        environmentDto.setEnvironmentId(environment.getEnvironmentId());
        log.info("Environment created successfully");
        return environmentDto;
    }

    public EnvironmentDto getEnvironmentById(Long id) {
        log.info("Fetching environment by id: {}", id);
        Optional<Environment> environmentOptional = environmentRepository.findById(id);
        if (environmentOptional.isPresent()) {
            Environment environment = environmentOptional.get();
            EnvironmentDto environmentDto = new EnvironmentDto();
            environmentDto.setEnvironmentId(environment.getEnvironmentId());
            environmentDto.setName(environment.getName());
            environmentDto.setCapacity(environment.getCapacity());
            environmentDto.setIsAvailable(environment.getStatus());
            return environmentDto;
        } else {
            log.error("Environment not found");
            throw new RuntimeException("Environment not found");
        }
    }

    // Listar todos los ambientes
    public List<EnvironmentDto> getAllEnvironments() {
        log.info("Fetching all environments...");
        return environmentRepository.findAll().stream()
                .map(environment -> {
                    EnvironmentDto dto = new EnvironmentDto();
                    dto.setEnvironmentId(environment.getEnvironmentId());
                    dto.setName(environment.getName());
                    dto.setCapacity(environment.getCapacity());
                    dto.setIsAvailable(environment.getStatus());
                    return dto;
                })
                .collect(Collectors.toList());
    }

    // Actualizar un ambiente
    public EnvironmentDto updateEnvironment(Long id, EnvironmentDto environmentDto) {
        log.info("Updating environment id: {}", id);
        Optional<Environment> environmentOptional = environmentRepository.findById(id);
        if (environmentOptional.isPresent()) {
            Environment environment = environmentOptional.get();
            environment.setName(environmentDto.getName());
            environment.setCapacity(environmentDto.getCapacity());
            environment.setStatus(environmentDto.getIsAvailable());

            environment = environmentRepository.save(environment);
            environmentDto.setEnvironmentId(environment.getEnvironmentId());
            log.info("Environment updated successfully");
            return environmentDto;
        } else {
            log.error("Environment not found");
            throw new RuntimeException("Environment not found");
        }
    }

    // Eliminar un ambiente
    public void deleteEnvironment(Long id) {
        log.info("Deleting environment id: {}", id);
        if (environmentRepository.existsById(id)) {
            environmentRepository.deleteById(id);
            log.info("Environment deleted successfully");
        } else {
            log.error("Environment not found");
            throw new RuntimeException("Environment not found");
        }
    }
}
