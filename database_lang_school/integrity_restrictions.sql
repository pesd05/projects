CONSTRAINT zakaznici_pk PRIMARY KEY ( id_zakaznika );
ALTER TABLE zakaznici ADD CONSTRAINT datum_narozeni_chc CHECK( datum_narozeni < 
sysdate);

CONSTRAINT jazyk_pk PRIMARY KEY ( id_jazyka );
ALTER TABLE jazyk ADD CONSTRAINT cena_lekce_chc CHECK ( cena_lekce > 0);

ALTER TABLE uroven ADD CONSTRAINT uroven_pk PRIMARY KEY ( kod );
ALTER TABLE uroven ADD CHECK ( pocet_bodu BETWEEN 0 AND 100 ); 

ALTER TABLE se_deli_na ADD CONSTRAINT se_deli_na_pk PRIMARY KEY ( jazyk_id_jazyka,
                                                                  uroven_kod ); 
ALTER TABLE se_deli_na
    ADD CONSTRAINT se_deli_na_jazyk_fk FOREIGN KEY ( jazyk_id_jazyka )
        REFERENCES jazyk ( id_jazyka );

ALTER TABLE se_deli_na
    ADD CONSTRAINT se_deli_na_uroven_fk FOREIGN KEY ( uroven_kod )
        REFERENCES uroven ( kod );

ALTER TABLE zamestnanci ADD CONSTRAINT zamestnanci_pk PRIMARY KEY ( id_zamestnance );
ALTER TABLE zamestnanci ADD CONSTRAINT datum_narozeni_chc CHECK( datum_narozeni < 
sysdate);

ALTER TABLE lektori ADD CONSTRAINT lektori_pk PRIMARY KEY ( id_zamestnance );
ALTER TABLE lektori ADD CONSTRAINT datum_narozeni_chc CHECK( datum_narozeni < 
sysdate);
ALTER TABLE lektori ADD CONSTRAINT praxe_chc CHECK ( praxe > 0);

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

ALTER TABLE uci
    ADD CONSTRAINT uci_pk PRIMARY KEY ( lektori_id_zamestnance,
                                        jazyk_id_jazyka,
                                        zakaznici_id_zakaznika );

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

