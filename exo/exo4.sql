/*Triggers*/
CREATE OR REPLACE TRIGGER TR_STOCK_AUDIT 
BEFORE INSERT ON Vente
FOR EACH ROW

BEGIN
    UPDATE 
        Produit 
    SET 
        Qtestk = (Qtestk - :new.Qtev)
    WHERE 
        Reference = :new.Reference;
END;
/

/*Creation de la table journalisation*/
CREATE TABLE journalisation(
    datejour date NOT NULL,
    Reference CHAR(25),
    QteRest NUMBER,
    FOREIGN KEY (Reference) REFERENCES Produit(Reference)
);



/*
Modification du déclencheur
*/
CREATE OR REPLACE TRIGGER TR_STOCK_AUDIT 
BEFORE INSERT ON Vente
FOR EACH ROW

DECLARE
Vqte NUMBER;
Vdate DATE;
BEGIN
    UPDATE 
        Produit 
    SET 
        Qtestk = (Qtestk - :new.Qtev)
    WHERE Reference = :new.Reference;
    
    SELECT QTESTK INTO Vqte FROM PRODUIT WHERE REFERENCE = :new.Reference;
    
    Vdate := SYSDATE ;
    IF Vqte < 5 THEN
        INSERT INTO JOURNALISATION(Datejour, Reference, QteRest) VALUES (Vdate, :new.Reference, Vqte);
    END IF;
END;
/