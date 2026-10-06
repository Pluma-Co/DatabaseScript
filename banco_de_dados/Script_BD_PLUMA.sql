CREATE DATABASE pluma;
USE pluma;

CREATE TABLE empresa (
    id INT PRIMARY KEY AUTO_INCREMENT,
    razao_social VARCHAR(100),
    cnpj CHAR(14) UNIQUE ,
    dtcadastro DATE
);

CREATE TABLE usina (
    id INT PRIMARY KEY AUTO_INCREMENT,
    dtcadastro DATETIME,
    cidade VARCHAR(60),
    estado VARCHAR(45),
    endereco VARCHAR(100),
    fk_empresa INT,
    FOREIGN KEY (fk_empresa) REFERENCES empresa(id)
);

CREATE TABLE usuario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    email VARCHAR(80),
    senha VARCHAR(50),
    dtcadastro DATETIME,
    login VARCHAR(45),
    permissao VARCHAR(45),
    fk_empresa INT,
    FOREIGN KEY (fk_empresa) REFERENCES empresa(id)
);

CREATE TABLE sensor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    localinstalacao VARCHAR(45),
    ativo TINYINT,
    dtinstalacao DATE,
    numero_serie VARCHAR(20),
    fk_usina INT,
    FOREIGN KEY (fk_usina) REFERENCES Usina(id)
);

CREATE TABLE medicao (
    id INT PRIMARY KEY AUTO_INCREMENT,
    indice_gas DECIMAL(10,2),
    dtmedicao DATETIME,
    fk_sensor INT,
    FOREIGN KEY (fk_sensor) REFERENCES Sensor(id)
);

INSERT INTO empresa (razao_social, cnpj, dtcadastro) VALUES
('RZK Energia', '28133664000148', '2026-09-30'),
('Ecoparque Usina Paulínia Verde', '03279285002850', '2026-09-30'),
('Termoverde Caieiras', '10490040000112', '2026-09-30'),
('Biogás Energia Ambiental S.A.', '04131501000168', '2026-09-30'),
('Cocal Energia S.A', '14788495000170', '2026-09-30');

SELECT * FROM empresa;

INSERT INTO usina (dtCadastro, cidade, estado, endereco, fk_empresa) VALUES 
(NOW(), 'São Paulo', 'SP', 'Estr. de Sapopemba, 23325 - Cidade Satélite Santa Bárbara', 1),
(NOW(), 'Paulínia', 'SP', 'Avenida Orlando Vedovello, 894 - Parque da Represa, Paulínia', 2),
(NOW(), 'Caieiras', 'SP', 'Via de Acesso Norte, Km 33 Rodovia dos Bandeirantes – Bairro Calcárea, Caieiras', 3),
(NOW(), 'São Paulo', 'SP', 'Rua Mogeiro, 1.580 – Vila Perus', 4),
(NOW(), 'Narandiba', 'SP', 'Estrada Municipal Narandiba – Fazenda Mosquito', 5);

INSERT INTO sensor (localinstalacao, ativo, dtinstalacao, numero_serie, fk_usina) VALUES 
('Biodigestor', 1, '2026-09-30', 'MQ2-SP01', 1),
('Válvula de Purificação', 1, '2026-09-30', 'MQ2-SP02', 2),
('Gasômetro Principal', 1, '2026-09-30', 'MQ2-CAIE01', 3),
('Biodigestor', 1, '2026-09-30', 'MQ2-SP03', 4),
('Gasômetro Principal', 1, '2026-09-30', 'MQ2-NARAN01', 5);


INSERT INTO usuario (nome, email, senha, dtcadastro, login, permissao, fk_empresa) VALUES
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
JOIN usina ON empresa.id = usina.fk_empresa
INNER JOIN sensor ON usina.id = sensor.fk_usina;


-- Selecionar  empresas sua localização ,sensores e seus locais correspondentes 
SELECT 
empresa.razao_social AS 'Empresa Operadora',
usina.cidade AS 'Cidade',
usina.endereco AS 'Localização da Usina',
sensor.numero_serie AS 'Código do Sensor',
sensor.localinstalacao AS 'Ponto de Monitoramento'
FROM empresa
INNER JOIN usina ON empresa.id = usina.fk_empresa
INNER JOIN sensor ON usina.id = sensor.fk_usina;

-- Selecionar apenas o nome de cada empresa junto com o endereço de suas usinas 
SELECT 
empresa.razao_social AS NOME_EMPRESA,
usina.endereco AS ENDEREÇO_USINA
FROM empresa
INNER JOIN usina ON empresa.id = usina.fk_empresa; 

-- Selecionar a usina e a quantidade de sensores relacionados a ela 
SELECT 
usina.endereco AS USINA,
sensor.numero_serie AS SENSORES 
FROM usina
INNER JOIN sensor ON usina.id = usina.fk_empresa;

-- Selecionar usina e seus sensores respectivos mostrando apenas sensores ativos 
SELECT 
empresa.razao_social AS EMPRESA,
usina.id AS USINA,
sensor.numero_serie AS SENSORES_ATIVOS
FROM usina 
INNER JOIN sensor ON usina.id = usina.fk_empresa
INNER JOIN empresa ON empresa.id = usina.fk_empresa
WHERE ativo = 1; 

-- Selecionar empresas de São paulo e suas respectivas usinas 
SELECT 
empresa.razao_social AS NOME_EMPRESA,
usina.cidade AS USINA,
usina.estado AS CIDADE 
FROM empresa
INNER JOIN usina ON empresa.id = usina.fk_empresa
WHERE usina.estado = 'SP';


