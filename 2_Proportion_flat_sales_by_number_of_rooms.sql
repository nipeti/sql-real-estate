SELECT joinb.nombre_pieces_princip_local AS nombre_de_pieces, ROUND((COUNT (*)* 100.0 / SUM(COUNT(*)) OVER ()),2) AS proportion 
FROM 
	(SELECT local.id_local, joina.id_lot, local.code_type_local, local.nombre_pieces_princip_local, joina.id_acte
	FROM dataimmo.local
	LEFT JOIN (SELECT lot.id_lot, acte.id_acte
		FROM dataimmo.lot
		LEFT JOIN dataimmo.acte ON lot.id_lot = acte.id_acte) AS joinA
	ON joinA.id_acte = local.id_local
	WHERE local.code_type_local = 2 /*code 2 = appartement / code 1 = maison*/) AS joinB
GROUP BY joinb.nombre_pieces_princip_local
ORDER BY proportion DESC;
