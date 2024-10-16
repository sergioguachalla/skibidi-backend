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
    CONSTRAINT Lend_Book_pk PRIMARY KEY (lent_book_id)
);

-- Table: Person
CREATE TABLE Person (
    person_id serial  NOT NULL,
    name varchar(100)  NOT NULL,
    lastname varchar(200)  NOT NULL,
    id_number int  NOT NULL,
    expedition varchar(4)  NOT NULL,
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

INSERT INTO Language (language, status) VALUES ('Mandarín', 'Activo');
INSERT INTO Language (language, status) VALUES ('Inglés', 'Activo');
INSERT INTO Language (language, status) VALUES ('Hindú', 'Activo');
INSERT INTO Language (language, status) VALUES ('Español', 'Activo');
INSERT INTO Language (language, status) VALUES ('Árabe', 'Activo');
INSERT INTO Language (language, status) VALUES ('Bengalí', 'Activo');
INSERT INTO Language (language, status) VALUES ('Portugués', 'Activo');
INSERT INTO Language (language, status) VALUES ('Ruso', 'Activo');
INSERT INTO Language (language, status) VALUES ('Japonés', 'Activo');
INSERT INTO Language (language, status) VALUES ('Alemán', 'Activo');

--Editorial
INSERT INTO Editorial (editorial, status) VALUES ('Penguin Random House', 'Activo');
INSERT INTO Editorial (editorial, status) VALUES ('HarperCollins', 'Activo');
INSERT INTO Editorial (editorial, status) VALUES ('Simon & Schuster', 'Activo');
INSERT INTO Editorial (editorial, status) VALUES ('Macmillan Publishers', 'Activo');
INSERT INTO Editorial (editorial, status) VALUES ('Hachette Livre', 'Activo');
INSERT INTO Editorial (editorial, status) VALUES ('Scholastic', 'Activo');
INSERT INTO Editorial (editorial, status) VALUES ('Pearson', 'Activo');
INSERT INTO Editorial (editorial, status) VALUES ('Bloomsbury Publishing', 'Activo');
INSERT INTO Editorial (editorial, status) VALUES ('Wiley', 'Activo');
INSERT INTO Editorial (editorial, status) VALUES ('Oxford University Press', 'Activo');


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
