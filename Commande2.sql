-- 1
SELECT NOMPILOTE, ADRESSE
FROM PILOTE

-- 2
SELECT DISTINCT VILLEDEP
FROM VOL

--3
SELECT NUMVOL, VILLEDEP, VILLEARR, HEUREDEP, HEUREARR 
FROM VOL
WHERE VILLEDEP = 'Paris'
AND CONVERT(LEFT(HEUREDEP,2), INTEGER) BETWEEN 14 AND 16

--4
SELECT DISTINCT RIGHT(NOMAVION,4)
FROM AVION
WHERE LEFT(NOMAVION,6) = 'Airbus'

--5
SELECT *
FROM PILOTE
WHERE RIGHT(LEFT(NOMPILOTE,2),1) = 'i'

--6
SELECT *
FROM AVION
WHERE CAPACITE BETWEEN 200 AND 300

--7
SELECT `NOMAVION`,`NUMAVION`, `LOCALISATION`
FROM `AVION`
WHERE LOCALISATION != 'Nice'
AND CAPACITE > 200
ORDER BY NUMAVION DESC

--8
SELECT NOMPILOTE
FROM PILOTE
WHERE NUMPILOTE IN
	(SELECT NUMPILOTE
    FROM VOL
    WHERE VILLEDEP = 'Paris')

--9
SELECT NOMPILOTE
FROM PILOTE
WHERE ADRESSE IN
    (SELECT LOCALISATION
    FROM AVION
    WHERE LEFT(NOMAVION,6) = 'Airbus')

--10
SELECT NOMPILOTE
FROM PILOTE
WHERE NUMPILOTE IN
	(SELECT NUMPILOTE
     FROM VOL
     WHERE NUMAVION IN
	(SELECT NUMAVION
    FROM VOL
    WHERE NUMPILOTE = 2))

--11
SELECT NUMAVION, NOMAVION
FROM AVION
WHERE CAPACITE BETWEEN 200 AND 300
AND LOCALISATION IN
	(SELECT VILLEDEP
     FROM VOL
     WHERE NUMVOL = 'USA050')

--12
SELECT *
FROM AVION
WHERE CAPACITE >
	(SELECT MAX(CAPACITE)
        FROM AVION
        WHERE LOCALISATION = 'Nice'
    )

--13
SELECT *
FROM AVION
WHERE CAPACITE >
	(SELECT MIN(CAPACITE)
        FROM AVION
        WHERE LOCALISATION = 'Nice'
    )

--14
SELECT *
FROM PILOTE
WHERE ADRESSE IN
	(SELECT LOCALISATION
    FROM AVION
    WHERE LEFT(NOMAVION,6) = 'Airbus')
AND NUMPILOTE IN
    (SELECT NUMPILOTE
    FROM VOL
    WHERE VILLEDEP IN
	    (SELECT DISTINCT VILLEARR
        FROM VOL
        WHERE NUMPILOTE IN
            (SELECT NUMPILOTE
             FROM PILOTE
             WHERE NOMPILOTE LIKE 'Ader%')))

--15
SELECT COUNT(*)
FROM PILOTE

--16
SELECT NUMAVION
FROM AVION AS AV
WHERE CAPACITE >=
		(SELECT AVG(CAPACITE)
        FROM AVION
        WHERE LOCALISATION = AV.LOCALISATION)

--17
SELECT NUMAVION, NOMAVION
FROM AVION
WHERE CAPACITE * 1.1 > 250

--18
SELECT NOMPILOTE
FROM PILOTE
WHERE SOUNDEX(substring_index(NOMPILOTE,' ',1)) = SOUNDEX('bl�riaud')

--19
SELECT *
FROM AVION
WHERE CAPACITE >
	1.1 * (SELECT AVG(CAPACITE)
    FROM AVION)

--20
SELECT NOMPILOTE AS NP, (SELECT COUNT(*)
                        FROM VOL
                  		WHERE NUMPILOTE IN (SELECT NUMPILOTE
                                     	   FROM PILOTE
                                           WHERE NOMPILOTE = NP)) AS NbVol
FROM PILOTE

--21
SELECT DISTINCT LOCALISATION AS Ville, (SELECT MAX(CAPACITE)
                              FROM AVION
                              WHERE LOCALISATION = Ville) As 'Capacit� max'
FROM AVION

--22 FAUX
, (SELECT MAX(CAPACITE)
                              FROM AVION
                              WHERE LOCALISATION = Ville) As 'Capacit� max'