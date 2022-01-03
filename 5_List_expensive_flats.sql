--Liste des 10 appartements les plus chers avec le département 
--et le nombre de metres carrés
SELECT 
acte.valeur_fonciere_acte AS "prix", 
joinB.code_departement_parcelle AS departement, 
joinB.surface_carrez_lot AS "surface (m2)", 
ROUND(SUM(acte.valeur_fonciere_acte)/SUM(joinB.surface_carrez_lot)) 
AS prix_m2 
FROM dataimmo.acte
/*jointure entre les tables parcelle, lot, code_type_local, lot*/
LEFT JOIN
	(SELECT parcelle.code_departement_parcelle, 
	 joinA.surface_carrez_lot, joinA.code_type_local, joinA.id_lot
	FROM dataimmo.parcelle
	LEFT JOIN
		(SELECT local.code_type_local, lot.surface_carrez_lot, lot.id_lot
		FROM dataimmo.lot
		LEFT JOIN dataimmo.local 
		ON local.id_local = lot.id_lot)
		AS joinA
	ON parcelle.id_lot = joinA.id_lot
	/*sélection des appartements*/
	WHERE code_type_local = 2) 
	AS joinB
ON acte.id_acte = joinB.id_lot
/*mise de côté des valeurs foncieres nulles*/
WHERE acte.valeur_fonciere_acte IS NOT NULL
GROUP BY acte.valeur_fonciere_acte, joinB.code_departement_parcelle, 
joinB.code_departement_parcelle, joinB.surface_carrez_lot 
/*mise de côté des valeurs aberrantes : prix m2 supérieur à 20 000 €*/
HAVING (SUM(acte.valeur_fonciere_acte)/SUM(joinB.surface_carrez_lot)) 
< 20000 
ORDER BY acte.valeur_fonciere_acte DESC
LIMIT 10; 