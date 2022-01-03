--Nombre total d’appartements vendus au 1er semestre 2020

SELECT COUNT (*) AS "Nombre total"
FROM dataimmo.acte 
/* jointure entre les tables lot et local */
LEFT JOIN
	(SELECT lot.id_lot, lot.id_acte, local.code_type_local 
	FROM dataimmo.lot LEFT JOIN dataimmo.local ON lot.id_lot = local.id_lot) AS joinA
ON acte.id_acte = joinA.id_acte 
/* sélection de la période de temps */
WHERE code_type_local = 2 AND date_mutation_acte BETWEEN '2020-01-01' AND '2020-06-30'

-- nombre total = 31378
