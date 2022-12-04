/*
*Fonction fDemande
*/
CREATE OR REPLACE FUNCTION fDemande (num_produit IN CHAR) RETURN CHAR IS 
qte_vendue NUMBER;
BEGIN

SELECT SUM(Qtev) INTO qte_vendue FROM Vente WHERE Vente.Reference = num_produit;

    IF (qte_vendue > 15) THEN 
        RETURN ('forte');
    ELSIF (qte_vendue >= 11 AND qte_vendue <= 15) THEN 
        RETURN ('moyenne');
    ELSE 
        RETURN ('faible');
    END IF;
END;
/
SHOW ERRORS

/*
*Affichage des informations sur un produit et la demande
*/
SELECT Reference, Pu, fDemande(Reference) AS Demande FROM Produit;
