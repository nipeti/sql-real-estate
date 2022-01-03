--jointures des tables adresse, acte, local--
SELECT joinb.commune_adresse, joinb.date_mutation_acte, joinb.id_acte, joinb.id_lot, joinb.id_adresse
FROM dataimmo.local
LEFT JOIN 
	(SELECT acte.id_acte, joina.commune_adresse, acte.date_mutation_acte, joina.id_lot, joina.id_adresse
     FROM dataimmo.acte
     LEFT JOIN (SELECT adresse.id_adresse,adresse.commune_adresse, lot.id_lot
                FROM dataimmo.adresse
                LEFT JOIN dataimmo.lot ON adresse.id_adresse = lot.id_lot) AS joina 
	 ON acte.id_acte = joina.id_lot) AS joinb 
ON local.id_local = joinb.id_acte;