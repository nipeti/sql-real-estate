--Liste des communes où le nombre de ventes a augmenté d'au moins 20% entre T1 et T2--
SELECT *
FROM 
(
SELECT *, ((nombre_vente_T2::float - nombre_vente_T1::float)/(nombre_vente_T1::float*100)) AS taux_evolution
FROM 

	(SELECT COUNT(lister7.id_acte) as nombre_vente_T1, lister7.commune_adresse
	 FROM dataimmo.lister7 WHERE lister7.date_mutation_acte BETWEEN '2020-01-01' AND '2020-03-31'
	GROUP BY lister7.commune_adresse) as table1 
FULL JOIN
	(SELECT COUNT (lister7.id_acte) as nombre_vente_T2, lister7.commune_adresse 
	 FROM dataimmo.lister7 WHERE lister7.date_mutation_acte BETWEEN '2020-04-01' AND '2020-06-30'
	GROUP BY lister7.commune_adresse) as table2 
ON table1.commune_adresse = table2.commune_adresse
) AS table3 WHERE taux_evolution > 0.2
-- = 1 commune, Pau où T2 > 25% > T1 --
