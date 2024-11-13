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
                      status boolean  NOT NULL,
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

insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 4, 2, 'Wicked Little Things', '905206234-X', '4/1/2015', true, 'http://dummyimage.com/180x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 6, 7, 'FernGully 2: The Magical Rescue', '079158296-5', '10/19/2001', false, 'http://dummyimage.com/144x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 5, 'C(r)ook (Basta - Rotwein Oder Totsein)', '546938310-5', '11/1/2017', true, 'http://dummyimage.com/213x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 3, 6, 'Tess of the Storm Country', '943778956-8', '1/25/2019', false, 'http://dummyimage.com/163x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 8, 'Agatha Christie''s ''Ten Little Indians'' (Ten Little Indians) (And Then There Were None)', '360504229-5', '3/6/2011', true, 'http://dummyimage.com/112x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 3, 1, 'Freshman, The', '175115417-3', '3/17/2008', true, 'http://dummyimage.com/154x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 5, 'Blood on the Moon', '488325516-6', '7/8/2006', true, 'http://dummyimage.com/240x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 1, 1, 'For the Love of Movies', '692059174-X', '12/16/2022', true, 'http://dummyimage.com/205x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 9, 'Bed & Board (Domicile conjugal)', '352519064-6', '4/26/2024', true, 'http://dummyimage.com/139x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 9, 'Memorial Day', '154691033-6', '5/1/2011', false, 'http://dummyimage.com/223x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 5, 7, 'Every Man for Himself (Slow Motion) (Sauve qui peut (la vie))', '044138143-X', '10/16/2017', true, 'http://dummyimage.com/199x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 7, 'Guy', '085589838-0', '4/5/2003', true, 'http://dummyimage.com/119x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 6, 'Arthur Newman', '476588163-6', '10/26/2023', true, 'http://dummyimage.com/195x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 9, 'Land of the Lost', '066378826-9', '10/15/2019', false, 'http://dummyimage.com/101x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 7, 'Soldier in the Rain', '000724010-4', '3/24/2023', false, 'http://dummyimage.com/207x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 5, 7, 'Ninth Configuration, The (a.k.a. Twinkle, Twinkle, Killer Kane)', '573060603-6', '6/20/2005', false, 'http://dummyimage.com/142x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 9, 'Cornelis', '446417724-7', '2/6/2011', true, 'http://dummyimage.com/218x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 2, 'Dragon Ball Z: Bojack Unbound (Doragon bôru Z 9: Ginga girigiri!! Butchigiri no sugoi yatsu)', '485161289-3', '12/19/2000', true, 'http://dummyimage.com/114x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 6, 2, 'Bad Luck (Zezowate szczescie)', '604260195-4', '10/1/2006', true, 'http://dummyimage.com/179x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 6, 9, 'Lost and Delirious', '764584636-4', '2/25/2022', true, 'http://dummyimage.com/201x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 4, 3, 'Turtles Can Fly (Lakposhtha hâm parvaz mikonand)', '436968446-3', '12/31/2015', false, 'http://dummyimage.com/102x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 5, 2, 'The Tree, the Mayor and the Mediatheque', '022171819-2', '9/2/2017', false, 'http://dummyimage.com/106x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 1, 4, 'High Hopes', '446452984-4', '5/11/2004', false, 'http://dummyimage.com/101x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 7, 'American Kickboxer (American Kickboxer 1)', '230739921-6', '8/3/2019', false, 'http://dummyimage.com/239x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 4, 1, 'All for the Winner (Dou sing)', '225786493-X', '4/24/2009', false, 'http://dummyimage.com/141x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 6, 3, 'Dick Figures: The Movie', '716597945-X', '2/19/2021', true, 'http://dummyimage.com/240x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 4, 2, 'Offence, The', '799158303-1', '1/4/2023', true, 'http://dummyimage.com/230x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 1, 'Out of Balance: ExxonMobil''s Impact on Climate Change', '757812052-2', '1/12/2011', true, 'http://dummyimage.com/166x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 5, 7, 'All the Mornings of the World (Tous les matins du monde)', '331036247-7', '5/5/2001', true, 'http://dummyimage.com/204x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 5, 'Spies (Spione)', '037363656-3', '9/24/2012', false, 'http://dummyimage.com/173x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 3, 'Night of the Ghouls', '276290849-3', '1/17/2000', false, 'http://dummyimage.com/149x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 1, 'Buffy the Vampire Slayer', '472144724-8', '5/24/2008', true, 'http://dummyimage.com/197x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 2, 'Night Has a Thousand Eyes', '001092386-1', '8/24/2006', true, 'http://dummyimage.com/112x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 2, 'Patch Adams', '989337579-7', '2/4/2006', true, 'http://dummyimage.com/139x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 1, 'Appleseed Alpha', '080926094-8', '4/21/2017', true, 'http://dummyimage.com/178x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 6, 'Human Planet', '062728107-9', '2/4/2023', true, 'http://dummyimage.com/105x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 2, 'Het Vonnis', '389030606-3', '2/23/2005', true, 'http://dummyimage.com/250x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 6, 9, 'Dog Soldiers', '068356966-X', '10/20/2017', false, 'http://dummyimage.com/149x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 1, 9, 'Hour of the Pig, The', '436397735-3', '2/15/2015', true, 'http://dummyimage.com/209x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 3, '8 (8, the Play)', '846577463-3', '6/17/2024', true, 'http://dummyimage.com/200x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 5, 'King of the Zombies', '928587942-X', '1/5/2011', true, 'http://dummyimage.com/128x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 5, 2, 'Léon: The Professional (a.k.a. The Professional) (Léon)', '827058551-3', '1/15/2012', false, 'http://dummyimage.com/177x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 8, 'Slaughter of the Innocents', '951722918-6', '10/19/2021', true, 'http://dummyimage.com/158x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 2, 2, 'Big Parade, The', '416345999-5', '3/4/2002', false, 'http://dummyimage.com/117x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 9, 'Train', '724928483-5', '9/1/2019', false, 'http://dummyimage.com/130x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 4, 8, 'Blind Date', '645956354-3', '6/12/2019', true, 'http://dummyimage.com/193x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 2, 6, 'Day at the Races, A', '685579490-4', '4/5/2020', false, 'http://dummyimage.com/204x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 8, 'Post Mortem', '063438947-5', '1/23/2006', true, 'http://dummyimage.com/140x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 6, 6, 'In Crowd, The', '762062223-3', '4/11/2019', true, 'http://dummyimage.com/162x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 5, 'Love That Boy', '553818399-8', '6/26/2023', false, 'http://dummyimage.com/107x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 8, 'Tender Comrade', '121308159-9', '3/14/2019', true, 'http://dummyimage.com/120x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 3, 'Hedgehog, The (Le hérisson)', '652120527-7', '12/5/2015', true, 'http://dummyimage.com/126x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 1, 8, 'Last Seven, The', '844478210-6', '7/4/2005', true, 'http://dummyimage.com/170x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 5, 2, 'Perfect Human, The (Perfekte Menneske, Det)', '430577711-8', '2/28/2011', true, 'http://dummyimage.com/107x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 1, 2, 'Finger, The (Dedo, El)', '924964386-1', '10/2/2016', true, 'http://dummyimage.com/173x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 1, 2, 'Comrade Pedersen (Gymnaslærer Pedersen)', '691506599-7', '3/16/2002', true, 'http://dummyimage.com/210x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 1, 9, 'Breaker Morant', '733596650-7', '12/18/2023', false, 'http://dummyimage.com/190x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 4, 4, 'River, The (He liu)', '236025131-7', '11/9/2021', false, 'http://dummyimage.com/242x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 4, 1, 'EuroTrip', '756533851-6', '4/29/2014', true, 'http://dummyimage.com/181x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 8, 'Best Seller', '196713785-4', '4/26/2004', true, 'http://dummyimage.com/156x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 6, 'Bloody Child, The', '206816166-4', '3/20/2000', true, 'http://dummyimage.com/110x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 7, 'Assault on Precinct 13', '209334486-6', '3/5/2022', false, 'http://dummyimage.com/225x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 1, 4, 'Tillbaka till Bromma', '759498887-6', '10/16/2000', false, 'http://dummyimage.com/190x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 4, 'In Two Minds', '242351057-8', '1/31/2014', true, 'http://dummyimage.com/222x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 3, 6, 'Glory Road', '932298916-5', '1/16/2001', false, 'http://dummyimage.com/103x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 3, 'Arena', '490254672-8', '9/12/2016', false, 'http://dummyimage.com/211x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 1, 4, 'Thank You a Lot', '635216456-0', '8/4/2012', true, 'http://dummyimage.com/213x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 6, 9, 'Four Times, The (Le Quattro Volte)', '312093316-3', '11/29/2016', true, 'http://dummyimage.com/213x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 1, 5, 'Sex and the City', '463106893-0', '11/24/2001', false, 'http://dummyimage.com/179x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 2, 'Last Warrior, The (Last Patrol, The)', '564379734-8', '5/6/2015', false, 'http://dummyimage.com/133x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 4, 7, 'Order, The', '628924535-X', '2/8/2004', false, 'http://dummyimage.com/163x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 5, 4, 'Cyclo (Xich lo)', '992874956-6', '6/29/2010', false, 'http://dummyimage.com/121x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 6, 5, 'Confidence', '585906430-6', '10/20/2009', true, 'http://dummyimage.com/106x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 1, 5, 'Code Conspiracy, The', '922937971-9', '1/30/2004', false, 'http://dummyimage.com/116x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 3, 5, 'Deal, The', '568630279-0', '6/3/2013', true, 'http://dummyimage.com/198x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 8, 'Project A (''A'' gai waak)', '810321486-8', '4/16/2018', true, 'http://dummyimage.com/187x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 3, 2, 'Truth About Cats & Dogs, The', '700721839-3', '8/7/2008', true, 'http://dummyimage.com/100x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 8, 'Jingle All the Way', '207320962-9', '6/5/2020', false, 'http://dummyimage.com/222x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 6, 1, 'I Love You Again', '430997459-7', '11/7/2013', false, 'http://dummyimage.com/192x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 5, 'In Fear', '947968043-2', '9/16/2013', true, 'http://dummyimage.com/177x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 9, 'Body of War', '134983244-8', '11/29/2002', false, 'http://dummyimage.com/195x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 3, 2, 'Carnosaur 2', '833447683-3', '5/28/2023', true, 'http://dummyimage.com/177x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 8, 'Seduction of Joe Tynan, The', '084470258-7', '11/28/2020', true, 'http://dummyimage.com/215x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 5, 6, 'Levottomat 3', '942208304-4', '7/1/2008', false, 'http://dummyimage.com/214x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 9, 'Wilderness', '663056763-3', '8/15/2024', false, 'http://dummyimage.com/214x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 4, 'Pixote', '395952106-5', '4/30/2005', false, 'http://dummyimage.com/215x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 9, 'Last Ride, The', '496497456-1', '9/14/2015', false, 'http://dummyimage.com/167x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 3, 'My Way (Mai Wei)', '425704426-8', '5/3/2002', true, 'http://dummyimage.com/121x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 1, 7, 'Dallas: War of the Ewings', '682402586-0', '2/13/2020', false, 'http://dummyimage.com/121x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 8, 'Dreams That Money Can Buy', '785624681-2', '5/27/2001', false, 'http://dummyimage.com/141x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 2, 'Road to Morocco', '686913251-8', '6/13/2020', true, 'http://dummyimage.com/106x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 2, 7, 'Doctor at Sea', '345822240-5', '9/7/2020', true, 'http://dummyimage.com/224x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 5, 5, 'Auntie from Chicago, The (I theia apo to Chicago)', '032254052-6', '5/22/2022', true, 'http://dummyimage.com/204x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 3, 'Smokey and the Bandit', '899331287-7', '9/11/2000', false, 'http://dummyimage.com/208x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 6, 1, 'Hollywood Party', '678404222-0', '3/9/2024', false, 'http://dummyimage.com/237x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 9, 'Trans-Europ-Express', '066277116-8', '5/15/2007', true, 'http://dummyimage.com/165x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 3, 1, 'Cellular', '713006241-X', '10/20/2009', true, 'http://dummyimage.com/207x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 1, 'Zanjeer', '245878575-1', '11/4/2009', true, 'http://dummyimage.com/141x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 2, 'St. George Shoots the Dragon (Sveti Georgije ubiva azdahu)', '078167843-9', '5/21/2001', false, 'http://dummyimage.com/181x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 6, 'First Knight', '846604855-3', '11/18/2021', false, 'http://dummyimage.com/156x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 3, 'Vengeance is Mine (Fukushu suruwa wareniari)', '049301597-3', '4/23/2017', true, 'http://dummyimage.com/147x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 4, 'London - The Modern Babylon ', '324228742-8', '2/28/2005', true, 'http://dummyimage.com/237x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 4, 'Godson, The', '148232760-0', '3/5/2013', true, 'http://dummyimage.com/234x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 5, 'Trip to Bountiful, The', '616256985-3', '1/11/2012', true, 'http://dummyimage.com/237x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 8, 'Derailed', '822208012-1', '4/3/2023', false, 'http://dummyimage.com/228x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 2, 'Claire Dolan', '517121191-4', '12/1/2014', true, 'http://dummyimage.com/140x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 3, 4, 'Some Came Running', '295569523-8', '4/22/2018', false, 'http://dummyimage.com/189x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 9, 'Domestic Disturbance', '710082335-8', '9/6/2000', false, 'http://dummyimage.com/228x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 4, 5, 'Cold Fever (Á köldum klaka)', '688811102-4', '1/2/2024', false, 'http://dummyimage.com/191x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 9, 'Closing the Ring', '847652134-0', '11/10/2006', true, 'http://dummyimage.com/120x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 4, 'Knight''s Tale, A', '572163606-8', '3/29/2012', false, 'http://dummyimage.com/223x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 5, 'White Palms (Fehér tenyér)', '531733855-7', '8/26/2006', false, 'http://dummyimage.com/166x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 5, 1, 'Valentine Road', '130608374-5', '7/30/2005', true, 'http://dummyimage.com/218x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 3, 8, 'Boys Life', '736313707-2', '2/28/2014', false, 'http://dummyimage.com/114x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 6, 'Like Mike 2: Streetball', '230465045-7', '8/11/2001', false, 'http://dummyimage.com/125x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 6, 1, 'Star Trek Into Darkness', '033382417-2', '1/10/2002', false, 'http://dummyimage.com/246x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 6, 6, 'Entertaining Angels: The Dorothy Day Story', '511904999-0', '2/9/2019', true, 'http://dummyimage.com/132x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 3, 2, 'Only God Knows (Sólo Dios Sabe)', '642507861-8', '4/13/2021', false, 'http://dummyimage.com/167x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 6, 'Wonderful World of the Brothers Grimm, The', '122497791-2', '7/29/2024', false, 'http://dummyimage.com/112x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 6, 6, 'Caveman', '284688333-5', '6/11/2010', true, 'http://dummyimage.com/220x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 6, 4, 'Whisperers, The', '239531352-1', '9/11/2017', false, 'http://dummyimage.com/118x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 6, 'Tall T, The', '339578983-7', '8/7/2006', true, 'http://dummyimage.com/130x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 6, 'Kid & I, The', '661251172-9', '5/6/2022', false, 'http://dummyimage.com/154x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 5, 8, 'X2: X-Men United', '404380581-0', '12/10/2015', false, 'http://dummyimage.com/244x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 4, 1, 'Silent Light (Stellet licht)', '847517131-1', '8/21/2016', true, 'http://dummyimage.com/131x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 3, 2, 'Goldene Zeiten', '790806849-9', '6/3/2019', false, 'http://dummyimage.com/243x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 6, 'Life Is Sweet', '883497783-1', '4/21/2014', true, 'http://dummyimage.com/135x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 7, 'Last Tango in Paris (Ultimo tango a Parigi)', '350680391-3', '1/3/2005', false, 'http://dummyimage.com/172x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 4, 'Summer Days With Coo', '494560612-9', '4/23/2001', false, 'http://dummyimage.com/230x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 4, 'Close-Up (Nema-ye Nazdik)', '952563628-3', '10/15/2015', false, 'http://dummyimage.com/101x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 3, 2, 'Other Side of Midnight, The', '840694058-1', '12/20/2022', true, 'http://dummyimage.com/200x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 6, 5, '588 Rue Paradis (Mother)', '859830262-7', '9/26/2001', true, 'http://dummyimage.com/172x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 4, 1, 'Deep in the Valley (American Hot Babes)', '596137209-X', '6/4/2000', true, 'http://dummyimage.com/108x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 1, 9, 'Jamie and Jessie Are Not Together', '856046859-5', '6/2/2021', false, 'http://dummyimage.com/222x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 1, 'Unlawful Killing', '518096488-1', '11/22/2002', false, 'http://dummyimage.com/144x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 3, 1, 'High Heels and Low Lifes', '714540157-6', '9/6/2014', true, 'http://dummyimage.com/217x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 1, 'Dragon ball Z 04: Lord Slug', '938710051-0', '10/16/2007', true, 'http://dummyimage.com/101x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 1, 6, 'Matter of Dignity, A (To teleftaio psema)', '606722536-0', '7/30/2003', true, 'http://dummyimage.com/110x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 1, 3, 'Sleep Room, The', '680964509-8', '10/9/2023', false, 'http://dummyimage.com/104x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 3, 6, 'Three Colors: White (Trzy kolory: Bialy)', '195970523-7', '5/12/2017', false, 'http://dummyimage.com/236x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 3, 3, 'Delicate Delinquent, The', '050423677-6', '5/13/2016', true, 'http://dummyimage.com/197x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 4, 'Crossover', '771122113-4', '7/7/2008', false, 'http://dummyimage.com/205x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 6, 6, 'After School Special (a.k.a. Barely Legal)', '163543907-8', '9/21/2020', false, 'http://dummyimage.com/133x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 5, 6, 'Imagine That', '313950100-5', '4/19/2019', false, 'http://dummyimage.com/247x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 3, 'Deep in the Woods (Promenons-nous dans les bois)', '129582476-0', '8/24/2017', false, 'http://dummyimage.com/192x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 6, 4, 'Grill Point (Halbe Treppe)', '184782048-4', '10/16/2011', true, 'http://dummyimage.com/146x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 4, 8, 'White Hunter, Black Heart', '721353184-0', '7/27/2003', true, 'http://dummyimage.com/185x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 8, 'Card Player, The (Il cartaio)', '107164370-3', '12/6/2023', true, 'http://dummyimage.com/193x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 5, 'Intern, The', '137395816-2', '6/15/2004', true, 'http://dummyimage.com/109x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 3, 'Start the Revolution Without Me', '133400259-2', '10/7/2004', false, 'http://dummyimage.com/138x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 6, 2, 'Backfire', '386860955-5', '2/20/2020', true, 'http://dummyimage.com/206x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 4, 4, 'Year of Living Vicariously, The', '199893107-2', '10/29/2014', false, 'http://dummyimage.com/230x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 9, 'Forever Yours (Ikuisesti sinun)', '968121315-7', '12/7/2000', false, 'http://dummyimage.com/197x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 1, 'Olivier, Olivier', '694944080-4', '8/4/2021', false, 'http://dummyimage.com/202x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 1, 'Zapped Again!', '112303889-9', '3/2/2007', false, 'http://dummyimage.com/153x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 7, 'Heidi', '110104621-X', '9/26/2004', false, 'http://dummyimage.com/159x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 5, 'Hole, The', '946949409-1', '9/7/2022', false, 'http://dummyimage.com/114x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 4, 'Sixpack (Pussikaljaelokuva)', '149139455-2', '9/18/2005', true, 'http://dummyimage.com/236x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 9, 'Stop-Loss', '458362214-7', '5/8/2015', true, 'http://dummyimage.com/157x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 5, 'Take a Giant Step', '535911992-6', '2/16/2018', false, 'http://dummyimage.com/134x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 4, 1, 'Quiet Ones, The', '147033305-8', '10/28/2017', false, 'http://dummyimage.com/223x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 3, 'Goofy Movie, A', '592817284-2', '3/15/2012', true, 'http://dummyimage.com/201x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 3, 'Coffee and Cigarettes', '702942101-9', '5/4/2018', true, 'http://dummyimage.com/130x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 3, 'Forgotten Silver', '599900222-2', '5/12/2004', false, 'http://dummyimage.com/174x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 2, 7, 'Erendira', '656294191-1', '4/16/2013', false, 'http://dummyimage.com/246x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 2, 'Pups', '530248187-1', '6/28/2016', false, 'http://dummyimage.com/243x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 3, 1, 'Above Us Only Sky', '171391843-9', '11/24/2003', false, 'http://dummyimage.com/107x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 6, 'Tales from the Crypt', '759897631-7', '3/11/2000', false, 'http://dummyimage.com/227x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 7, 'Alila', '485239195-5', '7/15/2007', true, 'http://dummyimage.com/104x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 5, 'Undisputed', '646892262-3', '9/16/2006', false, 'http://dummyimage.com/148x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 6, 6, 'Chechahcos, The', '889560146-7', '12/3/2010', true, 'http://dummyimage.com/104x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 1, 'Trio, The (Trio, Das)', '135292675-X', '9/13/2022', true, 'http://dummyimage.com/249x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 1, 4, 'Mondo Cane', '233191971-2', '1/1/2019', false, 'http://dummyimage.com/140x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 6, 6, 'Night Train To Lisbon', '138078436-0', '7/4/2004', true, 'http://dummyimage.com/157x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 9, 'Monkey''s Paw, The', '931988789-6', '9/22/2006', true, 'http://dummyimage.com/110x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 4, 9, 'Hellgate', '864117601-2', '7/10/2000', true, 'http://dummyimage.com/153x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 3, 'Tai Chi Zero', '914551095-4', '11/22/2022', true, 'http://dummyimage.com/144x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 1, 2, 'Joe the King', '158564810-8', '3/9/2000', true, 'http://dummyimage.com/239x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 6, 4, 'Deep Impact', '054438117-3', '11/10/2009', true, 'http://dummyimage.com/210x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 1, 'You''ll Find Out', '926346909-1', '8/14/2021', true, 'http://dummyimage.com/176x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 7, 'Without Pity', '865098521-1', '12/16/2008', false, 'http://dummyimage.com/188x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 1, 'Creepshow 3', '970325159-5', '5/11/2006', false, 'http://dummyimage.com/191x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 1, 'Gypsy', '782819528-1', '8/25/2022', true, 'http://dummyimage.com/161x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 2, 'Star Trek: Insurrection', '109483409-2', '3/13/2024', true, 'http://dummyimage.com/241x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 7, 'Chronicles of Narnia: The Lion, the Witch and the Wardrobe, The', '939737585-7', '10/28/2004', true, 'http://dummyimage.com/221x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 3, 5, 'Workingman''s Death', '671300480-6', '8/29/2020', true, 'http://dummyimage.com/122x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 7, 'Killer Movie', '600143749-1', '6/3/2015', true, 'http://dummyimage.com/213x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 1, 'Jönssonligan spelar högt', '701385159-0', '11/9/2016', true, 'http://dummyimage.com/153x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 5, 6, 'Little Man', '622025604-2', '3/12/2019', true, 'http://dummyimage.com/234x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 4, 2, 'Walter', '563858462-5', '3/29/2009', false, 'http://dummyimage.com/222x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 9, 'Zone, The (La Zona)', '228083251-8', '3/31/2021', false, 'http://dummyimage.com/176x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 4, 'Just a Little Harmless Sex', '413912298-6', '11/11/2021', true, 'http://dummyimage.com/204x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 5, 'Highway ', '784823011-2', '3/17/2010', false, 'http://dummyimage.com/153x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 4, 8, 'Little Fridolf Becomes a Grandfather', '771702148-X', '11/23/2016', true, 'http://dummyimage.com/193x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 1, 9, 'Family Friend, The (L''amico di famiglia)', '087537456-5', '3/28/2009', false, 'http://dummyimage.com/166x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 4, 'Asylum', '400665369-7', '9/4/2023', true, 'http://dummyimage.com/238x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 4, 'Barabbas', '212743566-4', '6/26/2003', false, 'http://dummyimage.com/129x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 3, 'The World Forgotten', '124461409-2', '7/11/2010', true, 'http://dummyimage.com/190x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 2, 'Woman Chaser, The', '566682172-5', '7/17/2016', true, 'http://dummyimage.com/178x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 1, 'When Darkness Falls (När mörkret faller)', '289983537-8', '4/19/2010', false, 'http://dummyimage.com/208x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 8, 'Man in Grey, The', '360846392-5', '7/2/2016', false, 'http://dummyimage.com/222x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 2, 'Yes Man', '673926630-1', '1/25/2011', true, 'http://dummyimage.com/135x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 9, 'Strange Brew', '778728474-9', '7/3/2013', true, 'http://dummyimage.com/177x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 9, 'Tavarataivas', '576853152-1', '7/2/2021', true, 'http://dummyimage.com/188x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 6, 'Shattered Glass', '535374359-8', '7/24/2021', false, 'http://dummyimage.com/196x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 1, 'Leafie, a Hen Into the Wild (Madangeul Naon Amtak)', '887506371-0', '11/22/2000', false, 'http://dummyimage.com/236x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 7, 'Gunner Palace', '937203450-9', '10/30/2018', false, 'http://dummyimage.com/137x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 4, 'Very Brady Sequel, A', '302971546-9', '4/26/2020', true, 'http://dummyimage.com/209x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 6, 9, 'Double Dragon', '294218512-0', '5/3/2020', false, 'http://dummyimage.com/183x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 5, 9, 'Trust the Man', '826919200-7', '4/21/2023', true, 'http://dummyimage.com/158x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 4, 2, 'Swingers', '187680305-3', '1/4/2000', false, 'http://dummyimage.com/151x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 8, 'Highlander', '198359254-4', '1/15/2013', true, 'http://dummyimage.com/250x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 7, 'Goodbye, Dragon Inn (Bu san)', '546822859-9', '11/9/2006', false, 'http://dummyimage.com/213x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 7, 'Real Life', '964200364-3', '8/12/2024', true, 'http://dummyimage.com/117x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 1, 8, 'Gone Fishin''', '911160460-3', '1/18/2022', true, 'http://dummyimage.com/157x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 7, 'Crime Busters', '137549961-0', '12/13/2008', false, 'http://dummyimage.com/210x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 1, 'Enemies Closer', '317651411-5', '12/3/2014', true, 'http://dummyimage.com/164x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 4, 'Quest for a Heart (Röllin sydän)', '338050824-1', '4/24/2024', true, 'http://dummyimage.com/165x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 9, 'Anna Karenina', '005889528-0', '2/7/2008', true, 'http://dummyimage.com/203x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 6, 'Counterfeiters, The (Die Fälscher)', '967455688-5', '11/8/2015', true, 'http://dummyimage.com/131x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 9, 'Coquette', '088227671-9', '3/31/2021', false, 'http://dummyimage.com/244x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 6, 'Saragossa Manuscript, The (Rekopis znaleziony w Saragossie)', '067105565-8', '2/28/2009', true, 'http://dummyimage.com/201x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 2, 'Company of Heroes', '529898895-4', '12/27/1999', true, 'http://dummyimage.com/196x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 5, 'Behold a Pale Horse', '718764195-8', '12/6/2004', true, 'http://dummyimage.com/163x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 9, 'Talented Mr. Ripley, The', '016791356-5', '2/11/2003', true, 'http://dummyimage.com/117x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 4, 2, 'The Pacific', '660150087-9', '9/21/2000', true, 'http://dummyimage.com/213x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 4, 'The Adventures of Tom Thumb & Thumbelina', '658620837-8', '11/10/2010', true, 'http://dummyimage.com/196x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 5, 4, 'Desert Fox, The', '103744491-4', '3/26/2008', true, 'http://dummyimage.com/180x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 3, 2, 'HellBent', '188009603-X', '3/16/2001', true, 'http://dummyimage.com/191x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 3, 'Meet Dave', '296639851-5', '2/24/2009', false, 'http://dummyimage.com/116x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 6, 'Sacrifice (Zhao shi gu er)', '257447688-3', '7/22/2015', false, 'http://dummyimage.com/169x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 7, 'Hunting of the President, The', '262822865-3', '5/25/2008', true, 'http://dummyimage.com/196x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 7, 'What Have You Done to Solange?', '809593340-6', '12/21/2003', false, 'http://dummyimage.com/177x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 3, 1, 'Highway Racer', '784968100-2', '10/20/2016', false, 'http://dummyimage.com/143x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 4, 3, 'Why Do Fools Fall In Love?', '787442477-8', '7/29/2006', false, 'http://dummyimage.com/200x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 2, 'Igor', '755543577-2', '12/2/2005', false, 'http://dummyimage.com/166x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 2, 2, 'No Exit (Huis clos)', '267895150-2', '5/7/2021', true, 'http://dummyimage.com/235x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 4, 'The Last Wagon', '069918709-5', '5/1/2006', false, 'http://dummyimage.com/230x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 7, 'Singing Nun, The', '581351073-7', '4/16/2001', false, 'http://dummyimage.com/178x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 2, 'Crazies, The (a.k.a. Code Name: Trixie)', '243884630-5', '1/17/2011', false, 'http://dummyimage.com/164x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 1, 'Dancemaker', '919536422-6', '11/23/2020', false, 'http://dummyimage.com/229x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 6, 5, 'Hungry Hill', '116984468-5', '10/18/2008', true, 'http://dummyimage.com/187x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 4, 4, 'Psycho', '061411380-6', '9/4/2007', true, 'http://dummyimage.com/140x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 3, 'Edge of Seventeen', '853203103-X', '8/23/2009', false, 'http://dummyimage.com/120x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 6, 5, 'Willy Wonka & the Chocolate Factory', '120637642-2', '12/31/2018', false, 'http://dummyimage.com/231x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 5, 'King Lines', '815143257-8', '10/8/2023', false, 'http://dummyimage.com/217x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 3, 6, 'Private Eyes, The', '827797049-8', '2/5/2000', false, 'http://dummyimage.com/175x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 3, 'Blinkity Blank', '296961812-5', '9/20/2011', true, 'http://dummyimage.com/242x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 5, 3, 'Paris-Manhattan', '610771441-3', '7/28/2023', true, 'http://dummyimage.com/234x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 6, 2, 'Cheech & Chong''s Nice Dreams', '670946263-3', '2/15/2016', false, 'http://dummyimage.com/193x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 3, 7, 'Saint (Sint)', '860016844-9', '11/18/2017', true, 'http://dummyimage.com/230x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 3, 'Indian Summer (a.k.a. The Professor) (La prima notte di quiete)', '070028680-2', '5/22/2002', false, 'http://dummyimage.com/161x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 3, 2, 'Los Bandoleros', '175039397-2', '3/5/2005', true, 'http://dummyimage.com/191x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 6, 2, 'Karlsson Brothers (Bröderna Karlsson)', '055794219-5', '5/12/2007', true, 'http://dummyimage.com/213x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 6, 7, 'Way, Way Back, The', '765186063-2', '4/26/2010', true, 'http://dummyimage.com/182x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 2, 'Under Fire', '612789058-6', '8/16/2007', false, 'http://dummyimage.com/150x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 8, 'Black Room, The', '415856615-0', '12/16/2015', false, 'http://dummyimage.com/222x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 4, 9, 'Asylum', '767454698-5', '7/15/2001', true, 'http://dummyimage.com/144x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 8, 'Deserter (Dezertir)', '037465407-7', '11/12/2016', true, 'http://dummyimage.com/216x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 7, 'Dirt', '771992132-1', '2/14/2013', true, 'http://dummyimage.com/185x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 6, 'At the Earth''s Core', '203804446-5', '4/24/2022', true, 'http://dummyimage.com/118x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 2, 'Charlie Victor Romeo', '050484874-7', '5/16/2010', false, 'http://dummyimage.com/139x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 3, 'Love Exposure (Ai No Mukidashi)', '347658001-6', '3/6/2010', true, 'http://dummyimage.com/121x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 5, 'Island of the Burning Damned (Night of the Big Heat)', '257312208-5', '3/1/2002', true, 'http://dummyimage.com/196x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 3, 7, 'Uprising', '613055399-4', '6/13/2001', false, 'http://dummyimage.com/248x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 4, 9, 'Harum Scarum', '731977166-7', '5/17/2019', true, 'http://dummyimage.com/155x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 6, 5, 'Iron Eagle IV', '002140683-9', '11/11/2018', false, 'http://dummyimage.com/159x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 7, 'Conspiracy', '568165738-8', '4/26/2006', false, 'http://dummyimage.com/226x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 2, 'West of the Divide', '327776587-3', '5/12/2003', false, 'http://dummyimage.com/105x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 6, 4, 'Dark Floors', '419600859-3', '3/27/2010', true, 'http://dummyimage.com/104x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 9, 'Tarzan''s Magic Fountain', '719944936-4', '7/5/2000', true, 'http://dummyimage.com/237x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 3, 'St. Elmo''s Fire', '962241333-1', '5/25/2006', true, 'http://dummyimage.com/143x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 5, 'Bob Saget: That Ain''t Right', '098227069-0', '5/2/2018', false, 'http://dummyimage.com/140x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 2, 'Confidence', '348153242-3', '1/13/2019', false, 'http://dummyimage.com/168x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 6, 'Last Run, The', '816151360-0', '5/7/2021', false, 'http://dummyimage.com/127x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 3, 'Faust', '965421765-1', '8/19/2016', false, 'http://dummyimage.com/215x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 2, 6, 'Willow Tree, The (Beed-e majnoon)', '949888803-5', '11/14/2008', true, 'http://dummyimage.com/125x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 3, 4, 'Hell in the Pacific', '791948777-3', '10/31/2002', false, 'http://dummyimage.com/175x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 4, 1, 'Wild Hearts Can''t Be Broken', '957402814-3', '9/19/2009', false, 'http://dummyimage.com/116x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 2, 'The Hire: Follow, The', '611737317-1', '3/22/2023', false, 'http://dummyimage.com/166x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 7, 'Last Dance', '175548655-3', '2/4/2021', false, 'http://dummyimage.com/115x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 3, 'Pocahontas', '935931319-X', '3/20/2003', false, 'http://dummyimage.com/122x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 5, 9, 'Tank', '719508531-7', '5/24/2002', false, 'http://dummyimage.com/214x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 4, 'King''s Faith', '043148963-7', '12/1/2013', true, 'http://dummyimage.com/228x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 7, 'My Mother''s Smile (a.k.a. The Religion Hour) (L''ora di religione) (Il sorriso di mia madre)', '508352817-7', '3/6/2007', false, 'http://dummyimage.com/212x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 4, 4, 'Long Riders, The', '953887580-X', '2/23/2005', false, 'http://dummyimage.com/153x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 8, 'Best and the Brightest, The', '092846917-4', '2/20/2007', true, 'http://dummyimage.com/142x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 3, 'Watch Out for the Automobile (Beregis avtomobilya)', '309846259-0', '3/27/2002', false, 'http://dummyimage.com/135x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 7, 'Star Trek', '315910907-0', '3/29/2000', false, 'http://dummyimage.com/228x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 5, 3, 'Fiorile', '215783985-2', '10/14/2019', false, 'http://dummyimage.com/243x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 4, 'All Passion Spent', '674083126-2', '7/17/2003', true, 'http://dummyimage.com/102x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 6, 7, 'Amazon Women on the Moon', '847528051-X', '2/5/2020', true, 'http://dummyimage.com/166x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 4, 1, 'House on the Edge of the Park, The (Casa sperduta nel parco, La)', '955605397-2', '9/5/2004', false, 'http://dummyimage.com/155x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 5, 8, 'Too Early, Too Late (Trop tôt, trop tard)', '325376446-X', '12/4/2007', true, 'http://dummyimage.com/248x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 7, 'Killer (Tueur à gages)', '924266602-5', '11/23/2016', true, 'http://dummyimage.com/231x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 3, 'Solaris (Solyaris)', '090320849-0', '2/18/2004', false, 'http://dummyimage.com/177x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 1, 'Road to Zanzibar', '482222560-7', '9/10/2006', true, 'http://dummyimage.com/132x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 1, 9, 'Candleshoe', '809164233-4', '10/16/1999', true, 'http://dummyimage.com/243x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 3, 'Top Banana', '697077487-2', '3/20/2015', true, 'http://dummyimage.com/130x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 6, 'Yolanda and the Thief', '284581422-4', '7/27/2014', true, 'http://dummyimage.com/155x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 5, 'Alice''s Adventures in Wonderland', '693502163-4', '12/2/2005', false, 'http://dummyimage.com/105x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 5, 'High Test Girls', '296755434-0', '5/20/2020', true, 'http://dummyimage.com/230x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 5, 'Gun Woman', '959588115-5', '7/15/2010', true, 'http://dummyimage.com/237x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 3, 'The Face of Marble', '677787820-3', '1/21/2010', true, 'http://dummyimage.com/245x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 1, 'Moonrise Kingdom', '301766340-X', '11/19/2015', true, 'http://dummyimage.com/171x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 6, 3, 'Blood Spattered Bride, The (La novia ensangrentada)', '531640146-8', '9/5/2009', true, 'http://dummyimage.com/132x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 6, 1, 'Bring It On: Fight to the Finish', '876354661-2', '7/20/2016', true, 'http://dummyimage.com/164x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 1, 9, 'Groundstar Conspiracy, The', '971515758-0', '3/29/2024', false, 'http://dummyimage.com/164x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 3, 'Lola Versus', '616851908-4', '7/2/2004', false, 'http://dummyimage.com/138x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 4, 9, 'Monty Python Live (Mostly)', '403598108-7', '8/22/2023', true, 'http://dummyimage.com/219x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 8, 'Liliom', '281989772-X', '7/31/2001', false, 'http://dummyimage.com/214x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 8, 'Supermarket Woman (Sûpâ no onna)', '668147032-7', '9/7/2011', true, 'http://dummyimage.com/182x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 4, 4, 'Maid of Salem', '632936832-5', '1/13/2021', false, 'http://dummyimage.com/226x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 4, 'Abbott and Costello Meet the Invisible Man', '396230235-2', '3/22/2022', true, 'http://dummyimage.com/221x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 4, '''R Xmas', '012104667-2', '11/20/2018', false, 'http://dummyimage.com/232x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 2, 'Good Morning, Babylon', '256655663-6', '11/11/2009', false, 'http://dummyimage.com/153x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 3, 5, '6 Bullets', '432307635-5', '3/10/2003', false, 'http://dummyimage.com/173x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 3, 4, 'Timecrimes (Cronocrímenes, Los)', '820013313-3', '5/24/2001', false, 'http://dummyimage.com/127x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 2, 6, 'Raspberry Boat Refugee', '791469476-2', '6/26/2021', false, 'http://dummyimage.com/228x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 3, 6, 'Typhoon (Tae-poong)', '860832411-3', '12/25/2023', false, 'http://dummyimage.com/246x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 3, 1, 'Clear and Present Danger', '321437720-5', '7/11/2001', false, 'http://dummyimage.com/173x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 8, 'Fun in Acapulco', '899872642-4', '6/11/2012', false, 'http://dummyimage.com/218x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 3, 3, 'Pompeii', '837679636-4', '5/8/2008', false, 'http://dummyimage.com/199x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 4, 3, 'Yes Or No', '204215561-6', '6/11/2016', false, 'http://dummyimage.com/228x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 4, 6, 'Gold', '801163304-X', '11/6/2004', true, 'http://dummyimage.com/216x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 4, 2, 'Blood Ties', '473782493-3', '4/24/2023', false, 'http://dummyimage.com/151x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 8, 'Far from the Madding Crowd', '804746311-X', '9/7/2011', false, 'http://dummyimage.com/174x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 5, 9, 'Tremors 4: The Legend Begins', '792972590-1', '6/7/2005', true, 'http://dummyimage.com/140x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 1, 'Midnight (Primeiro Dia, O)', '987719763-4', '1/14/2010', true, 'http://dummyimage.com/198x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 5, 'Colossus: The Forbin Project', '704562921-4', '9/3/2024', true, 'http://dummyimage.com/196x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 9, 'Trances', '641573254-4', '5/23/2017', true, 'http://dummyimage.com/188x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 6, 'Ultimate Accessory,The (100% cachemire)', '931579365-X', '10/13/2004', false, 'http://dummyimage.com/216x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 6, 'Black Stallion Returns, The', '251795541-7', '10/1/2022', true, 'http://dummyimage.com/138x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 2, 'Unholy Three, The', '762191790-3', '12/20/2018', true, 'http://dummyimage.com/210x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 5, 7, 'Flawless', '059842280-3', '4/27/2009', false, 'http://dummyimage.com/163x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 1, 6, 'Just Anybody (Le premier venu)', '708694933-7', '12/5/2014', true, 'http://dummyimage.com/101x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 5, 'How I Live Now', '157387723-9', '6/6/2010', true, 'http://dummyimage.com/145x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 4, 'Battle Beyond the Stars', '851487889-1', '4/1/2022', false, 'http://dummyimage.com/141x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 6, 7, 'Titanic', '478057280-0', '2/1/2003', true, 'http://dummyimage.com/132x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 3, 7, 'Battlefield Baseball (Jigoku kôshien)', '298982210-0', '6/25/2005', false, 'http://dummyimage.com/227x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 6, 'Bagdad Cafe (Out of Rosenheim)', '972272469-X', '12/20/2001', true, 'http://dummyimage.com/143x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 6, 5, 'Pariah', '456285429-4', '12/28/2000', false, 'http://dummyimage.com/145x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 8, 'Fitna', '393654147-7', '5/15/2014', false, 'http://dummyimage.com/185x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 4, 6, 'Canyon Passage', '009794823-3', '6/1/2003', false, 'http://dummyimage.com/111x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 9, 'Secret World of Arrietty, The (Kari-gurashi no Arietti)', '315144703-1', '7/2/2013', false, 'http://dummyimage.com/190x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 2, '13B', '519082497-7', '4/10/2000', false, 'http://dummyimage.com/190x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 3, 8, 'Free Money', '142060231-4', '12/13/2007', false, 'http://dummyimage.com/141x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 7, 'Two Lives (Zwei Leben)', '851476072-6', '2/18/2008', false, 'http://dummyimage.com/206x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 3, 4, 'Rocky Saga: Going the Distance, The', '244607471-5', '1/18/2007', true, 'http://dummyimage.com/107x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 6, 1, 'Missionary', '714991348-2', '9/14/2004', true, 'http://dummyimage.com/242x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 2, 'Suburbans, The', '280698553-6', '8/29/2015', false, 'http://dummyimage.com/123x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 5, 'I Don''t Want to Be a Man (Ich möchte kein Mann sein)', '372826624-8', '12/1/2017', false, 'http://dummyimage.com/165x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 6, 'Sailor Who Fell from Grace with the Sea, The', '132273962-5', '10/18/2011', false, 'http://dummyimage.com/159x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 8, 'Evan Almighty', '786507557-X', '4/20/2008', true, 'http://dummyimage.com/223x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 4, 1, 'Born Yesterday', '666590093-2', '4/26/2006', true, 'http://dummyimage.com/150x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 5, 'Beware the Moon: Remembering ''An American Werewolf in London''', '827232272-2', '8/21/2024', true, 'http://dummyimage.com/111x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 2, 'Winnie the Pooh and a Day for Eeyore', '880251274-4', '10/11/2014', true, 'http://dummyimage.com/158x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 4, 6, 'Lost Boys: The Thirst', '471996630-6', '4/19/2003', true, 'http://dummyimage.com/103x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 8, 'Unaccompanied Minors', '377769281-6', '3/31/2021', false, 'http://dummyimage.com/167x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 9, 'Land of Silence and Darkness (Land des Schweigens und der Dunkelheit)', '280329300-5', '12/8/2011', false, 'http://dummyimage.com/147x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 2, 'Night of the Demons', '630332165-8', '3/14/2009', false, 'http://dummyimage.com/244x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 3, 'Whisperers, The', '705928235-1', '4/28/2016', false, 'http://dummyimage.com/175x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 3, 4, 'Waiting...', '273642728-9', '6/24/2015', false, 'http://dummyimage.com/212x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 5, 8, 'Bingo', '090103502-5', '6/23/2003', true, 'http://dummyimage.com/231x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 6, 'Alvarez Kelly', '311943436-1', '3/23/2010', false, 'http://dummyimage.com/133x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 3, 'The House of Intrigue', '023218378-3', '10/12/2017', true, 'http://dummyimage.com/108x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 4, 'I Walk the Line', '380992837-2', '10/14/2018', true, 'http://dummyimage.com/166x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 8, 'Dogville', '827485595-7', '6/5/2018', false, 'http://dummyimage.com/108x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 3, 'Mansion of Madness, The', '669276939-6', '4/28/2003', false, 'http://dummyimage.com/202x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 6, '3 Penny Opera, The (Threepenny Opera, The) (3 Groschen-Oper, Die)', '260597945-8', '6/20/2022', true, 'http://dummyimage.com/113x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 6, 'Richard Pryor Here and Now', '790457643-0', '11/3/2001', true, 'http://dummyimage.com/152x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 9, 'Two Little Boys', '264501327-9', '1/27/2002', true, 'http://dummyimage.com/162x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 6, 'Duck, You Sucker (a.k.a. Fistful of Dynamite, A) (Giù la testa)', '664471140-5', '6/21/2022', true, 'http://dummyimage.com/171x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 3, 'Message, The (a.k.a. Mohammad: Messenger of God)', '356969438-0', '8/12/2024', true, 'http://dummyimage.com/172x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 3, 4, 'Last Lions, The', '406206039-6', '6/6/2014', true, 'http://dummyimage.com/186x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 4, 'Emperor''s Naked Army Marches On, The (Yuki Yukite shingun)', '853522753-9', '12/6/2015', false, 'http://dummyimage.com/221x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 7, 'Return of the King, The', '306144314-2', '3/23/2006', true, 'http://dummyimage.com/202x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 6, 5, 'Master and Margaret, The (Il maestro e Margherita)', '989020501-7', '1/17/2010', false, 'http://dummyimage.com/223x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 8, 'Future Weather', '275867753-9', '11/14/2023', false, 'http://dummyimage.com/235x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 3, 'After Office Hours', '314821016-6', '12/1/2013', true, 'http://dummyimage.com/105x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 7, 'Schtonk!', '193017534-5', '5/27/2024', true, 'http://dummyimage.com/117x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 1, 'Double, The', '768509827-X', '12/1/2001', true, 'http://dummyimage.com/126x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 5, 'Hallelujah!', '268033832-4', '12/21/2002', true, 'http://dummyimage.com/140x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 1, 1, 'Purely Belter', '201736304-9', '9/28/2020', false, 'http://dummyimage.com/164x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 1, 'Deal, The', '444901592-4', '2/14/2019', true, 'http://dummyimage.com/193x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 9, 'Kaksparsh', '567774540-5', '3/11/2008', false, 'http://dummyimage.com/186x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 4, 'Poison Ivy: New Seduction', '235022173-3', '11/11/2022', false, 'http://dummyimage.com/120x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 9, 'The Mayor of Casterbridge', '472971423-7', '4/17/2022', true, 'http://dummyimage.com/170x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 3, 'Magic of Ordinary Days, The', '016567877-1', '7/4/2010', false, 'http://dummyimage.com/200x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 1, 3, 'Glass Menagerie, The', '449811967-3', '5/20/2005', true, 'http://dummyimage.com/227x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 9, 'Romy and Michele: In the Beginning', '308108969-7', '6/15/2005', true, 'http://dummyimage.com/199x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 5, 'Scarlet Street', '233542399-1', '2/27/2003', false, 'http://dummyimage.com/211x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 2, 2, 'Tinpis Run', '158482606-1', '11/21/2008', true, 'http://dummyimage.com/139x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 4, 'Tyson', '616942967-4', '2/20/2021', true, 'http://dummyimage.com/143x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 1, 'Devil Inside, The', '245967048-6', '12/17/2021', true, 'http://dummyimage.com/248x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 3, 'Love the Beast', '900507615-1', '3/21/2005', false, 'http://dummyimage.com/199x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 4, 5, 'Belles on Their Toes', '439387857-4', '10/17/2014', true, 'http://dummyimage.com/174x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 5, 'Angel Dog', '485520849-3', '7/10/2007', true, 'http://dummyimage.com/193x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 6, 'Blood of Dracula', '201219432-X', '4/2/2016', true, 'http://dummyimage.com/122x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 4, 7, 'Alamo, The', '385095696-2', '12/2/2017', false, 'http://dummyimage.com/170x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 5, 'What a Girl Wants', '445302327-8', '12/10/2020', false, 'http://dummyimage.com/214x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 6, 1, 'Boy and the Pirates, The', '732152896-0', '12/30/2016', true, 'http://dummyimage.com/150x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 5, 9, 'Independents', '765006542-1', '9/17/2003', false, 'http://dummyimage.com/113x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 4, 3, 'Dancing in the Rain (Ples v dezju)', '438755041-4', '2/27/2000', true, 'http://dummyimage.com/115x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 6, 'E.T. the Extra-Terrestrial', '629551566-5', '4/25/2014', true, 'http://dummyimage.com/117x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 6, 2, 'Asterix: The Land of the Gods', '823806057-5', '10/10/2018', false, 'http://dummyimage.com/188x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 1, 3, 'Leadbelly', '042422830-0', '5/28/2011', true, 'http://dummyimage.com/143x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 1, 'The Rag Man', '315475459-8', '6/24/2002', false, 'http://dummyimage.com/160x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 6, 'Along Came a Spider', '774413865-1', '5/8/2016', true, 'http://dummyimage.com/100x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 9, 'My Son the Fanatic', '061248959-0', '1/31/2001', false, 'http://dummyimage.com/190x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 3, 5, 'Come to the Stable', '397690310-8', '11/16/2008', false, 'http://dummyimage.com/201x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 4, 7, 'Balseros (Cuban Rafters)', '955315376-3', '2/14/2003', true, 'http://dummyimage.com/207x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 6, 'Elfie Hopkins: Cannibal Hunter', '905905471-7', '6/5/2020', false, 'http://dummyimage.com/111x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 6, 2, 'Underworld: Awakening', '515370663-X', '3/27/2006', false, 'http://dummyimage.com/144x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 5, 'See Heaven', '508656997-4', '7/6/2019', true, 'http://dummyimage.com/210x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 2, 'Godzilla vs. Gigan (Chikyû kogeki meirei: Gojira tai Gaigan)', '065879514-7', '8/18/2010', false, 'http://dummyimage.com/127x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 4, 'Other Boleyn Girl, The', '282185067-0', '1/3/2019', true, 'http://dummyimage.com/240x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 5, 'Copying Beethoven', '365570778-9', '10/25/2008', true, 'http://dummyimage.com/127x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 9, 'Fan, The', '282210328-3', '4/2/2016', false, 'http://dummyimage.com/188x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 5, 'Tightrope', '412979815-4', '12/24/2015', false, 'http://dummyimage.com/126x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 8, 'Burning Bed, The', '432420452-7', '12/4/2011', true, 'http://dummyimage.com/112x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 6, 'Dragonfly', '253302420-1', '11/17/2003', true, 'http://dummyimage.com/124x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 7, 'Feast of Love', '682351031-5', '11/20/2011', true, 'http://dummyimage.com/227x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 6, 'Fugitive, The', '065331543-0', '7/21/2003', false, 'http://dummyimage.com/204x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 9, 'Breakin'' 2: Electric Boogaloo', '114692189-6', '1/17/2012', true, 'http://dummyimage.com/123x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 9, 'Pin...', '078117192-X', '12/8/1999', false, 'http://dummyimage.com/108x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 1, 'Woman Always Pays, The (Afgrunden) (Abyss, The)', '381499745-X', '2/16/2011', true, 'http://dummyimage.com/140x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 1, 'Abandoned', '233901574-X', '2/24/2020', false, 'http://dummyimage.com/103x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 1, 1, 'Kicking and Screaming', '793572283-8', '3/24/2011', false, 'http://dummyimage.com/187x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 1, 'A Life in Dirty Movies', '340456101-5', '7/16/2010', true, 'http://dummyimage.com/148x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 2, 9, 'Bandits (Bandidos)', '554301865-7', '9/8/2015', false, 'http://dummyimage.com/175x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 3, 'Angel Levine, The', '972843399-9', '8/24/2009', true, 'http://dummyimage.com/109x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 8, 'Man of the House', '265791632-5', '3/9/2015', true, 'http://dummyimage.com/154x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 2, 8, 'McConkey', '472258638-1', '11/4/2005', false, 'http://dummyimage.com/115x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 4, 'Princess Protection Program', '159526963-0', '8/16/2005', true, 'http://dummyimage.com/123x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 3, 1, 'Wake Island', '893870593-5', '7/28/2008', false, 'http://dummyimage.com/161x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 5, 4, 'Iceman, The', '135823690-9', '1/11/2007', true, 'http://dummyimage.com/249x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 4, 8, 'Babadook, The', '487360147-9', '9/27/2019', true, 'http://dummyimage.com/216x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 4, 2, 'I Married a Monster from Outer Space', '187366322-6', '3/21/2012', true, 'http://dummyimage.com/217x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 3, 'Chronic Town', '750232488-7', '4/5/2007', false, 'http://dummyimage.com/230x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 4, 'Prom Night', '109843006-9', '10/5/2003', false, 'http://dummyimage.com/245x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 4, 4, 'Presence, The', '486921391-5', '11/30/2004', true, 'http://dummyimage.com/219x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 9, 'The Oblong Box', '165015856-4', '6/18/2017', false, 'http://dummyimage.com/180x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 1, '52 Tuesdays', '144319905-2', '5/21/2010', true, 'http://dummyimage.com/188x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 8, 'Maskerade', '820380066-1', '10/5/2023', false, 'http://dummyimage.com/232x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 3, 8, 'Trip, The', '993811892-5', '7/8/2015', true, 'http://dummyimage.com/101x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 1, 8, 'Phone Call from a Stranger', '794025856-7', '4/23/2011', true, 'http://dummyimage.com/212x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 6, 3, 'Phffft', '156950857-7', '9/11/2001', true, 'http://dummyimage.com/183x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 5, 8, 'Cloud Atlas', '040549465-3', '6/26/2014', true, 'http://dummyimage.com/102x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 1, 4, 'Incognito', '808365437-X', '10/15/2011', true, 'http://dummyimage.com/137x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 4, 8, 'Sound Barrier, The', '579249394-4', '2/24/2017', false, 'http://dummyimage.com/152x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 4, 'Devils, The', '912094203-6', '3/3/2019', false, 'http://dummyimage.com/160x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 4, 'Seed of Chucky (Child''s Play 5)', '745041908-4', '2/18/2006', true, 'http://dummyimage.com/240x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 5, 'Kiss and Make-Up', '159683436-6', '5/26/2009', true, 'http://dummyimage.com/136x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 1, 6, 'Milk and Honey', '590878821-X', '4/23/2005', true, 'http://dummyimage.com/158x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 3, 'Don''t Torture a Duckling (Non si sevizia un paperino)', '500763356-9', '9/24/2007', true, 'http://dummyimage.com/193x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 4, '39 Steps, The', '968236377-2', '6/26/2015', false, 'http://dummyimage.com/156x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 6, 2, 'Songcatcher', '400418553-X', '4/14/2018', true, 'http://dummyimage.com/239x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 9, 'When Time Ran Out... (Day the World Ended, The)', '653190529-8', '8/5/2003', true, 'http://dummyimage.com/212x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 6, 'Brain, The', '920763798-7', '2/25/2015', true, 'http://dummyimage.com/223x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 3, 4, 'Cobra', '795316783-2', '2/4/2009', true, 'http://dummyimage.com/187x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 6, 'Enid Is Sleeping', '107547444-2', '6/23/2013', true, 'http://dummyimage.com/202x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 1, 5, 'Young Philadelphians, The', '138217402-0', '10/3/2011', false, 'http://dummyimage.com/217x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 3, 5, 'Sister Act 2: Back in the Habit', '131065027-6', '7/23/2009', false, 'http://dummyimage.com/109x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 6, 'Don', '915201080-5', '7/31/2017', true, 'http://dummyimage.com/199x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 5, 'Dog Run', '815916812-8', '10/3/2018', true, 'http://dummyimage.com/130x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 6, 9, 'Force of One, A', '198737557-2', '5/13/2003', false, 'http://dummyimage.com/155x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 1, 'Institute Benjamenta, or This Dream People Call Human Life', '326655943-6', '5/12/2018', false, 'http://dummyimage.com/238x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 6, 1, 'House', '980647986-6', '9/5/2018', false, 'http://dummyimage.com/225x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 4, 'Quebrando o Tabu', '914741071-X', '12/29/2017', true, 'http://dummyimage.com/112x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 6, 'For a Lost Soldier (Voor een Verloren Soldaat)', '305819036-0', '9/5/2010', false, 'http://dummyimage.com/116x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 3, 'Nashville', '560259104-4', '3/19/2024', true, 'http://dummyimage.com/173x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 4, 6, 'White Angel, The (L''angelo bianco)', '700786461-9', '10/9/2014', false, 'http://dummyimage.com/124x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 8, 'Captain Mike Across America (Slacker Uprising)', '439115274-6', '5/5/2020', true, 'http://dummyimage.com/112x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 4, 5, 'What Have I Done to Deserve This? (¿Qué he hecho yo para merecer esto!!)', '233315342-3', '6/25/2012', true, 'http://dummyimage.com/100x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 1, 'Bow, The (Hwal)', '057751492-X', '10/24/2003', false, 'http://dummyimage.com/122x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 9, 'Big Star: Nothing Can Hurt Me', '049894743-2', '9/13/2020', true, 'http://dummyimage.com/131x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 9, 'Taxi Driver', '839937376-1', '2/25/2010', false, 'http://dummyimage.com/162x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 4, 'The Nativity', '017847007-4', '11/19/2004', false, 'http://dummyimage.com/198x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 4, 'Inhale', '140188672-8', '8/2/2007', true, 'http://dummyimage.com/222x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 4, 7, 'Johnny in the Clouds', '068545458-4', '10/29/2005', false, 'http://dummyimage.com/158x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 5, '4th Floor, The', '378296277-X', '1/8/2009', true, 'http://dummyimage.com/101x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 7, 'Ketchup Effect, The (Hip Hip Hora!)', '723832122-X', '12/25/2006', true, 'http://dummyimage.com/177x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 4, 6, 'Seitsemän veljestä', '652070045-2', '5/14/2004', false, 'http://dummyimage.com/137x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 6, 7, 'Citizenfour', '151187387-6', '9/9/2012', true, 'http://dummyimage.com/215x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 1, 'Let''s Do It Again', '727162789-8', '9/22/2007', true, 'http://dummyimage.com/155x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 4, 'Riverworld', '411217541-8', '10/22/2005', false, 'http://dummyimage.com/171x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 7, 'C.S.A.: The Confederate States of America', '549950338-9', '6/14/2020', true, 'http://dummyimage.com/157x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 5, 'Swamp Women', '367931744-1', '10/12/2004', true, 'http://dummyimage.com/176x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 4, 5, 'Great Caruso, The', '877731213-9', '2/26/2010', false, 'http://dummyimage.com/133x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 5, 'Chain of Command', '744189089-6', '8/17/2017', false, 'http://dummyimage.com/191x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 9, 'Big Wednesday', '296327009-7', '5/8/2008', false, 'http://dummyimage.com/248x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 1, 'Seven Psychopaths', '699651679-X', '5/5/2007', false, 'http://dummyimage.com/249x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 3, 'Film Noir: Bringing Darkness to Light', '875536509-4', '2/14/2001', false, 'http://dummyimage.com/135x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 5, 1, 'Happy New Year', '699185169-8', '3/18/2012', false, 'http://dummyimage.com/201x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 5, 'Des gens qui s''embrassent', '925358237-5', '5/29/2011', false, 'http://dummyimage.com/165x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 2, 7, 'Pretty/Handsome', '053012610-9', '1/26/2007', false, 'http://dummyimage.com/115x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 1, 'Parkland', '227704947-6', '12/29/2010', false, 'http://dummyimage.com/197x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 3, 9, 'Wog Boy, The', '038806478-1', '2/13/2020', true, 'http://dummyimage.com/188x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 2, 4, 'Me and the Colonel ', '685743729-7', '11/22/2003', false, 'http://dummyimage.com/246x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 5, 9, 'Horsemen', '248479481-9', '7/21/2002', false, 'http://dummyimage.com/126x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 4, 'Misérables, Les', '640110581-X', '5/21/2001', false, 'http://dummyimage.com/174x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 2, 'The Sky Dragon', '944430173-7', '4/19/2003', true, 'http://dummyimage.com/105x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 9, 'Ed and His Dead Mother', '234226669-3', '10/23/1999', false, 'http://dummyimage.com/147x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 3, 9, '5th Day of Peace (Dio è con noi)', '734675252-X', '2/24/2004', true, 'http://dummyimage.com/227x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 5, 5, 'Michael Jordan to the Max', '446404623-1', '9/2/2023', true, 'http://dummyimage.com/179x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 7, 'All for the Winner (Dou sing)', '069321370-1', '9/19/2011', true, 'http://dummyimage.com/128x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 3, 8, 'Bunnyman', '477807535-8', '6/8/2014', false, 'http://dummyimage.com/226x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 1, 2, 'Pickle, The', '898809527-8', '10/20/2022', false, 'http://dummyimage.com/231x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 4, 'Avalon', '624107034-7', '4/8/2004', false, 'http://dummyimage.com/208x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 1, 3, 'Wild Boys of the Road', '259766832-0', '10/4/2002', false, 'http://dummyimage.com/120x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 4, 3, 'Answer Man, The (a.k.a. Arlen Faber)', '777589291-9', '11/13/2000', true, 'http://dummyimage.com/124x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 3, 'Bad Men of Missouri', '270085282-6', '4/25/2007', false, 'http://dummyimage.com/135x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 3, 'James Dean Story, The', '191150498-3', '8/15/2024', true, 'http://dummyimage.com/150x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 5, 'Dead Heat', '914596609-5', '11/14/2001', false, 'http://dummyimage.com/115x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 2, 'Ernest Goes to School', '944856055-9', '12/19/2000', false, 'http://dummyimage.com/184x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 3, 3, 'Undisputed', '200014897-2', '6/14/2015', true, 'http://dummyimage.com/116x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 4, 5, 'Saving Santa', '556294135-X', '5/2/2019', false, 'http://dummyimage.com/194x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 4, 'Divorce Iranian Style', '485558437-1', '2/19/2022', true, 'http://dummyimage.com/147x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 2, 'Gappa: The Triphibian Monsters (AKA Monster from a Prehistoric Planet) (Daikyojû Gappa)', '613442196-0', '8/29/2018', true, 'http://dummyimage.com/225x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 3, 7, 'Illegal', '541206816-2', '2/16/2020', true, 'http://dummyimage.com/199x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 4, 'Someone''s Gaze', '146360131-X', '3/4/2016', false, 'http://dummyimage.com/219x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 9, 'My Girl', '229753837-5', '8/23/2010', true, 'http://dummyimage.com/230x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 3, 'House of Cards', '314781584-6', '2/15/2024', false, 'http://dummyimage.com/239x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 8, 'Supercop (Police Story 3: Supercop) (Jing cha gu shi III: Chao ji jing cha)', '809724339-3', '1/18/2000', true, 'http://dummyimage.com/168x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 1, 'Road to Morocco', '996701216-1', '8/18/2024', true, 'http://dummyimage.com/249x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 9, 'Show', '600936100-1', '10/30/2009', true, 'http://dummyimage.com/160x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 6, 'This Is Elvis', '465907003-4', '1/12/2009', false, 'http://dummyimage.com/147x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 6, 'Violeta Went to Heaven (Violeta se fue a los cielos)', '088823533-X', '12/2/2020', false, 'http://dummyimage.com/229x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 4, 1, 'Kadosh', '611108838-6', '12/28/2001', true, 'http://dummyimage.com/105x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 8, 'Endurance: Shackleton''s Legendary Antarctic Expedition, The', '284311099-8', '12/6/2001', true, 'http://dummyimage.com/108x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 1, 9, 'Flyboys', '341188940-3', '5/22/2000', false, 'http://dummyimage.com/181x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 6, 9, 'Land of Happines (Onnen maa)', '300474546-1', '4/6/2018', false, 'http://dummyimage.com/182x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 4, 6, '54', '217570417-3', '1/27/2012', true, 'http://dummyimage.com/181x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 3, 'Tournament, The', '008254353-4', '11/8/2011', true, 'http://dummyimage.com/245x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 5, 7, 'Nightmare on Elm Street, A', '789748877-2', '12/4/2002', false, 'http://dummyimage.com/231x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 7, 'Bernice Bobs Her Hair', '653050705-1', '11/17/2018', true, 'http://dummyimage.com/144x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 4, 'Nim''s Island', '553443643-3', '3/7/2018', false, 'http://dummyimage.com/106x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 7, 'Quiz Show', '131170882-0', '7/6/2010', true, 'http://dummyimage.com/130x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 2, 'Herr Lehmann', '853205177-4', '6/4/2014', false, 'http://dummyimage.com/195x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 2, 5, 'Shamus', '608729452-X', '6/13/2016', false, 'http://dummyimage.com/161x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 1, 8, 'At Home by Myself... with You', '488173045-2', '7/5/2005', false, 'http://dummyimage.com/113x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 8, 'Gabrielle', '068256869-4', '3/3/2024', false, 'http://dummyimage.com/156x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 7, 'Tale of Two Cities, A', '344478111-3', '4/18/2018', false, 'http://dummyimage.com/153x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 5, 3, 'Prisoner of Zenda, The', '154597261-3', '2/5/2024', false, 'http://dummyimage.com/104x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 5, 'Planet of the Apes', '065593007-8', '1/22/2010', true, 'http://dummyimage.com/130x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 1, 'Incident at Oglala', '849135798-X', '11/8/2010', false, 'http://dummyimage.com/219x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 9, 'Joshua', '887225622-4', '10/29/2018', false, 'http://dummyimage.com/209x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 4, 'Girl Can''t Help It, The', '237019135-X', '12/1/2009', true, 'http://dummyimage.com/174x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 4, 3, 'Badmaash Company', '164259669-8', '2/3/2017', false, 'http://dummyimage.com/102x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 1, 5, 'Cold Light of Day, The', '250211500-0', '12/9/2000', false, 'http://dummyimage.com/112x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 1, 8, 'Basketball Diaries, The', '207897996-1', '8/20/2015', false, 'http://dummyimage.com/220x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 3, 4, 'Case Against 8, The', '922021842-9', '4/16/2009', false, 'http://dummyimage.com/178x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 1, 'Morning Patrol (Proini peripolos)', '727578950-7', '10/10/2006', true, 'http://dummyimage.com/107x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 1, 'Sallah', '778436239-0', '5/29/2024', false, 'http://dummyimage.com/211x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 1, 7, 'For the Love of a Dog', '367755190-0', '1/24/2021', true, 'http://dummyimage.com/192x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 5, 1, 'Nasty Girl, The (schreckliche Mädchen, Das)', '517021045-0', '2/20/2024', false, 'http://dummyimage.com/120x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 5, 'Tokyo Story (Tôkyô monogatari)', '891416219-2', '6/15/2017', true, 'http://dummyimage.com/161x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 3, 'Idle Mist (Vana Espuma)', '372911617-7', '8/19/2020', true, 'http://dummyimage.com/195x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 5, 'Underground Comedy Movie, The', '792493398-0', '5/27/2012', false, 'http://dummyimage.com/217x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 4, 'Slow Burn', '382950513-2', '8/28/2013', false, 'http://dummyimage.com/239x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 6, 3, 'Arctic Blast', '108872549-X', '10/17/2022', true, 'http://dummyimage.com/241x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 8, 'Great Lie, The', '515981961-4', '2/15/2007', false, 'http://dummyimage.com/249x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 1, 7, 'Amelie (Fabuleux destin d''Amélie Poulain, Le)', '137617938-5', '4/27/2019', false, 'http://dummyimage.com/162x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 3, 9, 'Slipstream', '508913784-6', '3/27/2008', false, 'http://dummyimage.com/237x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 4, 'I Do: How to Get Married and Stay Single (Prête-moi ta main)', '043493133-0', '4/16/2003', false, 'http://dummyimage.com/218x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 6, 4, 'No Nukes', '353349536-1', '6/19/2006', false, 'http://dummyimage.com/156x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 4, 7, 'The Circle', '521905379-5', '4/23/2017', false, 'http://dummyimage.com/233x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 4, 4, 'Saraband', '791038092-5', '3/23/2014', false, 'http://dummyimage.com/142x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 6, 'Babylon 5: The Legend of the Rangers: To Live and Die in Starlight', '926095518-1', '8/15/2012', true, 'http://dummyimage.com/157x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 3, 'Dara Ó Briain Talks Funny: Live in London', '627068719-5', '7/11/2020', true, 'http://dummyimage.com/134x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 5, 7, 'Green Slime, The', '661863090-8', '3/28/2000', true, 'http://dummyimage.com/218x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 2, 'Square, The (Al Midan)', '969910618-2', '7/5/2004', true, 'http://dummyimage.com/195x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 7, 'Throw Away Your Books, Rally in the Streets', '709910750-X', '7/16/2022', true, 'http://dummyimage.com/241x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 9, 'American Gun', '364508312-X', '6/30/2008', false, 'http://dummyimage.com/225x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 7, 'Like Minds (Murderous Intent)', '259683960-1', '2/23/2003', false, 'http://dummyimage.com/214x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 3, 7, 'Good Mother, The', '964616076-X', '3/2/2014', true, 'http://dummyimage.com/171x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 5, 'Stuff, The', '095569094-3', '9/10/2020', true, 'http://dummyimage.com/106x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 4, 'Tooth & Nail', '556640088-4', '10/26/2011', true, 'http://dummyimage.com/117x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 6, 2, 'Citizen Toxie: The Toxic Avenger IV', '601195077-9', '5/5/2005', false, 'http://dummyimage.com/144x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 4, 5, 'Double Play: James Benning and Richard Linklater', '815689108-2', '8/8/2005', true, 'http://dummyimage.com/161x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 3, 'Destination Gobi', '311649803-2', '11/18/2001', false, 'http://dummyimage.com/217x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 9, 'They Live by Night', '775741339-7', '6/9/2017', true, 'http://dummyimage.com/107x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 6, 'Father of the Bride', '893421666-2', '2/24/2004', true, 'http://dummyimage.com/250x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 8, 'Shall We Dance', '800137271-5', '5/23/2006', true, 'http://dummyimage.com/104x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 2, 'El Greco', '063876937-X', '7/10/2024', false, 'http://dummyimage.com/217x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 4, 'Vacuuming Completely Nude in Paradise', '449279129-9', '7/26/2024', true, 'http://dummyimage.com/149x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 3, 1, 'Vinci', '567035336-6', '4/6/2020', true, 'http://dummyimage.com/111x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 1, 7, 'Dance of Reality, The (Danza de la realidad, La)', '604603619-4', '8/15/2022', false, 'http://dummyimage.com/158x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 6, 'Last Kiss, The (Ultimo bacio, L'')', '939923632-3', '11/19/2011', true, 'http://dummyimage.com/219x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 9, 'Dreamer: Inspired by a True Story', '593145945-6', '9/27/2020', false, 'http://dummyimage.com/158x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 2, 'Deathsport', '845300073-5', '11/30/2004', false, 'http://dummyimage.com/103x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 5, 1, 'Hawk Is Dying, The', '261557833-2', '2/3/2021', false, 'http://dummyimage.com/111x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 1, 5, 'Grey Fox, The', '910787992-X', '9/13/2024', false, 'http://dummyimage.com/240x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 3, 8, 'House of Frankenstein', '975856344-0', '12/7/2010', false, 'http://dummyimage.com/217x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 6, 8, 'Body Fat Index of Love', '548408759-7', '8/18/2012', true, 'http://dummyimage.com/179x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 3, 'Starman', '772543596-4', '11/13/2010', true, 'http://dummyimage.com/131x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 4, 2, 'Broadway Melody of 1938', '650159498-7', '6/20/2017', false, 'http://dummyimage.com/178x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 1, 'Cameraman, The', '468359727-6', '5/8/2022', true, 'http://dummyimage.com/153x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 2, 'Coming to America', '021427652-X', '5/4/2007', true, 'http://dummyimage.com/121x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 6, 'Ill Gotten Gains', '349997244-1', '10/7/2011', false, 'http://dummyimage.com/217x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 1, 'Weirdsville', '924511561-5', '3/12/2022', false, 'http://dummyimage.com/143x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 5, 'Thirst (Bakjwi)', '182489929-7', '12/14/2001', false, 'http://dummyimage.com/150x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 2, 3, 'Harry Potter and the Sorcerer''s Stone (a.k.a. Harry Potter and the Philosopher''s Stone)', '704931813-2', '4/7/2020', true, 'http://dummyimage.com/183x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 2, 'Spartan', '558441371-2', '1/10/2022', true, 'http://dummyimage.com/155x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 9, 'Deathstalker', '942224462-5', '7/20/2024', false, 'http://dummyimage.com/208x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 4, 5, 'Tropico', '067276115-7', '7/29/2013', true, 'http://dummyimage.com/133x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 2, 4, 'Last Will of Dr. Mabuse, The (Testament du Dr. Mabuse, Le)', '080539768-X', '6/30/2016', true, 'http://dummyimage.com/181x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 6, 7, 'Spider', '024739654-0', '1/10/2006', true, 'http://dummyimage.com/169x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 5, 4, 'Eros Plus Massacre (Erosu purasu Gyakusatsu)', '019152436-0', '5/17/2011', false, 'http://dummyimage.com/138x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 3, 3, 'Game Over', '636845642-6', '5/26/2005', false, 'http://dummyimage.com/219x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 1, 7, 'For the Birds', '946665934-0', '8/27/2003', true, 'http://dummyimage.com/149x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 6, 4, 'Field of Dreams', '182121928-7', '1/20/2020', false, 'http://dummyimage.com/106x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 6, 4, 'Bad Sleep Well, The (Warui yatsu hodo yoku nemuru)', '584961885-6', '7/16/2002', true, 'http://dummyimage.com/150x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 1, 1, 'A Gathering of Eagles', '533762280-3', '1/12/2021', true, 'http://dummyimage.com/113x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 8, 'Bananas!*', '709845010-3', '11/22/2002', false, 'http://dummyimage.com/222x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 1, '13 Beloved (13 game sayawng)', '095934844-1', '12/16/2007', true, 'http://dummyimage.com/195x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 8, 'Resan Till Melonia', '210207268-1', '12/1/1999', true, 'http://dummyimage.com/223x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 4, 1, 'Flight of the Navigator', '324992613-2', '8/20/2017', true, 'http://dummyimage.com/167x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 4, 1, 'Dead Silent', '890247105-5', '12/1/2000', false, 'http://dummyimage.com/165x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 4, 'Bereavement', '461631792-5', '9/4/2024', true, 'http://dummyimage.com/226x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 4, 'In My Skin (Dans ma Peau)', '681763701-5', '5/21/2003', false, 'http://dummyimage.com/160x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 2, 4, 'Araya', '853803568-1', '8/2/2007', false, 'http://dummyimage.com/219x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 2, 'Linewatch', '757952079-6', '3/12/2002', false, 'http://dummyimage.com/153x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 2, 'Badmaash Company', '409809555-6', '6/15/2018', true, 'http://dummyimage.com/209x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 4, '66 Scenes From America', '649223969-5', '11/13/2006', false, 'http://dummyimage.com/189x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 3, 'Rånarna', '816867899-0', '8/27/2010', false, 'http://dummyimage.com/200x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 3, 1, 'Snow White: A Tale of Terror', '612635225-4', '7/6/2008', true, 'http://dummyimage.com/125x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 7, 'Blade: Trinity', '669237109-0', '2/21/2017', true, 'http://dummyimage.com/241x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 5, 3, 'Last Days of Mussolini (Mussolini: Ultimo atto)', '974731979-9', '4/18/2012', false, 'http://dummyimage.com/182x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 6, 6, 'Tarzan Finds a Son!', '724706025-5', '12/19/2021', false, 'http://dummyimage.com/129x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 7, 'Miracle on 34th Street', '906029104-2', '3/26/2006', true, 'http://dummyimage.com/124x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 1, 6, 'In Therapy (Divã)', '893841586-4', '3/14/2020', false, 'http://dummyimage.com/191x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 4, 'Angel and the Badman', '475319083-8', '12/7/1999', true, 'http://dummyimage.com/220x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 3, 'Madame Butterfly', '377702604-2', '7/17/2007', false, 'http://dummyimage.com/195x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 8, 'Sandlot, The', '517441358-5', '11/4/2022', true, 'http://dummyimage.com/249x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 9, 'Seven Year Itch, The', '747572102-7', '1/29/2006', false, 'http://dummyimage.com/171x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 4, 4, 'Muppet Christmas: Letters to Santa, A', '895218795-4', '4/30/2001', true, 'http://dummyimage.com/114x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 9, 'Hit Lady', '421787233-X', '1/26/2004', false, 'http://dummyimage.com/155x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 6, 7, 'Criminal, The (a.k.a. Concrete Jungle)', '480460430-8', '9/9/2008', true, 'http://dummyimage.com/155x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 2, 1, 'Jimmy Carter Man from Plains', '410483871-3', '3/29/2001', false, 'http://dummyimage.com/179x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 5, 'Avenging Conscience, The', '036320759-7', '11/22/2017', true, 'http://dummyimage.com/114x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 8, 'Goldengirl', '570674874-8', '7/6/2001', false, 'http://dummyimage.com/188x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 5, 'Boy Upside Down', '160791812-9', '3/2/2014', false, 'http://dummyimage.com/163x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 1, 'Ice Princess', '914795657-7', '3/12/2005', false, 'http://dummyimage.com/201x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 5, 6, 'Inescapable', '344697968-9', '1/5/2004', false, 'http://dummyimage.com/134x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 1, 8, 'Red Angel (Akai tenshi)', '065829417-2', '12/14/2003', true, 'http://dummyimage.com/190x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 5, 'Ichi', '545872287-6', '10/31/2021', false, 'http://dummyimage.com/100x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 5, 'Lauderdale (a.k.a. Spring Break USA) (a.k.a. Spring Fever USA)', '503686004-7', '12/19/2014', false, 'http://dummyimage.com/150x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 3, 'Me and Him (Ich und Er)', '527258867-3', '10/31/2005', true, 'http://dummyimage.com/183x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 1, 'Mr. Toad''s Wild Ride (a.k.a. The Wind in the Willows)', '392639378-5', '2/18/2001', true, 'http://dummyimage.com/247x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 5, 1, 'Dirty Dozen: Next Mission, The', '924632581-8', '9/21/2022', true, 'http://dummyimage.com/206x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 3, 'Enola Gay and the Atomic Bombing of Japan', '472812799-0', '2/19/2011', false, 'http://dummyimage.com/107x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 3, 1, 'Last September, The', '154942497-1', '11/21/2008', true, 'http://dummyimage.com/177x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 1, 'Day Watch (Dnevnoy dozor)', '337013378-4', '4/10/2023', true, 'http://dummyimage.com/105x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 6, 9, 'Shipwrecked (a.k.a. Haakon Haakonsen)', '598137069-6', '11/5/2012', false, 'http://dummyimage.com/208x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 4, 'White, Red and Verdone', '375444444-1', '8/21/2012', false, 'http://dummyimage.com/193x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 6, 4, 'Red Cliff (Chi bi)', '634843151-7', '3/29/2017', false, 'http://dummyimage.com/178x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 1, 7, 'Emotion', '367213262-4', '4/8/2002', true, 'http://dummyimage.com/206x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 4, 'Scalphunters, The', '885067531-3', '6/16/2013', false, 'http://dummyimage.com/194x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 2, 'Cadence', '548153947-0', '7/12/2004', false, 'http://dummyimage.com/124x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 5, 5, 'Son of Flubber', '815359628-4', '10/2/2024', true, 'http://dummyimage.com/182x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 3, 4, 'The Pool Boys', '795492683-4', '2/25/2020', true, 'http://dummyimage.com/229x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 4, 8, 'Fellini''s Roma (Roma)', '402748118-6', '2/17/2001', false, 'http://dummyimage.com/103x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 3, 8, 'This Night I''ll Possess Your Corpse (Esta Noite Encarnarei no Teu Cadáver)', '292331477-8', '8/4/2010', false, 'http://dummyimage.com/193x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 7, 'Heidi Fleiss: Hollywood Madam', '696750823-7', '3/21/2008', true, 'http://dummyimage.com/137x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 2, 'On_Line (a.k.a. On Line)', '500684763-8', '7/23/2015', false, 'http://dummyimage.com/190x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 1, 7, 'Window, The', '644229855-8', '1/27/2000', false, 'http://dummyimage.com/100x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 8, 'Hercules', '102542903-6', '6/23/2004', true, 'http://dummyimage.com/230x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 8, 'Bonjour tristesse', '314899650-X', '12/28/2009', false, 'http://dummyimage.com/107x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 3, 4, 'Tall Story', '294439923-3', '1/8/2000', false, 'http://dummyimage.com/167x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 2, 'Benny''s Video', '894923071-2', '12/15/2004', false, 'http://dummyimage.com/101x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 3, 6, 'With Honors', '303141318-0', '3/27/2006', false, 'http://dummyimage.com/119x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 5, 'Wild Women', '432440222-1', '5/2/2023', true, 'http://dummyimage.com/186x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 8, 'One Direction: This Is Us', '930077945-1', '8/6/2007', true, 'http://dummyimage.com/114x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 1, 6, 'Kickboxer 3: The Art of War (Kickboxer III: The Art of War)', '336838901-7', '7/29/2022', true, 'http://dummyimage.com/230x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 4, 8, 'Château, The', '037551951-3', '1/10/2021', true, 'http://dummyimage.com/242x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 5, 3, 'Lone Ranger, The', '244065334-9', '9/9/2023', true, 'http://dummyimage.com/102x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 4, 1, '3 Needles', '009958815-3', '5/1/2020', false, 'http://dummyimage.com/130x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 8, 'People vs. Larry Flynt, The', '538688855-2', '11/12/2018', true, 'http://dummyimage.com/213x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 1, 'Paper Clips', '751562649-6', '12/8/2020', true, 'http://dummyimage.com/213x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 5, 'Get Carter', '857689993-0', '7/11/2010', false, 'http://dummyimage.com/148x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 1, 'Repo Men', '779492563-0', '6/11/2006', true, 'http://dummyimage.com/164x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 9, 'Three Musketeers, The', '190621775-0', '5/27/2003', true, 'http://dummyimage.com/191x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 4, 7, 'School Daze', '324634115-X', '5/25/2012', true, 'http://dummyimage.com/120x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 4, 1, 'Doctor X', '650457517-7', '12/2/2008', true, 'http://dummyimage.com/185x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 5, 7, 'Fausto 5.0', '229538843-0', '3/26/2006', true, 'http://dummyimage.com/156x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 3, 5, 'Into the Blue 2: The Reef', '546534872-0', '6/6/2006', true, 'http://dummyimage.com/207x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 4, 6, 'Remember Sunday', '888102624-4', '3/21/2006', false, 'http://dummyimage.com/196x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 9, 'Good Time Max', '407190224-8', '8/4/2013', true, 'http://dummyimage.com/125x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 1, 2, 'Stir of Echoes', '598801781-9', '4/5/2008', true, 'http://dummyimage.com/134x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 4, 9, 'Magadheera', '380407464-2', '11/24/2009', true, 'http://dummyimage.com/244x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 3, 'Blood and Black Lace (Sei donne per l''assassino)', '532547345-X', '3/31/2018', false, 'http://dummyimage.com/117x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 4, 'Bachelor in Paradise', '129293536-7', '4/10/2008', false, 'http://dummyimage.com/230x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 5, 'Breaking Wind', '302786896-9', '4/21/2020', true, 'http://dummyimage.com/157x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 6, 3, 'Julius Caesar', '974754313-3', '12/21/2010', true, 'http://dummyimage.com/138x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 6, '2081', '103258887-X', '3/17/2000', false, 'http://dummyimage.com/129x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 5, 'Papa''s Delicate Condition', '825794754-7', '7/21/2009', false, 'http://dummyimage.com/190x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 8, 'Tracks', '284479844-6', '12/29/1999', false, 'http://dummyimage.com/135x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 2, 'Stone Angel, The', '895737371-3', '3/18/2008', false, 'http://dummyimage.com/105x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 5, 4, 'Traveler, The (Mossafer)', '513299865-8', '4/6/2024', false, 'http://dummyimage.com/241x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 4, 'Bourne Legacy, The', '140631673-3', '12/15/2010', true, 'http://dummyimage.com/131x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 1, 7, 'Veteran, The', '856223316-1', '8/24/2000', true, 'http://dummyimage.com/124x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 9, 'Kill Buljo: The Movie', '906015630-7', '12/3/2004', true, 'http://dummyimage.com/211x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 8, 'Where Love Has Gone', '592320375-8', '3/15/2011', false, 'http://dummyimage.com/198x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 1, 1, 'Arabian Nights (Il fiore delle mille e una notte)', '187024255-6', '3/11/2008', false, 'http://dummyimage.com/118x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 5, 3, 'In Country', '300881218-X', '2/12/2010', true, 'http://dummyimage.com/216x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 5, 'Texas Chainsaw 3D', '372600058-5', '4/16/2002', false, 'http://dummyimage.com/233x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 5, 6, 'Piglet''s Big Movie', '225517443-X', '5/11/2016', false, 'http://dummyimage.com/119x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 9, 'Othello', '764639113-1', '7/25/2015', false, 'http://dummyimage.com/133x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 4, 5, 'ThanksKilling 3 ', '267119976-7', '12/27/2009', false, 'http://dummyimage.com/133x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 1, 'Just a Gigolo', '901352931-3', '9/10/2018', false, 'http://dummyimage.com/220x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 3, 'Burning, The', '039622556-X', '10/20/2010', false, 'http://dummyimage.com/114x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 4, 'Policeman (Ha-shoter)', '438493480-7', '4/23/2020', false, 'http://dummyimage.com/166x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 5, 'L.627', '939869894-3', '5/16/2004', true, 'http://dummyimage.com/187x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 2, 'Tromeo and Juliet', '404911745-2', '3/30/2019', true, 'http://dummyimage.com/125x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 5, 'Vincent Wants to Sea (Vincent will meer)', '909610023-9', '3/21/2021', false, 'http://dummyimage.com/147x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 7, 'Alone (Issiz adam)', '344038773-9', '7/23/2022', true, 'http://dummyimage.com/108x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 4, 6, 'Edge of the City', '086149354-0', '2/19/2022', false, 'http://dummyimage.com/140x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 4, 5, 'Family Life', '222285701-5', '7/27/2019', false, 'http://dummyimage.com/219x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 2, 'Three Way', '262541798-6', '2/11/2012', false, 'http://dummyimage.com/227x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 3, 'Monty Python: Almost the Truth - Lawyers Cut', '281913501-3', '8/31/2003', false, 'http://dummyimage.com/221x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 8, 'I''m Not There', '749546143-8', '11/17/2021', true, 'http://dummyimage.com/167x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 1, 4, 'Man from Nowhere, The (Ajeossi)', '681137895-6', '1/19/2007', true, 'http://dummyimage.com/217x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 5, 'Birdwatchers (BirdWatchers - La terra degli uomini rossi)', '513149619-5', '9/28/2018', false, 'http://dummyimage.com/188x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 8, 'White Elephant', '897088425-4', '6/14/2013', true, 'http://dummyimage.com/233x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 1, 'Song of Bernadette, The', '147432780-X', '9/28/2011', true, 'http://dummyimage.com/122x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 3, 2, 'Spider-Man 3', '321959403-4', '12/29/2017', false, 'http://dummyimage.com/169x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 3, 3, 'Bikini Summer III - South Beach Heat', '912787072-3', '1/31/2023', true, 'http://dummyimage.com/159x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 3, 'Darktown Strutters (Get Down and Boogie)', '028949805-8', '8/13/2015', true, 'http://dummyimage.com/232x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 4, 3, 'Star Maker, The (Uomo delle stelle, L'')', '641289191-9', '4/29/2001', true, 'http://dummyimage.com/109x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 3, 9, 'When Marnie Was There', '150524053-0', '4/15/2008', true, 'http://dummyimage.com/244x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 6, 'Texas Chainsaw Massacre, The', '611785957-0', '12/10/2012', false, 'http://dummyimage.com/121x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 6, 'My Man Godfrey', '692966714-5', '1/8/2001', true, 'http://dummyimage.com/106x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 3, '13 Beloved (13 game sayawng)', '894382582-X', '10/20/2019', true, 'http://dummyimage.com/163x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 4, 'Einstein and Eddington', '180509641-9', '4/3/2021', true, 'http://dummyimage.com/118x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 3, 'Torrente 2: Misión Marbella', '152705224-9', '5/20/2017', true, 'http://dummyimage.com/119x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 1, 1, 'Detective, The (C+ jing taam)', '589844308-8', '4/28/2006', false, 'http://dummyimage.com/183x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 5, 3, 'Taxi Blues', '605795162-X', '7/4/2006', false, 'http://dummyimage.com/161x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 5, 'Princess Ka''iulani', '080351983-4', '2/11/2003', false, 'http://dummyimage.com/207x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 6, 9, 'Chasing Ice', '719886038-9', '6/22/2000', true, 'http://dummyimage.com/198x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 8, 'Castle of Cloads, The (Pilvilinna)', '026960326-3', '6/8/2016', true, 'http://dummyimage.com/103x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 9, 'Ballou', '318682931-3', '1/31/2015', true, 'http://dummyimage.com/104x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 1, 3, 'Hercules', '220521933-2', '11/7/2009', true, 'http://dummyimage.com/124x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 7, 'Habana Blues', '714972002-1', '5/19/2015', true, 'http://dummyimage.com/110x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 4, 'xXx: State of the Union', '739783863-4', '10/25/2005', true, 'http://dummyimage.com/138x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 6, 'Fantomas (Fantômas - À l''ombre de la guillotine)', '357614916-3', '8/8/2000', false, 'http://dummyimage.com/182x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 9, 'Undefeated, The', '499249467-6', '12/10/2011', false, 'http://dummyimage.com/174x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 4, 1, 'Prince of Pennsylvania, The', '019420247-X', '4/15/2017', true, 'http://dummyimage.com/206x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 5, 5, 'Invictus', '064338756-0', '9/7/2001', false, 'http://dummyimage.com/168x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 4, 'Out of the Past', '604601779-3', '4/16/2005', true, 'http://dummyimage.com/208x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 5, 'For Your Eyes Only', '981315199-4', '7/6/2022', false, 'http://dummyimage.com/173x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 2, 'Johnny Belinda', '719513171-8', '2/9/2003', false, 'http://dummyimage.com/195x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 4, 'Fear X', '097876727-6', '11/19/2014', true, 'http://dummyimage.com/165x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 6, 7, 'Lt. Robin Crusoe, U.S.N.', '243418424-3', '10/20/1999', true, 'http://dummyimage.com/198x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 4, 'Tyler Perry''s Why Did I Get Married?', '126681069-2', '11/16/2022', true, 'http://dummyimage.com/242x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 7, 'Weary River', '063429357-5', '8/11/2018', true, 'http://dummyimage.com/105x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 6, 7, 'Playing the Victim (Izobrazhaya zhertvu)', '249833376-2', '2/25/2024', false, 'http://dummyimage.com/227x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 1, 8, 'Glass Bottom Boat, The', '650716646-4', '9/10/2019', true, 'http://dummyimage.com/190x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 7, 'Looking for Eric', '900057969-4', '5/10/2022', true, 'http://dummyimage.com/124x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 6, 'Hammett', '412169818-5', '10/8/2006', false, 'http://dummyimage.com/146x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 1, 3, 'Necessary Roughness', '669169218-7', '2/15/2003', true, 'http://dummyimage.com/114x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 8, 'Cambridge Spies', '404447551-2', '2/23/2010', true, 'http://dummyimage.com/182x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 6, 5, 'Castle Keep', '288023144-2', '8/24/2010', false, 'http://dummyimage.com/203x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 6, 'Dune', '397157713-X', '6/12/2017', true, 'http://dummyimage.com/228x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 3, 1, 'A Short History of Decay', '614566273-5', '6/26/2000', false, 'http://dummyimage.com/110x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 6, 'The Princess Comes Across', '473132908-6', '4/30/2001', false, 'http://dummyimage.com/229x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 8, 'Wife! Be Like a Rose! (Tsuma yo bara no yo ni)', '038797771-6', '10/20/2000', false, 'http://dummyimage.com/122x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 5, 'Pontypool', '312560467-2', '3/4/2003', false, 'http://dummyimage.com/160x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 5, 'Twisted', '529389118-9', '4/11/2009', false, 'http://dummyimage.com/243x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 3, 4, 'H-Man, The (Bijo to Ekitainingen)', '497871600-4', '7/29/2014', false, 'http://dummyimage.com/182x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 1, 'High and the Mighty, The', '339270517-9', '5/11/2016', true, 'http://dummyimage.com/115x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 1, 'Absolute Giganten', '214038063-0', '9/1/2008', false, 'http://dummyimage.com/154x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 1, 'Iron Ladies, The (Satree lek)', '514835466-6', '12/19/2002', false, 'http://dummyimage.com/116x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 5, 1, 'Last Mimzy, The', '071260912-1', '6/4/2007', true, 'http://dummyimage.com/223x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 6, 'Unidentified Flying Oddball (a.k.a. Spaceman and King Arthur, The) (a.k.a. Spaceman in King Arthur''s Court, A)', '331856078-2', '3/14/2004', false, 'http://dummyimage.com/188x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 7, 'Renaissance Man', '261820051-9', '1/13/2010', false, 'http://dummyimage.com/136x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 8, 'Junkopia', '191992387-X', '7/30/2013', true, 'http://dummyimage.com/186x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 1, 7, 'My Voyage to Italy (Il mio viaggio in Italia)', '568321060-7', '9/22/2010', false, 'http://dummyimage.com/186x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 1, 6, 'Cabiria', '402719572-8', '3/18/2011', false, 'http://dummyimage.com/108x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 5, 'Victory', '860647838-5', '5/6/2024', true, 'http://dummyimage.com/124x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 6, 'Creator', '663888006-3', '7/13/2017', false, 'http://dummyimage.com/241x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 8, 'L''antisémite', '656435559-9', '11/6/2022', true, 'http://dummyimage.com/227x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 1, 5, 'Abominable Dr. Phibes, The', '024985335-3', '3/11/2019', true, 'http://dummyimage.com/123x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 8, 'Peacekeeper, The', '741381849-3', '5/5/2008', false, 'http://dummyimage.com/130x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 8, 'Brothers Karamazov, The', '971774847-0', '1/2/2009', false, 'http://dummyimage.com/129x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 6, 2, 'Coming Home', '004948358-7', '6/1/2024', false, 'http://dummyimage.com/108x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 7, 'Hadewijch', '072029203-4', '4/20/2013', true, 'http://dummyimage.com/173x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 4, 5, 'Secret Things (Choses secrètes)', '459458406-3', '12/24/2008', false, 'http://dummyimage.com/150x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 5, 'Buffalo Bill', '351486588-4', '7/1/2001', false, 'http://dummyimage.com/114x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 4, 'That Most Important Thing: Love (L''important c''est d''aimer)', '543317342-9', '9/13/2016', false, 'http://dummyimage.com/199x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 2, 5, 'Power and Terror: Noam Chomsky in Our Times', '469327491-7', '11/21/1999', true, 'http://dummyimage.com/192x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 5, 'The Sweet Ride', '214276281-6', '2/25/2015', false, 'http://dummyimage.com/187x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 4, 'Slumber Party Massacre, The', '743157303-0', '5/18/2008', true, 'http://dummyimage.com/225x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 1, 'Mesmerist, The', '481464717-4', '9/17/2019', true, 'http://dummyimage.com/199x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 5, 'Rape of Europa, The', '844760842-5', '2/9/2007', true, 'http://dummyimage.com/201x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 4, 9, 'Sister Kenny', '956391838-X', '9/9/2016', true, 'http://dummyimage.com/206x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 8, 'Corpse Bride', '857710747-7', '1/2/2013', true, 'http://dummyimage.com/128x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 2, 'Scary Movie', '973657902-6', '8/27/2001', false, 'http://dummyimage.com/236x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 6, 7, 'Sharon''s Baby', '018737421-X', '6/16/2013', false, 'http://dummyimage.com/152x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 5, 'Animals are Beautiful People', '432291338-5', '3/1/2015', true, 'http://dummyimage.com/200x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 2, 'Case départ', '227225401-2', '5/28/2024', true, 'http://dummyimage.com/154x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 9, 'Good Wife, The', '852489007-X', '2/18/2002', true, 'http://dummyimage.com/228x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 2, 8, 'Victim', '425814405-3', '10/5/2010', false, 'http://dummyimage.com/121x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 7, 'Goat, The (a.k.a. Knock On Wood) (Chèvre, La)', '464410536-8', '4/22/2001', false, 'http://dummyimage.com/104x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 2, 'Yrrol: An Enormously Well Thought Out Movie (Yrrol - en kolossalt genomtänkt film)', '317411682-1', '12/5/2003', true, 'http://dummyimage.com/199x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 4, 'Devil''s Nightmare, The (Plus longue nuit du diable, La)', '374015734-8', '6/5/2009', true, 'http://dummyimage.com/110x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 2, 'Wedding Crashers', '391704211-8', '6/8/2018', false, 'http://dummyimage.com/122x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 2, 'Spy Kids 2: The Island of Lost Dreams', '823675073-6', '6/26/2016', true, 'http://dummyimage.com/190x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 6, 6, 'Little Drummer Boy, The', '115293657-3', '5/11/2002', true, 'http://dummyimage.com/244x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 6, 'Mommy', '956517443-4', '10/22/2020', false, 'http://dummyimage.com/183x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 2, 'Ever After: A Cinderella Story', '396284155-5', '11/26/2004', false, 'http://dummyimage.com/199x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 4, 'Play the Game', '334020204-4', '10/13/2017', true, 'http://dummyimage.com/134x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 1, 'American Astronaut, The', '571502174-X', '11/22/2003', true, 'http://dummyimage.com/195x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 7, 'Haunting in Connecticut 2: Ghosts of Georgia, The', '863919349-5', '2/13/2004', true, 'http://dummyimage.com/154x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 1, 7, 'Not as a Stranger', '713525754-5', '5/8/2020', true, 'http://dummyimage.com/232x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 4, 5, 'Kevin Hart: Seriously Funny', '016535057-1', '1/19/2015', false, 'http://dummyimage.com/160x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 5, 'Kidnap Syndicate', '864042591-4', '3/5/2022', false, 'http://dummyimage.com/183x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 5, 1, 'Fuzz', '154568358-1', '12/23/2015', true, 'http://dummyimage.com/239x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 5, 5, 'Animal Love (Tierische Liebe)', '560268181-7', '6/18/2005', true, 'http://dummyimage.com/220x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 7, '1984 (Nineteen Eighty-Four)', '796714135-0', '12/11/2021', true, 'http://dummyimage.com/116x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 7, 'Iron Ladies, The (Satree lek)', '016507294-6', '2/10/2016', true, 'http://dummyimage.com/212x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 5, 'Lawn Dogs', '559400498-X', '9/4/2024', false, 'http://dummyimage.com/106x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 4, 4, 'Carny', '954446371-2', '9/19/2021', false, 'http://dummyimage.com/197x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 4, 'Good Shepherd, The', '869915656-1', '5/21/2006', true, 'http://dummyimage.com/225x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 4, 1, 'Do the Right Thing', '407583023-3', '1/24/2023', true, 'http://dummyimage.com/212x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 3, 'Fear No Evil', '917527115-X', '12/12/2011', true, 'http://dummyimage.com/213x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 4, 1, 'Captain Thunder (Capitán Trueno y el Santo Grial, El) (Prince Killian and the Holy Grail)', '240653802-8', '11/13/2020', true, 'http://dummyimage.com/111x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 7, 'How to Stop Being a Loser', '567979345-8', '11/15/2000', true, 'http://dummyimage.com/232x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 4, 3, 'Gleason', '482831306-0', '2/4/2007', false, 'http://dummyimage.com/230x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 8, 'Last Stop 174 (Última Parada 174) ', '763417785-7', '11/29/2007', true, 'http://dummyimage.com/200x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 1, 3, 'Twelve Chairs, The', '554821052-1', '5/31/2010', true, 'http://dummyimage.com/109x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 9, 'Sea, The (Hafið)', '834779078-7', '12/18/2018', true, 'http://dummyimage.com/177x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 5, 'No God, No Master', '353579660-1', '4/11/2006', true, 'http://dummyimage.com/247x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 5, 'True Believer', '265514614-X', '9/2/2002', true, 'http://dummyimage.com/184x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 1, 'Mothra (Mosura)', '289100721-2', '10/27/2019', false, 'http://dummyimage.com/221x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 5, 'Weather Underground, The', '195382145-6', '10/16/2022', true, 'http://dummyimage.com/179x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 6, 'Helicopter String Quartet', '263761509-5', '9/21/2011', true, 'http://dummyimage.com/243x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 6, 6, 'Halloween II', '371732699-6', '4/7/2003', false, 'http://dummyimage.com/202x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 3, 7, 'Doctor Takes a Wife, The', '592228453-3', '6/9/2004', false, 'http://dummyimage.com/243x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 2, 6, 'Penitentiary II', '907901420-6', '7/30/2008', true, 'http://dummyimage.com/183x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 6, 5, 'Cialo', '830783389-2', '1/5/2019', true, 'http://dummyimage.com/238x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 3, 'Hangover Part II, The', '420696120-4', '4/11/2020', true, 'http://dummyimage.com/218x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 4, 9, 'Colt Comrades', '927730209-7', '9/13/2000', true, 'http://dummyimage.com/115x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 9, 'Heart of Glass (Herz aus Glas)', '724574434-3', '9/19/2017', true, 'http://dummyimage.com/221x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 8, 'In God''s Hands', '623836002-X', '4/12/2015', true, 'http://dummyimage.com/123x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 3, 7, 'Idolmaker, The', '392192244-5', '11/24/2022', false, 'http://dummyimage.com/184x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 8, 'Blood, Guts, Bullets and Octane', '364643438-4', '6/2/2017', true, 'http://dummyimage.com/151x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 4, 1, 'Summer Holiday', '512261166-1', '2/19/2009', true, 'http://dummyimage.com/239x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 6, 6, 'Guru', '957430488-4', '2/18/2012', false, 'http://dummyimage.com/161x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 6, 6, 'Chastity Bites', '007238904-4', '4/25/2007', true, 'http://dummyimage.com/122x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 3, 'Just Between Friends', '421826391-4', '9/30/2019', false, 'http://dummyimage.com/154x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 6, 'Lord of War', '332438798-1', '10/27/2011', true, 'http://dummyimage.com/198x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 2, 'Anchorman: The Legend of Ron Burgundy', '957185236-8', '9/1/2016', false, 'http://dummyimage.com/143x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 6, 'Ape, The (Apan)', '814374261-X', '2/21/2017', false, 'http://dummyimage.com/218x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 4, 6, 'Help Me, Eros (Bang bang wo ai shen)', '557559215-4', '5/18/2002', false, 'http://dummyimage.com/110x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 3, 'The Brass Legend', '998874876-0', '2/14/2003', false, 'http://dummyimage.com/106x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 2, 'I Am Santa Claus', '926261944-8', '2/5/2016', true, 'http://dummyimage.com/150x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 3, 9, 'Borrowers, The', '762506442-5', '4/21/2013', true, 'http://dummyimage.com/103x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 3, 'Wings of the Dove, The', '075109045-X', '5/27/2000', true, 'http://dummyimage.com/213x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 9, 'Welfare', '238749753-8', '12/4/2016', false, 'http://dummyimage.com/175x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 3, 'Paper Chase, The', '440680230-4', '11/8/2002', true, 'http://dummyimage.com/183x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 3, 'Brighton Rock', '568455373-7', '12/1/2019', true, 'http://dummyimage.com/223x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 2, 5, 'The Blue Room', '216095525-6', '4/23/2007', false, 'http://dummyimage.com/143x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 5, 'The Opposite Sex', '588695420-1', '12/6/2011', false, 'http://dummyimage.com/165x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 3, 'Aaron Loves Angela', '991369724-7', '7/29/2021', true, 'http://dummyimage.com/209x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 5, 'Belles of St. Trinian''s, The', '831261267-X', '12/17/2013', true, 'http://dummyimage.com/250x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 2, 'Dick', '860024612-1', '1/9/2006', false, 'http://dummyimage.com/141x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 3, 'Tarantula', '119652503-X', '11/18/2015', true, 'http://dummyimage.com/228x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 3, 6, 'Paper Chase, The', '348047466-7', '11/29/2021', true, 'http://dummyimage.com/106x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 3, 3, 'Gosford Park', '810602499-7', '3/30/2002', false, 'http://dummyimage.com/234x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 9, 'Mitt', '700658755-7', '1/25/2013', true, 'http://dummyimage.com/109x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 1, 4, 'Teacher''s Pet', '707103490-7', '6/23/2024', true, 'http://dummyimage.com/207x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 4, 4, 'Lonely Villa, The', '569822798-5', '9/2/2017', true, 'http://dummyimage.com/172x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 2, 'San Antonio', '273872632-1', '9/15/2006', false, 'http://dummyimage.com/109x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 6, 6, 'Poor Little Rich Girl', '450864347-7', '5/16/2018', false, 'http://dummyimage.com/209x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 9, 'Mo'' Money', '651892498-5', '10/11/2018', false, 'http://dummyimage.com/187x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 3, 'Meet Joe Black', '007001105-2', '3/13/2008', true, 'http://dummyimage.com/120x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 1, 9, 'Epidemic', '157756629-7', '6/21/2023', true, 'http://dummyimage.com/147x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 6, 3, 'Legend of the Lone Ranger, The', '106898067-2', '4/26/2002', true, 'http://dummyimage.com/178x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 9, 'The Suspicious Death of a Minor', '326825318-0', '11/29/2023', false, 'http://dummyimage.com/218x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 7, 'Double Dynamite', '995095444-4', '7/9/2017', false, 'http://dummyimage.com/193x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 3, 6, 'Whom the Gods Wish to Destroy (Nibelungen, Teil 1: Siegfried, Die)', '380104757-1', '7/15/2011', true, 'http://dummyimage.com/100x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 5, 8, 'Wimbledon', '533268650-1', '9/20/2014', false, 'http://dummyimage.com/159x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 5, 'Star Trek: Generations', '145738637-2', '8/23/2003', false, 'http://dummyimage.com/212x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 4, 'Good Marriage, A (Beau mariage, Le)', '003922832-0', '1/13/2021', false, 'http://dummyimage.com/230x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 1, 2, 'Our Song', '957844854-6', '10/20/2018', false, 'http://dummyimage.com/212x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 5, 3, 'We Are from the Future (My iz budushchego)', '121248153-4', '9/30/2009', false, 'http://dummyimage.com/171x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 2, 5, 'Four more years (Fyra år till)', '718379244-7', '4/26/2023', true, 'http://dummyimage.com/129x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 6, 3, 'Poetical Refugee', '272363095-1', '6/5/2022', true, 'http://dummyimage.com/231x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 2, 2, 'Armored', '935725326-2', '6/21/2014', false, 'http://dummyimage.com/148x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 2, 8, 'Sweet Liberty', '595911575-1', '4/28/2003', false, 'http://dummyimage.com/143x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 1, 'Offence, The', '488240091-X', '1/13/2014', false, 'http://dummyimage.com/135x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 4, 5, 'Pig''s Tale, A', '240727737-6', '4/13/2024', false, 'http://dummyimage.com/100x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 3, 9, 'Is It Easy to be Young?', '422650248-5', '2/22/2010', false, 'http://dummyimage.com/105x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 5, 5, 'Moment of Truth, The (Il momento della verità)', '499406772-4', '9/10/2023', false, 'http://dummyimage.com/118x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 7, 'Unvanquished, The (Aparajito)', '567536135-9', '4/10/2017', false, 'http://dummyimage.com/145x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 3, 8, 'Seaside (Bord de Mer)', '100457320-0', '12/11/2013', false, 'http://dummyimage.com/202x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 6, 'Monsters University', '930940311-X', '6/22/2007', false, 'http://dummyimage.com/167x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 5, 2, 'Hot Chick, The', '586126073-7', '12/15/2020', true, 'http://dummyimage.com/191x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 8, 'Imago mortis', '128862859-5', '3/22/2017', true, 'http://dummyimage.com/136x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 3, 1, 'Shockproof', '619262466-6', '7/31/2001', false, 'http://dummyimage.com/209x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 4, 'Inkwell, The', '327342928-3', '3/5/2007', false, 'http://dummyimage.com/171x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 5, 'Partners', '264829944-0', '3/15/2017', true, 'http://dummyimage.com/102x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 4, 'Rome, Open City (a.k.a. Open City) (Roma, città aperta)', '109273318-3', '10/19/2013', true, 'http://dummyimage.com/197x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 2, 'Arizona', '940506389-8', '11/12/2016', false, 'http://dummyimage.com/155x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 6, 4, 'Deep Blue', '360264494-4', '8/12/2016', false, 'http://dummyimage.com/176x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 3, 'Viy', '677146018-5', '5/24/2016', true, 'http://dummyimage.com/241x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 6, 4, 'Barefoot Executive, The', '513246850-0', '12/1/2017', false, 'http://dummyimage.com/145x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 6, 1, 'Italian Straw Hat, The (Un chapeau de paille d''Italie)', '425307566-5', '7/30/2018', false, 'http://dummyimage.com/233x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 2, 'Northanger Abbey', '860476000-8', '5/14/2021', false, 'http://dummyimage.com/129x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 1, 9, 'When the Road Bends: Tales of a Gypsy Caravan', '538616340-X', '1/5/2021', true, 'http://dummyimage.com/107x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 2, 8, 'Steel Helmet, The', '275062773-7', '10/3/2014', false, 'http://dummyimage.com/176x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 7, 'Quadrophenia', '752700360-X', '8/23/2015', true, 'http://dummyimage.com/246x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 8, 'Budrus', '874528182-3', '8/21/2004', false, 'http://dummyimage.com/165x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 2, 2, 'Blood and Chocolate', '910649417-X', '2/9/2001', true, 'http://dummyimage.com/140x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 6, 1, 'Distant Thunder', '890876930-7', '12/11/2021', false, 'http://dummyimage.com/135x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 3, 5, 'Way, The', '622719813-7', '12/19/2017', true, 'http://dummyimage.com/187x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 6, 'Three Musketeers, The', '234307060-1', '8/24/2019', false, 'http://dummyimage.com/152x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 5, 'Seventh Heaven', '480234515-1', '6/8/2003', true, 'http://dummyimage.com/215x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 9, 'Shattered Image', '537885750-3', '10/18/2004', true, 'http://dummyimage.com/180x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 3, '24 7: Twenty Four Seven', '725841210-7', '3/30/2022', false, 'http://dummyimage.com/230x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 4, 3, 'More Dead Than Alive', '458303350-8', '10/22/2021', false, 'http://dummyimage.com/202x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 5, 'Ondine', '034979937-7', '7/27/2001', true, 'http://dummyimage.com/242x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 4, 4, 'Facing Windows (Finestra di fronte, La)', '178579578-3', '3/27/2002', false, 'http://dummyimage.com/164x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 6, 'The Sweet Ride', '519231270-1', '12/15/2010', false, 'http://dummyimage.com/125x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 6, 2, 'Goodbye, Columbus', '664192042-9', '11/2/1999', false, 'http://dummyimage.com/172x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 1, 3, 'Rush Hour 3', '958268123-3', '10/1/2002', true, 'http://dummyimage.com/181x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 4, 'Something Wild', '179887545-4', '2/25/2014', true, 'http://dummyimage.com/147x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 5, 'New Guy, The', '411864805-9', '4/18/2006', false, 'http://dummyimage.com/201x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 5, 'L''instant et la patience ', '852545753-1', '4/30/2014', false, 'http://dummyimage.com/116x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 2, 2, 'Pit and the Pendulum, The', '589421093-3', '3/18/2006', true, 'http://dummyimage.com/192x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 1, 8, 'Garden, The', '676962306-4', '6/3/2001', true, 'http://dummyimage.com/186x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 4, 'Light Bulb Conspiracy, The', '789871426-1', '2/2/2000', false, 'http://dummyimage.com/148x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 5, 5, 'They Might Be Giants', '377366264-5', '1/29/2002', true, 'http://dummyimage.com/206x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 4, 'Last Witness, The', '339135068-7', '5/5/2013', true, 'http://dummyimage.com/136x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 8, 'Deception', '410965590-0', '8/3/2023', true, 'http://dummyimage.com/247x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 2, 'I Love Your Work', '256751581-X', '1/23/2018', false, 'http://dummyimage.com/216x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 7, 'Akira Kurosawa''s Dreams (Dreams)', '797904832-6', '11/9/2012', true, 'http://dummyimage.com/153x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 5, 8, 'Brides of Dracula', '919968458-6', '6/18/2009', true, 'http://dummyimage.com/232x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 1, 8, 'Bullets Over Broadway', '678795722-X', '6/15/2004', false, 'http://dummyimage.com/250x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 5, 'Her Alibi', '371496511-4', '10/14/2024', true, 'http://dummyimage.com/143x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 6, 9, 'Butch and Sundance: The Early Days', '377040564-1', '1/21/2024', false, 'http://dummyimage.com/125x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 8, 'Bee Season', '600427528-X', '8/4/2004', true, 'http://dummyimage.com/181x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 7, 'Ethan Frome', '178126678-6', '5/7/2003', true, 'http://dummyimage.com/157x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 6, 6, 'Silent Souls (Ovsyanki)', '242476313-5', '7/18/2006', false, 'http://dummyimage.com/128x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 6, 9, 'Uncommon Valor', '569913319-4', '2/27/2010', false, 'http://dummyimage.com/124x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 1, 1, 'Lathe of Heaven, The', '421513130-8', '11/6/2003', false, 'http://dummyimage.com/189x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 3, 3, 'Taxi', '337684060-1', '8/25/2024', false, 'http://dummyimage.com/137x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 4, 6, 'Alien Raiders', '926521584-4', '8/2/2012', false, 'http://dummyimage.com/138x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 5, 'It Might Get Loud', '048895326-X', '2/5/2019', true, 'http://dummyimage.com/117x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 9, 'Warsaw Bridge (Pont de Varsòvia)', '645529132-8', '1/14/2020', false, 'http://dummyimage.com/223x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 5, 7, 'Reasonable Doubt', '708232507-X', '5/20/2019', true, 'http://dummyimage.com/144x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 3, 8, 'Mackintosh Man, The', '168343988-0', '8/29/2024', true, 'http://dummyimage.com/192x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 2, 2, 'Warning for the Joensson Gang (Varning för Jönssonligan)', '847606596-5', '2/19/2021', true, 'http://dummyimage.com/189x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 6, 3, 'Santo vs. las lobas', '903598187-1', '3/18/2012', false, 'http://dummyimage.com/128x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 4, 4, 'Crime Lords of Tokyo', '617132526-0', '8/15/2014', true, 'http://dummyimage.com/137x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 6, 'Mummy Returns, The', '327659528-1', '10/25/2023', true, 'http://dummyimage.com/131x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 6, 8, 'Jack the Bear', '464387608-5', '7/17/2024', true, 'http://dummyimage.com/127x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 5, 'Penitentiary II', '733060312-0', '10/16/2008', false, 'http://dummyimage.com/211x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 5, 9, 'Ninja Cheerleaders', '530206937-7', '5/31/2003', false, 'http://dummyimage.com/245x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 4, 8, 'Mountaintop Motel Massacre ', '988068807-4', '5/8/2002', true, 'http://dummyimage.com/225x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 4, 7, 'Trail of the Screaming Forehead', '710952755-7', '7/12/2008', false, 'http://dummyimage.com/190x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 1, 9, 'Intermission', '300219381-X', '2/25/2013', true, 'http://dummyimage.com/172x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 1, 2, 'Mouse That Roared, The', '729977511-5', '11/4/2010', true, 'http://dummyimage.com/104x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 5, 4, 'Quid Pro Quo', '310209654-9', '12/9/2017', true, 'http://dummyimage.com/209x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 1, 2, 'Hunted City', '464186062-9', '6/17/2010', true, 'http://dummyimage.com/241x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 6, 5, 'Raising Helen', '314801629-7', '12/28/2013', true, 'http://dummyimage.com/157x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 8, 'Rio Rita', '162396168-8', '10/15/2006', false, 'http://dummyimage.com/242x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 5, 4, 'FM', '607106526-7', '1/19/2000', false, 'http://dummyimage.com/164x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 4, 5, 'Zorn''s Lemma', '555203038-9', '6/11/2008', false, 'http://dummyimage.com/134x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 4, 3, 'Steamboat Willie', '953505169-5', '8/4/2016', false, 'http://dummyimage.com/187x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 3, 8, 'Killer Bean 2: The Party', '557310471-3', '5/31/2001', true, 'http://dummyimage.com/249x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (7, 4, 4, 'Herbie Rides Again', '279186274-9', '2/20/2023', false, 'http://dummyimage.com/116x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 5, 9, 'Our Vines Have Tender Grapes', '527147213-2', '6/14/2024', false, 'http://dummyimage.com/241x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 5, 8, 'Gospel, The', '740901682-5', '4/28/2024', false, 'http://dummyimage.com/201x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 9, 'Attraction', '630461080-7', '3/13/2000', false, 'http://dummyimage.com/179x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 3, 6, 'House of Cards', '974701662-1', '5/21/2023', true, 'http://dummyimage.com/135x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 4, 1, 'Kiss Kiss Bang Bang', '213955091-9', '3/17/2010', false, 'http://dummyimage.com/227x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 3, 4, 'Cyberjack (Virtual Assassin)', '856625559-3', '12/12/2018', false, 'http://dummyimage.com/172x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 5, 3, 'Kommissarie Späck', '281783127-6', '7/29/2021', false, 'http://dummyimage.com/108x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 6, 6, 'The Invisible Frame', '970979080-3', '7/5/2000', true, 'http://dummyimage.com/159x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 6, 8, 'Hercules and the Amazon Women', '208326046-5', '9/29/2000', false, 'http://dummyimage.com/114x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 2, 8, 'Into the Storm', '167655295-2', '12/8/2017', false, 'http://dummyimage.com/215x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 7, 'Mirror Mirror', '778017824-2', '2/15/2009', false, 'http://dummyimage.com/138x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (8, 3, 5, 'Dangerous Lives of Altar Boys, The', '805667992-8', '3/16/2019', false, 'http://dummyimage.com/155x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 6, 'Métastases', '320850065-3', '11/4/2015', true, 'http://dummyimage.com/250x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 2, 3, 'The Story of Alexander Graham Bell', '013155707-6', '3/5/2002', true, 'http://dummyimage.com/118x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (3, 6, 4, 'Period of Adjustment', '893457036-9', '11/11/2010', true, 'http://dummyimage.com/226x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 1, 4, 'Prince of Jutland (a.k.a. Royal Deceit)', '377782113-6', '9/12/2023', true, 'http://dummyimage.com/130x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 2, 3, 'Libeled Lady', '641565571-X', '4/14/2004', true, 'http://dummyimage.com/229x100.png/5fa2dd/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 3, 7, 'May Fools (Milou en mai)', '310938555-4', '3/29/2021', true, 'http://dummyimage.com/204x100.png/cc0000/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 3, 5, 'Ace Attorney (Gyakuten saiban)', '662688588-X', '8/27/2006', true, 'http://dummyimage.com/181x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 4, 2, 'Fairly Odd Movie: Grow Up, Timmy Turner!, A', '264874382-0', '10/26/2004', true, 'http://dummyimage.com/227x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (2, 6, 2, 'Picture This', '721129364-0', '2/15/2022', true, 'http://dummyimage.com/106x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (1, 2, 4, 'Misérables, Les', '405289494-4', '12/23/2017', false, 'http://dummyimage.com/182x100.png/ff4444/ffffff');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (6, 3, 3, 'Gerry', '781931747-7', '7/13/2020', false, 'http://dummyimage.com/236x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (5, 1, 6, 'Roadside Prophets', '830559459-9', '7/22/2023', true, 'http://dummyimage.com/127x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (9, 3, 8, 'David Copperfield', '314700792-8', '6/23/2021', true, 'http://dummyimage.com/177x100.png/dddddd/000000');
insert into Book (editorial_id, genre_id, id_language, title, isbn, registration_date, status, image_url) values (4, 2, 6, 'The Count of Monte Cristo', '720523846-3', '3/26/2023', true, 'http://dummyimage.com/136x100.png/dddddd/000000');



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
