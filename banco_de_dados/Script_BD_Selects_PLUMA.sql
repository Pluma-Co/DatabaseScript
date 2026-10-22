-- Selecionar todos os dados das tabelas união completa entre empresa, usina e sensores.
SELECT * 
FROM empresa
JOIN usina ON empresa.id = usina.fkEmpresa
INNER JOIN sensor ON usina.id = sensor.fkUsina;

-- Selecionar empresas sua localização, sensores e seus locais correspondentes
SELECT 
empresa.razaoSocial AS 'Empresa Operadora',
usina.cidade AS 'Cidade',
usina.endereco AS 'Localização da Usina',
sensor.numeroSerie AS 'Código do Sensor',
sensor.localInstalacao AS 'Ponto de Monitoramento'
FROM empresa
INNER JOIN usina ON empresa.id = usina.fkEmpresa
INNER JOIN sensor ON usina.id = sensor.fkUsina;

-- Selecionar apenas o nome de cada empresa junto com o endereço de suas usinas
SELECT 
empresa.razaoSocial AS NOME_EMPRESA,
usina.endereco AS ENDEREÇO_USINA
FROM empresa
INNER JOIN usina ON empresa.id = usina.fkEmpresa;

-- Selecionar a usina e a quantidade de sensores relacionados a ela
SELECT 
usina.endereco AS USINA,
sensor.numeroSerie AS SENSORES 
FROM usina
INNER JOIN sensor ON usina.id = usina.fkEmpresa;

-- Selecionar usina e seus sensores respectivos mostrando apenas sensores ativos
SELECT 
empresa.razaoSocial AS EMPRESA,
usina.id AS USINA,
sensor.numeroSerie AS SENSORES_ATIVOS
FROM usina 
INNER JOIN sensor ON usina.id = usina.fkEmpresa
INNER JOIN empresa ON empresa.id = usina.fkEmpresa
WHERE ativo = 1;

-- Selecionar empresas de São Paulo e suas respectivas usinas
SELECT 
empresa.razaoSocial AS NOME_EMPRESA,
usina.cidade AS USINA,
usina.estado AS CIDADE 
FROM empresa
INNER JOIN usina ON empresa.id = usina.fkEmpresa
WHERE usina.estado = 'SP';