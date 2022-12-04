/*
*Création de l'utilisateur superadmin et attribution des privileges
*/
CREATE USER superadmin IDENTIFIED BY admin;
GRANT ALL PRIVILEGES TO superadmin;

/*
*Création des tables
*/
CREATE TABLE Client(
    Numcli NUMBER,
    Nom CHAR(25) NOT NULL,
    Ville CHAR(25),
    Sexe CHAR(1),
    PRIMARY KEY (Numcli)
);

CREATE TABLE Facture(
    Numfact NUMBER,
    Datefact DATE NOT NULL,
    Numcli NUMBER,
    PRIMARY KEY(Numfact),
    FOREIGN KEY (Numcli) REFERENCES Client(Numcli)
);

CREATE TABLE Produit(
    Reference CHAR(25),
    Nompro CHAR(255) NOT NULL,
    Pu NUMBER NOT NULL,
    Qtestk NUMBER DEFAULT(0),
    PRIMARY KEY(Reference)
);

CREATE TABLE Vente(
	Reference CHAR(25),
    Numfact NUMBER,
    Qtev NUMBER DEFAULT 0,
    PRIMARY KEY(Reference, Numfact),
    FOREIGN KEY (Reference) REFERENCES Produit(Reference),
    FOREIGN KEY (Numfact) REFERENCES Facture(Numfact),
    CONSTRAINT check_qte_sup CHECK (Qtev > 0 )
);

/*
**Création de l'utilisateur Gestockuser et attribution des privileges de consultation
*/
CREATE USER Gestockuser IDENTIFIED BY admin;
GRANT select ON Client TO Gestockuser; 
GRANT select ON Facture TO Gestockuser; 
GRANT select ON Produit TO Gestockuser; 
GRANT select ON Vente TO Gestockuser; 
GRANT update ON Client TO Gestockuser; 

/*
*Donner la possibilité au superadmin de donnée des droits à d'autres utilisateur
*/
GRANT ALL PRIVILEGES TO superadmin WITH ADMIN OPTION;

/*
*Suppression de l'utilisateur Gestockuser
*/
DROP USER Gestockuser;
