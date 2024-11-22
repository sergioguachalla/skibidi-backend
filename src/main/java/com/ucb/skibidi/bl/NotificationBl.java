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
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;
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


    public void sendNotification(Map<String,String> parameters, String phoneNumber, Long templateId) {
        log.info("Enviando notificación....");
        try{
            String token = parameterRepository.findValueByParameterId(1);
            Map<String, Object> headerMap = crearHeaderMap(token);
            String body = buildBody(parameters, phoneNumber, templateId);
            String responseWhatsApp = enviarWhatsApp(headerMap, body);
            String messageId = whatsAppResponse(responseWhatsApp);
            log.info("responseWhatsApp: " + responseWhatsApp);
            sendEmail(personRepository.findByPhoneNumber(phoneNumber).getEmail(),buildMetaBody(parameters, templateId));
        }catch(Exception e){
            log.info("Error registrando envio de mensajería");
            throw new RuntimeException(e);
        }
    }

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

    public String enviarWhatsApp(Map<String, Object> headerMap, String body) {
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", (String) headerMap.get("Authorization"));
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<String> requestEntity = new HttpEntity<>(body, headers);

        try {
            ResponseEntity<String> response = restTemplate.exchange(
                    metaPath,
                    HttpMethod.POST,
                    requestEntity,
                    String.class
            );
            return response.getBody();
        } catch (Exception e) {
            log.error("Error al enviar el mensaje a WhatsApp", e);
            throw new RuntimeException("Error al enviar el mensaje a WhatsApp: " + e.getMessage());
        }
    }

    public void sendEmail(String email,String body){
        emailService.sendEmailMime(email,
                "SKIBIDI LIBROS", body );
    }

    private String buildMetaBody(Map<String,String> parameters, Long templateId) {
        Optional<Template> plantillaJson = templateRepository.findById(templateId);
        String body = plantillaJson.get().getMetaContent();
        for (Map.Entry<String, String> entry : parameters.entrySet()) {
            body = body.replace("{{" + entry.getKey() + "}}", entry.getValue());
        }
        return body;
    }
}
