CREATE TABLE jazyk (
    id_jazyka  INTEGER NOT NULL,
    nazev      VARCHAR2(50 CHAR) NOT NULL,
    cena_lekce NUMBER DEFAULT 0 NOT NULL
);

ALTER TABLE jazyk ADD CONSTRAINT jazyk_pk PRIMARY KEY ( id_jazyka );

ALTER TABLE jazyk ADD CONSTRAINT cena_lekce_chc CHECK ( cena_lekce > 0);

GRANT SELECT ON jazyk TO STUDENT;

GRANT SELECT, DELETE, INSERT, UPDATE ON jazyk TO DB4IT218;

CREATE TABLE lektori (
    id_zamestnance    INTEGER NOT NULL,
    praxe             NUMBER DEFAULT 0 NOT NULL,
    jmeno             VARCHAR2(50 CHAR) NOT NULL,
    datum_narozeni    DATE NOT NULL,
    funkce            VARCHAR2(50 CHAR) NOT NULL,
    kontaktni_telefon VARCHAR2(15 CHAR) NOT NULL
);

ALTER TABLE lektori ADD CONSTRAINT lektori_pk PRIMARY KEY ( id_zamestnance );

ALTER TABLE lektori ADD CONSTRAINT praxe_chc CHECK ( praxe > 0);

ALTER TABLE lektori ADD CONSTRAINT datum_narozeni_chc CHECK (datum_narozeni < sysdate );

GRANT SELECT ON lektori TO STUDENT;

GRANT SELECT, DELETE, INSERT, UPDATE ON lektori TO DB4IT218;

CREATE TABLE se_deli_na (
    jazyk_id_jazyka INTEGER NOT NULL,
    uroven_kod      VARCHAR2(2 CHAR) NOT NULL
);

ALTER TABLE se_deli_na ADD CONSTRAINT se_deli_na_pk PRIMARY KEY ( jazyk_id_jazyka,
                                                                  uroven_kod );

GRANT SELECT ON se_deli_na TO STUDENT;

GRANT SELECT, DELETE, INSERT, UPDATE ON se_deli_na TO DB4IT218;

CREATE TABLE uci (
    lektori_id_zamestnance INTEGER NOT NULL,
    jazyk_id_jazyka        INTEGER NOT NULL,
    zakaznici_id_zakaznika INTEGER NOT NULL
);

ALTER TABLE uci
    ADD CONSTRAINT uci_pk PRIMARY KEY ( lektori_id_zamestnance,
                                        jazyk_id_jazyka,
                                        zakaznici_id_zakaznika );

GRANT SELECT ON uci TO STUDENT;

GRANT SELECT, DELETE, INSERT, UPDATE ON uci TO DB4IT218;

CREATE TABLE uroven (
    kod        VARCHAR2(2 CHAR) NOT NULL,
    nazev      VARCHAR2(50 CHAR) NOT NULL,
    pocet_bodu NUMBER(3) DEFAULT 0 NOT NULL
);

ALTER TABLE uroven ADD CHECK ( pocet_bodu BETWEEN 0 AND 100 );

ALTER TABLE uroven ADD CONSTRAINT uroven_pk PRIMARY KEY ( kod );

GRANT SELECT ON uroven TO STUDENT;

GRANT SELECT, DELETE, INSERT, UPDATE ON uroven TO DB4IT218;

CREATE TABLE zakaznici (
    id_zakaznika      INTEGER NOT NULL,
    jmeno             VARCHAR2(50 CHAR) NOT NULL,
    datum_narozeni    DATE NOT NULL,
    kontaktni_telefon VARCHAR2(15 CHAR) NOT NULL,
    kontaktni_email   VARCHAR2(255 CHAR) NOT NULL
);
ALTER TABLE zakaznici ADD CONSTRAINT datum_narozeni_chc CHECK( datum_narozeni < 
sysdate);

ALTER TABLE zakaznici ADD CONSTRAINT zakaznici_pk PRIMARY KEY ( id_zakaznika );

GRANT SELECT ON zakaznici TO STUDENT;

GRANT SELECT, DELETE, INSERT, UPDATE ON zakaznici TO DB4IT218; 

CREATE TABLE zamestnanci (
    id_zamestnance    INTEGER NOT NULL,
    jmeno             VARCHAR2(50 CHAR) NOT NULL,
    datum_narozeni    DATE NOT NULL,
    funkce            VARCHAR2(50 CHAR) NOT NULL,
    kontaktni_telefon VARCHAR2(15 CHAR) NOT NULL
);

ALTER TABLE zamestnanci ADD CONSTRAINT zamestnanci_pk PRIMARY KEY ( id_zamestnance );

ALTER TABLE zamestnanci ADD CONSTRAINT datum_narozeni_chc CHECK (datum_narozeni < sysdate);

GRANT SELECT ON zamestnanci TO STUDENT;

GRANT SELECT, DELETE, INSERT, UPDATE ON zamestnanci TO DB4IT218;

ALTER TABLE lektori
    ADD CONSTRAINT lektori_zamestnanci_fk FOREIGN KEY ( id_zamestnance )
        REFERENCES zamestnanci ( id_zamestnance );
        
ALTER TABLE lektori ADD CONSTRAINT funkce_chc CHECK ( funkce = 'lektor');

CREATE OR REPLACE TRIGGER funkce_lektori 
BEFORE INSERT OR UPDATE ON lektori FOR EACH ROW
AS BEGIN 
 IF :new.funkce != 'lektor' THEN
   raise_application_error(-20001, 'Funkce musí být lektor!!');
 END IF;
END;

ALTER TABLE se_deli_na
    ADD CONSTRAINT se_deli_na_jazyk_fk FOREIGN KEY ( jazyk_id_jazyka )
        REFERENCES jazyk ( id_jazyka );

ALTER TABLE se_deli_na
    ADD CONSTRAINT se_deli_na_uroven_fk FOREIGN KEY ( uroven_kod )
        REFERENCES uroven ( kod );

ALTER TABLE uci
    ADD CONSTRAINT uci_jazyk_fk FOREIGN KEY ( jazyk_id_jazyka )
        REFERENCES jazyk ( id_jazyka );

ALTER TABLE uci
    ADD CONSTRAINT uci_lektori_fk FOREIGN KEY ( lektori_id_zamestnance )
        REFERENCES lektori ( id_zamestnance );
            ON DELETE SET NULL

ALTER TABLE uci
    ADD CONSTRAINT uci_zakaznici_fk FOREIGN KEY ( zakaznici_id_zakaznika )
        REFERENCES zakaznici ( id_zakaznika )
            ON DELETE CASCADE;
