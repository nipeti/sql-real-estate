--Donnez les moyennes de valeurs foncières pour le top 20 des communes--

/*calcul de la moyenne des valeurs foncieres*/
SELECT ROUND(AVG (joinb.valeur_fonciere_acte)) AS moyenne, joinB.commune_adresse
FROM
/*selection des tables acte, adresse, lot*/
	(
	SELECT acte.id_acte, acte.valeur_fonciere_acte, joinA.commune_adresse
	FROM dataimmo.acte
	LEFT JOIN
		(
		SELECT adresse.commune_adresse, adresse.id_adresse, lot.id_lot, lot.id_acte
		FROM dataimmo.adresse
		LEFT JOIN
		dataimmo.lot
		ON lot.id_lot = adresse.id_adresse
		)
		AS joinA
	ON acte.id_acte = joinA.id_acte
	) AS joinB
/*mise à l'écart des valeurs foncieres nulles*/
WHERE joinb.valeur_fonciere_acte IS NOT NULL
GROUP BY joinB.commune_adresse
ORDER BY moyenne DESC
LIMIT 20;
