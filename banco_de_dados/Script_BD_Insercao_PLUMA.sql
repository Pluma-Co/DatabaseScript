INSERT INTO empresa (razaoSocial, cnpj, dtCadastro) VALUES
('RZK Energia', '28133664000148', '2026-09-30'),
('Ecoparque Usina Paulínia Verde', '03279285002850', '2026-09-30'),
('Termoverde Caieiras', '10490040000112', '2026-09-30'),
('Biogás Energia Ambiental S.A.', '04131501000168', '2026-09-30'),
('Cocal Energia S.A', '14788495000170', '2026-09-30');

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
