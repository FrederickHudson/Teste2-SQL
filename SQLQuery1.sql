
CREATE TABLE Remessa (
RemessaID INT PRIMARY KEY,
Situacao VARCHAR(10) NOT NULL,
InfValidas INT DEFAULT 0,
InfInval INT DEFAULT 0,
TotalInfra INT DEFAULT 0,
);

CREATE TABLE Infracoes   (
InfracaoID INT PRIMARY KEY,
DataHora SMALLDATETIME NOT NULL,
Equipamento VARCHAR(50),
VelPermitida INT DEFAULT 0,
VelMedida INT DEFAULT 0,
ValorBin BIT NOT NULL,
RemessaID INT FOREIGN KEY REFERENCES Remessa(RemessaID)
);

INSERT INTO Remessa (RemessaID, Situacao)
VALUES (1, '� Aceita'),
(2, 'Aceita'),
(3, 'Expedida'),
(4, 'Criada')

INSERT INTO Infracoes(InfracaoID,DataHora,Equipamento,VelPermitida,VelMedida,ValorBin,RemessaID)
VALUES 
(12, '2018/17/04 22:54:24', 'Radar Est�tico', 80, 117, 1, 1),
(13, '2017/04/12 21:41:36', 'Radar M�vel', 90, 111, 1, 1),
(21, '2016/22/11 19:12:12', 'Radar Port�til', 100, 105, 0, 2),
(33, '2015/30/09 16:36:43', 'Radar Est�tico', 60, 82, 1, 3),
(34, '2009/07/03 08:23:47', 'Radar Port�til', 100, 92, 0, 3),
(45, '2010/07/05 15:18:51', 'Radar M�vel', 110, 124, 0, 4),
(46, '2011/07/01 09:52:14', 'Radar Est�tico', 80, 97, 1, 4),
(47, '2012/07/02 23:13:15', 'Radar Port�til', 90, 118, 1, 4),
(48, '2013/07/11 02:55:33', 'Radar M�vel', 100, 115, 1, 4)

SELECT * FROM Remessa
SELECT * FROM Infracoes


--EXERCICIO 1 - Apresente todas infra��es com velmedida igual ou acima de 20% da velocidade permitida. Ordenar por data/hora da infra��o.

SELECT * 
FROM Infracoes
WHERE VelMedida >= (VelPermitida * 0.2) + VelPermitida
ORDER BY DataHora ASC

--EXERCICIO 2 - De cada remessa apresente sua identifica��o, sua situa��o, o total de infra��es, total de infra��es v�lidas e total de infra��es inv�lidas.
--Ordenar a consulta pela situa��o das remessas.

SELECT I.RemessaID, COUNT(I.RemessaID) TotalInfra, R.Situacao,
COUNT(CASE WHEN ValorBin = 0 THEN 1 ELSE NULL END) InfInvalidas,
COUNT(CASE WHEN ValorBin = 1 THEN 0 ELSE NULL END) InfValidas
FROM Infracoes I
INNER JOIN Remessa R ON R.RemessaID = I.RemessaID
GROUP BY I.RemessaID, R.Situacao
HAVING COUNT(I.RemessaID) >= 1 ORDER BY R.Situacao