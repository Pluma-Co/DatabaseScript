CREATE TABLE Empresa (
    id INT AUTO_INCREMENT PRIMARY KEY,
    razao_social VARCHAR(100),
    cnpj CHAR(14),
    dtCadastro DATE
);

CREATE TABLE Usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45),
    email VARCHAR(80),
    senha VARCHAR(50),
    dtCadastro DATETIME,
    login VARCHAR(45),
    permissao VARCHAR(45),
    fk_empresa INT,
    FOREIGN KEY (fk_empresa) REFERENCES Empresa(id)
);

CREATE TABLE Usina (
    id INT AUTO_INCREMENT PRIMARY KEY,
    dtCadastro DATETIME,
    cidade VARCHAR(60),
    estado VARCHAR(45),
    endereco VARCHAR(100),
    fk_empresa INT,
    FOREIGN KEY (fk_empresa) REFERENCES Empresa(id)
);

CREATE TABLE Sensor (
    id INT AUTO_INCREMENT PRIMARY KEY,
    localInstalacao VARCHAR(45),
    ativo TINYINT,
    dtInstalacao DATE,
    nSerie VARCHAR(20),
    fk_usina INT,
    FOREIGN KEY (fk_usina) REFERENCES Usina(id)
);

CREATE TABLE Medicao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    dtMedicao DATETIME,
    fk_sensor INT,
    FOREIGN KEY (fk_sensor) REFERENCES Sensor(id)
);