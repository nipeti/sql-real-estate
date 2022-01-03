 --jointures des tables acte, lot, parcelle, local, code type local pour un appartement de 3 pièces-- 
SELECT ROUND(sum(joinc.valeur_fonciere_acte) / sum(joinc.surface_carrez_lot)) AS "prix moyen du m2 - appartement"
FROM (SELECT parcelle.code_departement_parcelle,joinb.surface_carrez_lot,joinb.valeur_fonciere_acte,joinb.code_type_local
      FROM dataimmo.parcelle
      LEFT JOIN (SELECT acte.valeur_fonciere_acte, joina.code_type_local,joina.nombre_pieces_princip_local,
                 joina.surface_carrez_lot,joina.id_lot
                 FROM dataimmo.acte
                 LEFT JOIN (SELECT lot.id_lot,lot.id_acte,local.code_type_local,local.nombre_pieces_princip_local,lot.surface_carrez_lot
                           FROM dataimmo.lot
                           LEFT JOIN dataimmo.local ON lot.id_lot = local.id_lot) joina 
				 		   ON acte.id_acte = joina.id_acte) joinb 
	  			ON parcelle.id_parcelle = joinb.id_lot
      			WHERE joinb.code_type_local = 2 AND joinb.nombre_pieces_princip_local = 3) 
	  joinc;