package com.ucb.skibidi.bl;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ucb.skibidi.dao.NotificationRepository;
import com.ucb.skibidi.dao.ParameterRepository;
import com.ucb.skibidi.dao.PersonRepository;
import com.ucb.skibidi.dao.TemplateRepository;
import com.ucb.skibidi.entity.Template;
import com.ucb.skibidi.service.EmailService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Slf4j
@Service
public class NotificationBl {

    @Autowired
    NotificationRepository notificationRepository;
    @Autowired
    TemplateRepository templateRepository;
    @Autowired
    ParameterRepository parameterRepository;
    @Autowired
    PersonRepository personRepository;
    @Autowired
    EmailService emailService;

    @Value("${meta.path}")
    private String metaPath;


    private Map<String, Object> crearHeaderMap(String token) {
        Map<String, Object> headerMap = new HashMap<>();
        headerMap.put("Authorization", "Bearer " + token);
        headerMap.put("Content-Type", MediaType.APPLICATION_JSON);
        return headerMap;
    }
    private String buildBody(Map<String,String> parameters, String phoneNumber, Long templateId) {
        Optional<Template> plantillaJson = templateRepository.findById(templateId);
        String body = plantillaJson.get().getJsonBody().replace("{{PHONE_NUMBER}}", "591" + phoneNumber)
                .replace("{{NAME_TEMPLATE}}", plantillaJson.get().getName());
        for (Map.Entry<String, String> entry : parameters.entrySet()) {
            body = body.replace("{{" + entry.getKey() + "}}", entry.getValue());
        }
        return body;
    }

    public String whatsAppResponse(String responseWhatsApp) {
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            JsonNode jsonNode = objectMapper.readTree(responseWhatsApp);

            if (jsonNode.has("messages")) {
                JsonNode messageNode = jsonNode.get("messages").get(0);
                String messageId = messageNode.get("id").asText();
                log.info("ID del mensaje enviado: " + messageId);
                return messageId;
            }
            return null;
        } catch (IOException e) {
            throw new RuntimeException("No se pudo obtener el mensajeID");
        }
    }
}