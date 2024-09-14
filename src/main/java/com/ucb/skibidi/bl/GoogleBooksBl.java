package com.ucb.skibidi.bl;

import com.google.api.client.http.HttpRequest;
import com.google.api.client.http.HttpRequestInitializer;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.books.Books;
import com.google.api.services.books.BooksRequestInitializer;
import com.google.api.services.books.model.Volume;
import com.google.api.services.books.model.Volumes;
import com.ucb.skibidi.dto.BookDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.Date;

@Service
public class GoogleBooksBl {

    private static final Logger logger = LoggerFactory.getLogger(GoogleBooksBl.class);  // Agregar logger
    private static final String API_KEY = "AIzaSyB1uZ8FQLtA9_beKHYe_Br30x3Ylhm4fnU";

    public BookDto getBookByIsbn(String isbn) {
        try {
            logger.info("Iniciando búsqueda del libro con ISBN: {}", isbn);  // Log de inicio

            // Configurar el cliente de la API de Google Books
            Books books = new Books.Builder(new NetHttpTransport(), new JacksonFactory(), new HttpRequestInitializer() {
                @Override
                public void initialize(HttpRequest request) throws IOException {
                    // No se requiere configuración adicional aquí
                }
            })
                    .setApplicationName("Book API")
                    .setGoogleClientRequestInitializer(new BooksRequestInitializer(API_KEY))
                    .build();

            // Realizar la búsqueda del libro por ISBN
            Volumes volumes = books.volumes().list("isbn:" + isbn).execute();

            // Verificar si se encontraron libros
            logger.info("Total de libros encontrados: {}", volumes.getTotalItems());  // Log para verificar resultados

            if (volumes.getTotalItems() > 0 && volumes.getItems() != null) {
                Volume volume = volumes.getItems().get(0);  // Obtener el primer resultado
                logger.info("Libro encontrado: {}", volume.getVolumeInfo().getTitle());  // Log del libro encontrado

                // Crear el DTO y asignar valores
                BookDto bookDto = new BookDto();
                bookDto.setTitle(volume.getVolumeInfo().getTitle());
                bookDto.setIsbn(isbn);  // Asignar el ISBN proporcionado
                bookDto.setRegistrationDate(new Date());  // Asignar la fecha actual
                bookDto.setStatus(true);  // Asignar estado (ajusta según tu lógica)
                bookDto.setImage_url(volume.getVolumeInfo().getImageLinks() != null ?
                        volume.getVolumeInfo().getImageLinks().getThumbnail() : null);

                logger.info("DTO generado: {}", bookDto);  // Log del DTO generado
                return bookDto;
            } else {
                logger.warn("No se encontraron libros para el ISBN: {}", isbn);  // Log de advertencia si no se encuentra nada
            }
        } catch (IOException e) {
            logger.error("Error al conectar con la API de Google Books: {}", e.getMessage(), e);  // Log del error
        }
        return null;  // Retornar null si no se encuentra el libro o hay un error
    }
}
