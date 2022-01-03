--Prix moyen du mètre carré d’une maison en Île-de-France--

/* calcul du prix moyen du m2*/
SELECT ROUND((SUM(valeur_fonciere_acte) / SUM(surface_carrez_lot))) AS "prix moyen du m2"
FROM	
/*jointure entre les tables parcelle, lot, acte, local, code type local*/
	(SELECT parcelle.code_departement_parcelle, joinB.surface_carrez_lot, joinB.valeur_fonciere_acte, joinB.code_type_local
	FROM dataimmo.parcelle
	RIGHT JOIN
		(SELECT acte.valeur_fonciere_acte, joinA.code_type_local, joinA.surface_carrez_lot, joinA.id_lot
		FROM dataimmo.acte 
			RIGHT JOIN
			(SELECT lot.id_lot, lot.id_acte, local.code_type_local, lot.surface_carrez_lot 
			FROM dataimmo.lot RIGHT JOIN dataimmo.local ON lot.id_lot = local.id_lot) AS joinA
		ON acte.id_acte = joinA.id_acte) AS joinB
	ON parcelle.id_parcelle = joinB.id_lot
/*sélection de maison*/
WHERE code_type_local = 1 
	/*sélection de départements*/
	AND parcelle.code_departement_parcelle IN ('75','77','91','92','93','94','95')
	) AS joinC
-- = 3609€