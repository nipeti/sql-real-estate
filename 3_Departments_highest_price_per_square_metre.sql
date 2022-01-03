--Liste des 10 départements où le prix du mètre carré est le plus élevé-

/* calcul du prix du m2 */
SELECT ROUND(SUM(valeur_fonciere_acte)/SUM(surface_carrez_lot)) AS prix_du_m2, departement
FROM
/* jointure entre les tables parcelle, lot, acte pour avoir les données valeur, surface, département*/
	(SELECT acte.valeur_fonciere_acte, joinB.surface_carrez_lot, departement
	FROM dataimmo.acte 
		LEFT JOIN 
		(SELECT parcelle.code_departement_parcelle AS departement, parcelle.id_parcelle, lot.id_lot, lot.surface_carrez_lot 
		FROM dataimmo.lot LEFT JOIN dataimmo.parcelle ON parcelle.id_parcelle = lot.id_lot) AS joinB
	ON acte.id_acte = joinB.id_lot) AS joinA
GROUP BY departement
ORDER BY prix_du_m2 DESC
LIMIT 10;