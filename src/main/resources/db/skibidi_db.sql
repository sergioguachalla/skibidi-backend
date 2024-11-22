-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-10-15 02:20:29.466

-- tables
-- Table: Author
CREATE TABLE Author (
                        author_id serial  NOT NULL,
                        name varchar(300)  NOT NULL,
                        status boolean  NOT NULL,
                        CONSTRAINT Author_pk PRIMARY KEY (author_id)
);

-- Table: Book
CREATE TABLE Book (
                      book_id serial  NOT NULL,
                      editorial_id int  NOT NULL,
                      genre_id int  NOT NULL,
                      id_language int  NOT NULL,
                      title varchar(500)  NOT NULL,
                      isbn varchar(25)  NOT NULL,
                      registration_date date  NOT NULL,
                      status int  NOT NULL,
                      image_url varchar(500)  NULL,
                      CONSTRAINT Book_pk PRIMARY KEY (book_id)
);

-- Table: Book_Authors
CREATE TABLE Book_Authors (
                              book_authors_id serial  NOT NULL,
                              book_id int  NOT NULL,
                              author_id int  NOT NULL,
                              CONSTRAINT Book_Authors_pk PRIMARY KEY (book_authors_id)
);

-- Table: Editorial
CREATE TABLE Editorial (
                           editorial_id serial  NOT NULL,
                           editorial varchar(100)  NOT NULL,
                           status boolean  NOT NULL,
                           CONSTRAINT Editorial_pk PRIMARY KEY (editorial_id)
);

-- Table: Environment
CREATE TABLE Environment (
                             environment_id serial  NOT NULL,
                             name varchar(50)  NOT NULL,
                             capacity int  NOT NULL,
                             status boolean  NOT NULL,
                             CONSTRAINT Environment_pk PRIMARY KEY (environment_id)
);

-- Table: Environment_Use
CREATE TABLE Environment_Use (
                                 environment_use serial  NOT NULL,
                                 environment_id int  NOT NULL,
                                 librarian_id int  NULL,
                                 client_id int  NOT NULL,
                                 reservation_date date  NOT NULL,
                                 clock_in timestamp  NOT NULL,
                                 clock_out timestamp  NOT NULL,
                                 purpose varchar(500)  NOT NULL,
                                 reservation_status boolean  NOT NULL,
                                 status int  NOT NULL,
                                 CONSTRAINT Environment_Use_pk PRIMARY KEY (environment_use)
);

-- Table: Fines
CREATE TABLE Fines (
                       fine_id serial  NOT NULL,
                       type_fine_id int  NULL,
                       lent_book_id int  NULL,
                       start_date date  NOT NULL,
                       due_date date  NOT NULL,
                       paid_date date  NULL,
                       status int  NOT NULL,
                       CONSTRAINT Fines_pk PRIMARY KEY (fine_id)
);

-- Table: Genre
CREATE TABLE Genre (
                       genre_id serial  NOT NULL,
                       name varchar(30)  NOT NULL,
                       status boolean  NOT NULL,
                       CONSTRAINT Genre_pk PRIMARY KEY (genre_id)
);

-- Table: Infractions
CREATE TABLE Infractions (
                             infraction_id serial  NOT NULL,
                             description varchar(100)  NOT NULL,
                             user_id int  NOT NULL,
                             status int  NOT NULL,
                             infraction_type int  NOT NULL,
                             duration int  NOT NULL,
                             start_date date  NOT NULL,
                             serverity int  NOT NULL,
                             CONSTRAINT Infractions_pk PRIMARY KEY (infraction_id)
);

-- Table: Language
CREATE TABLE Language (
                          id_language serial  NOT NULL,
                          language varchar(50)  NOT NULL,
                          status boolean  NOT NULL,
                          CONSTRAINT Language_pk PRIMARY KEY (id_language)
);

-- Table: Lend_Book
CREATE TABLE Lend_Book (
                           lent_book_id serial  NOT NULL,
                           book_id int  NOT NULL,
                           librarian_id int  NOT NULL,
                           client_id int  NOT NULL,
                           lent_date date  NOT NULL,
                           return_date date  NOT NULL,
                           status int  NOT NULL,
                           request_extension int NOT NULL,
                           notes text  NULL,
                           notification_check boolean  NOT NULL,
                           CONSTRAINT Lend_Book_pk PRIMARY KEY (lent_book_id)
);

-- Table: Person
CREATE TABLE Person (
                        person_id serial  NOT NULL,
                        name varchar(100)  NOT NULL,
                        lastname varchar(200)  NOT NULL,
                        id_number int  NOT NULL,
                        expedition varchar(4)  NOT NULL,
                        phone_number varchar(20)  NOT NULL,
                        registration_date date  NOT NULL,
                        address varchar(500)  NOT NULL,
                        email varchar(100)  NOT NULL,
                        kc_uudi varchar(200) ,
                        CONSTRAINT Person_pk PRIMARY KEY (person_id)
);

-- Table: Type_Fines
CREATE TABLE Type_Fines (
                            type_fine_id serial  NOT NULL,
                            description varchar(200)  NOT NULL,
                            amount decimal(6,2)  NOT NULL,
                            CONSTRAINT Type_Fines_pk PRIMARY KEY (type_fine_id)
);

-- Table: User_Admin
CREATE TABLE User_Admin (
                            person_id serial  NOT NULL,
                            username varchar(100)  NOT NULL,
                            user_group varchar(20)  NOT NULL,
                            CONSTRAINT User_Admin_pk PRIMARY KEY (person_id)
);

-- Table: User_Client
CREATE TABLE User_Client (
                             client_id serial  NOT NULL,
                             person_id int  NOT NULL,
                             username varchar(100)  NOT NULL,
                             is_blocked boolean  NOT NULL,
                             user_group varchar(20)  NOT NULL,
                             status boolean  NOT NULL,
                             infraction_count int  NOT NULL,
                             can_use_studyroom boolean  NOT NULL DEFAULT TRUE,
                             can_borrow_books boolean  NOT NULL DEFAULT TRUE,
                             CONSTRAINT User_Client_pk PRIMARY KEY (client_id)
);

-- Table: User_Librarian
CREATE TABLE User_Librarian (
                                librarian_id serial  NOT NULL,
                                person_id int  NOT NULL,
                                username varchar(100)  NOT NULL,
                                is_blocked boolean  NOT NULL,
                                user_group varchar(20)  NOT NULL,
                                status boolean  NOT NULL,
                                CONSTRAINT User_Librarian_pk PRIMARY KEY (librarian_id)
);

CREATE TABLE notification (
                              notification_id serial  NOT NULL,
                              message text  NOT NULL,
                              date timestamp  NOT NULL,
                              status int  NOT NULL,
                              user_id int  NOT NULL,
                              CONSTRAINT notification_pk PRIMARY KEY (notification_id)
);

-- Table: parameter
CREATE TABLE parameter (
                           parameter_id serial  NOT NULL,
                           name varchar(100)  NOT NULL,
                           value text  NOT NULL,
                           CONSTRAINT parameter_pk PRIMARY KEY (parameter_id)
);

-- Table: template
CREATE TABLE template (
                          template_id serial  NOT NULL,
                          name varchar(100)  NOT NULL,
                          json_body text  NOT NULL,
                          status boolean  NOT NULL,
                          meta_content text NOT NULL,
                          CONSTRAINT template_pk PRIMARY KEY (template_id)
);

-- foreign keys
-- Reference: Book_Authors_Author (table: Book_Authors)
ALTER TABLE Book_Authors ADD CONSTRAINT Book_Authors_Author
    FOREIGN KEY (author_id)
        REFERENCES Author (author_id)
        NOT DEFERRABLE
            INITIALLY IMMEDIATE
;

-- Reference: Book_Authors_Book (table: Book_Authors)
ALTER TABLE Book_Authors ADD CONSTRAINT Book_Authors_Book
    FOREIGN KEY (book_id)
        REFERENCES Book (book_id)
        NOT DEFERRABLE
            INITIALLY IMMEDIATE
;

-- Reference: Book_Editorial (table: Book)
ALTER TABLE Book ADD CONSTRAINT Book_Editorial
    FOREIGN KEY (editorial_id)
        REFERENCES Editorial (editorial_id)
        NOT DEFERRABLE
            INITIALLY IMMEDIATE
;

-- Reference: Book_Genre (table: Book)
ALTER TABLE Book ADD CONSTRAINT Book_Genre
    FOREIGN KEY (genre_id)
        REFERENCES Genre (genre_id)
        NOT DEFERRABLE
            INITIALLY IMMEDIATE
;

-- Reference: Book_Language (table: Book)
ALTER TABLE Book ADD CONSTRAINT Book_Language
    FOREIGN KEY (id_language)
        REFERENCES Language (id_language)
        NOT DEFERRABLE
            INITIALLY IMMEDIATE
;

-- Reference: Environment_Use_Environment (table: Environment_Use)
ALTER TABLE Environment_Use ADD CONSTRAINT Environment_Use_Environment
    FOREIGN KEY (environment_id)
        REFERENCES Environment (environment_id)
        NOT DEFERRABLE
            INITIALLY IMMEDIATE
;

-- Reference: Environment_Use_User_Client (table: Environment_Use)
ALTER TABLE Environment_Use ADD CONSTRAINT Environment_Use_User_Client
    FOREIGN KEY (client_id)
        REFERENCES User_Client (client_id)
        NOT DEFERRABLE
            INITIALLY IMMEDIATE
;

-- Reference: Environment_Use_User_Librarian (table: Environment_Use)
ALTER TABLE Environment_Use ADD CONSTRAINT Environment_Use_User_Librarian
    FOREIGN KEY (librarian_id)
        REFERENCES User_Librarian (librarian_id)
        NOT DEFERRABLE
            INITIALLY IMMEDIATE
;

-- Reference: Fines_Lend_Book (table: Fines)
ALTER TABLE Fines ADD CONSTRAINT Fines_Lend_Book
    FOREIGN KEY (lent_book_id)
        REFERENCES Lend_Book (lent_book_id)
        NOT DEFERRABLE
            INITIALLY IMMEDIATE
;

-- Reference: Fines_Type_Fines (table: Fines)
ALTER TABLE Fines ADD CONSTRAINT Fines_Type_Fines
    FOREIGN KEY (type_fine_id)
        REFERENCES Type_Fines (type_fine_id)
        NOT DEFERRABLE
            INITIALLY IMMEDIATE
;

-- Reference: Lend_Book_Book (table: Lend_Book)
ALTER TABLE Lend_Book ADD CONSTRAINT Lend_Book_Book
    FOREIGN KEY (book_id)
        REFERENCES Book (book_id)
        NOT DEFERRABLE
            INITIALLY IMMEDIATE
;

-- Reference: Lend_Book_User_Client (table: Lend_Book)
ALTER TABLE Lend_Book ADD CONSTRAINT Lend_Book_User_Client
    FOREIGN KEY (client_id)
        REFERENCES User_Client (client_id)
        NOT DEFERRABLE
            INITIALLY IMMEDIATE
;

-- Reference: Lend_Book_User_Librarian (table: Lend_Book)
ALTER TABLE Lend_Book ADD CONSTRAINT Lend_Book_User_Librarian
    FOREIGN KEY (librarian_id)
        REFERENCES User_Librarian (librarian_id)
        NOT DEFERRABLE
            INITIALLY IMMEDIATE
;

-- Reference: User_Admin_Person (table: User_Admin)
ALTER TABLE User_Admin ADD CONSTRAINT User_Admin_Person
    FOREIGN KEY (person_id)
        REFERENCES Person (person_id)
        NOT DEFERRABLE
            INITIALLY IMMEDIATE
;

-- Reference: User_Client_Person (table: User_Client)
ALTER TABLE User_Client ADD CONSTRAINT User_Client_Person
    FOREIGN KEY (person_id)
        REFERENCES Person (person_id)
        NOT DEFERRABLE
            INITIALLY IMMEDIATE
;

-- Reference: User_Librarian_Person (table: User_Librarian)
ALTER TABLE User_Librarian ADD CONSTRAINT User_Librarian_Person
    FOREIGN KEY (person_id)
        REFERENCES Person (person_id)
        NOT DEFERRABLE
            INITIALLY IMMEDIATE
;


-- trigger para automatizar estado de las reservas

CREATE OR REPLACE FUNCTION update_status_expired_reservations()
RETURNS TRIGGER AS $$
BEGIN
    -- Si la fecha de la reserva ya pasó y el estado es pendiente (1), cambiar el estado a 3 (rechazada/expirada)
    IF NEW.reservation_date < CURRENT_DATE AND NEW.status = 1 THEN
        NEW.status = 4;
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Crear el trigger que se ejecuta antes de cada actualización o inserción en Environment_Use
CREATE TRIGGER check_expired_reservations
    BEFORE INSERT OR UPDATE ON Environment_Use
                         FOR EACH ROW
                         EXECUTE FUNCTION update_status_expired_reservations();



-- End of file.
-- Insert Genre Data
INSERT INTO Genre (name, status) VALUES ('Ficción', true);
INSERT INTO Genre (name, status) VALUES ('No Ficción', true);
INSERT INTO Genre (name, status) VALUES ('Ciencia Ficción', true);
INSERT INTO Genre (name, status) VALUES ('Fantasía', true);
INSERT INTO Genre (name, status) VALUES ('Misterio', true);
INSERT INTO Genre (name, status) VALUES ('Biografía', true);
INSERT INTO Genre (name, status) VALUES ('Poesía', true);

-- Insert Environment Data

INSERT INTO Environment (name, capacity, status) VALUES ('SALA-B1', 7, true);
INSERT INTO Environment (name, capacity, status) VALUES ('SALA-B2', 5, true);
INSERT INTO Environment (name, capacity, status) VALUES ('SALA-B3', 6, true);
INSERT INTO Environment (name, capacity, status) VALUES ('SALA-B4', 4, true);
INSERT INTO Environment (name, capacity, status) VALUES ('SALA-B5', 4, true);
INSERT INTO Environment (name, capacity, status) VALUES ('SALA-B6', 12, true);

-- language

-- Lenguajes
INSERT INTO Language (language, status) VALUES ('Mandarín', true);
INSERT INTO Language (language, status) VALUES ('Inglés', true);
INSERT INTO Language (language, status) VALUES ('Hindú', true);
INSERT INTO Language (language, status) VALUES ('Español', true);
INSERT INTO Language (language, status) VALUES ('Árabe', true);
INSERT INTO Language (language, status) VALUES ('Bengalí', true);
INSERT INTO Language (language, status) VALUES ('Portugués', true);
INSERT INTO Language (language, status) VALUES ('Ruso', true);
INSERT INTO Language (language, status) VALUES ('Japonés', true);
INSERT INTO Language (language, status) VALUES ('Alemán', true);

-- Editoriales
INSERT INTO Editorial (editorial, status) VALUES ('Penguin Random House', true);
INSERT INTO Editorial (editorial, status) VALUES ('HarperCollins', true);
INSERT INTO Editorial (editorial, status) VALUES ('Simon & Schuster', true);
INSERT INTO Editorial (editorial, status) VALUES ('Macmillan Publishers', true);
INSERT INTO Editorial (editorial, status) VALUES ('Hachette Livre', true);
INSERT INTO Editorial (editorial, status) VALUES ('Scholastic', true);
INSERT INTO Editorial (editorial, status) VALUES ('Pearson', true);
INSERT INTO Editorial (editorial, status) VALUES ('Bloomsbury Publishing', true);
INSERT INTO Editorial (editorial, status) VALUES ('Wiley', true);
INSERT INTO Editorial (editorial, status) VALUES ('Oxford University Press', true);


insert into Author (name, status) values ('Hildy O''Fearguise', false);
insert into Author (name, status) values ('Darrin Northin', true);
insert into Author (name, status) values ('Davie Vassall', false);
insert into Author (name, status) values ('Sabra Aicheson', false);
insert into Author (name, status) values ('Paulo Craigie', true);
insert into Author (name, status) values ('Judi Heffernan', true);
insert into Author (name, status) values ('Adriano Seniour', true);
insert into Author (name, status) values ('Reyna Ashpole', true);
insert into Author (name, status) values ('Cordell Gianuzzi', true);
insert into Author (name, status) values ('Ferrell Tomaszynski', false);
insert into Author (name, status) values ('Isabel Ogilby', true);
insert into Author (name, status) values ('Dorie Jakov', false);
insert into Author (name, status) values ('Stan Gibson', false);
insert into Author (name, status) values ('Rahal Constanza', true);
insert into Author (name, status) values ('Darline Pitkeathly', true);
insert into Author (name, status) values ('Netti Mepsted', false);
insert into Author (name, status) values ('Rebekkah Krale', false);
insert into Author (name, status) values ('Aleksandr Buard', false);
insert into Author (name, status) values ('Marsh Tape', false);
insert into Author (name, status) values ('Merill Cowdroy', false);
insert into Author (name, status) values ('Alvy Dingwall', false);
insert into Author (name, status) values ('Leonardo Szimoni', false);
insert into Author (name, status) values ('Floris Frango', true);
insert into Author (name, status) values ('Thadeus Bowcock', false);
insert into Author (name, status) values ('Melvyn Jessard', false);
insert into Author (name, status) values ('Corbett Collelton', true);
insert into Author (name, status) values ('Bogart Densie', false);
insert into Author (name, status) values ('Florida Galley', false);
insert into Author (name, status) values ('Gerianna Witherspoon', true);
insert into Author (name, status) values ('Sara-ann Gritsaev', false);
insert into Author (name, status) values ('Martie Chopping', false);
insert into Author (name, status) values ('Rodd Zincke', true);
insert into Author (name, status) values ('Raymond Bernholt', true);
insert into Author (name, status) values ('Talia Bilbrey', true);
insert into Author (name, status) values ('Starla Galiford', true);
insert into Author (name, status) values ('Maitilde Brookhouse', false);
insert into Author (name, status) values ('Enrichetta Harpur', false);
insert into Author (name, status) values ('Grace Gouda', false);
insert into Author (name, status) values ('Ginnie Willmer', false);
insert into Author (name, status) values ('Shea Ingliss', false);
insert into Author (name, status) values ('Monroe Parkhouse', true);
insert into Author (name, status) values ('Willis Sopper', true);
insert into Author (name, status) values ('Selina Kos', true);
insert into Author (name, status) values ('Ludovika Hall-Gough', false);
insert into Author (name, status) values ('Clevey Fydoe', true);
insert into Author (name, status) values ('Cristionna Gatcliff', false);
insert into Author (name, status) values ('Odell Dekeyser', false);
insert into Author (name, status) values ('Symon Tabary', false);
insert into Author (name, status) values ('Corina Ellerbeck', false);
insert into Author (name, status) values ('Marc Shayes', true);
insert into Author (name, status) values ('Katusha Oram', false);
insert into Author (name, status) values ('Robb Mcasparan', false);
insert into Author (name, status) values ('Elli Alps', true);
insert into Author (name, status) values ('Galven Dimmick', false);
insert into Author (name, status) values ('Wilmar Gimbart', false);
insert into Author (name, status) values ('Harland Brugden', false);
insert into Author (name, status) values ('Adelina Nodin', false);
insert into Author (name, status) values ('Tedi Springle', true);
insert into Author (name, status) values ('Oates Maplethorp', true);
insert into Author (name, status) values ('Sasha Dorow', false);
insert into Author (name, status) values ('Deanne Wonfor', true);
insert into Author (name, status) values ('Linnet MacSkeaghan', false);
insert into Author (name, status) values ('Virginie Ruppeli', true);
insert into Author (name, status) values ('Zachery Almeida', false);
insert into Author (name, status) values ('Clemmy Tocknell', true);
insert into Author (name, status) values ('Cymbre Watling', true);
insert into Author (name, status) values ('Almira Bradberry', true);
insert into Author (name, status) values ('Vevay Corden', true);
insert into Author (name, status) values ('Ephrayim Yanshinov', false);
insert into Author (name, status) values ('Ellen Worviell', true);
insert into Author (name, status) values ('Zacharie Bartlomiejczyk', true);
insert into Author (name, status) values ('Catlee O''Nions', false);
insert into Author (name, status) values ('Simone MacKill', false);
insert into Author (name, status) values ('Grete Doy', true);
insert into Author (name, status) values ('Felicio Gramer', true);
insert into Author (name, status) values ('Allard Ricoald', false);
insert into Author (name, status) values ('Doreen Veryard', true);
insert into Author (name, status) values ('Melodie Kamena', false);
insert into Author (name, status) values ('Ilaire Dacey', false);
insert into Author (name, status) values ('Petronilla Collyear', false);
insert into Author (name, status) values ('Ardys Orsi', false);
insert into Author (name, status) values ('Nady Dunstan', true);
insert into Author (name, status) values ('Sibelle Edel', true);
insert into Author (name, status) values ('Corilla Varfalameev', false);
insert into Author (name, status) values ('Frederik Gynni', false);
insert into Author (name, status) values ('Jessalyn Dedham', true);
insert into Author (name, status) values ('Jeanette Huge', false);
insert into Author (name, status) values ('Gaylene Ambrogioli', false);
insert into Author (name, status) values ('Erny Whyborne', false);
insert into Author (name, status) values ('Karmen Humburton', false);
insert into Author (name, status) values ('Lockwood Berrow', true);
insert into Author (name, status) values ('Bell Gillimgham', false);
insert into Author (name, status) values ('Dorella Siddele', true);
insert into Author (name, status) values ('Blancha Liversley', false);
insert into Author (name, status) values ('Conny D''eath', false);
insert into Author (name, status) values ('Jacky Longmuir', false);
insert into Author (name, status) values ('Darlleen Calwell', true);
insert into Author (name, status) values ('Maudie Parham', false);
insert into Author (name, status) values ('Deanne Suthworth', false);
insert into Author (name, status) values ('Rickert Shooter', true);
insert into Author (name, status) values ('Barbe Glentworth', true);
insert into Author (name, status) values ('Alana Vala', true);
insert into Author (name, status) values ('Jenilee Hessing', false);
insert into Author (name, status) values ('Corette Fonzone', false);
insert into Author (name, status) values ('Ugo Gledhill', false);
insert into Author (name, status) values ('Halsy Fairlaw', true);
insert into Author (name, status) values ('Herschel Wrightham', false);
insert into Author (name, status) values ('Casper Cutler', false);
insert into Author (name, status) values ('Ray Thickpenny', true);
insert into Author (name, status) values ('Michale Jarrard', false);
insert into Author (name, status) values ('Blondy Aherne', false);
insert into Author (name, status) values ('Rod Staker', true);
insert into Author (name, status) values ('Silvana Wybrow', true);
insert into Author (name, status) values ('Christin Silk', false);
insert into Author (name, status) values ('Antoni Rediers', true);
insert into Author (name, status) values ('Bernarr Instrell', false);
insert into Author (name, status) values ('Alvera Brotherwood', false);
insert into Author (name, status) values ('Cyndia Nassau', true);
insert into Author (name, status) values ('Ranna Wingeatt', true);
insert into Author (name, status) values ('Adelind Ordelt', false);
insert into Author (name, status) values ('Shurlocke Clemont', false);
insert into Author (name, status) values ('Vachel Beavis', true);
insert into Author (name, status) values ('Vito Savege', false);
insert into Author (name, status) values ('Elfie Gaynesford', true);
insert into Author (name, status) values ('Candis Whybray', true);
insert into Author (name, status) values ('Fidela Beals', false);
insert into Author (name, status) values ('Meagan MacGuffie', false);
insert into Author (name, status) values ('Clarke Puttrell', false);
insert into Author (name, status) values ('Stanly Hindge', true);
insert into Author (name, status) values ('Lindsey Richford', false);
insert into Author (name, status) values ('Essie Rzehor', true);
insert into Author (name, status) values ('Roanna Ximenez', false);
insert into Author (name, status) values ('Elaina Dulling', true);
insert into Author (name, status) values ('Audra Simonson', true);
insert into Author (name, status) values ('Kahlil Wornum', true);
insert into Author (name, status) values ('Flossy Strevens', true);
insert into Author (name, status) values ('Zsazsa Buttfield', false);
insert into Author (name, status) values ('Haywood Fiddy', false);
insert into Author (name, status) values ('Cyndia Whal', false);
insert into Author (name, status) values ('Rosamond Enright', false);
insert into Author (name, status) values ('Babette Tallent', false);
insert into Author (name, status) values ('Donal Decourt', true);
insert into Author (name, status) values ('Ertha Mizzi', false);
insert into Author (name, status) values ('Margot Silveston', true);
insert into Author (name, status) values ('Cathrine Mulchrone', true);
insert into Author (name, status) values ('Tiffani Measey', true);
insert into Author (name, status) values ('Vivyanne Duckerin', false);
insert into Author (name, status) values ('Georgette Oakenfield', false);
insert into Author (name, status) values ('Fletcher Flicker', false);
insert into Author (name, status) values ('Rosemonde Meritt', false);
insert into Author (name, status) values ('Englebert Rea', true);
insert into Author (name, status) values ('Cornell Argue', true);
insert into Author (name, status) values ('Ralf MacDunleavy', false);
insert into Author (name, status) values ('Melinda Duignan', true);
insert into Author (name, status) values ('Gregorio Gratten', true);
insert into Author (name, status) values ('Mycah Smalman', false);
insert into Author (name, status) values ('Worthy Campsall', false);
insert into Author (name, status) values ('Johnathan Royan', true);
insert into Author (name, status) values ('Freida O''Ferris', true);
insert into Author (name, status) values ('Liuka Adenet', true);
insert into Author (name, status) values ('Robinia Berriman', false);
insert into Author (name, status) values ('Damien Greenwell', true);
insert into Author (name, status) values ('Jedidiah Robak', false);
insert into Author (name, status) values ('Perla Coit', false);
insert into Author (name, status) values ('Bevin Wildber', false);
insert into Author (name, status) values ('Karalynn Coules', true);
insert into Author (name, status) values ('Joshuah Andreolli', true);
insert into Author (name, status) values ('Lesya Isakowicz', false);
insert into Author (name, status) values ('Ebonee Cuthill', true);
insert into Author (name, status) values ('Katharine Spillard', true);
insert into Author (name, status) values ('Batsheva Eunson', true);
insert into Author (name, status) values ('Jaquenette Kosiada', true);
insert into Author (name, status) values ('Everett Dreher', true);
insert into Author (name, status) values ('Pennie Carlon', false);
insert into Author (name, status) values ('Illa Adamo', false);
insert into Author (name, status) values ('Domini Nolte', true);
insert into Author (name, status) values ('Emelyne Bumpus', false);
insert into Author (name, status) values ('Joelly Beadnall', true);
insert into Author (name, status) values ('Shepperd Winterbotham', true);
insert into Author (name, status) values ('Ali Pickworth', true);
insert into Author (name, status) values ('Melicent Randales', true);
insert into Author (name, status) values ('Elissa Jaggs', true);
insert into Author (name, status) values ('Wilmette Gulc', false);
insert into Author (name, status) values ('Hilario Handyside', true);
insert into Author (name, status) values ('Anne-marie Grainger', true);
insert into Author (name, status) values ('Nat Leahair', true);
insert into Author (name, status) values ('Prisca Ciabatteri', false);
insert into Author (name, status) values ('Vevay McClinton', false);
insert into Author (name, status) values ('Sigismundo Harmeston', false);
insert into Author (name, status) values ('Brit Blanshard', true);
insert into Author (name, status) values ('Freda Bennington', false);
insert into Author (name, status) values ('Cassandry Aiton', true);
insert into Author (name, status) values ('Grete Deinhardt', false);
insert into Author (name, status) values ('Tucker Blissitt', false);
insert into Author (name, status) values ('Marion Raiman', false);
insert into Author (name, status) values ('Rodge Blundan', false);
insert into Author (name, status) values ('Gussie Vasyunin', true);
insert into Author (name, status) values ('Cindee De Brett', false);
insert into Author (name, status) values ('Ned Clampett', true);
insert into Author (name, status) values ('Jimmie Bellas', false);
insert into Author (name, status) values ('Lee Woller', true);
insert into Author (name, status) values ('Christine Rotlauf', false);
insert into Author (name, status) values ('Pepita Emsden', true);
insert into Author (name, status) values ('Kristos Nyssen', false);
insert into Author (name, status) values ('Imojean Tremmel', true);
insert into Author (name, status) values ('Nina Trollope', false);
insert into Author (name, status) values ('Kiele Searl', false);
insert into Author (name, status) values ('Clair Troman', true);
insert into Author (name, status) values ('Rutger Bertie', false);
insert into Author (name, status) values ('Daffi Bunton', true);
insert into Author (name, status) values ('Raphaela Tallboy', true);
insert into Author (name, status) values ('Lothaire Silman', false);
insert into Author (name, status) values ('Jaquelyn Andreoletti', false);
insert into Author (name, status) values ('Wilfred Stoeckle', false);
insert into Author (name, status) values ('Zerk Roll', false);
insert into Author (name, status) values ('Alvin Kleszinski', false);
insert into Author (name, status) values ('Geordie Ost', false);
insert into Author (name, status) values ('Zola Headington', false);
insert into Author (name, status) values ('Mel Dungey', false);
insert into Author (name, status) values ('Woodrow Mainson', true);
insert into Author (name, status) values ('Shanta Bruggeman', true);
insert into Author (name, status) values ('Leela Muckart', false);
insert into Author (name, status) values ('Clair Tills', false);
insert into Author (name, status) values ('Rosalind Cripwell', false);
insert into Author (name, status) values ('Natasha Cremins', true);
insert into Author (name, status) values ('Em Shervington', true);
insert into Author (name, status) values ('Creighton Do', true);
insert into Author (name, status) values ('Salaidh Skypp', false);
insert into Author (name, status) values ('Piper McGirl', true);
insert into Author (name, status) values ('Zarah Minci', true);
insert into Author (name, status) values ('Jeanne Clapshaw', false);
insert into Author (name, status) values ('Edgardo McConnachie', false);
insert into Author (name, status) values ('Kristan Munsey', false);
insert into Author (name, status) values ('Munroe Dameisele', true);
insert into Author (name, status) values ('Vin Bonanno', false);
insert into Author (name, status) values ('Brenda Mottinelli', true);
insert into Author (name, status) values ('Anselma Rattenberie', true);
insert into Author (name, status) values ('Hersch Skey', false);
insert into Author (name, status) values ('Klara Kille', true);
insert into Author (name, status) values ('Cristin Dean', false);
insert into Author (name, status) values ('Richmond Wortman', true);
insert into Author (name, status) values ('Bride Aprahamian', true);
insert into Author (name, status) values ('Ailene Pitts', false);
insert into Author (name, status) values ('Elvera Langthorn', false);
insert into Author (name, status) values ('Brian Weildish', true);
insert into Author (name, status) values ('Ainsley Nehl', true);
insert into Author (name, status) values ('Franny Klaggeman', true);
insert into Author (name, status) values ('Amelie Dunster', false);
insert into Author (name, status) values ('Rinaldo Lebond', true);
insert into Author (name, status) values ('Lane Rosetti', true);
insert into Author (name, status) values ('Zachary Nan Carrow', false);
insert into Author (name, status) values ('Wiley Rasch', true);
insert into Author (name, status) values ('Lura Innes', true);
insert into Author (name, status) values ('Abie Shakesby', true);
insert into Author (name, status) values ('Trina Thurley', false);
insert into Author (name, status) values ('Annabelle Dumphries', true);
insert into Author (name, status) values ('Suzanna Goodayle', false);
insert into Author (name, status) values ('Malanie Click', false);
insert into Author (name, status) values ('Lee Croisdall', true);
insert into Author (name, status) values ('Elli Gouldbourn', false);
insert into Author (name, status) values ('Constantino Karpmann', false);
insert into Author (name, status) values ('Kevyn Jackling', true);
insert into Author (name, status) values ('Pia Malt', true);
insert into Author (name, status) values ('Ethelda Riseborough', true);
insert into Author (name, status) values ('Ephrem Camilletti', false);
insert into Author (name, status) values ('Lennie Duplock', false);
insert into Author (name, status) values ('Stearne McCart', true);
insert into Author (name, status) values ('Mikael Ardling', true);
insert into Author (name, status) values ('Rebekkah Divall', false);
insert into Author (name, status) values ('Murielle Sendley', false);
insert into Author (name, status) values ('Dillie Chapelle', true);
insert into Author (name, status) values ('Lorene Bockings', false);
insert into Author (name, status) values ('Brok Boden', false);
insert into Author (name, status) values ('Zsa zsa Jirka', true);
insert into Author (name, status) values ('Rutledge Dickin', true);
insert into Author (name, status) values ('Sydney Hornung', false);
insert into Author (name, status) values ('Jeniffer Turpey', true);
insert into Author (name, status) values ('Sadye Willerson', true);
insert into Author (name, status) values ('Ruthann Langmuir', false);
insert into Author (name, status) values ('Nerta Sherwen', true);
insert into Author (name, status) values ('Elmore Josling', false);
insert into Author (name, status) values ('Manya Wiggin', false);
insert into Author (name, status) values ('Becca Sackur', false);
insert into Author (name, status) values ('Hailee Stambridge', true);
insert into Author (name, status) values ('Had Hollow', true);
insert into Author (name, status) values ('Hadlee Powe', true);
insert into Author (name, status) values ('Nickolas Lindhe', true);
insert into Author (name, status) values ('Bev Haggeth', false);
insert into Author (name, status) values ('Orv Stutte', true);
insert into Author (name, status) values ('Dixie Grisbrook', false);
insert into Author (name, status) values ('William McGarvie', false);
insert into Author (name, status) values ('Gilemette Garling', true);
insert into Author (name, status) values ('Enos Arkell', true);
insert into Author (name, status) values ('Tonye Anthes', false);
insert into Author (name, status) values ('Lillian Rickerd', true);
insert into Author (name, status) values ('Darb Duval', false);
insert into Author (name, status) values ('Somerset Kemwal', false);
insert into Author (name, status) values ('Pren Brinkman', false);
insert into Author (name, status) values ('Haskell Shewring', false);
insert into Author (name, status) values ('Abrahan Dike', true);
insert into Author (name, status) values ('Rafe Oldall', false);
insert into Author (name, status) values ('Tara Gierth', true);
insert into Author (name, status) values ('Cristionna Ungerechts', false);
insert into Author (name, status) values ('Ailbert Izzett', true);
insert into Author (name, status) values ('Jannel Golden', true);
insert into Author (name, status) values ('Halimeda Bengoechea', true);
insert into Author (name, status) values ('Berry Holley', true);
insert into Author (name, status) values ('Raine Bertholin', true);
insert into Author (name, status) values ('Renault Blampey', true);
insert into Author (name, status) values ('Brigham Oulet', true);
insert into Author (name, status) values ('Giovanna Boland', false);
insert into Author (name, status) values ('Sonni Markwick', false);
insert into Author (name, status) values ('Josie Sanday', true);
insert into Author (name, status) values ('Rolfe Hane', false);
insert into Author (name, status) values ('Dorisa Lardeux', false);
insert into Author (name, status) values ('Adrea Stanyan', false);
insert into Author (name, status) values ('Karita Arderne', false);
insert into Author (name, status) values ('Walt Shaplin', true);
insert into Author (name, status) values ('Averil Mussalli', true);
insert into Author (name, status) values ('Christoph Cricket', false);
insert into Author (name, status) values ('Callida Chaulk', false);
insert into Author (name, status) values ('Tiffie Cristoforetti', true);
insert into Author (name, status) values ('Kania Francescuzzi', true);
insert into Author (name, status) values ('Happy Babon', false);
insert into Author (name, status) values ('Gerri Jewer', true);
insert into Author (name, status) values ('Clementia Abbatini', false);
insert into Author (name, status) values ('Carlynne Norrie', true);
insert into Author (name, status) values ('Georges Naisbet', false);
insert into Author (name, status) values ('Lyell Yakunin', false);
insert into Author (name, status) values ('Hilary Cymper', true);
insert into Author (name, status) values ('Mariska Baber', false);
insert into Author (name, status) values ('Lynnell Rabl', true);
insert into Author (name, status) values ('Letisha Spaduzza', true);
insert into Author (name, status) values ('Dav Irnis', true);
insert into Author (name, status) values ('Janos Lambourne', true);
insert into Author (name, status) values ('Patricia Maryan', false);
insert into Author (name, status) values ('Melissa Belvard', true);
insert into Author (name, status) values ('Jenelle Lage', false);
insert into Author (name, status) values ('Lorilee Fone', true);
insert into Author (name, status) values ('Henrik Egan', false);
insert into Author (name, status) values ('Cacilie Rankine', false);
insert into Author (name, status) values ('Lida Mouatt', true);
insert into Author (name, status) values ('Marji Dampney', false);
insert into Author (name, status) values ('Valenka Shewan', false);
insert into Author (name, status) values ('Hortensia Shimon', true);
insert into Author (name, status) values ('Alfredo Whayman', false);
insert into Author (name, status) values ('Alfonso Labuschagne', false);
insert into Author (name, status) values ('Winslow Bohlsen', false);
insert into Author (name, status) values ('Hyacinth Nash', false);
insert into Author (name, status) values ('Iseabal Bingham', true);
insert into Author (name, status) values ('Fanny Service', false);
insert into Author (name, status) values ('Blondell Bowich', true);
insert into Author (name, status) values ('Nickey Sheekey', true);
insert into Author (name, status) values ('Florida Simonassi', true);
insert into Author (name, status) values ('Antoinette Nichol', false);
insert into Author (name, status) values ('Karla Glasscoo', false);
insert into Author (name, status) values ('Pall Pluck', false);
insert into Author (name, status) values ('Gallagher Larkcum', true);
insert into Author (name, status) values ('Alexander Caffin', false);
insert into Author (name, status) values ('Lorette Frodsham', true);
insert into Author (name, status) values ('Ira Robelin', false);
insert into Author (name, status) values ('Basilius Kuhle', false);
insert into Author (name, status) values ('Letty Milazzo', false);
insert into Author (name, status) values ('Piotr Crocken', false);
insert into Author (name, status) values ('Marcelo Harfleet', true);
insert into Author (name, status) values ('Reinwald Tungay', true);
insert into Author (name, status) values ('Estrella Gerritsma', true);
insert into Author (name, status) values ('Tessy Wilstead', false);
insert into Author (name, status) values ('Pia Templar', false);
insert into Author (name, status) values ('Caryn Pedwell', false);
insert into Author (name, status) values ('Maude Mapstone', false);
insert into Author (name, status) values ('Karla Spellman', true);
insert into Author (name, status) values ('Reynold Shelmerdine', true);
insert into Author (name, status) values ('Eziechiele Stuchbery', false);
insert into Author (name, status) values ('Gennie Stivani', false);
insert into Author (name, status) values ('Teodoro Domino', true);
insert into Author (name, status) values ('Jeramie Cotter', true);
insert into Author (name, status) values ('Fredericka Dodimead', false);
insert into Author (name, status) values ('Archibaldo Robert', true);
insert into Author (name, status) values ('Milty Raccio', true);
insert into Author (name, status) values ('Delcina McGuirk', true);
insert into Author (name, status) values ('Archibaldo Guynemer', true);
insert into Author (name, status) values ('Ashly Stanners', true);
insert into Author (name, status) values ('Nerte Crockley', false);
insert into Author (name, status) values ('Consuelo Tidmarsh', true);
insert into Author (name, status) values ('Niki Lile', true);
insert into Author (name, status) values ('Lilah Betun', false);
insert into Author (name, status) values ('Nealson Hovel', true);
insert into Author (name, status) values ('Olwen Goom', true);
insert into Author (name, status) values ('Amerigo Messer', false);
insert into Author (name, status) values ('Montgomery Cookman', false);
insert into Author (name, status) values ('Evie Baillie', true);
insert into Author (name, status) values ('Loralyn Redgrove', true);
insert into Author (name, status) values ('Leigha Monck', false);
insert into Author (name, status) values ('Galvin Pilley', false);
insert into Author (name, status) values ('Mirella Dumingo', false);
insert into Author (name, status) values ('Philipa Beckworth', true);
insert into Author (name, status) values ('Andy Custy', true);
insert into Author (name, status) values ('Beverlie Spight', true);
insert into Author (name, status) values ('Marco Grzesiak', false);
insert into Author (name, status) values ('Ranique Bexon', true);
insert into Author (name, status) values ('Madalena Prothero', true);
insert into Author (name, status) values ('Zach Carrabott', true);
insert into Author (name, status) values ('Manya Toffano', false);
insert into Author (name, status) values ('Neda Frude', false);
insert into Author (name, status) values ('Isidora Kenworthy', true);
insert into Author (name, status) values ('Karoline Docherty', true);
insert into Author (name, status) values ('Auberta Fawley', true);
insert into Author (name, status) values ('Tandy Keeltagh', false);
insert into Author (name, status) values ('Jada Maffia', true);
insert into Author (name, status) values ('Nedi de Werk', true);
insert into Author (name, status) values ('Jozef Heinig', true);
insert into Author (name, status) values ('Judah Dziwisz', false);
insert into Author (name, status) values ('Charlena Zieme', true);
insert into Author (name, status) values ('Morrie Zimmermanns', false);
insert into Author (name, status) values ('Vic Baily', false);
insert into Author (name, status) values ('Percival Ballchin', true);
insert into Author (name, status) values ('Janis Bouttell', true);
insert into Author (name, status) values ('Abby Campanelli', true);
insert into Author (name, status) values ('Lindy McColgan', true);
insert into Author (name, status) values ('Vickie Russell', false);
insert into Author (name, status) values ('Freddie Gallyhaock', false);
insert into Author (name, status) values ('Allyn Edes', false);
insert into Author (name, status) values ('Daphene Seeley', true);
insert into Author (name, status) values ('Pier Rihosek', false);
insert into Author (name, status) values ('Neille Kilmurray', true);
insert into Author (name, status) values ('Ruddy Bagguley', true);
insert into Author (name, status) values ('Maura Doley', true);
insert into Author (name, status) values ('Glory Wohlers', true);
insert into Author (name, status) values ('Stepha Gilardoni', false);
insert into Author (name, status) values ('Raquela Ditchett', true);
insert into Author (name, status) values ('Walliw Pitcher', false);
insert into Author (name, status) values ('Udall Waite', true);
insert into Author (name, status) values ('Bogart Eyeington', true);
insert into Author (name, status) values ('Athene Salvador', true);
insert into Author (name, status) values ('Herbert Castiblanco', false);
insert into Author (name, status) values ('Izaak Abrahams', true);
insert into Author (name, status) values ('Halley Teather', false);
insert into Author (name, status) values ('Penny Nunnerley', false);
insert into Author (name, status) values ('Devi Matuskiewicz', false);
insert into Author (name, status) values ('Maryjane Treanor', false);
insert into Author (name, status) values ('Winnah Petchey', false);
insert into Author (name, status) values ('Lian Grimestone', false);
insert into Author (name, status) values ('Harri Diter', false);
insert into Author (name, status) values ('Tressa Kenningham', true);
insert into Author (name, status) values ('Jessey Rysdale', true);
insert into Author (name, status) values ('Aeriell Kienlein', false);
insert into Author (name, status) values ('Vania Dakers', false);
insert into Author (name, status) values ('Stanfield Fisk', true);
insert into Author (name, status) values ('Diarmid Marnane', true);
insert into Author (name, status) values ('Bridget Impy', false);
insert into Author (name, status) values ('Antonella Guinan', true);
insert into Author (name, status) values ('Tomaso Clint', false);
insert into Author (name, status) values ('Jarrad Seniour', true);
insert into Author (name, status) values ('Brooke D''Alessio', false);
insert into Author (name, status) values ('Melloney Kores', false);
insert into Author (name, status) values ('Darnell Lewington', false);
insert into Author (name, status) values ('Rebeca Showering', true);
insert into Author (name, status) values ('Bevon Dellenbroker', false);
insert into Author (name, status) values ('Ogdan Sturley', true);
insert into Author (name, status) values ('Bern Warre', true);
insert into Author (name, status) values ('Mischa Masdin', true);
insert into Author (name, status) values ('Allistir Stroulger', true);
insert into Author (name, status) values ('Gayle Cervantes', true);
insert into Author (name, status) values ('Gaylord Jenckes', true);
insert into Author (name, status) values ('Mauricio Trobridge', false);
insert into Author (name, status) values ('Tremaine Cathrall', false);
insert into Author (name, status) values ('Bret Doddemeade', true);
insert into Author (name, status) values ('Laura Torbard', true);
insert into Author (name, status) values ('Jimmie Voden', false);
insert into Author (name, status) values ('Verina Copelli', false);
insert into Author (name, status) values ('Hunfredo Van der Krui', false);
insert into Author (name, status) values ('Reed Haldon', false);
insert into Author (name, status) values ('Bail Sellen', false);
insert into Author (name, status) values ('Sibella Stott', false);
insert into Author (name, status) values ('Hollis McRamsey', true);
insert into Author (name, status) values ('Lloyd Umpleby', true);
insert into Author (name, status) values ('Margette Moreby', false);
insert into Author (name, status) values ('Selina Gradwell', true);
insert into Author (name, status) values ('Leoline Smartman', true);
insert into Author (name, status) values ('Rubetta Myford', false);
insert into Author (name, status) values ('Curtis Kirkness', true);
insert into Author (name, status) values ('Steffane Cotman', true);
insert into Author (name, status) values ('Osmund De Fries', true);
insert into Author (name, status) values ('Cortney Richin', true);
insert into Author (name, status) values ('Harmon Jorry', true);
insert into Author (name, status) values ('Stanford Dray', false);
insert into Author (name, status) values ('Sibyl Chaunce', false);
insert into Author (name, status) values ('Ingar Yakushkin', false);
insert into Author (name, status) values ('Cecil Addeycott', true);
insert into Author (name, status) values ('Bren D''Ambrogio', false);
insert into Author (name, status) values ('Janel Ionesco', false);
insert into Author (name, status) values ('Mikol Gelsthorpe', true);
insert into Author (name, status) values ('Fabian Jedras', false);
insert into Author (name, status) values ('Stefa Kirsche', false);
insert into Author (name, status) values ('Florence Riply', true);
insert into Author (name, status) values ('Hamish McCart', true);
insert into Author (name, status) values ('Xerxes Oda', true);
insert into Author (name, status) values ('Winnie Stalman', false);
insert into Author (name, status) values ('Allen Nast', true);
insert into Author (name, status) values ('Keary Hubbold', false);
insert into Author (name, status) values ('Keely Lehrmann', true);
insert into Author (name, status) values ('Harmon Arunowicz', true);
insert into Author (name, status) values ('Archer Mabon', false);
insert into Author (name, status) values ('Hale Alcide', true);
insert into Author (name, status) values ('Anett Cosslett', true);
insert into Author (name, status) values ('Dareen Ventom', true);
insert into Author (name, status) values ('Essy Snookes', true);
insert into Author (name, status) values ('Konrad Corbally', false);
insert into Author (name, status) values ('Jakie Ungaretti', true);
insert into Author (name, status) values ('Brenna Bennitt', false);
insert into Author (name, status) values ('Novelia Nannoni', false);
insert into Author (name, status) values ('Eleen Wilds', true);
insert into Author (name, status) values ('Edeline Helm', true);
insert into Author (name, status) values ('Sharla Moggach', true);
insert into Author (name, status) values ('Astra Le Noury', true);
insert into Author (name, status) values ('Georgia Hadgkiss', false);
insert into Author (name, status) values ('Jacquelynn Haythorn', true);
insert into Author (name, status) values ('Hedvige Hendrich', false);
insert into Author (name, status) values ('Rolf Linden', false);
insert into Author (name, status) values ('Rand Patnelli', false);
insert into Author (name, status) values ('Emma Lealle', false);
insert into Author (name, status) values ('Corene Andrei', false);
insert into Author (name, status) values ('Lyndsay Gwilliams', true);
insert into Author (name, status) values ('Leslie Chaize', false);
insert into Author (name, status) values ('Yance Ilyenko', false);
insert into Author (name, status) values ('Brigitta Perone', false);
insert into Author (name, status) values ('Shurlock Shewery', false);
insert into Author (name, status) values ('Muriel Snowding', false);
insert into Author (name, status) values ('Lawrence Malcolmson', false);
insert into Author (name, status) values ('Jerrie de Najera', true);
insert into Author (name, status) values ('Jobey Morrel', true);
insert into Author (name, status) values ('Alfonso Kitchenham', false);
insert into Author (name, status) values ('Angelika Whates', true);
insert into Author (name, status) values ('Theresa Quarlis', true);
insert into Author (name, status) values ('Tobin Trowsdall', false);
insert into Author (name, status) values ('Madonna Groucock', false);
insert into Author (name, status) values ('Bobbe Lingley', true);
insert into Author (name, status) values ('Marge Lovelock', false);
insert into Author (name, status) values ('Brook Greatbanks', true);
insert into Author (name, status) values ('Morgun Ruppeli', false);
insert into Author (name, status) values ('Pauly Mc Queen', true);
insert into Author (name, status) values ('Cary Bourhill', true);
insert into Author (name, status) values ('Gene Hamp', true);
insert into Author (name, status) values ('Taddeo Kraft', false);
insert into Author (name, status) values ('Hedvige Londesborough', true);
insert into Author (name, status) values ('Vera Rumgay', true);
insert into Author (name, status) values ('Donelle Gibling', false);
insert into Author (name, status) values ('Nicki Jessope', false);
insert into Author (name, status) values ('Adelle Binns', true);
insert into Author (name, status) values ('Julie Bonifacio', true);
insert into Author (name, status) values ('Mickie Szymoni', false);
insert into Author (name, status) values ('De Gabites', false);
insert into Author (name, status) values ('Joby McGuiness', false);
insert into Author (name, status) values ('Bliss Cauldwell', false);
insert into Author (name, status) values ('Elfreda Gerred', true);
insert into Author (name, status) values ('Gracie Larway', false);
insert into Author (name, status) values ('Derby Flescher', false);
insert into Author (name, status) values ('Vinita Treadgear', false);
insert into Author (name, status) values ('Dall Fraanchyonok', false);
insert into Author (name, status) values ('Wendell Bygott', false);
insert into Author (name, status) values ('Tabbie Bearward', false);
insert into Author (name, status) values ('Berkeley Cardenas', false);
insert into Author (name, status) values ('Cchaddie Attenbrough', false);
insert into Author (name, status) values ('Rosy Pudan', false);
insert into Author (name, status) values ('Julie Bowart', true);
insert into Author (name, status) values ('Myrlene Medendorp', false);
insert into Author (name, status) values ('Sherie Brumbye', false);
insert into Author (name, status) values ('Gareth Illsley', true);
insert into Author (name, status) values ('Salvador Broszkiewicz', false);
insert into Author (name, status) values ('Tami Hazeley', true);
insert into Author (name, status) values ('Reiko Jiran', false);
insert into Author (name, status) values ('Lucky Feasey', true);
insert into Author (name, status) values ('Geraldine Marnes', true);
insert into Author (name, status) values ('Delmor Giorgini', false);
insert into Author (name, status) values ('Ebenezer Cast', false);
insert into Author (name, status) values ('Freddy Carabet', true);
insert into Author (name, status) values ('Jemimah Umpleby', false);
insert into Author (name, status) values ('Gerladina Dacombe', true);
insert into Author (name, status) values ('Fayette Gandar', true);
insert into Author (name, status) values ('Francoise Murrey', false);
insert into Author (name, status) values ('Jessalyn Nance', true);
insert into Author (name, status) values ('Livvie Sirmond', false);
insert into Author (name, status) values ('Celie Spriggs', false);
insert into Author (name, status) values ('Susanne Muglestone', true);
insert into Author (name, status) values ('Iver Darbey', true);
insert into Author (name, status) values ('Sharla Bahls', false);
insert into Author (name, status) values ('Isaac Fearnehough', true);
insert into Author (name, status) values ('Daphene McNern', false);
insert into Author (name, status) values ('Ervin Clifford', true);
insert into Author (name, status) values ('Ramsey Craigmyle', false);
insert into Author (name, status) values ('Eduard Norcross', false);
insert into Author (name, status) values ('Walton Jillett', false);
insert into Author (name, status) values ('Moss Aimson', true);
insert into Author (name, status) values ('Parnell Couroy', true);
insert into Author (name, status) values ('Giselbert Wais', false);
insert into Author (name, status) values ('Aline Weiser', true);
insert into Author (name, status) values ('Coral McNally', false);
insert into Author (name, status) values ('Sybyl Kneebone', true);
insert into Author (name, status) values ('Tabbitha Offin', false);
insert into Author (name, status) values ('Jakie Brandin', true);
insert into Author (name, status) values ('Petra Stendall', false);
insert into Author (name, status) values ('Sadie Dillestone', false);
insert into Author (name, status) values ('Prentice Colliss', false);
insert into Author (name, status) values ('Ferdy Dilke', true);
insert into Author (name, status) values ('Coleen Trouncer', true);
insert into Author (name, status) values ('Hazel Berkelay', false);
insert into Author (name, status) values ('Cherilynn McEllen', true);
insert into Author (name, status) values ('Cher Childe', true);
insert into Author (name, status) values ('Halsy O''Halleghane', true);
insert into Author (name, status) values ('Jobyna Lidgley', false);
insert into Author (name, status) values ('Valentina Ogglebie', true);
insert into Author (name, status) values ('Agneta Revell', true);
insert into Author (name, status) values ('Mose Garrals', false);
insert into Author (name, status) values ('Issie Shand', false);
insert into Author (name, status) values ('Mandy Morena', false);
insert into Author (name, status) values ('Reeva Roderick', true);
insert into Author (name, status) values ('Mariann Enrich', false);
insert into Author (name, status) values ('Rubetta Sinclar', true);
insert into Author (name, status) values ('Morgun Diess', true);
insert into Author (name, status) values ('Carmine Medd', true);
insert into Author (name, status) values ('Park Smees', false);
insert into Author (name, status) values ('Ashlen Duckett', false);
insert into Author (name, status) values ('Farica Deare', false);
insert into Author (name, status) values ('Wolfy Sleep', false);
insert into Author (name, status) values ('Kalle Muirden', false);
insert into Author (name, status) values ('Etta Hallstone', true);
insert into Author (name, status) values ('Riordan Poyntz', true);
insert into Author (name, status) values ('Greta Stopher', false);
insert into Author (name, status) values ('Izabel Brugmann', false);
insert into Author (name, status) values ('Noami Oran', false);
insert into Author (name, status) values ('Penni Reckless', true);
insert into Author (name, status) values ('Sofia Marsden', true);
insert into Author (name, status) values ('Cassaundra Olivas', true);
insert into Author (name, status) values ('Evvy Pieter', true);
insert into Author (name, status) values ('Jessie Vaudrey', true);
insert into Author (name, status) values ('Eryn Willishire', true);
insert into Author (name, status) values ('Atlante Maunder', false);
insert into Author (name, status) values ('Brendis Minguet', true);
insert into Author (name, status) values ('Minni Aistrop', false);
insert into Author (name, status) values ('Sande Rhydderch', true);
insert into Author (name, status) values ('Shawna Rahlof', false);
insert into Author (name, status) values ('Grannie Jurczyk', false);
insert into Author (name, status) values ('Udell Paule', true);
insert into Author (name, status) values ('Arlin Haime', true);
insert into Author (name, status) values ('Pinchas Brenneke', true);
insert into Author (name, status) values ('Annetta Loutheane', false);
insert into Author (name, status) values ('Beatrice Elstob', true);
insert into Author (name, status) values ('Juan Whyte', false);
insert into Author (name, status) values ('Cleveland Helgass', false);
insert into Author (name, status) values ('Rivalee Chell', true);
insert into Author (name, status) values ('Ciel Light', false);
insert into Author (name, status) values ('Olivie Buntin', false);
insert into Author (name, status) values ('Callida Hischke', true);
insert into Author (name, status) values ('Wanids Jeffels', false);
insert into Author (name, status) values ('Bryna Tellwright', false);
insert into Author (name, status) values ('Josepha Teresi', true);
insert into Author (name, status) values ('Phillipp Tirte', true);
insert into Author (name, status) values ('Saul Aphale', false);
insert into Author (name, status) values ('Hebert Peattie', false);
insert into Author (name, status) values ('Roddy Plain', false);
insert into Author (name, status) values ('Pepe Tibbetts', false);
insert into Author (name, status) values ('Nannette Gajownik', false);
insert into Author (name, status) values ('Nike Scammell', true);
insert into Author (name, status) values ('Tiler Dust', false);
insert into Author (name, status) values ('Currie Alder', false);
insert into Author (name, status) values ('Hedda Daen', false);
insert into Author (name, status) values ('Obidiah Grazier', false);
insert into Author (name, status) values ('Kellby Chudleigh', true);
insert into Author (name, status) values ('Shelley Southerden', true);
insert into Author (name, status) values ('Vince Dalliwatr', true);
insert into Author (name, status) values ('Gabbie Summerscales', true);
insert into Author (name, status) values ('Julieta Dudenie', false);
insert into Author (name, status) values ('Emilee Dowell', false);
insert into Author (name, status) values ('Raff Possa', true);
insert into Author (name, status) values ('Abbi McDowall', false);
insert into Author (name, status) values ('Daron Solleme', true);
insert into Author (name, status) values ('Moll Goodier', false);
insert into Author (name, status) values ('Anjela de Guise', false);
insert into Author (name, status) values ('Allen Newvell', false);
insert into Author (name, status) values ('Emily Keen', true);
insert into Author (name, status) values ('Randee Nunes Nabarro', false);
insert into Author (name, status) values ('Norean Uphill', false);
insert into Author (name, status) values ('Lesley Carbonell', true);
insert into Author (name, status) values ('Brig Rivilis', true);
insert into Author (name, status) values ('Flory Entreis', false);
insert into Author (name, status) values ('Hammad McArthur', false);
insert into Author (name, status) values ('Bronny Boyet', true);
insert into Author (name, status) values ('Blancha Pidgeley', false);
insert into Author (name, status) values ('Annamarie Baldick', true);
insert into Author (name, status) values ('Nicki Clemetts', false);
insert into Author (name, status) values ('Rhiamon Ferreiro', true);
insert into Author (name, status) values ('Michale Torbet', true);
insert into Author (name, status) values ('Royal Mabe', false);
insert into Author (name, status) values ('Ondrea Howsam', true);
insert into Author (name, status) values ('Krystyna Ferrige', false);
insert into Author (name, status) values ('Devi Malyon', false);
insert into Author (name, status) values ('Debi Laverack', true);
insert into Author (name, status) values ('Ivan Chasier', false);
insert into Author (name, status) values ('Loella Inch', true);
insert into Author (name, status) values ('Kale Ferrulli', false);
insert into Author (name, status) values ('Slade Leglise', false);
insert into Author (name, status) values ('Lorne Truder', false);
insert into Author (name, status) values ('Lacee Ishak', false);
insert into Author (name, status) values ('Clemmie Beefon', false);
insert into Author (name, status) values ('Welbie Mickleburgh', true);
insert into Author (name, status) values ('Elsey Monelli', false);
insert into Author (name, status) values ('Anderson Landsberg', false);
insert into Author (name, status) values ('Monty Erb', true);
insert into Author (name, status) values ('Elianora Vedeniktov', true);
insert into Author (name, status) values ('Alon Winckles', false);
insert into Author (name, status) values ('Emile Jorck', true);
insert into Author (name, status) values ('Tisha Cheake', true);
insert into Author (name, status) values ('Vern Potteridge', true);
insert into Author (name, status) values ('Ado Yesenin', false);
insert into Author (name, status) values ('Fleurette Vear', false);
insert into Author (name, status) values ('Giorgi Celloni', false);
insert into Author (name, status) values ('Gaspard Cowton', true);
insert into Author (name, status) values ('Chandler Zorzin', true);
insert into Author (name, status) values ('Emory Blaine', true);
insert into Author (name, status) values ('Evvie Salvidge', true);
insert into Author (name, status) values ('Ardenia Beeken', true);
insert into Author (name, status) values ('Glennie Seadon', true);
insert into Author (name, status) values ('Karissa Vivers', true);
insert into Author (name, status) values ('Loraine Litchmore', true);
insert into Author (name, status) values ('Tedmund Blois', false);
insert into Author (name, status) values ('Adoree Walesby', true);
insert into Author (name, status) values ('Kay Simcock', true);
insert into Author (name, status) values ('Hermine Mallinson', false);
insert into Author (name, status) values ('Delila Astman', true);
insert into Author (name, status) values ('Sela Roscow', false);
insert into Author (name, status) values ('Vilma Aicheson', true);
insert into Author (name, status) values ('Vickie Hubbucke', true);
insert into Author (name, status) values ('Rabbi Lemm', false);
insert into Author (name, status) values ('Reena Blaxill', false);
insert into Author (name, status) values ('Hildagard Edards', false);
insert into Author (name, status) values ('Malissia Korlat', true);
insert into Author (name, status) values ('Missie Verbeke', true);
insert into Author (name, status) values ('Gage Fadden', true);
insert into Author (name, status) values ('Manon Girauld', true);
insert into Author (name, status) values ('Judah Cordeux', true);
insert into Author (name, status) values ('Katina Avramov', true);
insert into Author (name, status) values ('Trenna Scay', true);
insert into Author (name, status) values ('Garrard Yesenev', false);
insert into Author (name, status) values ('Ozzy Hulk', true);
insert into Author (name, status) values ('Gib Broxholme', false);
insert into Author (name, status) values ('Wang Claus', true);
insert into Author (name, status) values ('Gerrilee Threadgold', false);
insert into Author (name, status) values ('Sloane Traske', true);
insert into Author (name, status) values ('Angie Milkeham', true);
insert into Author (name, status) values ('Elsi Baggott', true);
insert into Author (name, status) values ('Sissy Kensley', true);
insert into Author (name, status) values ('Micah Challiner', true);
insert into Author (name, status) values ('Phillie Bloxholm', false);
insert into Author (name, status) values ('Ki Gresty', true);
insert into Author (name, status) values ('Codee O''Sullivan', true);
insert into Author (name, status) values ('Kristian Hinrichs', false);
insert into Author (name, status) values ('Leroy Dixson', false);
insert into Author (name, status) values ('Gussi Jermy', false);
insert into Author (name, status) values ('Allyce Clemonts', true);
insert into Author (name, status) values ('Cassandra Di Bartolommeo', false);
insert into Author (name, status) values ('Carver Bettley', true);
insert into Author (name, status) values ('Marta Puvia', true);
insert into Author (name, status) values ('Randa Twist', true);
insert into Author (name, status) values ('Auberon Escolme', false);
insert into Author (name, status) values ('Shandie Raspel', true);
insert into Author (name, status) values ('Lisle Taillant', false);
insert into Author (name, status) values ('Lennard Yancey', false);
insert into Author (name, status) values ('Scott Trainor', true);
insert into Author (name, status) values ('Shepard Comino', false);
insert into Author (name, status) values ('Lawrence Regenhardt', false);
insert into Author (name, status) values ('Gleda Auguste', true);
insert into Author (name, status) values ('Margaret Charrington', true);
insert into Author (name, status) values ('Jillane Bridgwood', false);
insert into Author (name, status) values ('Venita Dunrige', true);
insert into Author (name, status) values ('Inna MacAndie', true);
insert into Author (name, status) values ('Amandy Hillam', true);
insert into Author (name, status) values ('Emmett Dumigan', false);
insert into Author (name, status) values ('Janenna Savage', false);
insert into Author (name, status) values ('Lesya Ditchburn', true);
insert into Author (name, status) values ('Bee Riggeard', true);
insert into Author (name, status) values ('Carolyn McWilliam', false);
insert into Author (name, status) values ('Cullan Braffington', true);
insert into Author (name, status) values ('Evelyn Karppi', false);
insert into Author (name, status) values ('Bev McCrystal', false);
insert into Author (name, status) values ('Nancie Biers', true);
insert into Author (name, status) values ('Marcille Robinett', false);
insert into Author (name, status) values ('Jonah Thulborn', false);
insert into Author (name, status) values ('Kelli Petrolli', false);
insert into Author (name, status) values ('Jermayne Maffione', true);
insert into Author (name, status) values ('Chrisse Eliet', false);
insert into Author (name, status) values ('Aguste Keppe', false);
insert into Author (name, status) values ('Ricoriki Penley', true);
insert into Author (name, status) values ('Clemmie Penelli', false);
insert into Author (name, status) values ('Huberto Kneesha', false);
insert into Author (name, status) values ('Sherwood Mation', false);
insert into Author (name, status) values ('Barbabas Stanistrete', true);
insert into Author (name, status) values ('Towny Vigietti', true);
insert into Author (name, status) values ('Jehanna Izzett', false);
insert into Author (name, status) values ('Ophelia Davage', false);
insert into Author (name, status) values ('Gerianne Vernazza', false);
insert into Author (name, status) values ('Dulce Hegg', false);
insert into Author (name, status) values ('Sapphira Baskeyfield', false);
insert into Author (name, status) values ('Alasdair Richemont', true);
insert into Author (name, status) values ('Durward Adamides', true);
insert into Author (name, status) values ('Grover Gorioli', true);
insert into Author (name, status) values ('Benoit Beceril', true);
insert into Author (name, status) values ('Wiatt Balas', true);
insert into Author (name, status) values ('Carney Bassett', true);
insert into Author (name, status) values ('Cass Ellerington', true);
insert into Author (name, status) values ('Nero Stonebridge', true);
insert into Author (name, status) values ('Elmer Greep', false);
insert into Author (name, status) values ('Orion Bruckenthal', false);
insert into Author (name, status) values ('Kay Ledger', false);
insert into Author (name, status) values ('Dyanne Decourcy', true);
insert into Author (name, status) values ('Clark Greengrass', false);
insert into Author (name, status) values ('Berty Bagster', true);
insert into Author (name, status) values ('Prentiss Mitchard', true);
insert into Author (name, status) values ('Orland Ginnally', false);
insert into Author (name, status) values ('Fanechka Chatteris', true);
insert into Author (name, status) values ('Wally Ryder', true);
insert into Author (name, status) values ('Wheeler Hance', false);
insert into Author (name, status) values ('Kara-lynn Simenel', true);
insert into Author (name, status) values ('Alis Mimmack', false);
insert into Author (name, status) values ('Freemon Tenny', true);
insert into Author (name, status) values ('Dionne Stemson', true);
insert into Author (name, status) values ('Myles Yousef', true);
insert into Author (name, status) values ('Judon Fido', true);
insert into Author (name, status) values ('Brantley Oakwell', false);
insert into Author (name, status) values ('Cammy Drain', false);
insert into Author (name, status) values ('Hurley Goldhill', true);
insert into Author (name, status) values ('Gwenneth Bulleyn', true);
insert into Author (name, status) values ('Cayla Ziemecki', false);
insert into Author (name, status) values ('Laina Wilcockes', true);
insert into Author (name, status) values ('Felicio Eastmond', true);
insert into Author (name, status) values ('Abdel Dodgson', false);
insert into Author (name, status) values ('Cornelia Bourley', false);
insert into Author (name, status) values ('Gabi McMonnies', false);
insert into Author (name, status) values ('Damita Watmore', true);
insert into Author (name, status) values ('Decca Isgar', false);
insert into Author (name, status) values ('Teena Granville', false);
insert into Author (name, status) values ('Brand Jouning', true);
insert into Author (name, status) values ('Roderich Ivashov', true);
insert into Author (name, status) values ('Chandra Akram', true);
insert into Author (name, status) values ('Luisa Somes', true);
insert into Author (name, status) values ('Bax Parlet', false);
insert into Author (name, status) values ('Base MacKartan', true);
insert into Author (name, status) values ('Riva Rosas', false);
insert into Author (name, status) values ('Retha Cowie', false);
insert into Author (name, status) values ('Florette Kinane', false);
insert into Author (name, status) values ('Samantha Arlott', false);
insert into Author (name, status) values ('Kandace Mawby', true);
insert into Author (name, status) values ('Garland Minnock', false);
insert into Author (name, status) values ('Roslyn Carriage', true);
insert into Author (name, status) values ('Sindee Balaisot', false);
insert into Author (name, status) values ('Kilian Gauntley', false);
insert into Author (name, status) values ('Bonnie Dark', false);
insert into Author (name, status) values ('Adi Phoenix', true);
insert into Author (name, status) values ('Rodge Andress', true);
insert into Author (name, status) values ('Klement Gallamore', false);
insert into Author (name, status) values ('Rutger Comsty', true);
insert into Author (name, status) values ('Justine Letson', false);
insert into Author (name, status) values ('Sherie Abrehart', true);
insert into Author (name, status) values ('Quincy Ickovits', true);
insert into Author (name, status) values ('Donny Yallop', true);
insert into Author (name, status) values ('Michel Snoddin', true);
insert into Author (name, status) values ('Carleen Hurch', true);
insert into Author (name, status) values ('Tildy Bridgwater', false);
insert into Author (name, status) values ('Brand Moyser', true);
insert into Author (name, status) values ('Rene Rehn', true);
insert into Author (name, status) values ('Max Enocksson', false);
insert into Author (name, status) values ('Fidelia Verner', false);
insert into Author (name, status) values ('Tera Tanser', false);
insert into Author (name, status) values ('Britni Bristow', true);
insert into Author (name, status) values ('Sidnee Neeson', false);
insert into Author (name, status) values ('Rosabelle Fosh', false);
insert into Author (name, status) values ('Bobbee Hush', true);
insert into Author (name, status) values ('Casandra Renner', false);
insert into Author (name, status) values ('Allyce Skeleton', true);
insert into Author (name, status) values ('Adella Winward', false);
insert into Author (name, status) values ('Jocko Scoffins', false);
insert into Author (name, status) values ('Felipe Rimer', false);
insert into Author (name, status) values ('Kendell Ivankovic', true);
insert into Author (name, status) values ('Courtnay Cobbledick', true);
insert into Author (name, status) values ('Jemie Claypool', false);
insert into Author (name, status) values ('Umeko Puleque', false);
insert into Author (name, status) values ('Vernice Hakonsen', true);
insert into Author (name, status) values ('Lawton Wiersma', true);
insert into Author (name, status) values ('Andi Prettyjohns', true);
insert into Author (name, status) values ('Sadye Groucock', true);
insert into Author (name, status) values ('Yuma Ivanitsa', true);
insert into Author (name, status) values ('Franz Alywen', true);
insert into Author (name, status) values ('Earlie Monte', true);
insert into Author (name, status) values ('Velma Tremblot', false);
insert into Author (name, status) values ('Kakalina Livingstone', true);
insert into Author (name, status) values ('Hilary Bartolacci', true);
insert into Author (name, status) values ('Priscilla Aleksashin', false);
insert into Author (name, status) values ('Andromache Littleover', false);
insert into Author (name, status) values ('Winona Bleue', false);
insert into Author (name, status) values ('Forbes Ardling', true);
insert into Author (name, status) values ('Fara Gettins', true);
insert into Author (name, status) values ('Brooke Poynton', true);
insert into Author (name, status) values ('Fulton Knighton', false);
insert into Author (name, status) values ('Ninetta Trace', false);
insert into Author (name, status) values ('Adrianna Kilgour', true);
insert into Author (name, status) values ('Hannie Lapping', true);
insert into Author (name, status) values ('Iggie Nicklinson', false);
insert into Author (name, status) values ('Bernadina Bernaert', false);
insert into Author (name, status) values ('Erica Gowthrop', true);
insert into Author (name, status) values ('Herb Janz', false);
insert into Author (name, status) values ('Ardeen Antonucci', true);
insert into Author (name, status) values ('Ysabel Vain', false);
insert into Author (name, status) values ('Georgy Tomaino', true);
insert into Author (name, status) values ('Avie Ewell', false);
insert into Author (name, status) values ('Estel Cooksley', true);
insert into Author (name, status) values ('Hartwell Brisson', false);
insert into Author (name, status) values ('Delmor Cathie', false);
insert into Author (name, status) values ('Huey Guerreau', true);
insert into Author (name, status) values ('Conny Olekhov', false);
insert into Author (name, status) values ('Bertina Walczynski', false);
insert into Author (name, status) values ('Chaddie Adey', false);
insert into Author (name, status) values ('Kaitlin Waddoups', true);
insert into Author (name, status) values ('Yancy Crufts', true);
insert into Author (name, status) values ('Louise Drable', true);
insert into Author (name, status) values ('Giacomo Geaveny', false);
insert into Author (name, status) values ('Celestina Jelk', true);
insert into Author (name, status) values ('Dav Gayle', true);
insert into Author (name, status) values ('Davita Asipenko', true);
insert into Author (name, status) values ('Violet Cropp', true);
insert into Author (name, status) values ('Brand Merton', false);
insert into Author (name, status) values ('Margareta Mannix', true);
insert into Author (name, status) values ('Jarrid Paudin', false);
insert into Author (name, status) values ('Isabel Coils', true);
insert into Author (name, status) values ('Adelina Wrinch', true);
insert into Author (name, status) values ('Carmita Qualtrough', true);
insert into Author (name, status) values ('Henrieta Campanelle', false);
insert into Author (name, status) values ('Alanson Oselton', true);
insert into Author (name, status) values ('Lelah Petrolli', false);
insert into Author (name, status) values ('Walton Klaessen', true);
insert into Author (name, status) values ('Marlo Brisker', false);
insert into Author (name, status) values ('Jeanie Cherrison', true);
insert into Author (name, status) values ('Rourke Sowersby', true);
insert into Author (name, status) values ('Van Iacabucci', true);
insert into Author (name, status) values ('Burnard Binny', true);
insert into Author (name, status) values ('Reta Mateuszczyk', true);
insert into Author (name, status) values ('Minetta Stothard', true);
insert into Author (name, status) values ('Johnna Matschek', true);
insert into Author (name, status) values ('Shir Geane', true);
insert into Author (name, status) values ('Francisca Poulglais', false);
insert into Author (name, status) values ('Matthiew Offiler', true);
insert into Author (name, status) values ('Rhoda Heal', true);
insert into Author (name, status) values ('Donny Sansbury', false);
insert into Author (name, status) values ('Jan Markos', true);
insert into Author (name, status) values ('Junia Demer', false);
insert into Author (name, status) values ('Trixy Langfield', true);
insert into Author (name, status) values ('Warner Lincke', true);
insert into Author (name, status) values ('Sargent Byrnes', true);
insert into Author (name, status) values ('Jaine McCart', true);
insert into Author (name, status) values ('Denny Soppit', true);
insert into Author (name, status) values ('Barry Izatson', false);
insert into Author (name, status) values ('Gaby Provis', false);
insert into Author (name, status) values ('Jinny Simecek', false);
insert into Author (name, status) values ('Inglebert Bridgen', true);
insert into Author (name, status) values ('Ardisj Jones', false);
insert into Author (name, status) values ('Daisi Eat', true);
insert into Author (name, status) values ('Heida Trewartha', false);
insert into Author (name, status) values ('Larisa Rowlett', true);
insert into Author (name, status) values ('Morly Sellens', false);
insert into Author (name, status) values ('Leola Berkery', true);
insert into Author (name, status) values ('Felisha Klas', false);
insert into Author (name, status) values ('Sonia McGeown', true);
insert into Author (name, status) values ('Vicky Wegenen', false);
insert into Author (name, status) values ('Pamela Albiston', false);
insert into Author (name, status) values ('Randy Kilford', false);
insert into Author (name, status) values ('Orsa Brenneke', true);
insert into Author (name, status) values ('Jules Daubeny', false);
insert into Author (name, status) values ('Bertie McTeague', false);
insert into Author (name, status) values ('Maegan Fogt', true);
insert into Author (name, status) values ('Damara Points', false);
insert into Author (name, status) values ('Hayden Blue', true);
insert into Author (name, status) values ('Kissiah Whatsize', true);
insert into Author (name, status) values ('Peta Kearton', false);
insert into Author (name, status) values ('Dannel Krysiak', true);
insert into Author (name, status) values ('Kriste Fideler', true);
insert into Author (name, status) values ('Remington Wardell', false);
insert into Author (name, status) values ('Gilda Brewster', false);
insert into Author (name, status) values ('Vivia Rawling', false);
insert into Author (name, status) values ('Jobye Advani', false);
insert into Author (name, status) values ('Virgie McKay', true);
insert into Author (name, status) values ('Zelma Muttitt', false);
insert into Author (name, status) values ('Pet Knath', false);
insert into Author (name, status) values ('Montgomery Synke', true);
insert into Author (name, status) values ('Austine Cramond', false);
insert into Author (name, status) values ('Albert McLeary', true);
insert into Author (name, status) values ('Con Kellert', true);
insert into Author (name, status) values ('Ancell Runciman', true);
insert into Author (name, status) values ('Catriona Hawthorn', false);
insert into Author (name, status) values ('Lilyan Petford', false);
insert into Author (name, status) values ('Cherianne O''Deegan', false);
insert into Author (name, status) values ('Micki Coffee', false);


insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 3, 'Cazuza - O Tempo Não Pára', '065947948-6', '8/5/2023', 1, 'http://dummyimage.com/202x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 6, 'Implanted', '848218004-5', '1/1/2024', 1, 'http://dummyimage.com/149x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 7, 7, 'Kill Your Darlings', '339287345-4', '2/8/2023', 1, 'http://dummyimage.com/204x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 7, 3, 'The Returned', '559989146-1', '11/20/2024', 1, 'http://dummyimage.com/238x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 1, 'Brigadoon', '511138601-7', '7/30/2023', 1, 'http://dummyimage.com/130x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 1, 'The Beast Kills in Cold Blood', '679129403-5', '7/10/2023', 1, 'http://dummyimage.com/222x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 4, 8, 'Two-Way Stretch', '468167945-3', '2/19/2023', 1, 'http://dummyimage.com/125x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 1, 'Tim''s Vermeer', '655677990-3', '4/27/2024', 1, 'http://dummyimage.com/124x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 4, 2, 'Always Tell Your Wife', '426354991-0', '11/23/2023', 1, 'http://dummyimage.com/153x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 7, 8, 'Singing Nun, The', '525738500-7', '10/14/2023', 1, 'http://dummyimage.com/139x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 4, 2, 'We Are Marshall', '654883921-8', '3/14/2024', 1, 'http://dummyimage.com/168x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 9, 'Brushfires', '165215455-8', '7/25/2024', 1, 'http://dummyimage.com/147x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 2, 3, 'Rosetta', '386028812-1', '11/16/2022', 1, 'http://dummyimage.com/153x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 7, 1, 'Big Bang in Tunguska (Das Rätsel von Tunguska)', '923367358-8', '2/27/2023', 1, 'http://dummyimage.com/155x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 3, 'Monty Python''s The Meaning of Life', '762365906-5', '1/4/2023', 1, 'http://dummyimage.com/217x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 7, 'Ambush (Rukajärven tie)', '553981758-3', '3/13/2023', 1, 'http://dummyimage.com/195x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 8, 'It Came from Hollywood', '063821752-0', '3/12/2023', 1, 'http://dummyimage.com/193x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 9, 'Torque', '866744144-9', '10/17/2023', 1, 'http://dummyimage.com/197x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 2, 4, 'Man Who Knew Too Little, The', '847737416-3', '8/20/2023', 1, 'http://dummyimage.com/113x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 5, 'Kill Your Darlings', '490489351-4', '5/1/2024', 1, 'http://dummyimage.com/247x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 4, 4, 'En rachâchant', '741662060-0', '1/24/2023', 1, 'http://dummyimage.com/200x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 5, 'Kommissarie Späck', '971318322-3', '12/15/2022', 1, 'http://dummyimage.com/120x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 8, 'Big Miracle', '552059439-2', '1/6/2023', 1, 'http://dummyimage.com/244x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 5, 'Club Dread', '247951384-X', '10/15/2022', 1, 'http://dummyimage.com/230x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 4, 'Hellion', '721878914-5', '2/27/2023', 1, 'http://dummyimage.com/214x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 6, 7, 'Acadia Acadia?!? (L''acadie, l''Acadie)', '235409401-9', '11/7/2024', 1, 'http://dummyimage.com/154x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 6, 2, 'Scanners III: The Takeover (Scanner Force)', '590392854-4', '2/28/2023', 1, 'http://dummyimage.com/139x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 3, 'No Such Thing', '771382661-0', '10/16/2023', 1, 'http://dummyimage.com/128x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 7, 8, 'One of Our Dinosaurs Is Missing', '599117360-5', '1/13/2023', 1, 'http://dummyimage.com/227x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 3, 'Silent Hill: Revelation 3D', '650508862-8', '1/15/2024', 1, 'http://dummyimage.com/135x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 4, 'The Frame', '277732115-9', '3/24/2024', 1, 'http://dummyimage.com/235x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 1, 6, 'Nightbreed', '386774869-1', '9/7/2024', 1, 'http://dummyimage.com/170x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 2, 'Jackass 3D', '228082155-9', '9/16/2024', 1, 'http://dummyimage.com/246x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 1, 2, 'When a Woman Ascends the Stairs (Onna ga kaidan wo agaru toki)', '682799174-1', '7/28/2023', 1, 'http://dummyimage.com/210x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 2, 'Theodore Rex', '068143906-8', '7/20/2022', 1, 'http://dummyimage.com/114x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 4, 'Lions For Lambs', '229885574-9', '5/16/2023', 1, 'http://dummyimage.com/247x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 3, 'King Boxer: Five Fingers of Death (Tian xia di yi quan)', '895498401-0', '11/14/2022', 1, 'http://dummyimage.com/112x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 6, 6, 'Open Season', '147344267-2', '10/31/2024', 1, 'http://dummyimage.com/245x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 6, 8, 'Gerry', '380575534-1', '1/29/2024', 1, 'http://dummyimage.com/178x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 1, 'Judge Dredd', '356543134-2', '6/27/2023', 1, 'http://dummyimage.com/217x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 6, 2, 'Two Lovers', '099696395-2', '9/14/2024', 1, 'http://dummyimage.com/163x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 1, 8, 'Carry on Cabby', '860326334-5', '7/13/2024', 1, 'http://dummyimage.com/174x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 1, 'At Sea', '078152199-8', '8/7/2022', 1, 'http://dummyimage.com/108x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 7, 5, '11th Hour, The', '853468496-0', '7/7/2023', 1, 'http://dummyimage.com/230x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 7, 'Grace Unplugged', '119860414-X', '2/11/2023', 1, 'http://dummyimage.com/192x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 3, 'Bedevilled (Kim Bok-nam salinsageonui jeonmal)', '705854340-2', '5/1/2023', 1, 'http://dummyimage.com/226x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 7, 'Between the Folds', '805062243-6', '9/29/2022', 1, 'http://dummyimage.com/180x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 4, 7, 'Chicago 10', '042067849-2', '3/7/2024', 1, 'http://dummyimage.com/224x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 2, 9, 'Gossip', '575219356-7', '1/16/2023', 1, 'http://dummyimage.com/238x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 4, 7, 'My Fair Lady', '569790442-8', '3/14/2023', 1, 'http://dummyimage.com/249x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 7, 8, 'Wide Awake', '584827769-9', '11/17/2024', 1, 'http://dummyimage.com/144x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 7, 2, 'Gangs of New York', '889484734-9', '8/5/2023', 1, 'http://dummyimage.com/157x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 3, 'Strange Circus (Kimyô na sâkasu)', '130897221-0', '8/21/2024', 1, 'http://dummyimage.com/149x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 3, 'Trials of Muhammad Ali, The', '127285710-7', '4/3/2023', 1, 'http://dummyimage.com/101x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 7, 'Hyenas (Hyènes)', '359558194-6', '12/13/2022', 1, 'http://dummyimage.com/240x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 4, 9, 'Raspberry Boat Refugee', '642063218-8', '6/10/2024', 1, 'http://dummyimage.com/125x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 1, 'Julie & Julia', '517292140-0', '8/9/2023', 1, 'http://dummyimage.com/206x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 9, 'Novocaine', '625821177-1', '9/8/2023', 1, 'http://dummyimage.com/226x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 4, 'Conceiving Ada', '756703831-5', '11/8/2023', 1, 'http://dummyimage.com/167x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 4, 'Freshman, The', '357883642-7', '5/3/2023', 1, 'http://dummyimage.com/215x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 4, 9, 'Kundun', '296047856-8', '12/18/2023', 1, 'http://dummyimage.com/192x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 8, 'Ichi', '633476881-6', '11/18/2023', 1, 'http://dummyimage.com/130x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 8, 'Hired Hand, The', '413517338-1', '11/3/2024', 1, 'http://dummyimage.com/176x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 7, 2, 'He Said, She Said', '720451055-0', '9/8/2024', 1, 'http://dummyimage.com/122x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 6, 'Souler Opposite, The', '537779839-2', '7/16/2024', 1, 'http://dummyimage.com/110x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 2, 'Esther Kahn', '095688363-X', '8/26/2024', 1, 'http://dummyimage.com/100x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 7, 8, 'Monsterman (Monsterimies)', '896487241-X', '2/19/2024', 1, 'http://dummyimage.com/125x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 5, 1, 'B.U.S.T.E.D (Everybody Loves Sunshine) (Busted)', '203741976-7', '4/29/2023', 1, 'http://dummyimage.com/159x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 4, 9, 'Carrie', '612290692-1', '6/7/2024', 1, 'http://dummyimage.com/122x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 3, 3, 'Blithe Spirit', '806762969-2', '11/27/2023', 1, 'http://dummyimage.com/211x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 3, 'Kidnapped For Christ', '532886433-6', '5/5/2023', 1, 'http://dummyimage.com/116x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 3, 'Hawking', '552254985-8', '8/10/2024', 1, 'http://dummyimage.com/123x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 6, 'Restless (Levottomat)', '506007774-8', '8/15/2024', 1, 'http://dummyimage.com/250x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 2, 'Mulan', '361394183-X', '8/23/2022', 1, 'http://dummyimage.com/237x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 5, 5, 'Deathtrap', '734631613-4', '9/24/2023', 1, 'http://dummyimage.com/124x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 1, 'Lisa Picard is Famous (a.k.a. Famous)', '476263943-5', '10/3/2024', 1, 'http://dummyimage.com/232x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 2, 'Flodder', '004661134-7', '4/8/2023', 1, 'http://dummyimage.com/246x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 7, 2, 'MGS: Philanthropy', '207158492-9', '8/21/2024', 1, 'http://dummyimage.com/121x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 7, 8, 'Enigma', '404881735-3', '5/23/2023', 1, 'http://dummyimage.com/174x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 5, 2, 'Presence, The', '199301763-1', '10/11/2024', 1, 'http://dummyimage.com/189x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 9, 'Landscape in the Mist (Topio stin omichli)', '775910558-4', '2/14/2023', 1, 'http://dummyimage.com/179x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 7, 3, 'Fantasia', '417669484-X', '6/26/2024', 1, 'http://dummyimage.com/123x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 7, 4, 'Solar Crisis', '883514700-X', '6/26/2023', 1, 'http://dummyimage.com/220x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 7, 'Lovers of Hate', '007167793-3', '8/17/2023', 1, 'http://dummyimage.com/167x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 3, 'Time of Peace (Tempos de Paz)', '515818550-6', '2/24/2023', 1, 'http://dummyimage.com/121x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 3, 'Mummies: Secrets of the Pharaohs (a.k.a. Mummies 3D)', '214848419-2', '3/13/2024', 1, 'http://dummyimage.com/196x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 1, 'Pokémon: The First Movie', '939815983-X', '4/18/2024', 1, 'http://dummyimage.com/115x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 6, 6, 'Driving Miss Daisy', '568150336-4', '8/8/2022', 1, 'http://dummyimage.com/175x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 7, 2, 'Thief of Bagdad, The', '694969650-7', '2/4/2023', 1, 'http://dummyimage.com/130x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 6, 'The Last Outpost', '157555407-0', '5/5/2024', 1, 'http://dummyimage.com/190x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 6, 'Stand Off', '990476185-X', '3/7/2023', 1, 'http://dummyimage.com/130x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 3, 2, 'Fandango', '819164554-8', '8/4/2022', 1, 'http://dummyimage.com/185x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 2, 'Machine Gun McCain (Gli intoccabili)', '891887982-2', '9/29/2023', 1, 'http://dummyimage.com/131x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 3, 4, 'Mr. Thank You (Arigatô-san)', '096908603-2', '5/16/2023', 1, 'http://dummyimage.com/164x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 3, 4, 'Cool Air', '231966345-2', '1/31/2024', 1, 'http://dummyimage.com/208x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 4, 'The Floating Castle', '935336419-1', '4/29/2024', 1, 'http://dummyimage.com/247x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 7, 3, 'Crazy, Stupid, Love.', '117026446-8', '12/28/2022', 1, 'http://dummyimage.com/163x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 3, 1, 'Chasing Mavericks', '829643657-4', '7/7/2023', 1, 'http://dummyimage.com/195x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 1, 3, 'Normal', '590885813-7', '12/29/2023', 1, 'http://dummyimage.com/186x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 2, 'Mortadelo & Filemon: The Big Adventure (La gran aventura de Mortadelo y Filemón)', '839830770-6', '8/2/2023', 1, 'http://dummyimage.com/115x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 3, 3, 'Corvette Summer', '344730235-6', '7/8/2024', 1, 'http://dummyimage.com/127x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 8, 'Mercy', '457404477-2', '7/2/2023', 1, 'http://dummyimage.com/243x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 4, 3, 'G.I. Joe: Operation Dragonfire', '520968143-2', '7/4/2022', 1, 'http://dummyimage.com/159x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 7, 7, 'Tokyo Gore Police (Tôkyô zankoku keisatsu)', '606716063-3', '3/3/2024', 1, 'http://dummyimage.com/195x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 2, 2, 'Day & Night', '794914414-9', '9/19/2023', 1, 'http://dummyimage.com/226x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 2, 'Ultimate Gift, The', '242062785-7', '7/10/2024', 1, 'http://dummyimage.com/141x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 3, 'Sister My Sister', '003979732-5', '3/27/2023', 1, 'http://dummyimage.com/172x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 4, 5, 'Sea Wolf, The', '859075757-9', '2/21/2023', 1, 'http://dummyimage.com/129x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 2, 'North (Nord)', '123179909-9', '12/28/2023', 1, 'http://dummyimage.com/100x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 4, 1, 'Stereo', '138991611-1', '4/30/2024', 1, 'http://dummyimage.com/176x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 4, 'Novocaine', '390437937-2', '10/29/2023', 1, 'http://dummyimage.com/157x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 3, 'Camp Nowhere', '415403052-3', '3/22/2023', 1, 'http://dummyimage.com/192x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 7, 5, 'Battlestar Galactica: Blood & Chrome', '579360940-7', '8/20/2022', 1, 'http://dummyimage.com/167x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 8, 'Absolute Power', '175345920-6', '5/3/2024', 1, 'http://dummyimage.com/202x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 7, 8, 'Endless Summer 2, The', '457378818-2', '2/1/2023', 1, 'http://dummyimage.com/209x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 7, 5, 'Dialogues with Solzhenitsyn (Uzel)', '279348046-0', '4/10/2024', 1, 'http://dummyimage.com/222x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 4, 'How Stella Got Her Groove Back', '504924839-6', '9/26/2023', 1, 'http://dummyimage.com/221x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 9, 'In Love and War', '688181092-X', '6/21/2023', 1, 'http://dummyimage.com/210x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 5, 'High Heels and Low Lifes', '977367988-8', '11/6/2023', 1, 'http://dummyimage.com/143x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 9, 'Vernon, Florida', '098298762-5', '10/27/2023', 1, 'http://dummyimage.com/187x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 3, 'Benchwarmers, The', '930401831-5', '3/23/2023', 1, 'http://dummyimage.com/227x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 1, 'Evil Cult, The (Lord of the Wu Tang) (Yi tian tu long ji: Zhi mo jiao jiao zhu)', '728366038-0', '7/28/2023', 1, 'http://dummyimage.com/240x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 4, 'High Tension (Haute tension) (Switchblade Romance)', '016969026-1', '11/3/2024', 1, 'http://dummyimage.com/121x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 7, 'The Improv: 50 Years Behind the Brick Wall', '903450207-4', '9/26/2022', 1, 'http://dummyimage.com/103x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 7, 'Gaucho, The', '088037478-0', '1/2/2024', 1, 'http://dummyimage.com/142x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 4, 4, 'Jungle Holocaust (Ultimo mondo cannibale)', '162776006-7', '2/17/2024', 1, 'http://dummyimage.com/175x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 9, 'Scent of a Woman', '588383668-2', '9/1/2023', 1, 'http://dummyimage.com/135x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 7, 'L.A. Without a Map', '749560474-3', '4/14/2024', 1, 'http://dummyimage.com/222x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 1, 'Hunger', '022550754-4', '8/4/2023', 1, 'http://dummyimage.com/242x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 3, 3, 'Grand Prix', '023625282-8', '10/8/2023', 1, 'http://dummyimage.com/230x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 7, 'Venom', '802707256-5', '6/19/2023', 1, 'http://dummyimage.com/216x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 7, 'Sadness of Sex, The', '788438145-1', '7/26/2022', 1, 'http://dummyimage.com/246x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 4, 'Fudoh: The New Generation (Gokudô sengokushi: Fudô)', '187311811-2', '10/5/2024', 1, 'http://dummyimage.com/155x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 7, 2, 'Without Lying Down: Frances Marion and the Power of Women in Hollywood', '045019141-9', '1/27/2024', 1, 'http://dummyimage.com/223x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 9, 'Blind Sunflowers, The (Los girasoles ciegos)', '595086963-X', '8/14/2023', 1, 'http://dummyimage.com/172x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 3, 7, 'Coriolanus', '589045991-0', '7/26/2023', 1, 'http://dummyimage.com/138x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 4, 5, 'Wreckers', '302569571-4', '7/6/2022', 1, 'http://dummyimage.com/184x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 3, 'To Be Takei', '806641693-8', '7/20/2024', 1, 'http://dummyimage.com/146x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 4, 'Keeping Mum', '511290422-4', '3/19/2023', 1, 'http://dummyimage.com/120x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 8, 'Baby of Mâcon, The (a.k.a. The Baby of Macon)', '519163938-3', '5/30/2024', 1, 'http://dummyimage.com/177x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 3, 5, 'Ever Since the World Ended', '386045480-3', '11/15/2023', 1, 'http://dummyimage.com/101x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 6, 2, 'Unknown Known, The', '738867178-1', '1/29/2023', 1, 'http://dummyimage.com/143x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 6, 3, 'Our Relations', '342764153-8', '6/12/2023', 1, 'http://dummyimage.com/167x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 3, 'Hidden (a.k.a. Cache) (Caché)', '699772419-1', '10/24/2024', 1, 'http://dummyimage.com/118x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 8, 'Sharpe''s Gold', '752897406-4', '4/29/2023', 1, 'http://dummyimage.com/160x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 4, 1, 'Incredible Shrinking Woman, The', '602273174-7', '1/3/2024', 1, 'http://dummyimage.com/170x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 5, 'Border Incident', '288968554-3', '9/26/2024', 1, 'http://dummyimage.com/247x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 6, 5, 'Stranger by the Lake (L''inconnu du lac)', '896305764-X', '4/21/2024', 1, 'http://dummyimage.com/111x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 9, 'Kiki''s Delivery Service', '025446077-1', '6/17/2023', 1, 'http://dummyimage.com/183x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 6, 5, 'Kenji Mizoguchi: The Life of a Film Director (Aru eiga-kantoku no shogai)', '955163473-X', '4/4/2024', 1, 'http://dummyimage.com/216x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 7, 5, 'Twin Falls Idaho', '390152565-3', '7/8/2024', 1, 'http://dummyimage.com/132x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 3, 2, 'Winter in Wartime', '606293883-0', '8/15/2024', 1, 'http://dummyimage.com/249x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 5, 'Never Forever', '609698913-6', '2/23/2023', 1, 'http://dummyimage.com/192x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 6, 'Last Lions, The', '550386897-8', '4/29/2024', 1, 'http://dummyimage.com/138x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 7, 'Guide, The (O Xenagos)', '306932194-1', '3/27/2023', 1, 'http://dummyimage.com/193x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 1, 3, 'Don''t Tell Mom the Babysitter''s Dead', '076395898-0', '4/4/2023', 1, 'http://dummyimage.com/107x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 8, 'Low Life', '488164817-9', '3/31/2024', 1, 'http://dummyimage.com/136x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 6, 'Miranda', '356397671-6', '12/24/2023', 1, 'http://dummyimage.com/221x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 1, 1, 'Shoot First, Die Later', '975088956-8', '8/22/2024', 1, 'http://dummyimage.com/174x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 3, 4, 'Don''t You Forget About Me', '941833660-X', '8/29/2023', 1, 'http://dummyimage.com/121x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 6, 'Ginger & Rosa', '537433113-2', '5/29/2023', 1, 'http://dummyimage.com/129x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 4, 'Perfect Storm, The', '342016977-9', '8/23/2024', 1, 'http://dummyimage.com/135x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 1, 'Prom Night in Mississippi', '577447961-7', '12/8/2022', 1, 'http://dummyimage.com/181x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 1, 2, 'Zatoichi Meets Yojimbo (Zatôichi to Yôjinbô) (Zatôichi 20)', '370187247-3', '10/31/2022', 1, 'http://dummyimage.com/102x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 4, 'Girl in the Red Velvet Swing, The', '305920291-5', '8/17/2022', 1, 'http://dummyimage.com/241x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 2, 7, 'Bitter Moon', '522748347-7', '6/13/2023', 1, 'http://dummyimage.com/191x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 7, 9, 'Wings', '599577348-8', '11/13/2024', 1, 'http://dummyimage.com/124x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 5, 9, 'Randy and the Mob', '362811965-0', '1/14/2024', 1, 'http://dummyimage.com/128x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 3, 7, 'Casual Sex?', '844083770-4', '10/20/2024', 1, 'http://dummyimage.com/182x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 3, 'Secret Sunshine (Milyang)', '533021014-3', '8/17/2022', 1, 'http://dummyimage.com/126x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 9, 'Weekend', '252612498-0', '12/24/2022', 1, 'http://dummyimage.com/226x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 6, 1, 'Snake Pit, The', '163824452-9', '4/30/2023', 1, 'http://dummyimage.com/143x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 4, 'Today''s Special', '320260736-7', '11/2/2024', 1, 'http://dummyimage.com/113x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 1, 7, 'Foolproof', '579420316-1', '7/10/2024', 1, 'http://dummyimage.com/206x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 5, 'Wind and the Lion, The', '619370693-3', '8/2/2023', 1, 'http://dummyimage.com/165x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 8, 'Gamera vs. Viras ', '204174769-2', '2/6/2024', 1, 'http://dummyimage.com/236x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 3, 1, 'Penda''s Fen', '285691072-6', '9/23/2024', 1, 'http://dummyimage.com/108x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 1, 'Mrs. Brown (a.k.a. Her Majesty, Mrs. Brown)', '423411198-8', '10/1/2023', 1, 'http://dummyimage.com/191x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 3, 2, 'Inherit the Wind', '047545872-9', '10/22/2023', 1, 'http://dummyimage.com/172x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 7, 4, 'Port of Flowers', '558914431-0', '3/31/2023', 1, 'http://dummyimage.com/104x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 2, 'Dr. Dolittle 3', '146247292-3', '4/13/2023', 1, 'http://dummyimage.com/150x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 7, 'Rogue', '961512503-2', '6/8/2023', 1, 'http://dummyimage.com/124x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 7, 7, 'Volga - Volga', '990315685-5', '8/25/2022', 1, 'http://dummyimage.com/187x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 3, 'Resistance', '648925026-8', '12/26/2022', 1, 'http://dummyimage.com/135x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 1, 'Eros', '314660513-9', '2/14/2024', 1, 'http://dummyimage.com/162x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 7, 9, 'Julia and Julia (Giulia e Giulia)', '385905820-7', '7/29/2022', 1, 'http://dummyimage.com/159x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 1, 5, 'Godzilla, Mothra, and King Ghidorah: Giant Monsters All-Out Attack (Gojira, Mosura, Kingu Gidorâ: Daikaijû sôkôgeki) (Godzilla, Mothra and King Ghidorah: Giant Monsters All-Out Attack)', '055320554-4', '2/13/2024', 1, 'http://dummyimage.com/211x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 5, 'The Widow From Chicago', '815974646-6', '7/16/2022', 1, 'http://dummyimage.com/174x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 1, 9, 'Loves of Carmen, The', '713507841-1', '7/24/2024', 1, 'http://dummyimage.com/238x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 2, 3, 'The End', '989994168-9', '9/6/2022', 1, 'http://dummyimage.com/219x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 1, 'Take the Trash', '596421356-1', '4/29/2024', 1, 'http://dummyimage.com/101x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 7, 8, 'Fly Away Home', '378536449-0', '5/5/2024', 1, 'http://dummyimage.com/166x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 5, 8, 'Romeo and Juliet', '449337936-7', '12/21/2022', 1, 'http://dummyimage.com/242x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 3, 'McCullochs, The', '160542831-0', '1/26/2023', 1, 'http://dummyimage.com/194x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 5, 4, 'Highway Racer', '633794279-5', '5/14/2023', 1, 'http://dummyimage.com/186x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 1, 3, 'To Sleep with Anger', '997669426-1', '2/11/2023', 1, 'http://dummyimage.com/168x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 7, 5, 'Cheeky Girls', '994741941-X', '11/17/2024', 1, 'http://dummyimage.com/160x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 2, 'Chained', '504136455-9', '11/18/2023', 1, 'http://dummyimage.com/242x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 7, 4, 'Breaking the Silence: Truth and Lies in the War on Terror', '853558298-3', '2/8/2024', 1, 'http://dummyimage.com/206x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 6, 'Dukes, The', '543367271-9', '5/29/2023', 1, 'http://dummyimage.com/151x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 4, 7, 'Wolf Man, The', '681944852-X', '5/22/2023', 1, 'http://dummyimage.com/212x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 6, 7, 'Jack Frost 2: Revenge of the Mutant Killer Snowman', '268819257-4', '9/23/2024', 1, 'http://dummyimage.com/186x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 3, 9, 'Blood and Chocolate', '154941018-0', '7/22/2023', 1, 'http://dummyimage.com/245x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 4, 'Everybody''s Acting', '548531327-2', '11/2/2022', 1, 'http://dummyimage.com/217x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 2, 'Maniac', '726610361-4', '1/2/2023', 1, 'http://dummyimage.com/206x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 6, 2, 'Dark Passage', '503186566-0', '7/4/2023', 1, 'http://dummyimage.com/243x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 7, 8, 'The Roots of Heaven', '854095409-5', '6/27/2024', 1, 'http://dummyimage.com/246x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 9, 'Parasite', '851880507-4', '9/25/2024', 1, 'http://dummyimage.com/202x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 6, 'Simpsons Movie, The', '988203344-X', '10/17/2023', 1, 'http://dummyimage.com/240x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 6, 'Black Orchid, The', '434615373-9', '7/21/2023', 1, 'http://dummyimage.com/110x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 3, 'Emperor of the North (Emperor of the North Pole)', '627067168-X', '3/8/2024', 1, 'http://dummyimage.com/138x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 7, 4, 'CJ7 (Cheung Gong 7 hou)', '650264445-7', '4/4/2024', 1, 'http://dummyimage.com/204x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 2, 'Belphecor: Curse of the Mummy (Belphégor - Le fantôme du Louvre)', '141514683-7', '7/16/2023', 1, 'http://dummyimage.com/114x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 8, 'The Bride Wore Red', '887751635-6', '12/6/2023', 1, 'http://dummyimage.com/217x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 9, 'No Place to Hide', '333639577-1', '3/14/2024', 1, 'http://dummyimage.com/139x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 6, 'Godzilla 1985: The Legend Is Reborn (Gojira) (Godzilla) (Return of Godzilla, The)', '355645505-6', '10/18/2024', 1, 'http://dummyimage.com/164x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 2, 3, 'Foreverland', '387550364-3', '8/3/2022', 1, 'http://dummyimage.com/225x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 6, 7, 'Carbon Nation', '254813534-9', '8/26/2022', 1, 'http://dummyimage.com/201x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 5, 5, 'First Position', '659840737-0', '8/19/2022', 1, 'http://dummyimage.com/199x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 7, 2, 'Boxing Helena', '019718685-8', '9/19/2022', 1, 'http://dummyimage.com/102x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 6, 2, 'Foxfire', '679442075-9', '6/20/2024', 1, 'http://dummyimage.com/227x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 3, 7, 'Land of the Lost', '508848531-X', '4/29/2023', 1, 'http://dummyimage.com/115x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 3, 7, 'Freshman, The', '139740197-4', '6/29/2024', 1, 'http://dummyimage.com/109x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 4, 'Buttcrack', '705770541-7', '6/11/2023', 1, 'http://dummyimage.com/194x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 5, 'Kiki', '291067276-X', '7/26/2023', 1, 'http://dummyimage.com/110x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 1, 'Slaughterhouse', '186694167-4', '8/31/2022', 1, 'http://dummyimage.com/131x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 9, 'Blue Bird, The', '471047904-6', '10/20/2022', 1, 'http://dummyimage.com/157x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 7, 9, 'Min så kallade pappa', '365720036-3', '12/29/2022', 1, 'http://dummyimage.com/147x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 9, 'Kingdom of the Spiders', '906871089-3', '9/18/2023', 1, 'http://dummyimage.com/233x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 8, 'Matrix Revolutions, The', '069029998-2', '3/18/2023', 1, 'http://dummyimage.com/161x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 5, 'Brainscan', '253877413-6', '5/30/2023', 1, 'http://dummyimage.com/240x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 1, 5, 'Days of Glory (Indigènes)', '081051350-1', '2/6/2023', 1, 'http://dummyimage.com/122x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 7, 1, 'Farewell My Concubine (Ba wang bie ji)', '849327516-6', '7/23/2022', 1, 'http://dummyimage.com/222x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 1, 'Creepshow 3', '047996486-6', '10/1/2024', 1, 'http://dummyimage.com/190x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 9, 'Appleseed Alpha', '247236745-7', '8/5/2024', 1, 'http://dummyimage.com/161x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 7, 1, 'Song of the Sea', '196034626-1', '8/22/2022', 1, 'http://dummyimage.com/245x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 3, 2, 'Siegfried & Roy: The Magic Box', '481833638-6', '2/11/2024', 1, 'http://dummyimage.com/199x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 3, 2, 'Young Aphrodites (Mikres Afrodites)', '674684406-4', '12/10/2023', 1, 'http://dummyimage.com/114x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 1, 'Shaolin Temple 2: Kids from Shaolin (Shao Lin xiao zi) (Kids from Shaolin)', '196734080-3', '11/11/2024', 1, 'http://dummyimage.com/218x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 6, 'Flashdance', '524741887-5', '12/27/2022', 1, 'http://dummyimage.com/184x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 8, 'Moebius Redux: A Life in Pictures', '423171515-7', '4/12/2023', 1, 'http://dummyimage.com/205x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 7, 6, 'Wodehouse In Exile', '192602763-9', '8/13/2024', 1, 'http://dummyimage.com/106x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 6, 5, 'Year of the Horse', '166223214-4', '3/12/2023', 1, 'http://dummyimage.com/245x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 4, 'Blind', '397512831-3', '8/11/2022', 1, 'http://dummyimage.com/116x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 2, 'Kiss Me Deadly', '118003981-5', '3/4/2024', 1, 'http://dummyimage.com/161x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 6, 'Wild Angels, The', '449273966-1', '7/1/2024', 1, 'http://dummyimage.com/228x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 4, 'Reel Rock 8 ', '736937752-0', '8/3/2024', 1, 'http://dummyimage.com/122x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 2, 4, 'Thirty-Two Short Films About Glenn Gould', '185014297-1', '7/14/2022', 1, 'http://dummyimage.com/121x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 4, 'Medora', '768128941-0', '5/28/2024', 1, 'http://dummyimage.com/147x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 4, 'Sleep Furiously', '402604525-0', '8/9/2022', 1, 'http://dummyimage.com/163x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 4, 'Woman in the Meadow (Nainen kedolla)', '901332210-7', '1/6/2024', 1, 'http://dummyimage.com/249x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 3, 4, 'Take Care of My Cat (Goyangileul butaghae)', '084301648-5', '2/4/2024', 1, 'http://dummyimage.com/242x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 7, 8, 'Last Hangman, The (Pierrepoint)', '136010853-X', '5/7/2023', 1, 'http://dummyimage.com/154x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 2, 'Father and Guns (De père en flic)', '035735779-5', '2/20/2024', 1, 'http://dummyimage.com/149x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 7, 'The Intruders', '464547174-0', '9/28/2023', 1, 'http://dummyimage.com/228x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 9, 'Blood of Dracula', '271915126-2', '3/10/2024', 1, 'http://dummyimage.com/129x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 8, 'Haunted Strangler, The (Grip of the Strangler)', '828335244-X', '8/28/2023', 1, 'http://dummyimage.com/179x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 7, 5, 'Don''t Say a Word', '953126259-4', '8/17/2023', 1, 'http://dummyimage.com/204x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 5, 6, 'Punk''s Not Dead', '864586330-8', '9/5/2023', 1, 'http://dummyimage.com/227x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 7, 8, 'Last Ride, The', '081187767-1', '9/12/2023', 1, 'http://dummyimage.com/182x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 6, 'Gasoline (Benzina)', '788638171-8', '10/10/2024', 1, 'http://dummyimage.com/233x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 1, 1, 'Waxwork', '455251738-4', '10/29/2022', 1, 'http://dummyimage.com/126x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 1, 'Good Shepherd, The', '144791295-0', '8/19/2022', 1, 'http://dummyimage.com/217x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 5, 'Study in Terror, A', '086980830-3', '12/16/2022', 1, 'http://dummyimage.com/247x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 1, 5, 'Lonely Passion of Judith Hearne, The', '346268982-7', '10/26/2022', 1, 'http://dummyimage.com/200x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 1, 'Blankman', '258031187-4', '4/23/2023', 1, 'http://dummyimage.com/174x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 8, '20,000 Years in Sing Sing', '711878445-1', '4/23/2024', 1, 'http://dummyimage.com/168x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 3, 1, 'Swamp Shark', '452640477-2', '1/29/2023', 1, 'http://dummyimage.com/219x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 4, 9, 'Vital Signs', '687856150-7', '7/21/2023', 1, 'http://dummyimage.com/247x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 7, 7, 'Hellraiser: Hellseeker', '351106625-5', '3/10/2023', 1, 'http://dummyimage.com/153x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 9, 'Yossi & Jagger', '129188253-7', '9/4/2024', 1, 'http://dummyimage.com/109x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 6, 5, 'Ambassador, The (Ambassadøren)', '852021173-9', '1/6/2024', 1, 'http://dummyimage.com/138x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 6, 8, 'Tinker, Tailor, Soldier, Spy', '543316258-3', '5/15/2023', 1, 'http://dummyimage.com/195x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 8, 'The 39 Steps', '528898633-9', '7/15/2022', 1, 'http://dummyimage.com/218x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 2, 1, 'Artifact', '539861218-2', '4/22/2024', 1, 'http://dummyimage.com/103x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 3, 9, 'Guitar, The', '236004692-6', '3/16/2024', 1, 'http://dummyimage.com/248x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 4, 4, 'Alexandria... Why? (Iskanderija... lih?)', '477057928-4', '12/24/2023', 1, 'http://dummyimage.com/167x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 6, 'Lone Wolf and Cub: Baby Cart to Hades (Kozure Ôkami: Shinikazeni mukau ubaguruma)', '938860282-X', '1/4/2024', 1, 'http://dummyimage.com/211x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 7, 3, 'Blutzbrüdaz', '041596160-2', '2/22/2023', 1, 'http://dummyimage.com/243x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 6, 'Ollin oppivuodet', '044012635-5', '12/29/2022', 1, 'http://dummyimage.com/235x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 3, 4, 'Bats', '160612312-2', '6/19/2023', 1, 'http://dummyimage.com/105x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 7, 6, 'Villain, The', '479927480-5', '10/24/2022', 1, 'http://dummyimage.com/196x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 1, 7, 'Adventureland', '642884019-7', '10/18/2023', 1, 'http://dummyimage.com/248x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 7, 'Interstellar', '093920047-3', '11/3/2023', 1, 'http://dummyimage.com/156x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 5, 'The Do-Deca-Pentathlon', '866408445-9', '1/1/2024', 1, 'http://dummyimage.com/102x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 2, 'Dark at the Top of the Stairs, The', '361601283-X', '5/27/2023', 1, 'http://dummyimage.com/214x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 7, 9, 'Permanent Midnight', '656525071-5', '3/5/2023', 1, 'http://dummyimage.com/238x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 7, 3, 'Tank', '607950676-9', '12/22/2023', 1, 'http://dummyimage.com/141x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 7, 3, 'Phantom (O Fantasma)', '714911672-8', '8/8/2023', 1, 'http://dummyimage.com/120x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 5, 9, 'Scenic Route, The', '757685898-2', '5/21/2024', 1, 'http://dummyimage.com/138x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 4, '7 Days in Havana', '552263892-3', '11/6/2024', 1, 'http://dummyimage.com/105x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 8, 'Never Again', '080974283-7', '4/20/2024', 1, 'http://dummyimage.com/237x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 2, 'Things Are Tough All Over', '179254578-9', '12/16/2023', 1, 'http://dummyimage.com/196x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 7, 9, 'Cantante, El', '567178749-1', '7/9/2022', 1, 'http://dummyimage.com/119x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 6, 'Special Bulletin', '241639875-X', '12/15/2022', 1, 'http://dummyimage.com/170x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 3, 8, 'Make Your Move', '786824151-9', '8/2/2024', 1, 'http://dummyimage.com/244x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 4, 'Väreitä', '627931420-0', '6/14/2024', 1, 'http://dummyimage.com/181x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 3, 7, 'Last Exit to Brooklyn', '497092956-4', '7/6/2023', 1, 'http://dummyimage.com/227x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 1, 'Sunshine Cleaning', '457351444-9', '8/31/2022', 1, 'http://dummyimage.com/215x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 3, 'Cop', '564368943-X', '7/8/2022', 1, 'http://dummyimage.com/137x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 4, 'Fox and the Hound, The', '634847945-5', '7/16/2022', 1, 'http://dummyimage.com/188x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 3, 'Missionary, The', '894685013-2', '12/10/2023', 1, 'http://dummyimage.com/119x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 7, 'The Kiss', '731461180-7', '9/2/2023', 1, 'http://dummyimage.com/107x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 1, 7, 'River Wild, The', '138591899-3', '8/14/2022', 1, 'http://dummyimage.com/108x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 6, 6, 'Revenge of the Green Dragons', '063724613-6', '3/24/2023', 1, 'http://dummyimage.com/236x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 1, 1, 'The Face Behind the Mask', '591691415-6', '4/12/2023', 1, 'http://dummyimage.com/207x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 4, 8, 'Pie in the Sky', '233456378-1', '3/5/2024', 1, 'http://dummyimage.com/169x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 7, 8, 'Almost Married', '185778648-3', '7/22/2024', 1, 'http://dummyimage.com/121x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 4, 'Cat Run 2', '024058811-8', '5/1/2023', 1, 'http://dummyimage.com/224x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 1, 'Cat and Dog', '976801352-4', '9/28/2024', 1, 'http://dummyimage.com/232x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 5, 3, 'Drew: The Man Behind the Poster', '754836986-7', '5/1/2024', 1, 'http://dummyimage.com/189x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 9, 'Titanic', '033682933-7', '12/31/2022', 1, 'http://dummyimage.com/237x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 1, 5, '13', '032801350-1', '4/7/2024', 1, 'http://dummyimage.com/194x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 3, 'Safe Sex', '213688773-4', '5/25/2023', 1, 'http://dummyimage.com/197x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 4, 'Polar Bear King, The (Kvitebjørn Kong Valemon)', '054675476-7', '8/9/2023', 1, 'http://dummyimage.com/219x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 4, 'Hercules', '104478817-8', '10/25/2022', 1, 'http://dummyimage.com/171x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 8, 'Troll in Central Park, A', '200776550-0', '6/22/2024', 1, 'http://dummyimage.com/178x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 6, 'Escape to Athena', '308780360-X', '10/20/2023', 1, 'http://dummyimage.com/223x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 9, 'Student Prince in Old Heidelberg, The', '787037859-3', '9/6/2022', 1, 'http://dummyimage.com/234x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 2, 5, 'Steak', '409933943-2', '10/1/2022', 1, 'http://dummyimage.com/220x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 7, 2, 'Romance in Manhattan', '015104139-3', '5/7/2024', 1, 'http://dummyimage.com/211x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 2, 'Beyond the Forest', '194814375-5', '5/15/2023', 1, 'http://dummyimage.com/104x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 6, 6, 'Private Lives of Pippa Lee, The', '817915661-3', '10/4/2022', 1, 'http://dummyimage.com/231x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 2, 9, 'Help!', '652873072-5', '3/14/2023', 1, 'http://dummyimage.com/219x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 6, 5, 'Jonas', '378916458-5', '8/12/2022', 1, 'http://dummyimage.com/160x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 2, 'Jane Austen Book Club, The', '777874808-8', '11/15/2024', 1, 'http://dummyimage.com/108x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 3, 'Meteor Man, The', '181612621-7', '12/3/2022', 1, 'http://dummyimage.com/149x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 5, 'Conspiracy', '373844762-8', '2/11/2024', 1, 'http://dummyimage.com/113x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 7, 8, 'Summer Wars (Samâ wôzu)', '347904174-4', '5/2/2024', 1, 'http://dummyimage.com/228x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 3, 2, 'End of the Line, The', '454600102-9', '12/17/2023', 1, 'http://dummyimage.com/229x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 4, 'Along Came a Spider', '314777425-2', '2/20/2023', 1, 'http://dummyimage.com/188x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 6, 6, 'Corridor, The', '805012159-3', '12/13/2022', 1, 'http://dummyimage.com/103x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 7, 2, 'Decameron, The (Decameron, Il)', '137024250-6', '8/11/2023', 1, 'http://dummyimage.com/139x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 4, 6, 'Another Day, Another Time: Celebrating the Music of Inside Llewyn Davis', '570226060-0', '10/10/2023', 1, 'http://dummyimage.com/182x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 3, 'Funny About Love', '338890293-3', '4/3/2024', 1, 'http://dummyimage.com/147x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 2, '4 for Texas', '513853098-4', '7/23/2023', 1, 'http://dummyimage.com/144x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 5, 'Death on the Staircase (Soupçons)', '961078935-8', '7/25/2024', 1, 'http://dummyimage.com/172x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 4, 4, 'Shopgirl', '595886805-5', '4/20/2024', 1, 'http://dummyimage.com/137x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 9, 'Bad Company', '178424079-6', '10/21/2023', 1, 'http://dummyimage.com/244x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 1, 'Ten Inch Hero', '959881280-4', '5/4/2024', 1, 'http://dummyimage.com/215x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 4, 'Kid, The', '381173667-1', '3/5/2024', 1, 'http://dummyimage.com/149x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 7, 2, 'Everybody Wants to Be Italian', '073497374-8', '7/8/2024', 1, 'http://dummyimage.com/133x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 7, 2, 'THX 1138', '341620351-8', '5/4/2023', 1, 'http://dummyimage.com/233x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 8, 'Blindsight', '528099741-2', '1/14/2024', 1, 'http://dummyimage.com/184x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 4, 'Ripley''s Game', '924674067-X', '11/16/2022', 1, 'http://dummyimage.com/132x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 4, 8, 'Spider-Man', '760490102-6', '6/19/2023', 1, 'http://dummyimage.com/109x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 3, 6, 'Once Upon a Forest', '992280298-8', '9/9/2023', 1, 'http://dummyimage.com/125x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 1, 2, 'Field, The', '498957450-8', '2/15/2024', 1, 'http://dummyimage.com/167x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 1, 6, 'Dr. T and the Women', '237175434-X', '1/15/2024', 1, 'http://dummyimage.com/227x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 2, 'In the Mood For Love (Fa yeung nin wa)', '278901211-3', '7/30/2024', 1, 'http://dummyimage.com/138x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 5, 'Body and Soul', '393917135-2', '11/24/2023', 1, 'http://dummyimage.com/109x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 1, 9, 'Mabel at the Wheel', '316630749-4', '4/12/2023', 1, 'http://dummyimage.com/106x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 9, 'Naked Spur, The', '689460699-4', '6/15/2024', 1, 'http://dummyimage.com/198x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 7, 'Effi Briest (Fontane - Effi Briest)', '368051458-1', '10/19/2024', 1, 'http://dummyimage.com/196x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 5, 8, 'Almost Famous', '051670292-0', '3/5/2024', 1, 'http://dummyimage.com/175x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 7, 'Dr. Gillespie''s New Assistant', '885871342-7', '3/12/2024', 1, 'http://dummyimage.com/143x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 3, 'Tetro', '992742356-X', '1/28/2024', 1, 'http://dummyimage.com/210x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 3, 7, 'Manos: The Hands of Fate', '496976478-6', '7/21/2024', 1, 'http://dummyimage.com/159x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 4, 5, 'Tetsuo II: Body Hammer', '082563501-2', '11/1/2024', 1, 'http://dummyimage.com/216x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 5, 'Designated Mourner, The', '920836359-7', '12/10/2022', 1, 'http://dummyimage.com/115x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 3, 'Come and See (Idi i smotri)', '334521025-8', '11/13/2023', 1, 'http://dummyimage.com/137x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 7, 'Basic Instinct 2', '633890333-5', '4/4/2023', 1, 'http://dummyimage.com/201x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 2, 'Above the Law', '301521270-2', '2/25/2023', 1, 'http://dummyimage.com/111x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 3, '13 Frightened Girls! (Candy Web, The)', '905345726-7', '1/18/2023', 1, 'http://dummyimage.com/140x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 6, 'Safe Conduct (Laissez-Passer)', '376004682-7', '12/27/2022', 1, 'http://dummyimage.com/145x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 4, 'The First Movie', '375550145-7', '5/31/2024', 1, 'http://dummyimage.com/189x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 1, 'Carson City', '079239026-1', '11/29/2022', 1, 'http://dummyimage.com/178x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 3, 'Who the Hell Is Juliette? (¿Quién diablos es Juliette?)', '434116687-5', '6/25/2024', 1, 'http://dummyimage.com/123x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 6, 8, 'Hour of the Gun', '457919141-2', '6/11/2023', 1, 'http://dummyimage.com/147x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 1, 4, 'Holy Matrimony', '165423299-8', '7/25/2023', 1, 'http://dummyimage.com/203x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 1, 'Freddy''s Dead: The Final Nightmare (Nightmare on Elm Street Part 6: Freddy''s Dead, A)', '740527078-6', '10/30/2022', 1, 'http://dummyimage.com/218x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 5, 'Rosetta', '067438023-1', '4/15/2023', 1, 'http://dummyimage.com/170x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 5, 'Jim Jefferies: BARE', '506243899-3', '10/19/2022', 1, 'http://dummyimage.com/201x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 7, 8, 'Agony (a.k.a. Rasputin) (Agoniya)', '462969936-8', '5/21/2024', 1, 'http://dummyimage.com/234x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 5, 'Pirates of Silicon Valley', '616968527-1', '7/5/2023', 1, 'http://dummyimage.com/187x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 8, 'Dead Hate the Living!, The', '044977934-3', '3/26/2024', 1, 'http://dummyimage.com/156x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 7, 'How I Ended This Summer (Kak ya provyol etim letom)', '074863542-4', '7/7/2024', 1, 'http://dummyimage.com/250x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 6, 7, 'Das Lied in mir', '778801068-5', '2/9/2023', 1, 'http://dummyimage.com/203x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 7, 'The Little Fox', '615462606-1', '1/8/2024', 1, 'http://dummyimage.com/182x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 1, 9, 'National Theatre Live: Frankenstein', '507441615-9', '6/5/2024', 1, 'http://dummyimage.com/163x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 8, 'Crackerjack', '605173215-2', '1/3/2023', 1, 'http://dummyimage.com/183x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 8, 'Apache Country', '187213438-6', '12/23/2023', 1, 'http://dummyimage.com/178x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 7, 7, 'YellowBrickRoad', '304744036-0', '1/15/2024', 1, 'http://dummyimage.com/176x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 7, 2, 'Souls for Sale', '239764014-7', '1/20/2024', 1, 'http://dummyimage.com/122x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 4, 'Hyenas (Hyènes)', '122664167-9', '4/15/2024', 1, 'http://dummyimage.com/192x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 7, 4, 'Reservoir Dogs', '925229237-3', '5/9/2024', 1, 'http://dummyimage.com/180x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 7, 9, 'Guess Who''s Coming to Dinner', '396335137-3', '2/26/2024', 1, 'http://dummyimage.com/200x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 1, 'Jeff, Who Lives at Home', '213029168-6', '7/13/2023', 1, 'http://dummyimage.com/197x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 7, 6, 'Balto: Wolf Quest ', '745180394-5', '5/30/2023', 1, 'http://dummyimage.com/161x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 8, 'Godzilla vs. Mechagodzilla (Gojira tai Mekagojira)', '233796381-0', '11/28/2023', 1, 'http://dummyimage.com/210x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 5, 9, 'Sune på bilsemester', '571673016-7', '11/14/2022', 1, 'http://dummyimage.com/133x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 5, 'Crashing', '901353260-8', '2/6/2023', 1, 'http://dummyimage.com/159x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 5, 2, 'Many Adventures of Winnie the Pooh, The', '807759667-3', '8/28/2024', 1, 'http://dummyimage.com/174x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 8, 'Faces in the Crowd', '317102058-0', '11/13/2024', 1, 'http://dummyimage.com/145x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 7, 5, 'Urban Legend', '190679099-X', '11/3/2022', 1, 'http://dummyimage.com/230x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 7, 'Kingdom, The', '859218737-0', '2/15/2023', 1, 'http://dummyimage.com/234x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 5, 6, 'Empire Records', '268929272-6', '11/15/2022', 1, 'http://dummyimage.com/164x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 7, 8, 'I Shot a Man in Vegas', '807870706-1', '1/16/2023', 1, 'http://dummyimage.com/154x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 3, 'Respiro', '031239630-9', '5/28/2023', 1, 'http://dummyimage.com/189x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 7, 1, 'Ungentlemanly Act, An', '321516775-1', '2/10/2023', 1, 'http://dummyimage.com/238x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 2, 7, 'The Expedition to the End of the World', '168799735-7', '10/16/2023', 1, 'http://dummyimage.com/215x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 3, 3, 'Isabelle au bois dormant', '175071622-4', '2/10/2023', 1, 'http://dummyimage.com/242x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 4, 2, 'Kippur', '766451007-4', '8/9/2022', 1, 'http://dummyimage.com/182x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 7, 'Milius', '582774563-4', '5/1/2023', 1, 'http://dummyimage.com/179x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 6, 'Dark House', '819901200-5', '1/12/2024', 1, 'http://dummyimage.com/170x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 7, 1, 'Yours, Mine and Ours', '977413220-3', '4/17/2023', 1, 'http://dummyimage.com/225x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 6, 'Men of Means', '762046087-X', '10/24/2023', 1, 'http://dummyimage.com/171x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 5, 1, 'Rocky Balboa', '255251788-9', '8/29/2022', 1, 'http://dummyimage.com/242x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 2, 1, 'Big Bounce, The', '242611743-5', '2/20/2023', 1, 'http://dummyimage.com/240x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 1, 'Gentlemen of Fortune (Dzhentlmeny udachi)', '165152629-X', '5/31/2023', 1, 'http://dummyimage.com/198x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 1, 'Alaska: Spirit of the Wild', '695050414-4', '11/15/2023', 1, 'http://dummyimage.com/121x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 8, 'Human Resources (Ressources humaines)', '407458051-9', '10/28/2023', 1, 'http://dummyimage.com/168x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 6, 7, 'Place of One''s Own, A', '083615131-3', '11/20/2023', 1, 'http://dummyimage.com/173x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 3, 'Love Affair', '631014441-3', '10/18/2024', 1, 'http://dummyimage.com/238x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 6, 8, 'First Position', '444625086-8', '9/10/2022', 1, 'http://dummyimage.com/232x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 5, 'Misery', '596395228-X', '11/15/2024', 1, 'http://dummyimage.com/191x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 5, 4, 'Laaga Chunari Mein Daag: Journey of a Woman', '245545782-6', '11/19/2023', 1, 'http://dummyimage.com/171x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 6, 'Jerusalem Countdown', '345302198-3', '10/5/2023', 1, 'http://dummyimage.com/174x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 1, 'Dragon Ball: The Path to Power (Doragon bôru: Saikyô e no michi)', '981361519-2', '5/31/2023', 1, 'http://dummyimage.com/181x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 6, 5, 'Princess Raccoon (Operetta tanuki goten)', '490266584-0', '5/26/2024', 1, 'http://dummyimage.com/194x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 7, 3, 'Mirror, The (Zerkalo)', '179423009-2', '7/27/2024', 1, 'http://dummyimage.com/142x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 5, 1, 'Carousel', '712031107-7', '1/25/2023', 1, 'http://dummyimage.com/216x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 6, 'Abominable Snowman, The (Abominable Snowman of the Himalayas, The)', '639734509-2', '4/29/2023', 1, 'http://dummyimage.com/220x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 7, 'Butcher Boy, The', '052831229-4', '9/11/2024', 1, 'http://dummyimage.com/173x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 1, 'Genevieve', '274331848-1', '9/27/2022', 1, 'http://dummyimage.com/103x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 3, 2, 'American Grindhouse', '779942747-7', '4/12/2023', 1, 'http://dummyimage.com/160x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 3, 9, 'Great White Hype, The', '748695978-X', '11/10/2022', 1, 'http://dummyimage.com/144x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 3, 'Fallen Angel', '377820085-2', '1/30/2023', 1, 'http://dummyimage.com/210x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 1, 'Blues Brothers, The', '622783444-0', '7/30/2023', 1, 'http://dummyimage.com/117x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 6, 6, 'Tuff Turf', '563232877-5', '12/19/2022', 1, 'http://dummyimage.com/174x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 2, 'Ballad of Narayama, The (Narayama Bushiko)', '648846610-0', '3/3/2024', 1, 'http://dummyimage.com/172x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 1, 2, 'Once Upon a Time in Anatolia (Bir zamanlar Anadolu''da)', '290286444-2', '9/21/2022', 1, 'http://dummyimage.com/244x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 7, 8, 'Rat King', '492168816-8', '12/10/2022', 1, 'http://dummyimage.com/239x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 6, 7, 'Mickey', '612220242-8', '10/28/2023', 1, 'http://dummyimage.com/115x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 9, 'Other Woman, The', '161327967-1', '9/12/2023', 1, 'http://dummyimage.com/198x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 5, 'Three Resurrected Drunkards (Kaette kita yopparai)', '458541161-5', '2/14/2023', 1, 'http://dummyimage.com/222x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 7, 'Late Great Planet Earth, The', '549499657-3', '11/1/2023', 1, 'http://dummyimage.com/100x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 5, 'Nightwing', '879989403-3', '1/10/2024', 1, 'http://dummyimage.com/123x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 3, 'Josephine', '498491476-9', '8/17/2024', 1, 'http://dummyimage.com/225x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 7, 7, 'Rounders', '197231278-2', '8/7/2022', 1, 'http://dummyimage.com/243x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 7, 8, 'Stromboli', '508635287-8', '2/26/2023', 1, 'http://dummyimage.com/183x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 8, 'Escape from L.A.', '951068482-1', '10/31/2024', 1, 'http://dummyimage.com/151x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 3, 8, 'Angst', '849814564-3', '12/14/2022', 1, 'http://dummyimage.com/230x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 8, 'Funny Lady', '732211599-6', '12/3/2023', 1, 'http://dummyimage.com/132x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 2, 'Welcome Farewell-Gutmann (Bienvenido a Farewell-Gutmann)', '836143320-1', '9/10/2024', 1, 'http://dummyimage.com/116x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 6, 'Mr. Bean''s Holiday', '239218752-5', '12/28/2022', 1, 'http://dummyimage.com/209x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 3, 'From the Hip', '364791408-8', '2/8/2024', 1, 'http://dummyimage.com/244x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 8, 'What Maisie Knew', '234084440-1', '4/27/2024', 1, 'http://dummyimage.com/188x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 8, 'Expendables 3, The', '418557757-5', '9/13/2023', 1, 'http://dummyimage.com/191x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 3, 'Eight Iron Men', '465990466-0', '12/25/2023', 1, 'http://dummyimage.com/200x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 5, 'Girlhood', '459936706-0', '8/2/2024', 1, 'http://dummyimage.com/201x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 3, 4, 'Temp, The', '387161272-3', '10/16/2022', 1, 'http://dummyimage.com/167x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 3, 'Bubble', '905640196-3', '12/27/2022', 1, 'http://dummyimage.com/250x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 3, 3, 'Árido Movie', '281259658-9', '11/7/2023', 1, 'http://dummyimage.com/128x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 5, 'You Don''t Know Jack', '583794442-7', '10/8/2022', 1, 'http://dummyimage.com/108x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 6, 7, 'Werner - Volles Rooäää', '670796453-4', '6/9/2023', 1, 'http://dummyimage.com/107x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 7, 8, 'No End (Bez konca)', '557091439-0', '7/1/2023', 1, 'http://dummyimage.com/206x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 2, 5, 'Avenging Angelo', '178614851-X', '4/5/2023', 1, 'http://dummyimage.com/177x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 6, 1, 'Lion of the Desert', '838532603-0', '2/23/2024', 1, 'http://dummyimage.com/109x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 5, 3, 'National Security', '237914255-6', '5/18/2023', 1, 'http://dummyimage.com/174x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 2, 2, 'Without Pity', '338877599-0', '1/22/2023', 1, 'http://dummyimage.com/211x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 8, 'The Affairs of Martha', '208141269-1', '8/16/2022', 1, 'http://dummyimage.com/105x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 5, 'Dead Meat', '254534409-5', '10/4/2023', 1, 'http://dummyimage.com/166x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 8, 'Kick-Ass 2', '346452043-9', '10/22/2023', 1, 'http://dummyimage.com/145x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 7, 'My Boyfriends'' Dogs', '842714829-1', '2/26/2024', 1, 'http://dummyimage.com/249x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 7, 'Support Your Local Gunfighter', '301545593-1', '8/22/2023', 1, 'http://dummyimage.com/195x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 1, 2, 'Things You Can Tell Just by Looking at Her', '382003139-1', '3/31/2024', 1, 'http://dummyimage.com/112x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 7, 4, 'Starfighters, The', '375593266-0', '2/24/2023', 1, 'http://dummyimage.com/161x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 4, 9, 'Monster, The', '457219449-1', '4/26/2024', 1, 'http://dummyimage.com/207x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 1, 8, 'James Dean', '297260244-7', '11/4/2024', 1, 'http://dummyimage.com/240x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 3, 'Toe to Toe', '235831666-0', '12/19/2023', 1, 'http://dummyimage.com/163x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 6, 5, 'Goldene Zeiten', '258629302-9', '1/3/2024', 1, 'http://dummyimage.com/110x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 8, 'The Final Girl', '955335083-6', '8/5/2022', 1, 'http://dummyimage.com/170x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 2, 'Grass Is Greener, The', '070170515-9', '9/28/2022', 1, 'http://dummyimage.com/155x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 6, 4, 'In Dreams', '237971235-2', '5/12/2023', 1, 'http://dummyimage.com/151x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 1, 'American Heart', '195289691-6', '1/15/2024', 1, 'http://dummyimage.com/181x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 4, 5, 'Dimensions of Dialogue (Moznosti dialogu)', '115003730-X', '7/12/2023', 1, 'http://dummyimage.com/214x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 7, 5, 'Curse of the Demon (Night of the Demon)', '052792797-X', '7/16/2022', 1, 'http://dummyimage.com/236x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 3, 'Dream Demon', '442472651-7', '4/6/2023', 1, 'http://dummyimage.com/246x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 2, 'King of Comedy (Hei kek ji wong)', '008433173-9', '10/10/2024', 1, 'http://dummyimage.com/244x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 3, 'To Be Takei', '359909747-X', '9/25/2023', 1, 'http://dummyimage.com/145x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 1, 'Spy Who Loved Me, The', '708069656-9', '3/31/2024', 1, 'http://dummyimage.com/111x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 9, 'Somewhere Under the Broad Sky', '835522315-2', '3/30/2024', 1, 'http://dummyimage.com/108x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 6, 'Race to Witch Mountain', '260385960-9', '11/2/2022', 1, 'http://dummyimage.com/103x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 6, 'Toxic Avenger, The', '748428765-2', '2/9/2024', 1, 'http://dummyimage.com/147x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 5, 'Steamroller and the Violin, The (Katok i skripka)', '785135700-4', '5/22/2024', 1, 'http://dummyimage.com/206x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 1, 'Children of Nature (Börn náttúrunnar)', '298887754-8', '5/30/2024', 1, 'http://dummyimage.com/221x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 1, 'Speed 2: Cruise Control', '908128232-8', '10/10/2023', 1, 'http://dummyimage.com/129x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 1, 'Divo, Il', '660945522-8', '11/8/2022', 1, 'http://dummyimage.com/137x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 5, 'Koran by Heart', '871051469-4', '12/8/2022', 1, 'http://dummyimage.com/158x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 4, 'Cotton Club, The', '450800274-9', '10/8/2023', 1, 'http://dummyimage.com/198x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 5, 'Whores'' Glory', '948167599-8', '3/2/2024', 1, 'http://dummyimage.com/116x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 7, 'Dragon Fist (Long quan)', '708773811-9', '10/22/2023', 1, 'http://dummyimage.com/246x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 6, 'Theremin: An Electronic Odyssey', '518417404-4', '7/26/2022', 1, 'http://dummyimage.com/150x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 7, 5, 'Shoot on Sight', '908196449-6', '10/4/2024', 1, 'http://dummyimage.com/180x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 5, 'Death at a Funeral', '168730933-7', '8/15/2023', 1, 'http://dummyimage.com/159x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 7, 1, 'Life is a Bed of Roses (Vie est un roman, La)', '886848137-5', '2/10/2024', 1, 'http://dummyimage.com/161x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 4, 1, 'Secret', '951580241-5', '1/28/2024', 1, 'http://dummyimage.com/240x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 3, 4, 'Gandhi', '408525039-6', '3/17/2023', 1, 'http://dummyimage.com/188x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 7, 'Weirdsville', '414979250-X', '12/27/2022', 1, 'http://dummyimage.com/249x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 4, 'Farewell, My Queen (Les adieux à la reine)', '080824117-6', '9/17/2024', 1, 'http://dummyimage.com/176x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 6, 8, 'Hand, The (Ruka)', '627584552-X', '7/17/2023', 1, 'http://dummyimage.com/171x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 9, 'Three Stooges, The', '291971817-7', '8/15/2022', 1, 'http://dummyimage.com/125x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 6, 1, 'Cradle 2 the Grave', '948944023-X', '10/21/2024', 1, 'http://dummyimage.com/148x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 5, 'Bo Burnham: what.', '073262641-2', '12/16/2023', 1, 'http://dummyimage.com/224x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 7, 4, 'St. Ives', '261834989-X', '3/15/2024', 1, 'http://dummyimage.com/213x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 4, 7, 'Talk of Angels', '999412142-1', '8/14/2022', 1, 'http://dummyimage.com/232x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 7, 'Grouse', '468777234-X', '4/9/2024', 1, 'http://dummyimage.com/179x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 3, 4, 'Mayerling', '067267539-0', '10/13/2023', 1, 'http://dummyimage.com/236x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 8, 'Sheik, The', '337507765-3', '9/6/2023', 1, 'http://dummyimage.com/164x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 6, 'By the Bluest of Seas (U samogo sinego morya)', '324577832-5', '5/14/2024', 1, 'http://dummyimage.com/214x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 4, 2, 'Frankenstein 90', '324373285-9', '10/7/2022', 1, 'http://dummyimage.com/166x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 4, 'Dragon Ball GT: A Hero''s Legacy (Doragon bôru GT: Gokû gaiden! Yûki no akashi wa sû-shin-chû)', '854285532-9', '10/5/2023', 1, 'http://dummyimage.com/190x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 9, 'Guncrazy', '210639744-5', '3/5/2024', 1, 'http://dummyimage.com/179x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 7, 3, 'Motel, The', '118509692-2', '5/23/2024', 1, 'http://dummyimage.com/163x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 3, 'Day After Trinity, The', '269993582-4', '3/11/2024', 1, 'http://dummyimage.com/148x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 7, 'Paper Heart', '307366519-6', '4/2/2023', 1, 'http://dummyimage.com/200x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 7, 8, 'Dischord', '812235543-9', '10/25/2023', 1, 'http://dummyimage.com/165x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 2, 'Run All Night', '161745952-6', '6/1/2023', 1, 'http://dummyimage.com/216x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 2, 'Telling Lies in America', '864881741-2', '10/15/2023', 1, 'http://dummyimage.com/169x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 2, 'Alps (Alpeis)', '233150325-7', '10/12/2024', 1, 'http://dummyimage.com/199x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 2, 5, 'Big Bird Cage, The', '855799708-6', '9/22/2024', 1, 'http://dummyimage.com/169x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 2, 6, 'Sex and Breakfast', '217113932-3', '8/1/2024', 1, 'http://dummyimage.com/173x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 9, 'Informant!, The', '123762759-1', '2/21/2023', 1, 'http://dummyimage.com/163x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 7, 5, 'Man on the Train (Homme du train, L'')', '505847969-9', '11/15/2023', 1, 'http://dummyimage.com/131x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 6, 1, 'Travellers and Magicians', '006665613-3', '6/21/2024', 1, 'http://dummyimage.com/145x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 6, 3, 'Princess and the Pony', '632209476-9', '11/28/2023', 1, 'http://dummyimage.com/249x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 9, 'Beast, The (La bête)', '202041401-5', '12/31/2022', 1, 'http://dummyimage.com/157x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 2, 'Unrest', '851681391-6', '9/10/2023', 1, 'http://dummyimage.com/216x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 5, 'Brazil: In the Shadow of the Stadiums', '328185843-0', '3/14/2023', 1, 'http://dummyimage.com/141x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 9, 'Man on the Flying Trapeze', '763401854-6', '7/13/2023', 1, 'http://dummyimage.com/133x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 4, 'Old San Francisco', '885843573-7', '9/10/2022', 1, 'http://dummyimage.com/236x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 8, 'Betty Boop''s Hallowe''en Party', '372361312-8', '10/6/2022', 1, 'http://dummyimage.com/205x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 5, 6, 'Life and Nothing But (Vie et rien d''autre, La)', '636263575-2', '5/16/2023', 1, 'http://dummyimage.com/141x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 7, 3, 'Big Wednesday', '611077135-X', '2/2/2024', 1, 'http://dummyimage.com/145x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 6, 'Natural, The', '408640649-7', '2/28/2023', 1, 'http://dummyimage.com/215x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 7, 6, 'Private Romeo', '619754548-9', '5/16/2024', 1, 'http://dummyimage.com/245x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 2, 'Forest of Bliss', '010900278-4', '3/2/2023', 1, 'http://dummyimage.com/240x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 6, 'Breaking the Girls ', '428630853-7', '3/18/2024', 1, 'http://dummyimage.com/230x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 7, 'Equinox', '187134891-9', '9/26/2022', 1, 'http://dummyimage.com/176x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 5, 6, 'Frailty', '944725452-7', '3/13/2023', 1, 'http://dummyimage.com/142x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 6, 5, 'Evolution', '350713999-5', '10/5/2023', 1, 'http://dummyimage.com/170x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 5, 7, 'Attack of the Puppet People', '384141466-4', '7/7/2023', 1, 'http://dummyimage.com/184x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 7, 'Nothing''s All Bad', '682605950-9', '11/5/2024', 1, 'http://dummyimage.com/197x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 6, 'Silent Fall', '428386331-9', '11/8/2023', 1, 'http://dummyimage.com/185x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 9, 'Dudley Do-Right', '812196949-2', '10/18/2023', 1, 'http://dummyimage.com/129x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 5, 3, 'In Like Flint', '352933697-1', '11/8/2023', 1, 'http://dummyimage.com/208x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 4, 9, 'Star Wars: Episode II - Attack of the Clones', '715295981-1', '2/12/2024', 1, 'http://dummyimage.com/223x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 9, 'Life is a Miracle (Zivot je cudo)', '533925823-8', '1/25/2024', 1, 'http://dummyimage.com/241x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 4, 6, 'Phantom Tollbooth, The', '275517883-3', '5/26/2023', 1, 'http://dummyimage.com/120x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 6, 7, 'Special Correspondents (Envoyés très spéciaux)', '147892950-2', '9/12/2022', 1, 'http://dummyimage.com/176x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 7, 9, 'Daddy (Tato)', '101044783-1', '10/31/2024', 1, 'http://dummyimage.com/195x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 6, 5, 'Six Shooter', '887291918-5', '8/30/2022', 1, 'http://dummyimage.com/119x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 9, 'Christmas on Mars', '809327782-X', '12/31/2022', 1, 'http://dummyimage.com/216x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 3, 'Child, The', '138219767-5', '10/12/2022', 1, 'http://dummyimage.com/197x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 1, 4, 'Curse, The (a.k.a. The Farm)', '049201431-0', '9/5/2023', 1, 'http://dummyimage.com/247x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 3, 'Losing Isaiah', '405395932-2', '7/13/2022', 1, 'http://dummyimage.com/197x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 8, 'American Winter', '376079780-6', '2/24/2023', 1, 'http://dummyimage.com/199x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 3, 1, 'Choose Me', '300598828-7', '12/5/2023', 1, 'http://dummyimage.com/235x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 6, 'Whirlygirl', '508541893-X', '11/20/2022', 1, 'http://dummyimage.com/137x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 3, 'What''s Up, Doc?', '690877404-X', '7/24/2022', 1, 'http://dummyimage.com/231x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 3, 8, 'This Is My Life', '382009153-X', '3/12/2024', 1, 'http://dummyimage.com/226x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 6, 8, 'Stardust', '383226005-6', '7/19/2022', 1, 'http://dummyimage.com/207x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 1, 1, 'Judith of Bethulia', '665971563-0', '8/13/2023', 1, 'http://dummyimage.com/183x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 3, 'Prinsessa (Starring Maja)', '367865296-4', '3/15/2023', 1, 'http://dummyimage.com/183x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 3, 3, 'These Final Hours', '924788376-8', '9/12/2022', 1, 'http://dummyimage.com/249x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 7, 'Blue Vinyl', '462820224-9', '2/23/2023', 1, 'http://dummyimage.com/159x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 1, 'The Old Gun', '308012896-6', '5/17/2023', 1, 'http://dummyimage.com/106x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 1, 'A Thousand Times Goodnight', '734040702-2', '4/15/2024', 1, 'http://dummyimage.com/247x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 7, 1, 'Winds of the Wasteland', '555032266-8', '10/7/2022', 1, 'http://dummyimage.com/203x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 2, 'Flight of the Intruder', '032984336-2', '11/19/2024', 1, 'http://dummyimage.com/237x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 6, 'Howl', '199958342-6', '4/12/2024', 1, 'http://dummyimage.com/223x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 7, 5, 'Skin', '291674694-3', '1/20/2023', 1, 'http://dummyimage.com/125x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 5, 'Kind Lady', '609954872-6', '7/15/2024', 1, 'http://dummyimage.com/162x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 7, 3, 'Invisible Woman, The', '758955595-9', '11/3/2024', 1, 'http://dummyimage.com/103x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 9, 'Three and Out (Deal Is a Deal, A)', '082226732-2', '9/24/2022', 1, 'http://dummyimage.com/119x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 2, 'Go Fish', '917623355-3', '1/17/2023', 1, 'http://dummyimage.com/205x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 5, 'Care Bears Movie, The', '332152747-2', '11/29/2023', 1, 'http://dummyimage.com/195x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 8, 'Man Escaped, A (Un  condamné à mort s''est échappé ou Le vent souffle où il veut)', '843419009-5', '3/23/2024', 1, 'http://dummyimage.com/232x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 3, 'Breaking and Entering', '636735210-4', '2/6/2023', 1, 'http://dummyimage.com/152x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 1, 'Lost Embrace (Abrazo partido, El)', '453453651-8', '11/15/2023', 1, 'http://dummyimage.com/193x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 7, 5, 'Code, The', '875296697-6', '10/12/2022', 1, 'http://dummyimage.com/246x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 6, 'Herbie: Fully Loaded', '983506552-7', '8/25/2023', 1, 'http://dummyimage.com/116x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 2, 1, 'Mike''s New Car', '552164943-3', '6/16/2024', 1, 'http://dummyimage.com/144x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 7, 2, 'Librarian: Return to King Solomon''s Mines, The', '747902834-2', '10/25/2023', 1, 'http://dummyimage.com/117x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 5, 'Martín (Hache)', '361192143-2', '11/5/2023', 1, 'http://dummyimage.com/120x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 6, 3, 'Street Kings', '407748481-2', '12/5/2023', 1, 'http://dummyimage.com/193x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 4, 'Permanent Vacation', '229248287-8', '2/5/2023', 1, 'http://dummyimage.com/106x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 1, 'Beatdown', '912716495-0', '7/13/2024', 1, 'http://dummyimage.com/242x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 7, 'Klute', '232559513-7', '8/19/2024', 1, 'http://dummyimage.com/123x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 1, 'Tie Xi Qu: West of the Tracks (Tiexi qu)', '951888489-7', '7/14/2022', 1, 'http://dummyimage.com/151x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 5, 'Yacoubian Building, The (Omaret yakobean)', '311898391-4', '4/24/2023', 1, 'http://dummyimage.com/123x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 8, 'Renoir', '097444114-7', '5/12/2023', 1, 'http://dummyimage.com/169x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 1, 'Gemini (Sôseiji)', '176985168-2', '11/24/2022', 1, 'http://dummyimage.com/203x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 3, 1, 'Stella Does Tricks', '147093807-3', '8/12/2023', 1, 'http://dummyimage.com/161x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 5, 'Hatchet for the Honeymoon (Rosso segno della follia, Il)', '362535854-9', '3/28/2023', 1, 'http://dummyimage.com/156x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 1, 3, 'Six Days', '338212689-3', '1/4/2023', 1, 'http://dummyimage.com/244x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 6, 'Busting', '753817185-1', '3/30/2023', 1, 'http://dummyimage.com/170x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 1, 6, 'Smokin'' Aces', '984008488-7', '6/23/2023', 1, 'http://dummyimage.com/200x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 3, 8, 'Story of My Life, The (Mensonges et trahisons et plus si affinités...)', '286012027-0', '1/24/2023', 1, 'http://dummyimage.com/142x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 3, 'Eat Pray Love', '543145132-4', '8/1/2022', 1, 'http://dummyimage.com/241x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 7, 6, 'Best Years of Our Lives, The', '374513856-2', '5/25/2023', 1, 'http://dummyimage.com/200x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 3, 3, 'National Theatre Live: Frankenstein', '976710122-5', '4/27/2023', 1, 'http://dummyimage.com/117x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 4, 2, 'Little Nicky', '394103086-8', '7/3/2023', 1, 'http://dummyimage.com/103x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 7, 'Man for All Seasons, A', '501859321-0', '11/9/2024', 1, 'http://dummyimage.com/167x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 6, 8, 'General''s Daughter, The', '827553269-8', '8/28/2023', 1, 'http://dummyimage.com/204x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 4, 3, 'Hustle', '936672129-X', '5/15/2023', 1, 'http://dummyimage.com/179x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 7, 'Institute, The', '719249169-1', '10/12/2024', 1, 'http://dummyimage.com/177x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 1, 3, 'Last Stop for Paul', '844728109-4', '9/21/2023', 1, 'http://dummyimage.com/120x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 7, 8, 'Architect, The', '918244638-5', '2/3/2024', 1, 'http://dummyimage.com/214x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 7, 7, 'Many Adventures of Winnie the Pooh, The', '645139042-9', '6/26/2024', 1, 'http://dummyimage.com/178x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 7, 8, 'Flaming Creatures', '566442186-X', '1/16/2023', 1, 'http://dummyimage.com/115x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 5, 'Mondo Topless', '308519492-4', '9/6/2022', 1, 'http://dummyimage.com/244x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 7, 9, 'Zachariah', '849802060-3', '12/30/2022', 1, 'http://dummyimage.com/125x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 3, 1, 'Fat Girl (À ma soeur!)', '337511283-1', '3/18/2023', 1, 'http://dummyimage.com/241x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 7, 'Erin Brockovich', '860713672-0', '12/8/2023', 1, 'http://dummyimage.com/221x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 7, 3, 'Firelight', '392774850-1', '9/2/2023', 1, 'http://dummyimage.com/123x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 1, 'Fighting Prince of Donegal, The', '891817633-3', '8/22/2023', 1, 'http://dummyimage.com/113x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 3, 7, 'Chambermaid on the Titanic, The (Femme de chambre du Titanic, La)', '083653835-8', '10/12/2024', 1, 'http://dummyimage.com/145x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 7, 8, 'Hannie Caulder', '206626708-2', '8/2/2024', 1, 'http://dummyimage.com/233x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 6, 9, 'Trailer Park Boys: Don''t Legalize It', '271218373-8', '8/12/2022', 1, 'http://dummyimage.com/225x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 7, 6, 'Happy Time, The', '468516731-7', '4/3/2023', 1, 'http://dummyimage.com/247x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 7, 3, 'Chelsea Girls', '298782684-2', '9/2/2023', 1, 'http://dummyimage.com/175x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 6, 9, '40 Pounds of Trouble', '561860607-0', '10/18/2022', 1, 'http://dummyimage.com/100x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 7, 'By the People: The Election of Barack Obama', '108255815-X', '7/15/2023', 1, 'http://dummyimage.com/169x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 1, 9, 'Black Magic Rites & the Secret Orgies of the 14th Century (Riti, magie nere e segrete orge nel trecento...)', '102896573-7', '10/26/2024', 1, 'http://dummyimage.com/188x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 6, 'Scorpion King 3: Battle for Redemption, The', '970316681-4', '1/24/2024', 1, 'http://dummyimage.com/222x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 2, 'Wicker Man, The', '994799574-7', '9/2/2024', 1, 'http://dummyimage.com/137x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 5, 'Mr. Blandings Builds His Dream House', '779959235-4', '6/28/2023', 1, 'http://dummyimage.com/167x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 3, 6, 'Fire', '430807825-3', '12/8/2023', 1, 'http://dummyimage.com/244x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 5, 'Pépé le Moko', '820257706-3', '12/29/2023', 1, 'http://dummyimage.com/115x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 9, 'Odds, The', '904266157-7', '10/1/2022', 1, 'http://dummyimage.com/113x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 2, 9, 'Timecrimes (Cronocrímenes, Los)', '953241246-8', '11/27/2023', 1, 'http://dummyimage.com/140x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 3, 4, 'Goebbels Experiment, The (Das Goebbels Experiment)', '046946464-X', '7/20/2023', 1, 'http://dummyimage.com/146x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 5, 'Wrong Box, The', '402187655-3', '10/28/2023', 1, 'http://dummyimage.com/145x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 1, 'All Night Long', '848981914-9', '3/11/2024', 1, 'http://dummyimage.com/215x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 6, 'Amber Lake ', '413050643-9', '11/15/2024', 1, 'http://dummyimage.com/123x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 9, 'Double Or Nothing', '272066751-X', '2/12/2023', 1, 'http://dummyimage.com/182x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 7, 'Zeitgeist: Addendum', '662213463-4', '10/7/2023', 1, 'http://dummyimage.com/222x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 3, 'Ice Castles', '700510268-1', '7/19/2024', 1, 'http://dummyimage.com/157x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 7, 'The Pokrovsky Gates', '818953429-7', '7/19/2022', 1, 'http://dummyimage.com/215x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 6, 6, 'Enron: The Smartest Guys in the Room', '649573306-2', '8/26/2023', 1, 'http://dummyimage.com/180x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 5, 'Satan Bug, The', '714623584-X', '4/2/2023', 1, 'http://dummyimage.com/206x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 8, 'Allotment Wives', '677839481-1', '5/10/2023', 1, 'http://dummyimage.com/169x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 2, 9, 'Harrison''s Flowers', '652953529-2', '7/14/2022', 1, 'http://dummyimage.com/129x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 1, 'Football Factory, The', '154362145-7', '1/30/2023', 1, 'http://dummyimage.com/217x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 7, 7, 'Bestiaire', '680621758-3', '4/23/2024', 1, 'http://dummyimage.com/146x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 4, 'Men in Black II (a.k.a. MIIB) (a.k.a. MIB 2)', '970581187-3', '8/4/2022', 1, 'http://dummyimage.com/207x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 7, 3, 'Alice and Martin (Alice et Martin)', '000425953-X', '5/25/2023', 1, 'http://dummyimage.com/176x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 3, 3, 'Hamlet, Prince of Denmark', '667990006-9', '12/21/2022', 1, 'http://dummyimage.com/246x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 7, 7, 'Student of the Year', '447032729-8', '4/26/2024', 1, 'http://dummyimage.com/250x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 8, 'Snows of Kilimanjaro, The', '462072990-6', '2/7/2024', 1, 'http://dummyimage.com/161x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 1, 6, 'Star Chamber, The', '916368702-X', '7/6/2024', 1, 'http://dummyimage.com/199x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 9, 'Skipped Parts', '573139205-6', '1/16/2023', 1, 'http://dummyimage.com/201x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 1, 3, 'Tabu', '012447790-9', '7/25/2022', 1, 'http://dummyimage.com/215x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 9, 'Lost in La Mancha', '933524988-2', '7/6/2022', 1, 'http://dummyimage.com/194x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 1, 'Thief of Hearts', '463935335-9', '8/2/2023', 1, 'http://dummyimage.com/178x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 4, 'Jack Ryan: Shadow Recruit', '265962221-3', '11/23/2022', 1, 'http://dummyimage.com/134x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 3, 5, 'Shaolin Soccer (Siu lam juk kau)', '988361971-5', '9/16/2022', 1, 'http://dummyimage.com/165x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 6, 'Escape to Athena', '790007806-1', '7/15/2023', 1, 'http://dummyimage.com/192x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 8, 'Nicholas and Alexandra', '194669113-5', '6/23/2024', 1, 'http://dummyimage.com/249x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 7, 'Frozen Ghost, The', '324960523-9', '11/22/2022', 1, 'http://dummyimage.com/165x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 4, 'Chronicle of a Summer (Chronique d''un été)', '495610662-9', '11/14/2024', 1, 'http://dummyimage.com/127x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 4, 'Juarez', '997100304-X', '5/8/2024', 1, 'http://dummyimage.com/190x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 4, 'Save the Last Dance 2', '191438758-9', '10/19/2023', 1, 'http://dummyimage.com/118x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 8, 'Krabat', '911924966-7', '3/15/2023', 1, 'http://dummyimage.com/187x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 6, 5, 'Four Seasons, The', '843583845-5', '6/11/2023', 1, 'http://dummyimage.com/156x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 2, 'Love and Bullets', '041046683-2', '11/26/2023', 1, 'http://dummyimage.com/228x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 3, 6, 'False as Water (Falsk som vatten)', '773676728-9', '5/31/2024', 1, 'http://dummyimage.com/215x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 6, 9, 'Murder, He Says', '868359033-X', '11/17/2022', 1, 'http://dummyimage.com/183x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 3, 7, 'Pit, the Pendulum and Hope, The (Kyvadlo, jáma a nadeje)', '287106658-2', '9/1/2024', 1, 'http://dummyimage.com/115x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 2, 9, 'Big Bang Theory, The (2007-)', '792523081-9', '4/18/2024', 1, 'http://dummyimage.com/136x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 4, 'United States of Leland, The', '433463265-3', '6/18/2023', 1, 'http://dummyimage.com/106x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 1, 'Bulldog Drummond Escapes', '780986823-3', '4/20/2023', 1, 'http://dummyimage.com/165x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 9, 'Foreign Affair, A', '384063326-5', '10/22/2023', 1, 'http://dummyimage.com/248x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 5, 'You Can''t Take It with You', '671320041-9', '8/21/2023', 1, 'http://dummyimage.com/218x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 1, 'Breakfast with Scot', '362977978-6', '4/27/2023', 1, 'http://dummyimage.com/156x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 2, 5, 'Wieners', '477005079-8', '6/27/2023', 1, 'http://dummyimage.com/222x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 7, 1, 'Ten Skies', '325299456-9', '4/21/2023', 1, 'http://dummyimage.com/247x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 3, 3, 'Foul King, The (Banchikwang)', '447343292-0', '4/4/2024', 1, 'http://dummyimage.com/181x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 7, 6, 'Me, Myself and Mum (Les garçons et Guillaume, à table!)', '124770942-6', '12/29/2023', 1, 'http://dummyimage.com/121x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 4, 8, 'Room Service', '745411072-X', '1/9/2024', 1, 'http://dummyimage.com/202x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 7, 5, 'Darkest Night', '712357158-4', '9/8/2024', 1, 'http://dummyimage.com/172x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 2, 'Kelly''s Heroes', '101704966-1', '9/23/2022', 1, 'http://dummyimage.com/182x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 2, 7, 'Dead End', '035942100-8', '7/24/2023', 1, 'http://dummyimage.com/211x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 8, 'From the Life of the Marionettes (Aus dem Leben der Marionetten) ', '710954186-X', '9/9/2023', 1, 'http://dummyimage.com/130x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 8, 'Day in the Life, A', '215656462-0', '8/16/2024', 1, 'http://dummyimage.com/146x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 7, 1, 'Night in Casablanca, A', '355788014-1', '7/9/2023', 1, 'http://dummyimage.com/126x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 1, 6, 'Zombieland', '473957154-4', '7/21/2023', 1, 'http://dummyimage.com/187x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 6, 'Circle of Deception, A', '245488847-5', '9/24/2024', 1, 'http://dummyimage.com/126x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 2, 'G', '918760163-X', '10/30/2023', 1, 'http://dummyimage.com/125x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 1, 'Kid & I, The', '058258883-9', '7/12/2023', 1, 'http://dummyimage.com/193x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 2, 8, 'Man Who Quit Smoking, The (Mannen som slutade röka)', '280539176-4', '7/9/2022', 1, 'http://dummyimage.com/155x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 8, 'Without Warning (a.k.a. Alien Warning) (a.k.a. It Came Without Warning)', '867531090-0', '7/7/2022', 1, 'http://dummyimage.com/232x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 5, 8, 'Coraline', '255285082-0', '4/26/2023', 1, 'http://dummyimage.com/191x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 7, 'Castle, The', '134607850-5', '9/24/2022', 1, 'http://dummyimage.com/244x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 6, 9, 'How the Myth Was Made: A Study of Robert Flaherty''s Man of Aran', '181562385-3', '10/8/2022', 1, 'http://dummyimage.com/191x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 6, 1, 'Daniel Deronda', '165033136-3', '10/13/2024', 1, 'http://dummyimage.com/165x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 6, 'Solyaris', '938191696-9', '12/21/2023', 1, 'http://dummyimage.com/118x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 7, 4, 'Little Otik (Otesánek)', '710032459-9', '12/29/2022', 1, 'http://dummyimage.com/186x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 3, 'Dam Busters, The', '672223090-2', '5/6/2024', 1, 'http://dummyimage.com/159x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 4, 'Awful Truth, The', '269290155-X', '12/10/2022', 1, 'http://dummyimage.com/156x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 5, 'Paramore Live, the Final Riot!', '316493818-7', '9/21/2022', 1, 'http://dummyimage.com/182x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 4, 'Waiting for Happiness (Heremakono)', '925296253-0', '10/24/2022', 1, 'http://dummyimage.com/102x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 3, 'King Ralph', '184216488-0', '1/30/2024', 1, 'http://dummyimage.com/211x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 9, 'Enchanted', '657061555-6', '1/29/2024', 1, 'http://dummyimage.com/161x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 3, 'Making a Killing: The Untold Story of Psychotropic Drugging', '418126927-2', '3/4/2023', 1, 'http://dummyimage.com/238x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 6, 'Dark Eyes (Oci ciornie)', '226577208-9', '7/27/2024', 1, 'http://dummyimage.com/165x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 1, 8, 'Neighbors', '624644499-7', '7/2/2024', 1, 'http://dummyimage.com/224x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 5, 'Generation P', '188441892-9', '5/28/2024', 1, 'http://dummyimage.com/239x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 1, 2, 'Sorry, Haters', '990256062-8', '3/25/2024', 1, 'http://dummyimage.com/213x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 7, 'Honey Moon (Honigmond)', '053105049-1', '11/14/2023', 1, 'http://dummyimage.com/185x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 4, 1, 'Back Stage', '171481957-4', '8/14/2023', 1, 'http://dummyimage.com/192x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 7, 6, 'Three Fugitives', '362945733-9', '6/7/2023', 1, 'http://dummyimage.com/227x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 7, 8, 'Simple Men', '150321640-3', '10/7/2024', 1, 'http://dummyimage.com/112x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 6, 7, 'The Amazing Spider-Man 2', '019908858-6', '8/3/2024', 1, 'http://dummyimage.com/200x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 5, 'Attack of the 50 Ft. Woman', '302871447-7', '1/1/2024', 1, 'http://dummyimage.com/167x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 4, 'What''s Love Got to Do with It?', '869177200-X', '2/16/2023', 1, 'http://dummyimage.com/125x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 7, 2, 'Last Metro, The (Dernier métro, Le)', '329297653-7', '11/24/2023', 1, 'http://dummyimage.com/179x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 8, 'Perestroika', '029375937-5', '8/7/2024', 1, 'http://dummyimage.com/120x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 7, 6, 'Beijing Bicycle (Shiqi sui de dan che)', '425713878-5', '7/11/2024', 1, 'http://dummyimage.com/234x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 4, 'Citizenfour', '304491413-2', '3/26/2024', 1, 'http://dummyimage.com/225x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 2, 'Poolboy: Drowning Out the Fury', '414121077-3', '5/9/2024', 1, 'http://dummyimage.com/193x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 4, 7, 'Look of Love, The', '556702694-3', '10/30/2023', 1, 'http://dummyimage.com/140x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 2, 'Ice Storm, The', '699463077-3', '10/21/2023', 1, 'http://dummyimage.com/144x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 4, 6, 'Faust', '033843851-3', '3/30/2023', 1, 'http://dummyimage.com/167x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 4, 9, 'Drei Stunden', '484411810-2', '5/20/2023', 1, 'http://dummyimage.com/111x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 6, 6, 'Tales from the Darkside: The Movie', '848403447-X', '12/5/2023', 1, 'http://dummyimage.com/104x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 3, 2, 'Flesh and Blood', '275686927-9', '6/22/2024', 1, 'http://dummyimage.com/199x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 5, 'I Melt with You', '686378146-8', '8/17/2024', 1, 'http://dummyimage.com/215x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 3, 3, '13B', '173542913-9', '4/23/2024', 1, 'http://dummyimage.com/126x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 6, 5, 'Desert Rats, The', '199629364-8', '5/25/2023', 1, 'http://dummyimage.com/153x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 2, 'Agony and the Ecstasy of Phil Spector, The', '819468600-8', '3/10/2023', 1, 'http://dummyimage.com/177x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 6, 'Listen Up Philip', '575527479-7', '7/28/2023', 1, 'http://dummyimage.com/210x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 2, 'Thousand Cuts, A', '054606914-2', '6/13/2023', 1, 'http://dummyimage.com/241x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 1, 1, 'Numb', '982093553-9', '6/6/2023', 1, 'http://dummyimage.com/186x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 2, 'Crimi Clowns: De Movie', '420586445-0', '9/23/2023', 1, 'http://dummyimage.com/231x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 4, 'Mysterious Island', '592976133-7', '9/8/2023', 1, 'http://dummyimage.com/168x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 3, 'Classic, The (Klassikko)', '093165738-5', '9/13/2024', 1, 'http://dummyimage.com/201x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 7, 'Christmas Memory, A (Truman Capote''s ''A Christmas Memory'')', '670547721-0', '11/25/2022', 1, 'http://dummyimage.com/134x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 3, 5, 'Trailer Park Boys', '473810998-7', '7/29/2024', 1, 'http://dummyimage.com/208x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 5, 4, 'A Cry in the Wild', '060924237-7', '7/1/2023', 1, 'http://dummyimage.com/161x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 4, 'Mr. Warmth: The Don Rickles Project', '178561712-5', '2/5/2023', 1, 'http://dummyimage.com/250x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 3, 'Don''t Tell Mom the Babysitter''s Dead', '822079121-7', '9/3/2024', 1, 'http://dummyimage.com/171x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 7, 4, 'The Story of Robin Hood and His Merrie Men', '817202678-1', '1/27/2023', 1, 'http://dummyimage.com/107x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 3, 3, 'Lucrèce Borgia', '060016163-3', '11/4/2022', 1, 'http://dummyimage.com/180x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 8, 'Trash', '545081279-5', '12/19/2022', 1, 'http://dummyimage.com/209x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 7, 'The Fuller Brush Girl', '838659854-9', '11/17/2024', 1, 'http://dummyimage.com/214x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 5, 'Tombstone', '555660532-7', '8/17/2023', 1, 'http://dummyimage.com/104x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 5, 'Scar', '225405698-0', '8/29/2024', 1, 'http://dummyimage.com/135x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 1, 'Nicht mein Tag', '708827312-8', '4/1/2023', 1, 'http://dummyimage.com/236x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 9, 'Trespasser, The', '778221010-0', '7/13/2023', 1, 'http://dummyimage.com/112x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 7, 'Blue Max, The', '028914739-5', '3/12/2024', 1, 'http://dummyimage.com/173x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 5, 'Stranger Than Paradise', '666008767-2', '10/17/2023', 1, 'http://dummyimage.com/185x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 9, 'Naturally Native', '240229566-X', '7/15/2024', 1, 'http://dummyimage.com/101x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 1, 4, 'Red Rock West', '236984189-3', '10/4/2022', 1, 'http://dummyimage.com/115x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 5, 2, '2010: The Year We Make Contact', '182301537-9', '9/6/2024', 1, 'http://dummyimage.com/210x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 7, 'Ticking Clock', '882448300-3', '11/16/2022', 1, 'http://dummyimage.com/132x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 4, 2, 'Mimic', '043747338-4', '7/1/2023', 1, 'http://dummyimage.com/208x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 4, 'The Story of Alexander Graham Bell', '250864271-1', '8/18/2022', 1, 'http://dummyimage.com/174x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 6, 'Bohème, La', '907846666-9', '11/2/2022', 1, 'http://dummyimage.com/245x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 8, 'Bright Young Things', '609152258-2', '6/3/2024', 1, 'http://dummyimage.com/126x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 3, 1, 'Thrilla in Manila', '948300792-5', '2/17/2024', 1, 'http://dummyimage.com/207x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 5, 'Killer Bean 2: The Party', '563012496-X', '8/20/2024', 1, 'http://dummyimage.com/189x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 7, 4, 'Swing Time', '557320524-2', '12/4/2023', 1, 'http://dummyimage.com/150x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 3, 'Holiday Wishes', '837771220-2', '8/7/2023', 1, 'http://dummyimage.com/224x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 3, 3, 'Assault on a Queen', '681517856-0', '2/27/2024', 1, 'http://dummyimage.com/121x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 7, 'Tyson', '240842562-X', '5/10/2024', 1, 'http://dummyimage.com/224x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 3, 6, 'Introduction to Physics, An', '533551355-1', '8/26/2022', 1, 'http://dummyimage.com/118x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 7, 4, 'The Last Gladiators', '089280560-9', '3/11/2023', 1, 'http://dummyimage.com/203x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 5, 'Black Hawk Down', '856808924-0', '2/18/2023', 1, 'http://dummyimage.com/177x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 8, 'To Be or Not to Be', '078163743-0', '1/7/2023', 1, 'http://dummyimage.com/230x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 7, 6, 'Arcana', '130262150-5', '6/13/2024', 1, 'http://dummyimage.com/239x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 6, 'Penthouse', '857135051-5', '8/9/2024', 1, 'http://dummyimage.com/211x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 6, 'Little Fauss and Big Halsy', '605426288-2', '9/12/2022', 1, 'http://dummyimage.com/174x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 4, 6, 'Producers, The', '936936515-X', '7/5/2023', 1, 'http://dummyimage.com/159x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 4, 7, 'In the Midst of Life (Au coeur de la vie)', '413963140-6', '2/22/2024', 1, 'http://dummyimage.com/124x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 7, 'Battery, The', '183217632-0', '6/28/2024', 1, 'http://dummyimage.com/103x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 2, 'Cialo', '183124490-X', '3/28/2023', 1, 'http://dummyimage.com/179x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 4, 'Super Mario Bros.', '286909511-2', '2/20/2023', 1, 'http://dummyimage.com/180x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 7, 5, 'Knockout', '826543858-3', '2/12/2024', 1, 'http://dummyimage.com/173x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 1, 8, 'Under Fire', '186494177-4', '3/21/2024', 1, 'http://dummyimage.com/151x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 6, 4, 'Medea', '667775622-X', '6/20/2024', 1, 'http://dummyimage.com/132x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 9, 'Henry Kissinger: Secrets of a Superpower (Henry Kissinger - Geheimnisse einer Supermacht)', '123503302-3', '5/16/2023', 1, 'http://dummyimage.com/102x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 4, 4, 'Lackawanna Blues', '239685493-3', '4/25/2023', 1, 'http://dummyimage.com/194x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 7, 8, 'Tales from the Crypt Presents: Bordello of Blood', '642957319-2', '1/8/2023', 1, 'http://dummyimage.com/242x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 6, 9, 'Mad Love', '337251566-8', '11/27/2022', 1, 'http://dummyimage.com/214x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 6, 'Italian Job, The', '082657795-4', '8/6/2023', 1, 'http://dummyimage.com/195x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 1, 9, '21 and Over', '564878183-0', '12/31/2023', 1, 'http://dummyimage.com/144x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 9, 'Jack and the Cuckoo-Clock Heart (Jack et la mécanique du coeur)', '541110404-1', '8/25/2024', 1, 'http://dummyimage.com/159x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 8, 'Satan Never Sleeps', '586494895-0', '2/16/2023', 1, 'http://dummyimage.com/118x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 8, 'Curse of the Pink Panther', '287590723-9', '12/6/2023', 1, 'http://dummyimage.com/152x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 5, 'Who''s Singin'' Over There? (a.k.a. Who Sings Over There) (Ko to tamo peva)', '872984407-X', '9/29/2024', 1, 'http://dummyimage.com/140x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 5, 'Screaming Skull, The', '379133429-8', '11/15/2023', 1, 'http://dummyimage.com/209x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 1, 'Keep Walking (Camminacammina)', '262822140-3', '10/27/2022', 1, 'http://dummyimage.com/188x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 5, 3, 'Making ''Do the Right Thing''', '913534527-6', '8/6/2024', 1, 'http://dummyimage.com/135x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 8, 'Love Story', '327791787-8', '10/3/2022', 1, 'http://dummyimage.com/176x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 7, 'Mile... Mile & a Half', '324012636-2', '8/10/2023', 1, 'http://dummyimage.com/149x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 7, 'Confessions of an Opium Eater', '973122161-1', '5/17/2024', 1, 'http://dummyimage.com/224x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 7, 5, 'Cast a Giant Shadow', '681497740-0', '11/26/2022', 1, 'http://dummyimage.com/185x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 7, 8, 'Lord of the Rings: The Return of the King, The', '317304832-6', '9/6/2023', 1, 'http://dummyimage.com/166x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 7, 'All the King''s Men', '693190352-7', '6/23/2024', 1, 'http://dummyimage.com/206x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 9, 'American Raspberry (Prime Time) (Funny America)', '791263049-X', '12/16/2023', 1, 'http://dummyimage.com/204x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 3, 'Tokyo Gore Police (Tôkyô zankoku keisatsu)', '755297919-4', '7/4/2023', 1, 'http://dummyimage.com/114x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 6, 'Delusions of Grandeur (La folie des grandeurs)', '581265859-5', '5/11/2024', 1, 'http://dummyimage.com/186x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 4, 5, 'Jonah Who Will Be 25 in the Year 2000 (Jonas qui aura 25 ans en l''an 2000)', '802320880-2', '3/26/2023', 1, 'http://dummyimage.com/242x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 3, 9, 'The Intruders', '348265769-6', '10/29/2023', 1, 'http://dummyimage.com/226x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 9, 'Countdown to Looking Glass', '653227967-6', '9/15/2023', 1, 'http://dummyimage.com/120x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 1, 'The Count of Monte Cristo', '225676335-8', '11/18/2024', 1, 'http://dummyimage.com/241x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 6, 'Godzilla vs. Destroyah (Gojira vs. Desutoroiâ) ', '156163020-9', '12/19/2022', 1, 'http://dummyimage.com/174x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 7, 3, 'Dangerous Ground', '592410523-7', '5/12/2023', 1, 'http://dummyimage.com/201x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 7, 'Flight', '460989915-9', '11/14/2023', 1, 'http://dummyimage.com/136x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 1, 'Electric House, The', '196852913-6', '9/24/2022', 1, 'http://dummyimage.com/198x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 9, 'Zero Motivation (Efes beyahasei enosh)', '222026522-6', '1/10/2023', 1, 'http://dummyimage.com/122x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 2, 3, 'Private War of Major Benson, The', '314380359-2', '5/26/2024', 1, 'http://dummyimage.com/210x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 2, 2, 'La Legge Violenta Della Squadra Anticrimine', '526940110-X', '11/30/2023', 1, 'http://dummyimage.com/152x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 3, 'All This, and Heaven Too', '150106303-0', '7/10/2023', 1, 'http://dummyimage.com/245x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 4, 5, 'High School Confidential!', '109761817-X', '7/14/2022', 1, 'http://dummyimage.com/111x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 1, 'Manny', '623953514-1', '10/7/2024', 1, 'http://dummyimage.com/184x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 1, 'Get Rich or Die Tryin''', '096232545-7', '2/8/2024', 1, 'http://dummyimage.com/154x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 4, 'I, Monster', '477992945-8', '4/11/2023', 1, 'http://dummyimage.com/156x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 5, 8, 'Making the Earth Stand Still', '716482400-2', '11/20/2022', 1, 'http://dummyimage.com/156x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 2, 7, '(Absolutions) Pipilotti''s Mistakes ((Entlastungen) Pipilottis Fehler)', '711986775-X', '12/11/2023', 1, 'http://dummyimage.com/166x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 4, 7, 'Rude Boy', '341201491-5', '4/17/2023', 1, 'http://dummyimage.com/151x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 1, 8, 'Mayerling', '247103709-7', '3/12/2024', 1, 'http://dummyimage.com/223x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 7, 6, 'Bottle Rocket', '255881872-4', '4/8/2024', 1, 'http://dummyimage.com/136x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 5, 'Ferngully: The Last Rainforest', '931430896-0', '3/22/2023', 1, 'http://dummyimage.com/135x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 6, 5, 'Scribbler, The', '316960089-3', '12/24/2022', 1, 'http://dummyimage.com/235x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 1, 2, 'Welcome to the Jungle', '279235516-6', '2/4/2024', 1, 'http://dummyimage.com/171x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 1, 'Sexmission (Seksmisja)', '118412650-X', '10/30/2023', 1, 'http://dummyimage.com/135x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 7, 8, 'The Great Northfield Minnesota Raid', '201827198-9', '5/27/2024', 1, 'http://dummyimage.com/202x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 9, 'Until the Light Takes Us', '936445134-1', '5/31/2023', 1, 'http://dummyimage.com/234x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 2, 5, 'Today You Die', '834888646-X', '10/4/2023', 1, 'http://dummyimage.com/143x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 6, 'Mambo Italiano', '632539431-3', '10/28/2023', 1, 'http://dummyimage.com/168x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 7, 'Shadow Kill', '390368754-5', '4/20/2023', 1, 'http://dummyimage.com/201x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 3, 7, 'Changeling', '683612122-3', '11/24/2023', 1, 'http://dummyimage.com/144x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 4, 7, 'Hamlet (Gamlet)', '893988390-X', '5/22/2023', 1, 'http://dummyimage.com/242x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 7, 4, 'Nothing But the Night', '306401734-9', '7/31/2022', 1, 'http://dummyimage.com/131x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 7, 2, 'Killer at Large', '037011436-1', '3/14/2024', 1, 'http://dummyimage.com/127x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 1, 7, 'Keys of the Kingdom, The', '654370724-0', '4/9/2023', 1, 'http://dummyimage.com/146x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 9, 'To the Shores of Tripoli', '598688089-7', '3/29/2023', 1, 'http://dummyimage.com/163x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 7, 6, 'Rent: Filmed Live on Broadway', '801225269-4', '3/30/2024', 1, 'http://dummyimage.com/220x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 1, 5, 'Messenger of Death', '625689362-X', '1/20/2024', 1, 'http://dummyimage.com/127x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 9, 'Time and Tide (Seunlau Ngaklau)', '693623665-0', '7/6/2024', 1, 'http://dummyimage.com/192x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 7, 9, 'Zatoichi on the Road (Zatôichi kenka-tabi) (Zatôichi 5)', '200318032-X', '12/1/2023', 1, 'http://dummyimage.com/132x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 7, 'Bachelor Night', '954706510-6', '11/27/2023', 1, 'http://dummyimage.com/232x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 2, 'Training Day', '523618643-9', '4/2/2024', 1, 'http://dummyimage.com/223x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 7, 'Faith School Menace?', '391054255-7', '12/13/2022', 1, 'http://dummyimage.com/166x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 5, 'Spring in a Small Town (Xiao cheng zhi chun)', '482151849-X', '6/18/2024', 1, 'http://dummyimage.com/103x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 8, 'Paradox', '487637562-3', '12/12/2023', 1, 'http://dummyimage.com/155x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 8, 'Black Peter (Cerný Petr)', '360041446-1', '8/5/2022', 1, 'http://dummyimage.com/116x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 8, 'Advantageous', '707961143-1', '1/4/2024', 1, 'http://dummyimage.com/164x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 4, 4, 'Hellfighters', '907081890-6', '2/3/2023', 1, 'http://dummyimage.com/132x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 3, 4, 'Home on the Range', '533125161-7', '6/22/2023', 1, 'http://dummyimage.com/129x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 2, '2 Fast 2 Furious (Fast and the Furious 2, The)', '367344447-6', '2/16/2024', 1, 'http://dummyimage.com/179x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 7, 5, 'Designing Woman', '322978013-2', '9/5/2022', 1, 'http://dummyimage.com/141x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 6, 3, 'Winter Kills', '674724378-1', '6/27/2023', 1, 'http://dummyimage.com/228x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 7, 5, 'Friends, The (Les Amis)', '368403934-9', '2/6/2023', 1, 'http://dummyimage.com/199x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 5, 'Sandra of a Thousand Delights (Vaghe stelle dell''Orsa...)', '949466632-1', '11/1/2024', 1, 'http://dummyimage.com/178x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 7, 2, 'Ex Drummer', '665315023-2', '8/30/2022', 1, 'http://dummyimage.com/108x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 6, 9, 'On Earth as It Is in Heaven (Así en el cielo como en la tierra)', '173234474-4', '5/26/2024', 1, 'http://dummyimage.com/162x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 8, 'Friends with Kids', '558694977-6', '1/25/2024', 1, 'http://dummyimage.com/150x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 7, 5, 'Wind', '767343534-9', '5/14/2023', 1, 'http://dummyimage.com/106x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 4, 'You Only Live Twice', '545185804-7', '5/6/2023', 1, 'http://dummyimage.com/137x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 6, 7, 'Tinseltown', '222877225-9', '12/12/2022', 1, 'http://dummyimage.com/115x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 9, 'Antoine and Colette (Antoine et Colette)', '075488006-0', '10/2/2023', 1, 'http://dummyimage.com/221x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 2, 'Return of Jafar, The', '820403234-X', '2/7/2023', 1, 'http://dummyimage.com/248x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 2, 'Steal This Film II', '386137079-4', '4/29/2024', 1, 'http://dummyimage.com/186x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 7, 2, 'Desire: The Vampire', '157519902-5', '11/22/2023', 1, 'http://dummyimage.com/236x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 5, 'Peppermint Candy (Bakha satang)', '958863326-5', '1/2/2023', 1, 'http://dummyimage.com/166x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 6, 'Jawbreaker', '733043803-0', '4/6/2023', 1, 'http://dummyimage.com/231x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 8, 'Kevin & Perry Go Large', '790708808-9', '7/23/2022', 1, 'http://dummyimage.com/218x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 3, 6, 'I Want You', '724427227-8', '9/29/2024', 1, 'http://dummyimage.com/192x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 1, 3, 'Streets of Blood', '662434728-7', '5/24/2024', 1, 'http://dummyimage.com/189x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 7, 1, 'Emigrants, The (Utvandrarna)', '543764380-2', '1/10/2023', 1, 'http://dummyimage.com/146x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 4, 8, 'Meat the Truth', '600393162-0', '10/6/2024', 1, 'http://dummyimage.com/196x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 4, 8, 'Deuce Bigalow: European Gigolo', '334017082-7', '2/3/2024', 1, 'http://dummyimage.com/236x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 3, 2, 'After Innocence', '059761690-6', '6/18/2024', 1, 'http://dummyimage.com/110x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 5, 9, 'Black Sunday', '241701408-4', '10/15/2024', 1, 'http://dummyimage.com/181x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 6, 'Pieces (Mil gritos tiene la noche) (One Thousand Cries Has the Night)', '568521561-4', '5/13/2023', 1, 'http://dummyimage.com/119x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 6, 'God''s Little Acre', '982752784-3', '11/15/2022', 1, 'http://dummyimage.com/158x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 1, 1, 'London Conspiracy', '132206336-2', '5/2/2024', 1, 'http://dummyimage.com/117x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 7, 'I Dreamed of Africa', '245859598-7', '11/7/2023', 1, 'http://dummyimage.com/249x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 8, 'Chain Reaction', '312683844-8', '4/22/2023', 1, 'http://dummyimage.com/108x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 3, 'God Is the Bigger Elvis', '398804032-0', '3/25/2023', 1, 'http://dummyimage.com/242x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 6, 3, 'Every Little Step', '370652993-9', '12/10/2023', 1, 'http://dummyimage.com/249x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 7, 3, 'Lakeview Terrace', '513938087-0', '11/14/2023', 1, 'http://dummyimage.com/100x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 3, 4, 'Journey Into Fear', '099792278-8', '9/27/2023', 1, 'http://dummyimage.com/168x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 1, 1, 'Jönssonligans största kupp', '905725598-7', '11/22/2023', 1, 'http://dummyimage.com/104x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 7, 8, 'Testament of Dr. Mabuse, The (Das Testament des Dr. Mabuse)', '723940740-3', '3/12/2023', 1, 'http://dummyimage.com/135x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 3, 'Big Day, The (We Met on the Vineyard)', '339298922-3', '6/29/2024', 1, 'http://dummyimage.com/176x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 7, 'Night of the Generals, The', '180551561-6', '9/6/2022', 1, 'http://dummyimage.com/105x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 4, 2, 'The Magnet', '714103447-1', '6/14/2024', 1, 'http://dummyimage.com/222x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 2, 'Going to Kansas City', '693387140-1', '10/10/2023', 1, 'http://dummyimage.com/155x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 2, 8, 'Adrenalin: Fear the Rush', '275237479-8', '12/14/2023', 1, 'http://dummyimage.com/168x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 3, 7, 'Bad Girl Island (Sirens of Eleuthera) (Sirens of the Caribbean)', '269385410-5', '10/24/2024', 1, 'http://dummyimage.com/235x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 2, 'Mike Bassett: England Manager', '266748653-6', '8/14/2022', 1, 'http://dummyimage.com/236x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 2, 'Somewhere Under the Broad Sky', '144977535-7', '3/4/2023', 1, 'http://dummyimage.com/125x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 7, 'Secret Life of Walter Mitty, The', '125729378-8', '9/13/2022', 1, 'http://dummyimage.com/112x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 4, 4, 'Exit to Eden', '383392724-0', '2/10/2024', 1, 'http://dummyimage.com/140x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 7, 7, 'Curse of the Golden Flower (Man cheng jin dai huang jin jia)', '536419280-6', '2/1/2023', 1, 'http://dummyimage.com/228x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 7, 1, 'Evelyn Prentice', '786291872-X', '12/26/2022', 1, 'http://dummyimage.com/138x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 7, 1, 'Crave', '291673941-6', '6/17/2024', 1, 'http://dummyimage.com/146x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 1, 'Singin'' in the Rain', '358817674-8', '10/10/2022', 1, 'http://dummyimage.com/175x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 2, 'Three Brave Men', '352828197-9', '4/23/2023', 1, 'http://dummyimage.com/113x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 5, 'Rickshaw Man, The (Muhomatsu no issho)', '307566101-5', '11/27/2022', 1, 'http://dummyimage.com/136x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 1, 'Method to the Madness of Jerry Lewis', '912538706-5', '8/2/2024', 1, 'http://dummyimage.com/205x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 3, 4, 'Backlight', '226316671-8', '10/28/2022', 1, 'http://dummyimage.com/151x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 3, 'Son of Paleface', '284232535-4', '2/14/2023', 1, 'http://dummyimage.com/141x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 6, 'Dangerous', '902983782-9', '5/28/2023', 1, 'http://dummyimage.com/108x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 7, 'Where Were You When the Lights Went Out?', '821045748-9', '3/4/2023', 1, 'http://dummyimage.com/181x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 7, 2, 'Star Trek: Insurrection', '290516558-8', '1/7/2024', 1, 'http://dummyimage.com/159x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 3, 4, 'Black Waters of Echo''s Pond, The', '239720914-4', '3/19/2024', 1, 'http://dummyimage.com/246x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 9, 'Ingmar Bergman on Life and Work (Ingmar Bergman: Om liv och arbete)', '951965787-8', '5/20/2024', 1, 'http://dummyimage.com/225x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 6, 2, 'Romancing the Stone', '395283725-3', '9/6/2023', 1, 'http://dummyimage.com/180x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 1, 3, 'People I Know', '336027621-3', '8/31/2023', 1, 'http://dummyimage.com/202x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 7, 5, 'Diaries of Vaslav Nijinsky, The', '702329681-6', '10/8/2022', 1, 'http://dummyimage.com/194x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 8, 'Arachnophobia', '750532494-2', '5/23/2023', 1, 'http://dummyimage.com/232x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 6, 1, 'Severe Clear', '365615102-4', '10/26/2022', 1, 'http://dummyimage.com/193x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 4, 'Inhuman Resources (Redd Inc.)', '749925342-2', '9/27/2023', 1, 'http://dummyimage.com/222x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 9, 'Don''t Look Now', '068708032-0', '2/27/2024', 1, 'http://dummyimage.com/105x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 7, 'Life and Times of Hank Greenberg, The', '641079129-1', '10/9/2024', 1, 'http://dummyimage.com/108x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 8, 'Battle of the Year', '562589024-2', '8/22/2022', 1, 'http://dummyimage.com/153x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 7, 3, 'Blackbeard, the Pirate', '161969743-2', '2/15/2023', 1, 'http://dummyimage.com/170x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 7, 4, 'Merry Jail, The (Das fidele Gefängnis)', '331905514-3', '11/25/2022', 1, 'http://dummyimage.com/227x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 3, 1, 'Bed & Breakfast: Love is a Happy Accident (Bed & Breakfast)', '080954422-9', '11/13/2022', 1, 'http://dummyimage.com/131x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 6, 7, 'Restoration', '106395193-3', '1/7/2024', 1, 'http://dummyimage.com/114x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 7, 'Winchester ''73', '821590237-5', '8/10/2022', 1, 'http://dummyimage.com/169x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 8, 'Stranded: I''ve Come from a Plane That Crashed on the Mountains', '909177449-5', '9/26/2022', 1, 'http://dummyimage.com/145x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 9, 'Under Siege', '576690014-7', '4/28/2024', 1, 'http://dummyimage.com/156x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 3, 'War of the Worlds', '096337681-0', '9/9/2024', 1, 'http://dummyimage.com/125x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 8, 'Marjoe', '845876600-0', '7/18/2024', 1, 'http://dummyimage.com/181x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 6, 6, 'Ice Pirates, The', '047232161-7', '12/20/2023', 1, 'http://dummyimage.com/134x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 7, 1, 'If You Could Only Cook', '038646568-1', '3/7/2024', 1, 'http://dummyimage.com/128x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 7, 9, 'Conspirators of Pleasure (Spiklenci slasti)', '574823077-1', '9/4/2024', 1, 'http://dummyimage.com/236x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 7, 2, 'Man Called Horse, A', '894987733-3', '9/2/2023', 1, 'http://dummyimage.com/124x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 4, 9, 'Legend of Sleepy Hollow, The', '581402366-X', '5/28/2024', 1, 'http://dummyimage.com/169x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 4, 5, '3 Ring Circus', '175134740-0', '12/6/2023', 1, 'http://dummyimage.com/185x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 1, 'Bobo, The', '978226281-1', '9/25/2024', 1, 'http://dummyimage.com/232x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 7, 'Andy Hardy Meets Debutante', '238929837-0', '9/30/2024', 1, 'http://dummyimage.com/117x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 8, 'Lookout, The', '140545170-X', '1/19/2023', 1, 'http://dummyimage.com/159x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 5, 7, '3 Holiday Tails (Golden Christmas 2: The Second Tail, A)', '337513140-2', '10/20/2024', 1, 'http://dummyimage.com/229x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 6, 5, 'Joyeux Noël (Merry Christmas)', '992044602-5', '5/31/2024', 1, 'http://dummyimage.com/145x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 5, 3, 'Vampire''s Kiss', '752450733-X', '6/25/2024', 1, 'http://dummyimage.com/132x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 2, 'Après lui', '400936994-9', '6/1/2024', 1, 'http://dummyimage.com/225x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 1, 'Hammett', '010480069-0', '6/20/2023', 1, 'http://dummyimage.com/189x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 7, 2, 'Justice League: The Flashpoint Paradox', '408209408-3', '1/28/2024', 1, 'http://dummyimage.com/119x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 9, 'Scorned', '826183539-1', '6/13/2024', 1, 'http://dummyimage.com/163x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 4, 'The Sex and Violence Family Hour', '056042895-2', '7/23/2024', 1, 'http://dummyimage.com/206x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 2, 'Bambi Meets Godzilla', '669024122-X', '12/11/2023', 1, 'http://dummyimage.com/246x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 4, 'End of the Spear', '765444977-1', '10/26/2022', 1, 'http://dummyimage.com/172x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 4, 'Silence, The (Tystnaden)', '309577877-5', '3/7/2024', 1, 'http://dummyimage.com/197x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 1, 9, 'Gabrielle', '789839606-5', '4/10/2024', 1, 'http://dummyimage.com/173x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 1, 'See No Evil, Hear No Evil', '912943514-5', '8/9/2023', 1, 'http://dummyimage.com/195x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 1, 'Outskirts (Okraina)', '976980095-3', '4/14/2024', 1, 'http://dummyimage.com/229x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 2, 'Lakeview Terrace', '905826100-X', '5/2/2024', 1, 'http://dummyimage.com/106x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 6, 8, 'Secret Admirer', '139829123-4', '11/11/2024', 1, 'http://dummyimage.com/191x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 2, 'Games', '444801714-1', '9/1/2024', 1, 'http://dummyimage.com/177x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 7, 5, 'Blue', '216135114-1', '11/12/2023', 1, 'http://dummyimage.com/234x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 8, 'Purge, The', '167298425-4', '2/23/2023', 1, 'http://dummyimage.com/120x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 9, 'Porky''s', '741012625-6', '1/1/2024', 1, 'http://dummyimage.com/137x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 2, 'Landscape Suicide', '889803632-9', '1/18/2023', 1, 'http://dummyimage.com/238x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 4, 9, 'Lana Turner... a Daughter''s Memoir', '176373040-9', '11/25/2022', 1, 'http://dummyimage.com/160x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 9, 'Flower in Hell (Jiokhwa)', '575795660-7', '6/2/2024', 1, 'http://dummyimage.com/109x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 6, 'Tex', '190464943-2', '8/31/2023', 1, 'http://dummyimage.com/196x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 5, 2, 'No Impact Man: The Documentary', '589207487-0', '7/20/2023', 1, 'http://dummyimage.com/190x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 9, 'Loved One, The', '908451414-9', '9/23/2023', 1, 'http://dummyimage.com/155x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 7, 4, 'Trainspotting', '941698148-6', '4/6/2023', 1, 'http://dummyimage.com/202x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 3, 'Friends with Benefits', '464283713-2', '8/22/2023', 1, 'http://dummyimage.com/122x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 1, 'Sweeney, The', '284838760-2', '5/21/2024', 1, 'http://dummyimage.com/157x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 1, 'Incruste, L'' (a.k.a. L''Incruste, fallait pas le laisser entrer!)', '009662761-1', '3/9/2023', 1, 'http://dummyimage.com/226x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 3, 'History of Kim Skov (Historien om Kim Skov)', '315443277-9', '9/9/2022', 1, 'http://dummyimage.com/181x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 3, 'Max Payne', '055692947-0', '8/21/2022', 1, 'http://dummyimage.com/227x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 4, 2, 'My Father and the Man in Black', '452425285-1', '4/27/2024', 1, 'http://dummyimage.com/227x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 4, 'Death Race', '721767380-1', '12/15/2022', 1, 'http://dummyimage.com/145x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 2, 'Lion of the Desert', '357221632-X', '12/10/2023', 1, 'http://dummyimage.com/106x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 6, 1, 'Air Bud: Golden Receiver', '672556816-5', '10/3/2023', 1, 'http://dummyimage.com/150x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 4, 'Cat Soup (Nekojiru-so)', '011475397-0', '11/13/2024', 1, 'http://dummyimage.com/208x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 9, 'Dinner, The (Diner, Het)', '877933471-7', '4/12/2024', 1, 'http://dummyimage.com/130x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 7, 4, 'Night and Day (Bam gua nat)', '554929950-X', '5/8/2024', 1, 'http://dummyimage.com/249x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 1, 4, 'National Lampoon''s Van Wilder', '018721215-5', '11/3/2022', 1, 'http://dummyimage.com/245x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 6, 'The Brass Legend', '584789021-4', '9/1/2022', 1, 'http://dummyimage.com/248x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 6, 3, 'Mulholland Falls', '721867363-5', '11/24/2022', 1, 'http://dummyimage.com/126x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 1, 'China Lake Murders, The', '168851695-6', '12/5/2023', 1, 'http://dummyimage.com/105x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 7, 8, 'Human Centipede, The (First Sequence)', '833897114-6', '6/28/2024', 1, 'http://dummyimage.com/143x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 1, 'Meet the Fockers', '690817620-7', '7/20/2024', 1, 'http://dummyimage.com/211x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 7, 7, 'Ex-Lady', '613936972-X', '1/16/2024', 1, 'http://dummyimage.com/193x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 4, 'Ranma ½: Big Trouble in Nekonron, China (Ranma ½: Chûgoku Nekonron daikessen! Okite yaburi no gekitô hen)', '374007056-0', '1/5/2023', 1, 'http://dummyimage.com/179x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 1, 7, 'Dragon Ball: The Path to Power (Doragon bôru: Saikyô e no michi)', '137101679-8', '11/8/2022', 1, 'http://dummyimage.com/126x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 6, 3, 'Deep Blue', '726691337-3', '2/13/2024', 1, 'http://dummyimage.com/162x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 5, 'In Old Arizona', '285283214-3', '11/4/2024', 1, 'http://dummyimage.com/198x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 7, 3, 'Teen Spirit', '158819233-4', '10/8/2022', 1, 'http://dummyimage.com/202x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 7, 4, 'Spirit of St. Louis, The', '614278135-0', '2/17/2023', 1, 'http://dummyimage.com/189x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 4, 7, 'Shipping News, The', '805903921-0', '1/12/2023', 1, 'http://dummyimage.com/239x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 7, 'Commare secca, La (Grim Reaper, The)', '337789262-1', '12/20/2022', 1, 'http://dummyimage.com/109x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 6, 'Gun Woman', '155733804-3', '1/15/2024', 1, 'http://dummyimage.com/189x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 8, 'Raintree County', '154630771-0', '2/18/2024', 1, 'http://dummyimage.com/220x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 2, 3, 'Nightwatch (Nattevagten)', '242266828-3', '8/27/2022', 1, 'http://dummyimage.com/230x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 4, 1, 'Orphans of the Storm', '364982821-9', '4/10/2023', 1, 'http://dummyimage.com/100x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 7, 'Spanish Prisoner, The', '001124298-1', '7/15/2023', 1, 'http://dummyimage.com/145x100.png/5fa2dd/ffffff');


insert into Book_Authors (book_id, author_id) values (1, 68);
insert into Book_Authors (book_id, author_id) values (2, 320);
insert into Book_Authors (book_id, author_id) values (3, 35);
insert into Book_Authors (book_id, author_id) values (4, 201);
insert into Book_Authors (book_id, author_id) values (5, 291);
insert into Book_Authors (book_id, author_id) values (6, 266);
insert into Book_Authors (book_id, author_id) values (7, 294);
insert into Book_Authors (book_id, author_id) values (8, 109);
insert into Book_Authors (book_id, author_id) values (9, 201);
insert into Book_Authors (book_id, author_id) values (10, 98);
insert into Book_Authors (book_id, author_id) values (11, 251);
insert into Book_Authors (book_id, author_id) values (12, 399);
insert into Book_Authors (book_id, author_id) values (13, 373);
insert into Book_Authors (book_id, author_id) values (14, 10);
insert into Book_Authors (book_id, author_id) values (15, 89);
insert into Book_Authors (book_id, author_id) values (16, 251);
insert into Book_Authors (book_id, author_id) values (17, 281);
insert into Book_Authors (book_id, author_id) values (18, 354);
insert into Book_Authors (book_id, author_id) values (19, 92);
insert into Book_Authors (book_id, author_id) values (20, 208);
insert into Book_Authors (book_id, author_id) values (21, 394);
insert into Book_Authors (book_id, author_id) values (22, 346);
insert into Book_Authors (book_id, author_id) values (23, 336);
insert into Book_Authors (book_id, author_id) values (24, 1);
insert into Book_Authors (book_id, author_id) values (25, 254);
insert into Book_Authors (book_id, author_id) values (26, 171);
insert into Book_Authors (book_id, author_id) values (27, 29);
insert into Book_Authors (book_id, author_id) values (28, 67);
insert into Book_Authors (book_id, author_id) values (29, 55);
insert into Book_Authors (book_id, author_id) values (30, 286);
insert into Book_Authors (book_id, author_id) values (31, 208);
insert into Book_Authors (book_id, author_id) values (32, 249);
insert into Book_Authors (book_id, author_id) values (33, 355);
insert into Book_Authors (book_id, author_id) values (34, 38);
insert into Book_Authors (book_id, author_id) values (35, 197);
insert into Book_Authors (book_id, author_id) values (36, 269);
insert into Book_Authors (book_id, author_id) values (37, 95);
insert into Book_Authors (book_id, author_id) values (38, 221);
insert into Book_Authors (book_id, author_id) values (39, 48);
insert into Book_Authors (book_id, author_id) values (40, 190);
insert into Book_Authors (book_id, author_id) values (41, 290);
insert into Book_Authors (book_id, author_id) values (42, 393);
insert into Book_Authors (book_id, author_id) values (43, 285);
insert into Book_Authors (book_id, author_id) values (44, 270);
insert into Book_Authors (book_id, author_id) values (45, 328);
insert into Book_Authors (book_id, author_id) values (46, 309);
insert into Book_Authors (book_id, author_id) values (47, 279);
insert into Book_Authors (book_id, author_id) values (48, 344);
insert into Book_Authors (book_id, author_id) values (49, 202);
insert into Book_Authors (book_id, author_id) values (50, 138);
insert into Book_Authors (book_id, author_id) values (51, 115);
insert into Book_Authors (book_id, author_id) values (52, 184);
insert into Book_Authors (book_id, author_id) values (53, 29);
insert into Book_Authors (book_id, author_id) values (54, 286);
insert into Book_Authors (book_id, author_id) values (55, 370);
insert into Book_Authors (book_id, author_id) values (56, 30);
insert into Book_Authors (book_id, author_id) values (57, 367);
insert into Book_Authors (book_id, author_id) values (58, 207);
insert into Book_Authors (book_id, author_id) values (59, 370);
insert into Book_Authors (book_id, author_id) values (60, 33);
insert into Book_Authors (book_id, author_id) values (61, 71);
insert into Book_Authors (book_id, author_id) values (62, 294);
insert into Book_Authors (book_id, author_id) values (63, 45);
insert into Book_Authors (book_id, author_id) values (64, 189);
insert into Book_Authors (book_id, author_id) values (65, 380);
insert into Book_Authors (book_id, author_id) values (66, 157);
insert into Book_Authors (book_id, author_id) values (67, 210);
insert into Book_Authors (book_id, author_id) values (68, 334);
insert into Book_Authors (book_id, author_id) values (69, 213);
insert into Book_Authors (book_id, author_id) values (70, 251);
insert into Book_Authors (book_id, author_id) values (71, 124);
insert into Book_Authors (book_id, author_id) values (72, 214);
insert into Book_Authors (book_id, author_id) values (73, 382);
insert into Book_Authors (book_id, author_id) values (74, 178);
insert into Book_Authors (book_id, author_id) values (75, 302);
insert into Book_Authors (book_id, author_id) values (76, 131);
insert into Book_Authors (book_id, author_id) values (77, 34);
insert into Book_Authors (book_id, author_id) values (78, 382);
insert into Book_Authors (book_id, author_id) values (79, 362);
insert into Book_Authors (book_id, author_id) values (80, 84);
insert into Book_Authors (book_id, author_id) values (81, 15);
insert into Book_Authors (book_id, author_id) values (82, 237);
insert into Book_Authors (book_id, author_id) values (83, 172);
insert into Book_Authors (book_id, author_id) values (84, 232);
insert into Book_Authors (book_id, author_id) values (85, 57);
insert into Book_Authors (book_id, author_id) values (86, 305);
insert into Book_Authors (book_id, author_id) values (87, 211);
insert into Book_Authors (book_id, author_id) values (88, 48);
insert into Book_Authors (book_id, author_id) values (89, 297);
insert into Book_Authors (book_id, author_id) values (90, 169);
insert into Book_Authors (book_id, author_id) values (91, 303);
insert into Book_Authors (book_id, author_id) values (92, 264);
insert into Book_Authors (book_id, author_id) values (93, 29);
insert into Book_Authors (book_id, author_id) values (94, 368);
insert into Book_Authors (book_id, author_id) values (95, 388);
insert into Book_Authors (book_id, author_id) values (96, 237);
insert into Book_Authors (book_id, author_id) values (97, 84);
insert into Book_Authors (book_id, author_id) values (98, 162);
insert into Book_Authors (book_id, author_id) values (99, 47);
insert into Book_Authors (book_id, author_id) values (100, 238);
insert into Book_Authors (book_id, author_id) values (101, 236);
insert into Book_Authors (book_id, author_id) values (102, 46);
insert into Book_Authors (book_id, author_id) values (103, 82);
insert into Book_Authors (book_id, author_id) values (104, 350);
insert into Book_Authors (book_id, author_id) values (105, 246);
insert into Book_Authors (book_id, author_id) values (106, 141);
insert into Book_Authors (book_id, author_id) values (107, 277);
insert into Book_Authors (book_id, author_id) values (108, 295);
insert into Book_Authors (book_id, author_id) values (109, 302);
insert into Book_Authors (book_id, author_id) values (110, 303);
insert into Book_Authors (book_id, author_id) values (111, 77);
insert into Book_Authors (book_id, author_id) values (112, 145);
insert into Book_Authors (book_id, author_id) values (113, 376);
insert into Book_Authors (book_id, author_id) values (114, 340);
insert into Book_Authors (book_id, author_id) values (115, 173);
insert into Book_Authors (book_id, author_id) values (116, 136);
insert into Book_Authors (book_id, author_id) values (117, 360);
insert into Book_Authors (book_id, author_id) values (118, 218);
insert into Book_Authors (book_id, author_id) values (119, 113);
insert into Book_Authors (book_id, author_id) values (120, 216);
insert into Book_Authors (book_id, author_id) values (121, 307);
insert into Book_Authors (book_id, author_id) values (122, 389);
insert into Book_Authors (book_id, author_id) values (123, 85);
insert into Book_Authors (book_id, author_id) values (124, 125);
insert into Book_Authors (book_id, author_id) values (125, 38);
insert into Book_Authors (book_id, author_id) values (126, 305);
insert into Book_Authors (book_id, author_id) values (127, 305);
insert into Book_Authors (book_id, author_id) values (128, 14);
insert into Book_Authors (book_id, author_id) values (129, 200);
insert into Book_Authors (book_id, author_id) values (130, 250);
insert into Book_Authors (book_id, author_id) values (131, 171);
insert into Book_Authors (book_id, author_id) values (132, 51);
insert into Book_Authors (book_id, author_id) values (133, 88);
insert into Book_Authors (book_id, author_id) values (134, 377);
insert into Book_Authors (book_id, author_id) values (135, 164);
insert into Book_Authors (book_id, author_id) values (136, 155);
insert into Book_Authors (book_id, author_id) values (137, 273);
insert into Book_Authors (book_id, author_id) values (138, 296);
insert into Book_Authors (book_id, author_id) values (139, 209);
insert into Book_Authors (book_id, author_id) values (140, 260);
insert into Book_Authors (book_id, author_id) values (141, 4);
insert into Book_Authors (book_id, author_id) values (142, 50);
insert into Book_Authors (book_id, author_id) values (143, 253);
insert into Book_Authors (book_id, author_id) values (144, 378);
insert into Book_Authors (book_id, author_id) values (145, 45);
insert into Book_Authors (book_id, author_id) values (146, 254);
insert into Book_Authors (book_id, author_id) values (147, 224);
insert into Book_Authors (book_id, author_id) values (148, 106);
insert into Book_Authors (book_id, author_id) values (149, 325);
insert into Book_Authors (book_id, author_id) values (150, 296);
insert into Book_Authors (book_id, author_id) values (151, 35);
insert into Book_Authors (book_id, author_id) values (152, 76);
insert into Book_Authors (book_id, author_id) values (153, 275);
insert into Book_Authors (book_id, author_id) values (154, 18);
insert into Book_Authors (book_id, author_id) values (155, 118);
insert into Book_Authors (book_id, author_id) values (156, 202);
insert into Book_Authors (book_id, author_id) values (157, 165);
insert into Book_Authors (book_id, author_id) values (158, 151);
insert into Book_Authors (book_id, author_id) values (159, 149);
insert into Book_Authors (book_id, author_id) values (160, 144);
insert into Book_Authors (book_id, author_id) values (161, 172);
insert into Book_Authors (book_id, author_id) values (162, 396);
insert into Book_Authors (book_id, author_id) values (163, 282);
insert into Book_Authors (book_id, author_id) values (164, 97);
insert into Book_Authors (book_id, author_id) values (165, 108);
insert into Book_Authors (book_id, author_id) values (166, 188);
insert into Book_Authors (book_id, author_id) values (167, 3);
insert into Book_Authors (book_id, author_id) values (168, 188);
insert into Book_Authors (book_id, author_id) values (169, 305);
insert into Book_Authors (book_id, author_id) values (170, 55);
insert into Book_Authors (book_id, author_id) values (171, 327);
insert into Book_Authors (book_id, author_id) values (172, 237);
insert into Book_Authors (book_id, author_id) values (173, 81);
insert into Book_Authors (book_id, author_id) values (174, 6);
insert into Book_Authors (book_id, author_id) values (175, 167);
insert into Book_Authors (book_id, author_id) values (176, 186);
insert into Book_Authors (book_id, author_id) values (177, 340);
insert into Book_Authors (book_id, author_id) values (178, 46);
insert into Book_Authors (book_id, author_id) values (179, 20);
insert into Book_Authors (book_id, author_id) values (180, 118);
insert into Book_Authors (book_id, author_id) values (181, 20);
insert into Book_Authors (book_id, author_id) values (182, 39);
insert into Book_Authors (book_id, author_id) values (183, 304);
insert into Book_Authors (book_id, author_id) values (184, 10);
insert into Book_Authors (book_id, author_id) values (185, 379);
insert into Book_Authors (book_id, author_id) values (186, 248);
insert into Book_Authors (book_id, author_id) values (187, 84);
insert into Book_Authors (book_id, author_id) values (188, 86);
insert into Book_Authors (book_id, author_id) values (189, 370);
insert into Book_Authors (book_id, author_id) values (190, 211);
insert into Book_Authors (book_id, author_id) values (191, 2);
insert into Book_Authors (book_id, author_id) values (192, 71);
insert into Book_Authors (book_id, author_id) values (193, 91);
insert into Book_Authors (book_id, author_id) values (194, 130);
insert into Book_Authors (book_id, author_id) values (195, 277);
insert into Book_Authors (book_id, author_id) values (196, 190);
insert into Book_Authors (book_id, author_id) values (197, 132);
insert into Book_Authors (book_id, author_id) values (198, 369);
insert into Book_Authors (book_id, author_id) values (199, 140);
insert into Book_Authors (book_id, author_id) values (200, 389);
insert into Book_Authors (book_id, author_id) values (201, 118);
insert into Book_Authors (book_id, author_id) values (202, 159);
insert into Book_Authors (book_id, author_id) values (203, 172);
insert into Book_Authors (book_id, author_id) values (204, 341);
insert into Book_Authors (book_id, author_id) values (205, 336);
insert into Book_Authors (book_id, author_id) values (206, 17);
insert into Book_Authors (book_id, author_id) values (207, 168);
insert into Book_Authors (book_id, author_id) values (208, 71);
insert into Book_Authors (book_id, author_id) values (209, 246);
insert into Book_Authors (book_id, author_id) values (210, 174);
insert into Book_Authors (book_id, author_id) values (211, 397);
insert into Book_Authors (book_id, author_id) values (212, 212);
insert into Book_Authors (book_id, author_id) values (213, 249);
insert into Book_Authors (book_id, author_id) values (214, 177);
insert into Book_Authors (book_id, author_id) values (215, 169);
insert into Book_Authors (book_id, author_id) values (216, 178);
insert into Book_Authors (book_id, author_id) values (217, 306);
insert into Book_Authors (book_id, author_id) values (218, 318);
insert into Book_Authors (book_id, author_id) values (219, 395);
insert into Book_Authors (book_id, author_id) values (220, 96);
insert into Book_Authors (book_id, author_id) values (221, 247);
insert into Book_Authors (book_id, author_id) values (222, 187);
insert into Book_Authors (book_id, author_id) values (223, 339);
insert into Book_Authors (book_id, author_id) values (224, 190);
insert into Book_Authors (book_id, author_id) values (225, 33);
insert into Book_Authors (book_id, author_id) values (226, 389);
insert into Book_Authors (book_id, author_id) values (227, 269);
insert into Book_Authors (book_id, author_id) values (228, 141);
insert into Book_Authors (book_id, author_id) values (229, 177);
insert into Book_Authors (book_id, author_id) values (230, 169);
insert into Book_Authors (book_id, author_id) values (231, 184);
insert into Book_Authors (book_id, author_id) values (232, 57);
insert into Book_Authors (book_id, author_id) values (233, 85);
insert into Book_Authors (book_id, author_id) values (234, 336);
insert into Book_Authors (book_id, author_id) values (235, 300);
insert into Book_Authors (book_id, author_id) values (236, 144);
insert into Book_Authors (book_id, author_id) values (237, 289);
insert into Book_Authors (book_id, author_id) values (238, 179);
insert into Book_Authors (book_id, author_id) values (239, 277);
insert into Book_Authors (book_id, author_id) values (240, 233);
insert into Book_Authors (book_id, author_id) values (241, 32);
insert into Book_Authors (book_id, author_id) values (242, 159);
insert into Book_Authors (book_id, author_id) values (243, 57);
insert into Book_Authors (book_id, author_id) values (244, 209);
insert into Book_Authors (book_id, author_id) values (245, 211);
insert into Book_Authors (book_id, author_id) values (246, 315);
insert into Book_Authors (book_id, author_id) values (247, 361);
insert into Book_Authors (book_id, author_id) values (248, 150);
insert into Book_Authors (book_id, author_id) values (249, 153);
insert into Book_Authors (book_id, author_id) values (250, 142);
insert into Book_Authors (book_id, author_id) values (251, 303);
insert into Book_Authors (book_id, author_id) values (252, 44);
insert into Book_Authors (book_id, author_id) values (253, 320);
insert into Book_Authors (book_id, author_id) values (254, 122);
insert into Book_Authors (book_id, author_id) values (255, 37);
insert into Book_Authors (book_id, author_id) values (256, 393);
insert into Book_Authors (book_id, author_id) values (257, 42);
insert into Book_Authors (book_id, author_id) values (258, 229);
insert into Book_Authors (book_id, author_id) values (259, 396);
insert into Book_Authors (book_id, author_id) values (260, 242);
insert into Book_Authors (book_id, author_id) values (261, 131);
insert into Book_Authors (book_id, author_id) values (262, 314);
insert into Book_Authors (book_id, author_id) values (263, 267);
insert into Book_Authors (book_id, author_id) values (264, 50);
insert into Book_Authors (book_id, author_id) values (265, 102);
insert into Book_Authors (book_id, author_id) values (266, 70);
insert into Book_Authors (book_id, author_id) values (267, 277);
insert into Book_Authors (book_id, author_id) values (268, 266);
insert into Book_Authors (book_id, author_id) values (269, 267);
insert into Book_Authors (book_id, author_id) values (270, 267);
insert into Book_Authors (book_id, author_id) values (271, 67);
insert into Book_Authors (book_id, author_id) values (272, 267);
insert into Book_Authors (book_id, author_id) values (273, 222);
insert into Book_Authors (book_id, author_id) values (274, 291);
insert into Book_Authors (book_id, author_id) values (275, 110);
insert into Book_Authors (book_id, author_id) values (276, 109);
insert into Book_Authors (book_id, author_id) values (277, 253);
insert into Book_Authors (book_id, author_id) values (278, 111);
insert into Book_Authors (book_id, author_id) values (279, 171);
insert into Book_Authors (book_id, author_id) values (280, 64);
insert into Book_Authors (book_id, author_id) values (281, 365);
insert into Book_Authors (book_id, author_id) values (282, 117);
insert into Book_Authors (book_id, author_id) values (283, 82);
insert into Book_Authors (book_id, author_id) values (284, 265);
insert into Book_Authors (book_id, author_id) values (285, 46);
insert into Book_Authors (book_id, author_id) values (286, 359);
insert into Book_Authors (book_id, author_id) values (287, 254);
insert into Book_Authors (book_id, author_id) values (288, 28);
insert into Book_Authors (book_id, author_id) values (289, 192);
insert into Book_Authors (book_id, author_id) values (290, 375);
insert into Book_Authors (book_id, author_id) values (291, 336);
insert into Book_Authors (book_id, author_id) values (292, 213);
insert into Book_Authors (book_id, author_id) values (293, 369);
insert into Book_Authors (book_id, author_id) values (294, 17);
insert into Book_Authors (book_id, author_id) values (295, 53);
insert into Book_Authors (book_id, author_id) values (296, 310);
insert into Book_Authors (book_id, author_id) values (297, 151);
insert into Book_Authors (book_id, author_id) values (298, 316);
insert into Book_Authors (book_id, author_id) values (299, 284);
insert into Book_Authors (book_id, author_id) values (300, 109);
insert into Book_Authors (book_id, author_id) values (301, 353);
insert into Book_Authors (book_id, author_id) values (302, 144);
insert into Book_Authors (book_id, author_id) values (303, 246);
insert into Book_Authors (book_id, author_id) values (304, 56);
insert into Book_Authors (book_id, author_id) values (305, 229);
insert into Book_Authors (book_id, author_id) values (306, 370);
insert into Book_Authors (book_id, author_id) values (307, 198);
insert into Book_Authors (book_id, author_id) values (308, 268);
insert into Book_Authors (book_id, author_id) values (309, 175);
insert into Book_Authors (book_id, author_id) values (310, 229);
insert into Book_Authors (book_id, author_id) values (311, 280);
insert into Book_Authors (book_id, author_id) values (312, 42);
insert into Book_Authors (book_id, author_id) values (313, 31);
insert into Book_Authors (book_id, author_id) values (314, 306);
insert into Book_Authors (book_id, author_id) values (315, 206);
insert into Book_Authors (book_id, author_id) values (316, 125);
insert into Book_Authors (book_id, author_id) values (317, 336);
insert into Book_Authors (book_id, author_id) values (318, 10);
insert into Book_Authors (book_id, author_id) values (319, 52);
insert into Book_Authors (book_id, author_id) values (320, 40);
insert into Book_Authors (book_id, author_id) values (321, 132);
insert into Book_Authors (book_id, author_id) values (322, 382);
insert into Book_Authors (book_id, author_id) values (323, 290);
insert into Book_Authors (book_id, author_id) values (324, 311);
insert into Book_Authors (book_id, author_id) values (325, 37);
insert into Book_Authors (book_id, author_id) values (326, 230);
insert into Book_Authors (book_id, author_id) values (327, 134);
insert into Book_Authors (book_id, author_id) values (328, 276);
insert into Book_Authors (book_id, author_id) values (329, 349);
insert into Book_Authors (book_id, author_id) values (330, 351);
insert into Book_Authors (book_id, author_id) values (331, 342);
insert into Book_Authors (book_id, author_id) values (332, 106);
insert into Book_Authors (book_id, author_id) values (333, 369);
insert into Book_Authors (book_id, author_id) values (334, 267);
insert into Book_Authors (book_id, author_id) values (335, 25);
insert into Book_Authors (book_id, author_id) values (336, 334);
insert into Book_Authors (book_id, author_id) values (337, 215);
insert into Book_Authors (book_id, author_id) values (338, 265);
insert into Book_Authors (book_id, author_id) values (339, 39);
insert into Book_Authors (book_id, author_id) values (340, 388);
insert into Book_Authors (book_id, author_id) values (341, 26);
insert into Book_Authors (book_id, author_id) values (342, 266);
insert into Book_Authors (book_id, author_id) values (343, 91);
insert into Book_Authors (book_id, author_id) values (344, 73);
insert into Book_Authors (book_id, author_id) values (345, 204);
insert into Book_Authors (book_id, author_id) values (346, 183);
insert into Book_Authors (book_id, author_id) values (347, 39);
insert into Book_Authors (book_id, author_id) values (348, 272);
insert into Book_Authors (book_id, author_id) values (349, 300);
insert into Book_Authors (book_id, author_id) values (350, 76);
insert into Book_Authors (book_id, author_id) values (351, 369);
insert into Book_Authors (book_id, author_id) values (352, 45);
insert into Book_Authors (book_id, author_id) values (353, 162);
insert into Book_Authors (book_id, author_id) values (354, 182);
insert into Book_Authors (book_id, author_id) values (355, 368);
insert into Book_Authors (book_id, author_id) values (356, 193);
insert into Book_Authors (book_id, author_id) values (357, 100);
insert into Book_Authors (book_id, author_id) values (358, 45);
insert into Book_Authors (book_id, author_id) values (359, 148);
insert into Book_Authors (book_id, author_id) values (360, 376);
insert into Book_Authors (book_id, author_id) values (361, 237);
insert into Book_Authors (book_id, author_id) values (362, 244);
insert into Book_Authors (book_id, author_id) values (363, 325);
insert into Book_Authors (book_id, author_id) values (364, 191);
insert into Book_Authors (book_id, author_id) values (365, 64);
insert into Book_Authors (book_id, author_id) values (366, 348);
insert into Book_Authors (book_id, author_id) values (367, 192);
insert into Book_Authors (book_id, author_id) values (368, 73);
insert into Book_Authors (book_id, author_id) values (369, 14);
insert into Book_Authors (book_id, author_id) values (370, 256);
insert into Book_Authors (book_id, author_id) values (371, 234);
insert into Book_Authors (book_id, author_id) values (372, 293);
insert into Book_Authors (book_id, author_id) values (373, 3);
insert into Book_Authors (book_id, author_id) values (374, 206);
insert into Book_Authors (book_id, author_id) values (375, 388);
insert into Book_Authors (book_id, author_id) values (376, 238);
insert into Book_Authors (book_id, author_id) values (377, 365);
insert into Book_Authors (book_id, author_id) values (378, 309);
insert into Book_Authors (book_id, author_id) values (379, 367);
insert into Book_Authors (book_id, author_id) values (380, 88);
insert into Book_Authors (book_id, author_id) values (381, 52);
insert into Book_Authors (book_id, author_id) values (382, 289);
insert into Book_Authors (book_id, author_id) values (383, 203);
insert into Book_Authors (book_id, author_id) values (384, 340);
insert into Book_Authors (book_id, author_id) values (385, 232);
insert into Book_Authors (book_id, author_id) values (386, 330);
insert into Book_Authors (book_id, author_id) values (387, 297);
insert into Book_Authors (book_id, author_id) values (388, 153);
insert into Book_Authors (book_id, author_id) values (389, 230);
insert into Book_Authors (book_id, author_id) values (390, 310);
insert into Book_Authors (book_id, author_id) values (391, 206);
insert into Book_Authors (book_id, author_id) values (392, 161);
insert into Book_Authors (book_id, author_id) values (393, 181);
insert into Book_Authors (book_id, author_id) values (394, 400);
insert into Book_Authors (book_id, author_id) values (395, 360);
insert into Book_Authors (book_id, author_id) values (396, 18);
insert into Book_Authors (book_id, author_id) values (397, 244);
insert into Book_Authors (book_id, author_id) values (398, 229);
insert into Book_Authors (book_id, author_id) values (399, 221);
insert into Book_Authors (book_id, author_id) values (400, 219);
insert into Book_Authors (book_id, author_id) values (401, 351);
insert into Book_Authors (book_id, author_id) values (402, 37);
insert into Book_Authors (book_id, author_id) values (403, 11);
insert into Book_Authors (book_id, author_id) values (404, 7);
insert into Book_Authors (book_id, author_id) values (405, 345);
insert into Book_Authors (book_id, author_id) values (406, 38);
insert into Book_Authors (book_id, author_id) values (407, 239);
insert into Book_Authors (book_id, author_id) values (408, 114);
insert into Book_Authors (book_id, author_id) values (409, 141);
insert into Book_Authors (book_id, author_id) values (410, 93);
insert into Book_Authors (book_id, author_id) values (411, 208);
insert into Book_Authors (book_id, author_id) values (412, 114);
insert into Book_Authors (book_id, author_id) values (413, 322);
insert into Book_Authors (book_id, author_id) values (414, 278);
insert into Book_Authors (book_id, author_id) values (415, 213);
insert into Book_Authors (book_id, author_id) values (416, 102);
insert into Book_Authors (book_id, author_id) values (417, 169);
insert into Book_Authors (book_id, author_id) values (418, 49);
insert into Book_Authors (book_id, author_id) values (419, 244);
insert into Book_Authors (book_id, author_id) values (420, 189);
insert into Book_Authors (book_id, author_id) values (421, 321);
insert into Book_Authors (book_id, author_id) values (422, 168);
insert into Book_Authors (book_id, author_id) values (423, 276);
insert into Book_Authors (book_id, author_id) values (424, 257);
insert into Book_Authors (book_id, author_id) values (425, 278);
insert into Book_Authors (book_id, author_id) values (426, 318);
insert into Book_Authors (book_id, author_id) values (427, 397);
insert into Book_Authors (book_id, author_id) values (428, 318);
insert into Book_Authors (book_id, author_id) values (429, 324);
insert into Book_Authors (book_id, author_id) values (430, 87);
insert into Book_Authors (book_id, author_id) values (431, 82);
insert into Book_Authors (book_id, author_id) values (432, 312);
insert into Book_Authors (book_id, author_id) values (433, 25);
insert into Book_Authors (book_id, author_id) values (434, 316);
insert into Book_Authors (book_id, author_id) values (435, 335);
insert into Book_Authors (book_id, author_id) values (436, 111);
insert into Book_Authors (book_id, author_id) values (437, 261);
insert into Book_Authors (book_id, author_id) values (438, 150);
insert into Book_Authors (book_id, author_id) values (439, 174);
insert into Book_Authors (book_id, author_id) values (440, 74);
insert into Book_Authors (book_id, author_id) values (441, 340);
insert into Book_Authors (book_id, author_id) values (442, 47);
insert into Book_Authors (book_id, author_id) values (443, 314);
insert into Book_Authors (book_id, author_id) values (444, 224);
insert into Book_Authors (book_id, author_id) values (445, 94);
insert into Book_Authors (book_id, author_id) values (446, 64);
insert into Book_Authors (book_id, author_id) values (447, 127);
insert into Book_Authors (book_id, author_id) values (448, 104);
insert into Book_Authors (book_id, author_id) values (449, 145);
insert into Book_Authors (book_id, author_id) values (450, 15);
insert into Book_Authors (book_id, author_id) values (451, 61);
insert into Book_Authors (book_id, author_id) values (452, 54);
insert into Book_Authors (book_id, author_id) values (453, 131);
insert into Book_Authors (book_id, author_id) values (454, 89);
insert into Book_Authors (book_id, author_id) values (455, 330);
insert into Book_Authors (book_id, author_id) values (456, 243);
insert into Book_Authors (book_id, author_id) values (457, 124);
insert into Book_Authors (book_id, author_id) values (458, 376);
insert into Book_Authors (book_id, author_id) values (459, 231);
insert into Book_Authors (book_id, author_id) values (460, 256);
insert into Book_Authors (book_id, author_id) values (461, 372);
insert into Book_Authors (book_id, author_id) values (462, 323);
insert into Book_Authors (book_id, author_id) values (463, 208);
insert into Book_Authors (book_id, author_id) values (464, 81);
insert into Book_Authors (book_id, author_id) values (465, 280);
insert into Book_Authors (book_id, author_id) values (466, 388);
insert into Book_Authors (book_id, author_id) values (467, 46);
insert into Book_Authors (book_id, author_id) values (468, 145);
insert into Book_Authors (book_id, author_id) values (469, 356);
insert into Book_Authors (book_id, author_id) values (470, 326);
insert into Book_Authors (book_id, author_id) values (471, 146);
insert into Book_Authors (book_id, author_id) values (472, 24);
insert into Book_Authors (book_id, author_id) values (473, 161);
insert into Book_Authors (book_id, author_id) values (474, 203);
insert into Book_Authors (book_id, author_id) values (475, 28);
insert into Book_Authors (book_id, author_id) values (476, 134);
insert into Book_Authors (book_id, author_id) values (477, 245);
insert into Book_Authors (book_id, author_id) values (478, 317);
insert into Book_Authors (book_id, author_id) values (479, 23);
insert into Book_Authors (book_id, author_id) values (480, 355);
insert into Book_Authors (book_id, author_id) values (481, 350);
insert into Book_Authors (book_id, author_id) values (482, 89);
insert into Book_Authors (book_id, author_id) values (483, 368);
insert into Book_Authors (book_id, author_id) values (484, 365);
insert into Book_Authors (book_id, author_id) values (485, 41);
insert into Book_Authors (book_id, author_id) values (486, 221);
insert into Book_Authors (book_id, author_id) values (487, 329);
insert into Book_Authors (book_id, author_id) values (488, 123);
insert into Book_Authors (book_id, author_id) values (489, 246);
insert into Book_Authors (book_id, author_id) values (490, 193);
insert into Book_Authors (book_id, author_id) values (491, 232);
insert into Book_Authors (book_id, author_id) values (492, 100);
insert into Book_Authors (book_id, author_id) values (493, 118);
insert into Book_Authors (book_id, author_id) values (494, 21);
insert into Book_Authors (book_id, author_id) values (495, 137);
insert into Book_Authors (book_id, author_id) values (496, 182);
insert into Book_Authors (book_id, author_id) values (497, 35);
insert into Book_Authors (book_id, author_id) values (498, 352);
insert into Book_Authors (book_id, author_id) values (499, 9);
insert into Book_Authors (book_id, author_id) values (500, 236);
insert into Book_Authors (book_id, author_id) values (501, 104);
insert into Book_Authors (book_id, author_id) values (502, 347);
insert into Book_Authors (book_id, author_id) values (503, 372);
insert into Book_Authors (book_id, author_id) values (504, 318);
insert into Book_Authors (book_id, author_id) values (505, 40);
insert into Book_Authors (book_id, author_id) values (506, 327);
insert into Book_Authors (book_id, author_id) values (507, 221);
insert into Book_Authors (book_id, author_id) values (508, 223);
insert into Book_Authors (book_id, author_id) values (509, 364);
insert into Book_Authors (book_id, author_id) values (510, 155);
insert into Book_Authors (book_id, author_id) values (511, 303);
insert into Book_Authors (book_id, author_id) values (512, 173);
insert into Book_Authors (book_id, author_id) values (513, 392);
insert into Book_Authors (book_id, author_id) values (514, 228);
insert into Book_Authors (book_id, author_id) values (515, 107);
insert into Book_Authors (book_id, author_id) values (516, 275);
insert into Book_Authors (book_id, author_id) values (517, 269);
insert into Book_Authors (book_id, author_id) values (518, 134);
insert into Book_Authors (book_id, author_id) values (519, 332);
insert into Book_Authors (book_id, author_id) values (520, 62);
insert into Book_Authors (book_id, author_id) values (521, 160);
insert into Book_Authors (book_id, author_id) values (522, 82);
insert into Book_Authors (book_id, author_id) values (523, 139);
insert into Book_Authors (book_id, author_id) values (524, 217);
insert into Book_Authors (book_id, author_id) values (525, 180);
insert into Book_Authors (book_id, author_id) values (526, 389);
insert into Book_Authors (book_id, author_id) values (527, 385);
insert into Book_Authors (book_id, author_id) values (528, 154);
insert into Book_Authors (book_id, author_id) values (529, 173);
insert into Book_Authors (book_id, author_id) values (530, 286);
insert into Book_Authors (book_id, author_id) values (531, 237);
insert into Book_Authors (book_id, author_id) values (532, 9);
insert into Book_Authors (book_id, author_id) values (533, 168);
insert into Book_Authors (book_id, author_id) values (534, 296);
insert into Book_Authors (book_id, author_id) values (535, 392);
insert into Book_Authors (book_id, author_id) values (536, 202);
insert into Book_Authors (book_id, author_id) values (537, 71);
insert into Book_Authors (book_id, author_id) values (538, 396);
insert into Book_Authors (book_id, author_id) values (539, 227);
insert into Book_Authors (book_id, author_id) values (540, 175);
insert into Book_Authors (book_id, author_id) values (541, 136);
insert into Book_Authors (book_id, author_id) values (542, 91);
insert into Book_Authors (book_id, author_id) values (543, 140);
insert into Book_Authors (book_id, author_id) values (544, 319);
insert into Book_Authors (book_id, author_id) values (545, 294);
insert into Book_Authors (book_id, author_id) values (546, 90);
insert into Book_Authors (book_id, author_id) values (547, 234);
insert into Book_Authors (book_id, author_id) values (548, 97);
insert into Book_Authors (book_id, author_id) values (549, 299);
insert into Book_Authors (book_id, author_id) values (550, 392);
insert into Book_Authors (book_id, author_id) values (551, 15);
insert into Book_Authors (book_id, author_id) values (552, 173);
insert into Book_Authors (book_id, author_id) values (553, 176);
insert into Book_Authors (book_id, author_id) values (554, 222);
insert into Book_Authors (book_id, author_id) values (555, 140);
insert into Book_Authors (book_id, author_id) values (556, 29);
insert into Book_Authors (book_id, author_id) values (557, 222);
insert into Book_Authors (book_id, author_id) values (558, 302);
insert into Book_Authors (book_id, author_id) values (559, 162);
insert into Book_Authors (book_id, author_id) values (560, 218);
insert into Book_Authors (book_id, author_id) values (561, 7);
insert into Book_Authors (book_id, author_id) values (562, 369);
insert into Book_Authors (book_id, author_id) values (563, 238);
insert into Book_Authors (book_id, author_id) values (564, 43);
insert into Book_Authors (book_id, author_id) values (565, 156);
insert into Book_Authors (book_id, author_id) values (566, 11);
insert into Book_Authors (book_id, author_id) values (567, 311);
insert into Book_Authors (book_id, author_id) values (568, 326);
insert into Book_Authors (book_id, author_id) values (569, 221);
insert into Book_Authors (book_id, author_id) values (570, 149);
insert into Book_Authors (book_id, author_id) values (571, 146);
insert into Book_Authors (book_id, author_id) values (572, 350);
insert into Book_Authors (book_id, author_id) values (573, 24);
insert into Book_Authors (book_id, author_id) values (574, 286);
insert into Book_Authors (book_id, author_id) values (575, 274);
insert into Book_Authors (book_id, author_id) values (576, 65);
insert into Book_Authors (book_id, author_id) values (577, 160);
insert into Book_Authors (book_id, author_id) values (578, 333);
insert into Book_Authors (book_id, author_id) values (579, 57);
insert into Book_Authors (book_id, author_id) values (580, 362);
insert into Book_Authors (book_id, author_id) values (581, 215);
insert into Book_Authors (book_id, author_id) values (582, 281);
insert into Book_Authors (book_id, author_id) values (583, 339);
insert into Book_Authors (book_id, author_id) values (584, 24);
insert into Book_Authors (book_id, author_id) values (585, 90);
insert into Book_Authors (book_id, author_id) values (586, 169);
insert into Book_Authors (book_id, author_id) values (587, 340);
insert into Book_Authors (book_id, author_id) values (588, 72);
insert into Book_Authors (book_id, author_id) values (589, 369);
insert into Book_Authors (book_id, author_id) values (590, 70);
insert into Book_Authors (book_id, author_id) values (591, 113);
insert into Book_Authors (book_id, author_id) values (592, 79);
insert into Book_Authors (book_id, author_id) values (593, 304);
insert into Book_Authors (book_id, author_id) values (594, 6);
insert into Book_Authors (book_id, author_id) values (595, 160);
insert into Book_Authors (book_id, author_id) values (596, 260);
insert into Book_Authors (book_id, author_id) values (597, 111);
insert into Book_Authors (book_id, author_id) values (598, 310);
insert into Book_Authors (book_id, author_id) values (599, 39);
insert into Book_Authors (book_id, author_id) values (600, 165);
insert into Book_Authors (book_id, author_id) values (601, 29);
insert into Book_Authors (book_id, author_id) values (602, 263);
insert into Book_Authors (book_id, author_id) values (603, 235);
insert into Book_Authors (book_id, author_id) values (604, 189);
insert into Book_Authors (book_id, author_id) values (605, 245);
insert into Book_Authors (book_id, author_id) values (606, 233);
insert into Book_Authors (book_id, author_id) values (607, 265);
insert into Book_Authors (book_id, author_id) values (608, 80);
insert into Book_Authors (book_id, author_id) values (609, 390);
insert into Book_Authors (book_id, author_id) values (610, 211);
insert into Book_Authors (book_id, author_id) values (611, 339);
insert into Book_Authors (book_id, author_id) values (612, 394);
insert into Book_Authors (book_id, author_id) values (613, 65);
insert into Book_Authors (book_id, author_id) values (614, 237);
insert into Book_Authors (book_id, author_id) values (615, 309);
insert into Book_Authors (book_id, author_id) values (616, 24);
insert into Book_Authors (book_id, author_id) values (617, 42);
insert into Book_Authors (book_id, author_id) values (618, 66);
insert into Book_Authors (book_id, author_id) values (619, 205);
insert into Book_Authors (book_id, author_id) values (620, 388);
insert into Book_Authors (book_id, author_id) values (621, 275);
insert into Book_Authors (book_id, author_id) values (622, 276);
insert into Book_Authors (book_id, author_id) values (623, 7);
insert into Book_Authors (book_id, author_id) values (624, 10);
insert into Book_Authors (book_id, author_id) values (625, 169);
insert into Book_Authors (book_id, author_id) values (626, 32);
insert into Book_Authors (book_id, author_id) values (627, 161);
insert into Book_Authors (book_id, author_id) values (628, 219);
insert into Book_Authors (book_id, author_id) values (629, 285);
insert into Book_Authors (book_id, author_id) values (630, 283);
insert into Book_Authors (book_id, author_id) values (631, 182);
insert into Book_Authors (book_id, author_id) values (632, 234);
insert into Book_Authors (book_id, author_id) values (633, 299);
insert into Book_Authors (book_id, author_id) values (634, 256);
insert into Book_Authors (book_id, author_id) values (635, 198);
insert into Book_Authors (book_id, author_id) values (636, 141);
insert into Book_Authors (book_id, author_id) values (637, 343);
insert into Book_Authors (book_id, author_id) values (638, 239);
insert into Book_Authors (book_id, author_id) values (639, 58);
insert into Book_Authors (book_id, author_id) values (640, 255);
insert into Book_Authors (book_id, author_id) values (641, 116);
insert into Book_Authors (book_id, author_id) values (642, 116);
insert into Book_Authors (book_id, author_id) values (643, 9);
insert into Book_Authors (book_id, author_id) values (644, 173);
insert into Book_Authors (book_id, author_id) values (645, 334);
insert into Book_Authors (book_id, author_id) values (646, 261);
insert into Book_Authors (book_id, author_id) values (647, 279);
insert into Book_Authors (book_id, author_id) values (648, 70);
insert into Book_Authors (book_id, author_id) values (649, 329);
insert into Book_Authors (book_id, author_id) values (650, 131);
insert into Book_Authors (book_id, author_id) values (651, 313);
insert into Book_Authors (book_id, author_id) values (652, 46);
insert into Book_Authors (book_id, author_id) values (653, 157);
insert into Book_Authors (book_id, author_id) values (654, 242);
insert into Book_Authors (book_id, author_id) values (655, 138);
insert into Book_Authors (book_id, author_id) values (656, 280);
insert into Book_Authors (book_id, author_id) values (657, 95);
insert into Book_Authors (book_id, author_id) values (658, 301);
insert into Book_Authors (book_id, author_id) values (659, 250);
insert into Book_Authors (book_id, author_id) values (660, 257);
insert into Book_Authors (book_id, author_id) values (661, 5);
insert into Book_Authors (book_id, author_id) values (662, 181);
insert into Book_Authors (book_id, author_id) values (663, 119);
insert into Book_Authors (book_id, author_id) values (664, 73);
insert into Book_Authors (book_id, author_id) values (665, 255);
insert into Book_Authors (book_id, author_id) values (666, 159);
insert into Book_Authors (book_id, author_id) values (667, 277);
insert into Book_Authors (book_id, author_id) values (668, 76);
insert into Book_Authors (book_id, author_id) values (669, 174);
insert into Book_Authors (book_id, author_id) values (670, 348);
insert into Book_Authors (book_id, author_id) values (671, 392);
insert into Book_Authors (book_id, author_id) values (672, 391);
insert into Book_Authors (book_id, author_id) values (673, 93);
insert into Book_Authors (book_id, author_id) values (674, 109);
insert into Book_Authors (book_id, author_id) values (675, 46);
insert into Book_Authors (book_id, author_id) values (676, 280);
insert into Book_Authors (book_id, author_id) values (677, 209);
insert into Book_Authors (book_id, author_id) values (678, 365);
insert into Book_Authors (book_id, author_id) values (679, 187);
insert into Book_Authors (book_id, author_id) values (680, 100);
insert into Book_Authors (book_id, author_id) values (681, 237);
insert into Book_Authors (book_id, author_id) values (682, 11);
insert into Book_Authors (book_id, author_id) values (683, 197);
insert into Book_Authors (book_id, author_id) values (684, 274);
insert into Book_Authors (book_id, author_id) values (685, 110);
insert into Book_Authors (book_id, author_id) values (686, 148);
insert into Book_Authors (book_id, author_id) values (687, 393);
insert into Book_Authors (book_id, author_id) values (688, 80);
insert into Book_Authors (book_id, author_id) values (689, 283);
insert into Book_Authors (book_id, author_id) values (690, 173);
insert into Book_Authors (book_id, author_id) values (691, 156);
insert into Book_Authors (book_id, author_id) values (692, 143);
insert into Book_Authors (book_id, author_id) values (693, 199);
insert into Book_Authors (book_id, author_id) values (694, 262);
insert into Book_Authors (book_id, author_id) values (695, 6);
insert into Book_Authors (book_id, author_id) values (696, 228);
insert into Book_Authors (book_id, author_id) values (697, 224);
insert into Book_Authors (book_id, author_id) values (698, 318);
insert into Book_Authors (book_id, author_id) values (699, 151);
insert into Book_Authors (book_id, author_id) values (700, 326);
insert into Book_Authors (book_id, author_id) values (701, 302);
insert into Book_Authors (book_id, author_id) values (702, 82);
insert into Book_Authors (book_id, author_id) values (703, 382);
insert into Book_Authors (book_id, author_id) values (704, 368);
insert into Book_Authors (book_id, author_id) values (705, 11);
insert into Book_Authors (book_id, author_id) values (706, 374);
insert into Book_Authors (book_id, author_id) values (707, 160);
insert into Book_Authors (book_id, author_id) values (708, 62);
insert into Book_Authors (book_id, author_id) values (709, 47);
insert into Book_Authors (book_id, author_id) values (710, 381);
insert into Book_Authors (book_id, author_id) values (711, 369);
insert into Book_Authors (book_id, author_id) values (712, 108);
insert into Book_Authors (book_id, author_id) values (713, 103);
insert into Book_Authors (book_id, author_id) values (714, 254);
insert into Book_Authors (book_id, author_id) values (715, 139);
insert into Book_Authors (book_id, author_id) values (716, 160);
insert into Book_Authors (book_id, author_id) values (717, 309);
insert into Book_Authors (book_id, author_id) values (718, 63);
insert into Book_Authors (book_id, author_id) values (719, 306);
insert into Book_Authors (book_id, author_id) values (720, 49);
insert into Book_Authors (book_id, author_id) values (721, 356);
insert into Book_Authors (book_id, author_id) values (722, 65);
insert into Book_Authors (book_id, author_id) values (723, 216);
insert into Book_Authors (book_id, author_id) values (724, 348);
insert into Book_Authors (book_id, author_id) values (725, 335);
insert into Book_Authors (book_id, author_id) values (726, 277);
insert into Book_Authors (book_id, author_id) values (727, 291);
insert into Book_Authors (book_id, author_id) values (728, 348);
insert into Book_Authors (book_id, author_id) values (729, 307);
insert into Book_Authors (book_id, author_id) values (730, 130);
insert into Book_Authors (book_id, author_id) values (731, 206);
insert into Book_Authors (book_id, author_id) values (732, 240);
insert into Book_Authors (book_id, author_id) values (733, 189);
insert into Book_Authors (book_id, author_id) values (734, 123);
insert into Book_Authors (book_id, author_id) values (735, 111);
insert into Book_Authors (book_id, author_id) values (736, 251);
insert into Book_Authors (book_id, author_id) values (737, 268);
insert into Book_Authors (book_id, author_id) values (738, 194);
insert into Book_Authors (book_id, author_id) values (739, 265);
insert into Book_Authors (book_id, author_id) values (740, 6);
insert into Book_Authors (book_id, author_id) values (741, 386);
insert into Book_Authors (book_id, author_id) values (742, 289);
insert into Book_Authors (book_id, author_id) values (743, 387);
insert into Book_Authors (book_id, author_id) values (744, 33);
insert into Book_Authors (book_id, author_id) values (745, 339);
insert into Book_Authors (book_id, author_id) values (746, 241);
insert into Book_Authors (book_id, author_id) values (747, 240);
insert into Book_Authors (book_id, author_id) values (748, 3);
insert into Book_Authors (book_id, author_id) values (749, 143);
insert into Book_Authors (book_id, author_id) values (750, 354);
insert into Book_Authors (book_id, author_id) values (751, 328);
insert into Book_Authors (book_id, author_id) values (752, 157);
insert into Book_Authors (book_id, author_id) values (753, 332);
insert into Book_Authors (book_id, author_id) values (754, 90);
insert into Book_Authors (book_id, author_id) values (755, 60);
insert into Book_Authors (book_id, author_id) values (756, 303);
insert into Book_Authors (book_id, author_id) values (757, 5);
insert into Book_Authors (book_id, author_id) values (758, 200);
insert into Book_Authors (book_id, author_id) values (759, 109);
insert into Book_Authors (book_id, author_id) values (760, 17);
insert into Book_Authors (book_id, author_id) values (761, 164);
insert into Book_Authors (book_id, author_id) values (762, 159);
insert into Book_Authors (book_id, author_id) values (763, 348);
insert into Book_Authors (book_id, author_id) values (764, 393);
insert into Book_Authors (book_id, author_id) values (765, 254);
insert into Book_Authors (book_id, author_id) values (766, 40);
insert into Book_Authors (book_id, author_id) values (767, 390);
insert into Book_Authors (book_id, author_id) values (768, 297);
insert into Book_Authors (book_id, author_id) values (769, 77);
insert into Book_Authors (book_id, author_id) values (770, 195);
insert into Book_Authors (book_id, author_id) values (771, 362);
insert into Book_Authors (book_id, author_id) values (772, 125);
insert into Book_Authors (book_id, author_id) values (773, 220);
insert into Book_Authors (book_id, author_id) values (774, 234);
insert into Book_Authors (book_id, author_id) values (775, 51);
insert into Book_Authors (book_id, author_id) values (776, 55);
insert into Book_Authors (book_id, author_id) values (777, 156);
insert into Book_Authors (book_id, author_id) values (778, 197);
insert into Book_Authors (book_id, author_id) values (779, 329);
insert into Book_Authors (book_id, author_id) values (780, 215);
insert into Book_Authors (book_id, author_id) values (781, 200);
insert into Book_Authors (book_id, author_id) values (782, 290);
insert into Book_Authors (book_id, author_id) values (783, 400);
insert into Book_Authors (book_id, author_id) values (784, 2);
insert into Book_Authors (book_id, author_id) values (785, 220);
insert into Book_Authors (book_id, author_id) values (786, 218);
insert into Book_Authors (book_id, author_id) values (787, 343);
insert into Book_Authors (book_id, author_id) values (788, 263);
insert into Book_Authors (book_id, author_id) values (789, 205);
insert into Book_Authors (book_id, author_id) values (790, 66);
insert into Book_Authors (book_id, author_id) values (791, 208);
insert into Book_Authors (book_id, author_id) values (792, 31);
insert into Book_Authors (book_id, author_id) values (793, 20);
insert into Book_Authors (book_id, author_id) values (794, 199);
insert into Book_Authors (book_id, author_id) values (795, 32);
insert into Book_Authors (book_id, author_id) values (796, 341);
insert into Book_Authors (book_id, author_id) values (797, 11);
insert into Book_Authors (book_id, author_id) values (798, 131);
insert into Book_Authors (book_id, author_id) values (799, 206);
insert into Book_Authors (book_id, author_id) values (800, 298);
insert into Book_Authors (book_id, author_id) values (801, 229);
insert into Book_Authors (book_id, author_id) values (802, 246);
insert into Book_Authors (book_id, author_id) values (803, 187);
insert into Book_Authors (book_id, author_id) values (804, 356);
insert into Book_Authors (book_id, author_id) values (805, 151);
insert into Book_Authors (book_id, author_id) values (806, 30);
insert into Book_Authors (book_id, author_id) values (807, 25);
insert into Book_Authors (book_id, author_id) values (808, 258);
insert into Book_Authors (book_id, author_id) values (809, 16);
insert into Book_Authors (book_id, author_id) values (810, 18);
insert into Book_Authors (book_id, author_id) values (811, 397);
insert into Book_Authors (book_id, author_id) values (812, 194);
insert into Book_Authors (book_id, author_id) values (813, 284);
insert into Book_Authors (book_id, author_id) values (814, 346);
insert into Book_Authors (book_id, author_id) values (815, 139);
insert into Book_Authors (book_id, author_id) values (816, 391);
insert into Book_Authors (book_id, author_id) values (817, 27);
insert into Book_Authors (book_id, author_id) values (818, 27);
insert into Book_Authors (book_id, author_id) values (819, 149);
insert into Book_Authors (book_id, author_id) values (820, 316);
insert into Book_Authors (book_id, author_id) values (821, 8);
insert into Book_Authors (book_id, author_id) values (822, 372);
insert into Book_Authors (book_id, author_id) values (823, 384);
insert into Book_Authors (book_id, author_id) values (824, 340);
insert into Book_Authors (book_id, author_id) values (825, 123);
insert into Book_Authors (book_id, author_id) values (826, 185);
insert into Book_Authors (book_id, author_id) values (827, 321);
insert into Book_Authors (book_id, author_id) values (828, 281);
insert into Book_Authors (book_id, author_id) values (829, 133);
insert into Book_Authors (book_id, author_id) values (830, 118);
insert into Book_Authors (book_id, author_id) values (831, 136);
insert into Book_Authors (book_id, author_id) values (832, 301);
insert into Book_Authors (book_id, author_id) values (833, 309);
insert into Book_Authors (book_id, author_id) values (834, 110);
insert into Book_Authors (book_id, author_id) values (835, 281);
insert into Book_Authors (book_id, author_id) values (836, 329);
insert into Book_Authors (book_id, author_id) values (837, 331);
insert into Book_Authors (book_id, author_id) values (838, 32);
insert into Book_Authors (book_id, author_id) values (839, 12);
insert into Book_Authors (book_id, author_id) values (840, 52);
insert into Book_Authors (book_id, author_id) values (841, 218);
insert into Book_Authors (book_id, author_id) values (842, 159);
insert into Book_Authors (book_id, author_id) values (843, 314);
insert into Book_Authors (book_id, author_id) values (844, 321);
insert into Book_Authors (book_id, author_id) values (845, 367);
insert into Book_Authors (book_id, author_id) values (846, 61);
insert into Book_Authors (book_id, author_id) values (847, 190);
insert into Book_Authors (book_id, author_id) values (848, 167);
insert into Book_Authors (book_id, author_id) values (849, 178);
insert into Book_Authors (book_id, author_id) values (850, 204);
insert into Book_Authors (book_id, author_id) values (851, 45);
insert into Book_Authors (book_id, author_id) values (852, 91);
insert into Book_Authors (book_id, author_id) values (853, 168);
insert into Book_Authors (book_id, author_id) values (854, 304);
insert into Book_Authors (book_id, author_id) values (855, 222);
insert into Book_Authors (book_id, author_id) values (856, 100);
insert into Book_Authors (book_id, author_id) values (857, 268);
insert into Book_Authors (book_id, author_id) values (858, 154);
insert into Book_Authors (book_id, author_id) values (859, 215);
insert into Book_Authors (book_id, author_id) values (860, 204);
insert into Book_Authors (book_id, author_id) values (861, 373);
insert into Book_Authors (book_id, author_id) values (862, 131);
insert into Book_Authors (book_id, author_id) values (863, 76);
insert into Book_Authors (book_id, author_id) values (864, 52);
insert into Book_Authors (book_id, author_id) values (865, 217);
insert into Book_Authors (book_id, author_id) values (866, 257);
insert into Book_Authors (book_id, author_id) values (867, 254);
insert into Book_Authors (book_id, author_id) values (868, 390);
insert into Book_Authors (book_id, author_id) values (869, 230);
insert into Book_Authors (book_id, author_id) values (870, 292);
insert into Book_Authors (book_id, author_id) values (871, 233);
insert into Book_Authors (book_id, author_id) values (872, 321);
insert into Book_Authors (book_id, author_id) values (873, 213);
insert into Book_Authors (book_id, author_id) values (874, 293);
insert into Book_Authors (book_id, author_id) values (875, 134);
insert into Book_Authors (book_id, author_id) values (876, 11);
insert into Book_Authors (book_id, author_id) values (877, 355);
insert into Book_Authors (book_id, author_id) values (878, 39);
insert into Book_Authors (book_id, author_id) values (879, 193);
insert into Book_Authors (book_id, author_id) values (880, 258);
insert into Book_Authors (book_id, author_id) values (881, 243);
insert into Book_Authors (book_id, author_id) values (882, 106);
insert into Book_Authors (book_id, author_id) values (883, 26);
insert into Book_Authors (book_id, author_id) values (884, 98);
insert into Book_Authors (book_id, author_id) values (885, 65);
insert into Book_Authors (book_id, author_id) values (886, 36);
insert into Book_Authors (book_id, author_id) values (887, 90);
insert into Book_Authors (book_id, author_id) values (888, 399);
insert into Book_Authors (book_id, author_id) values (889, 11);
insert into Book_Authors (book_id, author_id) values (890, 85);
insert into Book_Authors (book_id, author_id) values (891, 350);
insert into Book_Authors (book_id, author_id) values (892, 55);
insert into Book_Authors (book_id, author_id) values (893, 313);
insert into Book_Authors (book_id, author_id) values (894, 391);
insert into Book_Authors (book_id, author_id) values (895, 35);
insert into Book_Authors (book_id, author_id) values (896, 198);
insert into Book_Authors (book_id, author_id) values (897, 354);
insert into Book_Authors (book_id, author_id) values (898, 119);
insert into Book_Authors (book_id, author_id) values (899, 271);
insert into Book_Authors (book_id, author_id) values (900, 289);
insert into Book_Authors (book_id, author_id) values (901, 91);
insert into Book_Authors (book_id, author_id) values (902, 305);
insert into Book_Authors (book_id, author_id) values (903, 343);
insert into Book_Authors (book_id, author_id) values (904, 70);
insert into Book_Authors (book_id, author_id) values (905, 223);
insert into Book_Authors (book_id, author_id) values (906, 259);
insert into Book_Authors (book_id, author_id) values (907, 10);
insert into Book_Authors (book_id, author_id) values (908, 392);
insert into Book_Authors (book_id, author_id) values (909, 318);
insert into Book_Authors (book_id, author_id) values (910, 285);
insert into Book_Authors (book_id, author_id) values (911, 5);
insert into Book_Authors (book_id, author_id) values (912, 187);
insert into Book_Authors (book_id, author_id) values (913, 395);
insert into Book_Authors (book_id, author_id) values (914, 302);
insert into Book_Authors (book_id, author_id) values (915, 232);
insert into Book_Authors (book_id, author_id) values (916, 43);
insert into Book_Authors (book_id, author_id) values (917, 216);
insert into Book_Authors (book_id, author_id) values (918, 206);
insert into Book_Authors (book_id, author_id) values (919, 197);
insert into Book_Authors (book_id, author_id) values (920, 27);
insert into Book_Authors (book_id, author_id) values (921, 365);
insert into Book_Authors (book_id, author_id) values (922, 54);
insert into Book_Authors (book_id, author_id) values (923, 172);
insert into Book_Authors (book_id, author_id) values (924, 4);
insert into Book_Authors (book_id, author_id) values (925, 165);
insert into Book_Authors (book_id, author_id) values (926, 313);
insert into Book_Authors (book_id, author_id) values (927, 376);
insert into Book_Authors (book_id, author_id) values (928, 221);
insert into Book_Authors (book_id, author_id) values (929, 373);
insert into Book_Authors (book_id, author_id) values (930, 250);
insert into Book_Authors (book_id, author_id) values (931, 203);
insert into Book_Authors (book_id, author_id) values (932, 323);
insert into Book_Authors (book_id, author_id) values (933, 139);
insert into Book_Authors (book_id, author_id) values (934, 195);
insert into Book_Authors (book_id, author_id) values (935, 136);
insert into Book_Authors (book_id, author_id) values (936, 249);
insert into Book_Authors (book_id, author_id) values (937, 131);
insert into Book_Authors (book_id, author_id) values (938, 187);
insert into Book_Authors (book_id, author_id) values (939, 118);
insert into Book_Authors (book_id, author_id) values (940, 371);
insert into Book_Authors (book_id, author_id) values (941, 179);
insert into Book_Authors (book_id, author_id) values (942, 181);
insert into Book_Authors (book_id, author_id) values (943, 60);
insert into Book_Authors (book_id, author_id) values (944, 346);
insert into Book_Authors (book_id, author_id) values (945, 340);
insert into Book_Authors (book_id, author_id) values (946, 233);
insert into Book_Authors (book_id, author_id) values (947, 41);
insert into Book_Authors (book_id, author_id) values (948, 13);
insert into Book_Authors (book_id, author_id) values (949, 318);
insert into Book_Authors (book_id, author_id) values (950, 373);
insert into Book_Authors (book_id, author_id) values (951, 353);
insert into Book_Authors (book_id, author_id) values (952, 210);
insert into Book_Authors (book_id, author_id) values (953, 306);
insert into Book_Authors (book_id, author_id) values (954, 351);
insert into Book_Authors (book_id, author_id) values (955, 31);
insert into Book_Authors (book_id, author_id) values (956, 197);
insert into Book_Authors (book_id, author_id) values (957, 230);
insert into Book_Authors (book_id, author_id) values (958, 76);
insert into Book_Authors (book_id, author_id) values (959, 154);
insert into Book_Authors (book_id, author_id) values (960, 9);
insert into Book_Authors (book_id, author_id) values (961, 298);
insert into Book_Authors (book_id, author_id) values (962, 347);
insert into Book_Authors (book_id, author_id) values (963, 304);
insert into Book_Authors (book_id, author_id) values (964, 187);
insert into Book_Authors (book_id, author_id) values (965, 68);
insert into Book_Authors (book_id, author_id) values (966, 205);
insert into Book_Authors (book_id, author_id) values (967, 328);
insert into Book_Authors (book_id, author_id) values (968, 224);
insert into Book_Authors (book_id, author_id) values (969, 373);
insert into Book_Authors (book_id, author_id) values (970, 61);
insert into Book_Authors (book_id, author_id) values (971, 372);
insert into Book_Authors (book_id, author_id) values (972, 12);
insert into Book_Authors (book_id, author_id) values (973, 264);
insert into Book_Authors (book_id, author_id) values (974, 273);
insert into Book_Authors (book_id, author_id) values (975, 85);
insert into Book_Authors (book_id, author_id) values (976, 219);
insert into Book_Authors (book_id, author_id) values (977, 341);
insert into Book_Authors (book_id, author_id) values (978, 70);
insert into Book_Authors (book_id, author_id) values (979, 219);
insert into Book_Authors (book_id, author_id) values (980, 299);
insert into Book_Authors (book_id, author_id) values (981, 116);
insert into Book_Authors (book_id, author_id) values (982, 54);
insert into Book_Authors (book_id, author_id) values (983, 301);
insert into Book_Authors (book_id, author_id) values (984, 1);
insert into Book_Authors (book_id, author_id) values (985, 337);
insert into Book_Authors (book_id, author_id) values (986, 277);
insert into Book_Authors (book_id, author_id) values (987, 341);
insert into Book_Authors (book_id, author_id) values (988, 185);
insert into Book_Authors (book_id, author_id) values (989, 46);
insert into Book_Authors (book_id, author_id) values (990, 81);
insert into Book_Authors (book_id, author_id) values (991, 259);
insert into Book_Authors (book_id, author_id) values (992, 314);
insert into Book_Authors (book_id, author_id) values (993, 123);
insert into Book_Authors (book_id, author_id) values (994, 211);
insert into Book_Authors (book_id, author_id) values (995, 366);
insert into Book_Authors (book_id, author_id) values (996, 311);
insert into Book_Authors (book_id, author_id) values (997, 186);
insert into Book_Authors (book_id, author_id) values (998, 120);
insert into Book_Authors (book_id, author_id) values (999, 340);
insert into Book_Authors (book_id, author_id) values (1000, 386);

insert into parameter (name, value) VALUES ('whatsapp', 'EAALp1sLIddsBO7znGRDvZBYqMchVZAEhN5LovgegF7vl5RSWqrMCfN9dWxrMctJf7ulCbdGFpDWxPS1uRAvKset99YM0JI1A3P3tJzet915YhEUjkG1lro3OxcYqQLV6CSM8g8sZBYpZANjt9ZC2zRMyHRqZB9UktVPoW0JHbpDyYyjLvqmkCMOyZBk8nJ99x6uK9N2U6f9YXrU2JFCh6JsAZAfXaqiB');
INSERT INTO template (name, json_body, status, meta_content) VALUES ('library_update', '{
    "messaging_product": "whatsapp",
    "to": "{{PHONE_NUMBER}}",
    "type": "template",
    "template": {
        "name": "{{NAME_TEMPLATE}}",
        "language": {
            "code": "ES"
        },
        "components": [
            {
                "type": "body",
                "parameters": [
                    {
                        "type": "text",
                        "text": "{{1}}"
                    },
                    {
                        "type": "text",
                        "text": "{{2}}"
                    },
                    {
                        "type": "text",
                        "text": "{{3}}"
                    },
                    {
                        "type": "text",
                        "text": "{{4}}"
                    },
                    {
                        "type": "text",
                        "text": "{{5}}"
                    },
                    {
                        "type": "text",
                        "text": "{{6}}"
                    }
                ]
            }
        ]
    }
}', true,'Estimado/a {{1}}:

Le informamos que su reserva del ambiente de estudio ha sido modificada. A continuación, le detallamos la información actualizada:

* Fecha: {{2}}
* Hora de entrada: {{3}}
* Hora de salida: {{4}}
* Ambiente: {{5}}
* Proposito: {{6}}

Para cualquier pregunta o ajuste adicional, no dude en ponerse en contacto con nosotros. Apreciamos su comprensión y estamos aquí para ayudarle a planificar su tiempo de estudio de la mejor manera posible.

Gracias por su confianza.');


INSERT INTO template (name, json_body, status, meta_content) VALUES ('ambiente_aceptado', '{
    "messaging_product": "whatsapp",
    "to": "{{PHONE_NUMBER}}",
    "type": "template",
    "template": {
        "name": "{{NAME_TEMPLATE}}",
        "language": {
            "code": "ES"
        },
        "components": [
            {
                "type": "body",
                "parameters": [
                    {
                        "type": "text",
                        "text": "{{1}}"
                    },
                    {
                        "type": "text",
                        "text": "{{2}}"
                    },
                    {
                        "type": "text",
                        "text": "{{3}}"
                    },
                    {
                        "type": "text",
                        "text": "{{4}}"
                    },
                    {
                        "type": "text",
                        "text": "{{5}}"
                    }
                ]
            }
        ]
    }
}', true,'Estimado/a {{1}},

Nos complace informarle que su reserva del ambiente de estudio ha sido *aceptada* y ha sido procesada exitosamente. A continuación, le brindamos los detalles de su reserva:

* Fecha: {{2}}
* Hora de entrada: {{3}}
* Hora de salida: {{4}}
* Ambiente: {{5}}

Estamos a su disposición para cualquier pregunta o asistencia adicional que pueda necesitar. Agradecemos su confianza en nuestros servicios y esperamos que su experiencia de estudio sea satisfactoria.');


INSERT INTO template (name, json_body, status, meta_content) VALUES ('plantilla_cancelada', '{
    "messaging_product": "whatsapp",
    "to": "{{PHONE_NUMBER}}",
    "type": "template",
    "template": {
        "name": "{{NAME_TEMPLATE}}",
        "language": {
            "code": "ES"
        },
        "components": [
            {
                "type": "body",
                "parameters": [
                    {
                        "type": "text",
                        "text": "{{1}}"
                    },
                    {
                        "type": "text",
                        "text": "{{2}}"
                    },
                    {
                        "type": "text",
                        "text": "{{3}}"
                    },
                    {
                        "type": "text",
                        "text": "{{4}}"
                    },
                    {
                        "type": "text",
                        "text": "{{5}}"
                    }
                ]
            }
        ]
    }
}', true, 'Estimado/a {{1}},

Lamentamos informarle que su solicitud de reserva para el ambiente de estudio ha sido cancelada. A continuación, le proporcionamos los detalles de la solicitud:
* Fecha: {{2}}
* Hora de entrada: {{3}}
* Hora de salida: {{4}}
* Ambiente: {{5}}
Si desea realizar una nueva solicitud o tiene alguna consulta, no dude en contactarnos. Estamos aquí para ayudarle a encontrar una solución que se adapte a sus necesidades de estudio.

Gracias por su comprensión.');

INSERT INTO template (name, json_body, status, meta_content) VALUES ('devolucion_libro', '{
    "messaging_product": "whatsapp",
    "to": "{{PHONE_NUMBER}}",
    "type": "template",
    "template": {
        "name": "{{NAME_TEMPLATE}}",
        "language": {
            "code": "ES"
        },
        "components": [
            {
                "type": "body",
                "parameters": [
                    {
                        "type": "text",
                        "text": "{{1}}"
                    },
                    {
                        "type": "text",
                        "text": "{{2}}"
                    },
                    {
                        "type": "text",
                        "text": "{{3}}"
                    }
                ]
            }
        ]
    }
}', true, 'Estimado/a {{1}},

Le recordamos que se acerca la fecha de devolución del libro que ha tomado en préstamo de nuestra biblioteca. A continuación, le detallamos la información:

Título del Libro: {{2}}
Fecha de Devolución: {{3}}

Le recomendamos devolver el libro a tiempo para evitar posibles multas. Gracias por su atención y por ser parte de nuestra comunidad,');

INSERT INTO template (name, json_body, status, meta_content) VALUES ('fine', '{
    "messaging_product": "whatsapp",
    "to": "{{PHONE_NUMBER}}",
    "type": "template",
    "template": {
        "name": "{{NAME_TEMPLATE}}",
        "language": {
            "code": "ES"
        },
        "components": [
            {
                "type": "body",
                "parameters": [
                    {
                        "type": "text",
                        "text": "{{1}}"
                    },
                    {
                        "type": "text",
                        "text": "{{2}}"
                    },
                    {
                        "type": "text",
                        "text": "{{3}}"
                    },
                    {
                        "type": "text",
                        "text": "{{4}}"
                    },
                    {
                        "type": "text",
                        "text": "{{5}}"
                    }
                ]
            }
        ]
    }
}', true, 'Estimado/a {{1}},
Le informamos que ha pasado la fecha límite de devolución del libro que tomó en préstamo de nuestra biblioteca. A continuación, le proporcionamos los detalles:

Título del Libro: {{2}}
Fecha de Devolución Original: {{3}}
Fecha de Notificación: {{4}}
Detalle: {{5}}

Lamentablemente, debido al retraso, se ha generado una multa por demora. Por favor, diríjase a la biblioteca para ser atendido por un bibliotecario y evitar más cargos.

Gracias por su comprensión y atención.');

INSERT INTO template (name, json_body, status, meta_content)
VALUES (
           'loan_extension',
           '{
               "messaging_product": "whatsapp",
               "to": "{{PHONE_NUMBER}}",
               "type": "template",
               "template": {
                   "name": "{{NAME_TEMPLATE}}",
                   "language": {
                       "code": "ES"
                   },
                   "components": [
                       {
                           "type": "body",
                           "parameters": [
                               {
                                   "type": "text",
                                   "text": "{{1}}"
                               },
                               {
                                   "type": "text",
                                   "text": "{{2}}"
                               },
                               {
                                   "type": "text",
                                   "text": "{{3}}"
                               },
                               {
                                   "type": "text",
                                   "text": "{{4}}"
                               }
                           ]
                       }
                   ]
               }
           }',
           true,
           'Estimado/a {{1}},
       Nos complace informarle que su solicitud de extensión de préstamo del libro ha sido aprobada. Aquí están los detalles:

       Título del Libro: {{2}}
       Nueva Fecha de Devolución: {{3}}
       Fecha de Notificación: {{4}}

       Gracias por confiar en nuestra biblioteca. Si tiene alguna pregunta, no dude en contactarnos.'
       );

INSERT INTO template (name, json_body, status, meta_content)
VALUES (
           'loan_cancellation',
           '{
               "messaging_product": "whatsapp",
               "to": "{{PHONE_NUMBER}}",
               "type": "template",
               "template": {
                   "name": "{{NAME_TEMPLATE}}",
                   "language": {
                       "code": "ES"
                   },
                   "components": [
                       {
                           "type": "body",
                           "parameters": [
                               {
                                   "type": "text",
                                   "text": "{{1}}"
                               },
                               {
                                   "type": "text",
                                   "text": "{{2}}"
                               },
                               {
                                   "type": "text",
                                   "text": "{{3}}"
                               },
                               {
                                   "type": "text",
                                   "text": "{{4}}"
                               }
                           ]
                       }
                   ]
               }
           }',
           true,
           'Estimado/a {{1}},
       Lamentamos informarle que su solicitud de préstamo del libro "{{2}}" ha sido cancelada. Aquí están los detalles:

       Título del Libro: {{2}}
       Fecha de Solicitud: {{3}}
       Fecha de Notificación: {{4}}

       Le sugerimos explorar otras opciones en nuestro catálogo o contactar con el personal de la biblioteca para más información. Sentimos los inconvenientes ocasionados y agradecemos su comprensión.

       Gracias por confiar en nuestra biblioteca.'
       );

INSERT INTO Type_Fines (description, amount)
VALUES
    ('Multa por retraso en la devolución', 10.00),
    ('Multa por daño al libro', 15.00),
    ('Multa por pérdida de libro', 30.00);
