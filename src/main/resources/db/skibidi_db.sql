-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-10-13 00:39:33.041

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
    kc_uudi varchar(200)  NOT NULL,
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

