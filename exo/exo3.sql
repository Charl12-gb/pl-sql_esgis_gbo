SET SERVEROUTPUT ON;

/*
*Fonction qui retourne le nombre de facture d'un client
*/
CREATE OR REPLACE FUNCTION nbfact(num_client NUMBER) RETURN NUMBER IS
VnbreFacture NUMBER;
BEGIN

SELECT
    COUNT(*) INTO VnbreFacture
FROM
    Facture
WHERE
    Numcli = num_client;

RETURN VnbreFacture;

END nbfact;
/ 
SHOW ERRORS

/*
*Fonction qui retourne le chiffre d'affaire d'un client
*/
CREATE OR REPLACE FUNCTION ca (num_client NUMBER) RETURN NUMBER IS
VChiifreAffaire NUMBER;
BEGIN

SELECT
    SUM(Pu * Qtev) INTO VChiifreAffaire
FROM
    Facture, Produit, Vente
WHERE
    Facture.Numfact = Vente.Numfact AND
    Produit.Reference = Vente.Reference AND
    Facture.Numcli = num_client;

RETURN VChiifreAffaire;

END ca;

/ 
SHOW ERRORS

/*
* Produit qui affiche : 
* Client 1 (Numéro client)
* 4 (Nbre de facture) / 339500 (Chiffre d'affaire)
* ----------------------------------------------
*/
CREATE OR REPLACE PROCEDURE profilClient(VnumCli IN NUMBER) IS
BEGIN 
    DBMS_OUTPUT.PUT_LINE('Client ' || VnumCli);
    DBMS_OUTPUT.PUT_LINE(nbfact(VnumCli) || ' / ' || ca(VnumCli));
    DBMS_OUTPUT.PUT_LINE('------------------');
END;
/
SHOW ERRORS

/*
* Programme principale
*/
DECLARE
/*
* CURSOR qui nous permet d'obtenir le numéro des clients
*/
CURSOR Vclient IS SELECT Numcli FROM Client;
BEGIN

    /*
    * Affichage des informations du client 1
    */
    DBMS_OUTPUT.PUT_LINE('Client 1');
    DBMS_OUTPUT.PUT_LINE(nbfact(1) || ' / ' || ca(1));
    DBMS_OUTPUT.PUT_LINE('**********************************************');
    
    /*Appel de la procédure*/
    /*
    FOR maListe IN Vclient LOOP
        PROFILCLIENT(maListe.Numcli);
    END LOOP;
    */

    /*
    * Affichage des info de chaque client
    */
    FOR maListe IN Vclient LOOP
        DBMS_OUTPUT.PUT_LINE('Client ' || maListe.Numcli);
        DBMS_OUTPUT.PUT_LINE(nbfact(maListe.Numcli) || ' / ' || ca(maListe.Numcli));
        DBMS_OUTPUT.PUT_LINE('------------------');
    END LOOP;
END;
/