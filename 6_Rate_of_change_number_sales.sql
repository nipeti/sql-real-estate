--Taux d’évolution du nombre de ventes entre le premier et le deuxième trimestres de 2020--
--(VB-VA)/(VA*100)
SELECT ROUND
	( 
	(SELECT COUNT (*) 
	FROM dataimmo.acte
	WHERE acte.date_mutation_acte BETWEEN '2020-04-01' AND '2020-06-30')
	-
	(SELECT COUNT (*) 
	FROM dataimmo.acte
	WHERE acte.date_mutation_acte BETWEEN '2020-01-01' AND '2020-03-31')
	)
/
	(
	(SELECT COUNT (*)
	FROM dataimmo.acte
	WHERE acte.date_mutation_acte BETWEEN '2020-01-01' AND '2020-03-31')
	*100
	)*100 
::float 
AS taux_en_pourcentage
-- = 0.0003677873152122079 soit 0,036%