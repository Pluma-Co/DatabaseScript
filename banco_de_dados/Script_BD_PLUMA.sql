CREATE DATABASE pluma;
USE pluma;

CREATE TABLE empresa (
    id INT PRIMARY KEY AUTO_INCREMENT,
    razaoSocial VARCHAR(100) NOT NULL,
    cnpj CHAR(14) UNIQUE NOT NULL,
    codEmpresa CHAR(8) NOT NULL UNIQUE, -- XXXX1234
    dtCadastro DATETIME NOT NULL DEFAULT NOW()
);

CREATE TABLE usina (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    dtCadastro DATETIME NOT NULL DEFAULT NOW(),
    cidade VARCHAR(60) NOT NULL,
    estado VARCHAR(45) NOT NULL,
    logradouro VARCHAR(100) NOT NULL,
    fkEmpresa INT NOT NULL,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(id)
);

CREATE TABLE usuario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    email VARCHAR(80) NOT NULL,
    senha VARCHAR(50) NOT NULL,
    dtCadastro DATETIME NOT NULL DEFAULT NOW(),
    permissao VARCHAR(45) NOT NULL DEFAULT 'operador',
    fkEmpresa INT NOT NULL,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(id),
    CONSTRAINT chkPermissao CHECK(permissao IN('operador','administrador'))
);

CREATE TABLE sensor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    localInstalacao VARCHAR(45) NOT NULL,
    ativo TINYINT NOT NULL,
    dtInstalacao DATE NOT NULL,
    numeroSerie VARCHAR(20) NOT NULL,
    fkUsina INT NOT NULL,
    FOREIGN KEY (fkUsina) REFERENCES usina(id)
);

CREATE TABLE medicao (
    id INT PRIMARY KEY AUTO_INCREMENT,
    indiceGas DECIMAL(10,2) NOT NULL,
    dtMedicao DATETIME NOT NULL DEFAULT NOW(),
    fkSensor INT NOT NULL,
    FOREIGN KEY (fkSensor) REFERENCES sensor(id)
);

CREATE TABLE vazamento (
  id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  vazamentoTotal DECIMAL(10,2) NOT NULL,
  dataInicio DATETIME NOT NULL,
  dataFim DATETIME NOT NULL,
  fkSensor INT NOT NULL,
  FOREIGN KEY (fkSensor) REFERENCES sensor(id)
);

SELECT * FROM medicao;

INSERT INTO empresa (razaoSocial, cnpj, codEmpresa, dtCadastro) VALUES
('RZK Energia', '28133664000148', 'RZKE0001', '2026-09-30'),
('Ecoparque Usina Paulínia Verde', '03279285002850', 'EUPV0002', '2026-09-30'),
('Termoverde Caieiras', '10490040000112', 'TECA0003', '2026-09-30'),
('Biogás Energia Ambiental S.A.', '04131501000168', 'BESA0004', '2026-09-30'),
('Cocal Energia S.A', '14788495000170', 'COEN0005', '2026-09-30');

SELECT * FROM empresa;

INSERT INTO usina (nome, dtCadastro, cidade, estado, logradouro, fkEmpresa) VALUES 
('Thopen',  NOW(), 'São Paulo', 'SP', 'Estr. de Sapopemba, 23325 - Cidade Satélite Santa Bárbara', 1),
('UTE Paulínia Verde', NOW(), 'Paulínia', 'SP', 'Avenida Orlando Vedovello, 894 - Parque da Represa, Paulínia', 2),
('UVS Termoverde Caieiras', NOW(), 'Caieiras', 'SP', 'Via de Acesso Norte, Km 33 Rodovia dos Bandeirantes – Bairro Calcárea, Caieiras', 3),
('Usina Bandeirantes', NOW(), 'São Paulo', 'SP', 'Rua Mogeiro, 1.580 – Vila Perus', 4),
('Usina Cocal', NOW(), 'Narandiba', 'SP', 'Estrada Municipal Narandiba – Fazenda Mosquito', 5);

INSERT INTO sensor (localInstalacao, ativo, dtInstalacao, numeroSerie, fkUsina) VALUES 
('Armazenamento', 1, '2026-09-30', 'MQ2-SP01', 1),
('Purificador', 1, '2026-09-30', 'MQ2-SP02', 1),
('Compressor', 1, '2026-09-30', 'MQ2-CAIE01', 1),
('Biodigestor', 1, '2026-09-30', 'MQ2-SP03', 2),
('Gasômetro Principal', 1, '2026-09-30', 'MQ2-NARAN01', 3);

INSERT INTO usuario (nome, email, senha, dtCadastro, permissao, fkEmpresa) VALUES
('Fabio Alves', 'fabio.alves@rzk.com', 'senha123', NOW(), 'administrador', 1),
('Ana Souza', 'ana.souza@ecoparque.com', 'senha1234', NOW(), 'operador', 2),
('Claudio Frizzarini', 'claudio.frizzarini@gmail.com', 'senha1234', NOW(), 'operador', 3),
('Isis Cruz', 'isis.cruz@gmail.com', 'senha123', NOW(), 'administrador', 4),
('Carlos Monteiro', 'carlos.monteiro@icloud.com', 'senha123', NOW(), 'operador', 1);


INSERT INTO medicao (indiceGas, dtMedicao, fkSensor) VALUES

-- SENSOR 1: ARMAZENAMENTO
(0,    '2026-10-01 08:00:00', 1),
(200,  '2026-10-01 09:00:00', 1),
(450,  '2026-10-01 10:00:00', 1),
(800,  '2026-10-01 12:00:00', 1),
(1200, '2026-10-01 14:00:00', 1),

(0,    '2026-10-04 08:00:00', 1),
(300,  '2026-10-04 10:00:00', 1),
(650,  '2026-10-04 12:00:00', 1),
(1200, '2026-10-04 14:00:00', 1),

(0,    '2026-10-25 08:00:00', 1),
(250,  '2026-10-25 11:00:00', 1),
(600,  '2026-10-25 14:00:00', 1),
(900,  '2026-10-25 17:00:00', 1),
(1200, '2026-10-25 20:00:00', 1),

-- SENSOR 2: PURIFICADOR
(0,    '2026-10-01 09:00:00', 2),
(150,  '2026-10-01 10:00:00', 2),
(400,  '2026-10-01 12:00:00', 2),
(800,  '2026-10-01 14:00:00', 2),
(1200, '2026-10-01 15:00:00', 2),

(0,    '2026-10-04 09:00:00', 2),
(250,  '2026-10-04 11:00:00', 2),
(600,  '2026-10-04 13:00:00', 2),
(1200, '2026-10-04 15:00:00', 2),

(0,    '2026-10-25 09:00:00', 2),
(300,  '2026-10-25 10:00:00', 2),
(700,  '2026-10-25 11:00:00', 2),
(1200, '2026-10-25 12:00:00', 2),

-- SENSOR 3: COMPRESSOR
(0,    '2026-10-01 10:00:00', 3),
(100,  '2026-10-01 11:00:00', 3),
(350,  '2026-10-01 13:00:00', 3),
(750,  '2026-10-01 14:00:00', 3),
(1200, '2026-10-01 16:00:00', 3),

(0,    '2026-10-04 10:00:00', 3),
(200,  '2026-10-04 12:00:00', 3),
(550,  '2026-10-04 14:00:00', 3),
(900,  '2026-10-04 15:00:00', 3),
(1200, '2026-10-04 16:00:00', 3),

(0,    '2026-10-25 10:00:00', 3),
(300,  '2026-10-25 11:00:00', 3),
(650,  '2026-10-25 12:00:00', 3),
(1200, '2026-10-25 13:00:00', 3);

-- vazamentos
INSERT INTO vazamento (vazamentoTotal, dataInicio, dataFim, fkSensor) VALUES

-- SENSOR 1 (8 vazamentos de 6h e 1 de 12h)
(3200.00, '2026-10-01 08:00:00', '2026-10-01 14:00:00', 1),
(4500.00, '2026-10-04 08:00:00', '2026-10-04 14:00:00', 1),
(5800.00, '2026-10-07 08:00:00', '2026-10-07 14:00:00', 1),
(6100.00, '2026-10-10 08:00:00', '2026-10-10 14:00:00', 1),
(7200.00, '2026-10-13 08:00:00', '2026-10-13 14:00:00', 1),
(7900.00, '2026-10-16 08:00:00', '2026-10-16 14:00:00', 1),
(8100.00, '2026-10-19 08:00:00', '2026-10-19 14:00:00', 1),
(8200.00, '2026-10-22 08:00:00', '2026-10-22 14:00:00', 1),
(8433.00, '2026-10-25 08:00:00', '2026-10-25 20:00:00', 1),

-- SENSOR 2 (8 vazamentos de 6h e 1 de 3h)
(1200.00, '2026-10-01 09:00:00', '2026-10-01 15:00:00', 2),
(1800.00, '2026-10-04 09:00:00', '2026-10-04 15:00:00', 2),
(2100.00, '2026-10-07 09:00:00', '2026-10-07 15:00:00', 2),
(2500.00, '2026-10-10 09:00:00', '2026-10-10 15:00:00', 2),
(2900.00, '2026-10-13 09:00:00', '2026-10-13 15:00:00', 2),
(3100.00, '2026-10-16 09:00:00', '2026-10-16 15:00:00', 2),
(3400.00, '2026-10-19 09:00:00', '2026-10-19 15:00:00', 2),
(3600.00, '2026-10-22 09:00:00', '2026-10-22 15:00:00', 2),
(3787.00, '2026-10-25 09:00:00', '2026-10-25 12:00:00', 2),

-- SENSOR 3 (8 vazamentos de 6h e 1 de 3h)
(100.00, '2026-10-01 10:00:00', '2026-10-01 16:00:00', 3),
(150.00, '2026-10-04 10:00:00', '2026-10-04 16:00:00', 3),
(180.00, '2026-10-07 10:00:00', '2026-10-07 16:00:00', 3),
(220.00, '2026-10-10 10:00:00', '2026-10-10 16:00:00', 3),
(250.00, '2026-10-13 10:00:00', '2026-10-13 16:00:00', 3),
(280.00, '2026-10-16 10:00:00', '2026-10-16 16:00:00', 3),
(300.00, '2026-10-19 10:00:00', '2026-10-19 16:00:00', 3),
(320.00, '2026-10-22 10:00:00', '2026-10-22 16:00:00', 3),
(340.00, '2026-10-25 10:00:00', '2026-10-25 13:00:00', 3);


SELECT * FROM empresa;
SELECT * FROM sensor;
SELECT * FROM usina;
SELECT * FROM usuario;

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

-- Selecionar usina e seus sensores respectivos mostrando apenas sensores ativos 
SELECT 
empresa.razaoSocial AS EMPRESA,
usina.nome AS USINA,
sensor.numeroSerie AS SENSORES_ATIVOS
FROM usina 
JOIN sensor ON sensor.fkUsina = usina.id
LEFT JOIN empresa ON empresa.id = usina.fkEmpresa
WHERE ativo = 1;


-- Selecionar empresas de São Paulo e suas respectivas usinas
SELECT 
empresa.razaoSocial AS NOME_EMPRESA,
usina.cidade AS USINA,
usina.estado AS CIDADE 
FROM empresa
INNER JOIN usina ON empresa.id = usina.fkEmpresa
WHERE usina.estado = 'SP';


-- Selects - Dashboard 

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