CREATE DATABASE pluma;
USE pluma;

CREATE TABLE empresa (
    id INT PRIMARY KEY AUTO_INCREMENT,
    razaoSocial VARCHAR(100) NOT NULL,
    cnpj CHAR(14) UNIQUE NOT NULL,
    dtCadastro DATETIME NOT NULL DEFAULT NOW()
);

CREATE TABLE usina (
    id INT PRIMARY KEY AUTO_INCREMENT,
    dtCadastro DATETIME NOT NULL DEFAULT NOW(),
    cidade VARCHAR(60) NOT NULL,
    estado VARCHAR(45) NOT NULL,
    endereco VARCHAR(100) NOT NULL,
    fkEmpresa INT NOT NULL,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(id)
);

CREATE TABLE usuario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    email VARCHAR(80) NOT NULL,
    senha VARCHAR(50) NOT NULL,
    dtCadastro DATETIME NOT NULL DEFAULT NOW(),
    login VARCHAR(45) NOT NULL,
    permissao VARCHAR(45) NOT NULL,
    fkEmpresa INT NOT NULL,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(id)
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

SELECT * FROM medicao;

INSERT INTO empresa (razaoSocial, cnpj, dtCadastro) VALUES
('RZK Energia', '28133664000148', '2026-09-30'),
('Ecoparque Usina Paulínia Verde', '03279285002850', '2026-09-30'),
('Termoverde Caieiras', '10490040000112', '2026-09-30'),
('Biogás Energia Ambiental S.A.', '04131501000168', '2026-09-30'),
('Cocal Energia S.A', '14788495000170', '2026-09-30');

SELECT * FROM empresa;

INSERT INTO usina (dtCadastro, cidade, estado, endereco, fkEmpresa) VALUES 
(NOW(), 'São Paulo', 'SP', 'Estr. de Sapopemba, 23325 - Cidade Satélite Santa Bárbara', 1),
(NOW(), 'Paulínia', 'SP', 'Avenida Orlando Vedovello, 894 - Parque da Represa, Paulínia', 2),
(NOW(), 'Caieiras', 'SP', 'Via de Acesso Norte, Km 33 Rodovia dos Bandeirantes – Bairro Calcárea, Caieiras', 3),
(NOW(), 'São Paulo', 'SP', 'Rua Mogeiro, 1.580 – Vila Perus', 4),
(NOW(), 'Narandiba', 'SP', 'Estrada Municipal Narandiba – Fazenda Mosquito', 5);

INSERT INTO sensor (localInstalacao, ativo, dtInstalacao, numeroSerie, fkUsina) VALUES 
('Biodigestor', 1, '2026-09-30', 'MQ2-SP01', 1),
('Válvula de Purificação', 1, '2026-09-30', 'MQ2-SP02', 2),
('Gasômetro Principal', 1, '2026-09-30', 'MQ2-CAIE01', 3),
('Biodigestor', 1, '2026-09-30', 'MQ2-SP03', 4),
('Gasômetro Principal', 1, '2026-09-30', 'MQ2-NARAN01', 5);

INSERT INTO usuario (nome, email, senha, dtCadastro, login, permissao, fkEmpresa) VALUES
('Fabio Alves', 'fabio.alves@rzk.com', 'senha123', NOW(), 'falves', 'Administrador', 1),
('Ana Souza', 'ana.souza@ecoparque.com', 'senha1234', NOW(), 'asouza', 'Operador', 2),
('Claudio Frizzarini', 'claudio.frizzarini@gmail.com', 'senha1234', NOW(), 'cfrizzarini', 'Técnico', 3),
('Isis Cruz', 'isis.cruz@gmail.com', 'senha123', NOW(), 'icruz', 'Administrador', 4),
('Carlos Monteiro', 'carlos.monteiro@icloud.com', 'senha123', NOW(), 'cmonteiro', 'Operador', 1);

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