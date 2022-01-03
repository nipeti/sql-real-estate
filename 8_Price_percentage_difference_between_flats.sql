--Différence en pourcentage du prix au mètre carré 
--entre un appartement de 2 pièces et un appartement de 3 pièces--
SELECT ROUND 
(
	(
	SELECT 
	(
	(SELECT * FROM dataimmo.prixm2appartement2pieces)
	-
	(SELECT * FROM dataimmo.prixm2appartement3pieces)
	)
	/
	(SELECT * FROM dataimmo.prixm2appartement3pieces)
	)*100
)
AS "Différence en pourcentage du prix"
-- = 14 %--