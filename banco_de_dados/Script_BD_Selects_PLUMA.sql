
-- Selecionar todos os dados das tabelas união completa entre empresa, usina e sensores.
SELECT * 
FROM empresa
JOIN usina ON empresa.id = usina.fkEmpresa
INNER JOIN sensor ON usina.id = sensor.fkUsina;

-- Selecionar empresas sua localização, sensores e seus locais correspondentes
SELECT 
empresa.razaoSocial AS 'Empresa Operadora',
usina.cidade AS 'Cidade',
usina.logradouro AS 'Localização da Usina',
sensor.numeroSerie AS 'Código do Sensor',
sensor.localInstalacao AS 'Ponto de Monitoramento'
FROM empresa
INNER JOIN usina ON empresa.id = usina.fkEmpresa
INNER JOIN sensor ON usina.id = sensor.fkUsina;

-- Selecionar apenas o nome de cada empresa junto com o endereço de suas usinas
SELECT 
empresa.razaoSocial AS NOME_EMPRESA,
usina.logradouro AS ENDEREÇO_USINA
FROM empresa
INNER JOIN usina ON empresa.id = usina.fkEmpresa;

-- Selecionar empresas de São Paulo e suas respectivas usinas
SELECT 
empresa.razaoSocial AS NOME_EMPRESA,
usina.cidade AS USINA,
usina.estado AS CIDADE 
FROM empresa
INNER JOIN usina ON empresa.id = usina.fkEmpresa
WHERE usina.estado = 'SP';

USE pluma;
-- Selects - Dashboard 

-- Selecionar usina e seus sensores respectivos mostrando apenas sensores ativos 
SELECT 
empresa.razaoSocial AS EMPRESA,
usina.nome AS USINA,
sensor.numeroSerie AS SENSORES_ATIVOS
FROM usina 
JOIN sensor ON sensor.fkUsina = usina.id
LEFT JOIN empresa ON empresa.id = usina.fkEmpresa
WHERE ativo = 1;

-- Historico de medições
SELECT * FROM medicao 
ORDER BY dtMedicao DESC;

-- Total de vazamentos
SELECT COUNT(*) 'Vazamentos Totais'
FROM vazamento
WHERE dataInicio >= '2026-10-01'
AND dataInicio < '2026-11-01';

-- Maior tempo de vazamento
SELECT MAX(TIMESTAMPDIFF(HOUR, dataInicio, dataFim)) maiorTempoVazamento
FROM vazamento
WHERE dataInicio >= '2026-10-01'
AND dataInicio < '2026-11-01';

-- Vazamento Total por Local
SELECT
sensor.localInstalacao 'Vazamento por Local',
SUM(vazamento.vazamentoTotal) Total
FROM vazamento
JOIN sensor ON vazamento.fkSensor = sensor.id
WHERE vazamento.dataInicio >= '2026-10-01'
AND vazamento.dataInicio < '2026-11-01'
GROUP BY sensor.localInstalacao
ORDER BY Total DESC;