CREATE TABLE cliente (
cpf VARCHAR(14) PRIMARY KEY,
nome VARCHAR(255),
idade INT,
sexo CHAR(1),
telefone VARCHAR(15),
email VARCHAR(255),
endereco VARCHAR(255),
bairro VARCHAR(255),
cidade VARCHAR(255),
estado VARCHAR(255),
foto BYTEA
);

CREATE TABLE veiculo (
placa VARCHAR(7) PRIMARY KEY,
modelo VARCHAR(255),
fabricante VARCHAR(255),
chassi VARCHAR(17),
ano INT,
categoria VARCHAR(255),
cpf_cliente VARCHAR(14),
FOREIGN KEY (cpf_cliente) REFERENCES cliente(cpf)
);

CREATE TABLE produto (
codigo_do_produto INT PRIMARY KEY,
nome VARCHAR(255),
descricao VARCHAR(255),
valor DECIMAL(10, 2)
);

CREATE TABLE estoque (
codigo INT PRIMARY KEY,
quantidade INT,
codigo_do_produto INT,
FOREIGN KEY (codigo_do_produto) REFERENCES produto(codigo_do_produto)
);

CREATE TABLE servico (
codigo_do_servico INT PRIMARY KEY,
manutencao VARCHAR(255),
revisao VARCHAR(255),
descricao VARCHAR(255),
valor DECIMAL(10, 2)
);

CREATE TABLE servico_concluido (
codigo_concluido INT PRIMARY KEY,
codigo_servico INT,
cpf_cliente VARCHAR(14),
placa_veiculo VARCHAR(10),
valor DECIMAL(10, 2),
data DATE,
FOREIGN KEY (codigo_servico) REFERENCES servico(codigo_do_servico),
FOREIGN KEY (cpf_cliente) REFERENCES cliente(cpf),
FOREIGN KEY (placa_veiculo) REFERENCES veiculo(placa)
);

CREATE TABLE funcionario (
cpf BIGINT PRIMARY KEY,
nome VARCHAR(255),
sexo VARCHAR(10),
idade INT,
especialidade VARCHAR(255),
telefone VARCHAR(20)
);

CREATE TABLE setor (
codigo INT PRIMARY KEY,
nome VARCHAR(255)
);

CREATE TABLE agendamento (
codigo_do_agendamento INT PRIMARY KEY,
data DATE,
hora TIME,
placa_veiculo VARCHAR(10),
cpf_cliente VARCHAR(14),
codigo_servico INT,
FOREIGN KEY (placa_veiculo) REFERENCES veiculo(placa),
FOREIGN KEY (cpf_cliente) REFERENCES cliente(cpf),
FOREIGN KEY (codigo_servico) REFERENCES servico(codigo_do_servico)
);

CREATE TABLE pagamento (
codigo_pagamento INT PRIMARY KEY,
valor DECIMAL(10, 2),
data DATE,
codigo_concluido INT,
FOREIGN KEY (codigo_concluido) REFERENCES servico_concluido(codigo_concluido)
);


/* relacionamento funcionario setor */
ALTER TABLE funcionario
ADD COLUMN codigo_setor INT,
ADD FOREIGN KEY (codigo_setor) REFERENCES setor(codigo);

/* relacionamento cliente servico */
ALTER TABLE cliente
ADD COLUMN codigo_servico INT,
ADD FOREIGN KEY (codigo_servico) REFERENCES servico(codigo_do_servico);

/* relacionamento cliente veiculo */
ALTER TABLE cliente
ADD COLUMN placa_veiculo VARCHAR(7),
ADD FOREIGN KEY (placa_veiculo) REFERENCES veiculo(placa);

/* relacionamento produto servico */
ALTER TABLE produto
ADD COLUMN codigo_servico INT,
ADD FOREIGN KEY (codigo_servico) REFERENCES servico(codigo_do_servico);

/* relacionamento produto estoque */
ALTER TABLE produto
ADD COLUMN codigo_estoque INT,
ADD FOREIGN KEY (codigo_estoque) REFERENCES estoque(codigo);

/* relacionamento servico servico_concluido */
ALTER TABLE servico
ADD COLUMN codigo_concluido INT,
ADD FOREIGN KEY (codigo_concluido) REFERENCES servico_concluido(codigo_concluido);

/* relacionamento funcionario servico */
ALTER TABLE funcionario
ADD COLUMN codigo_servico INT,
ADD FOREIGN KEY (codigo_servico) REFERENCES servico(codigo_do_servico);
ALTER TABLE funcionario ADD COLUMN departamento text;

/* populando tabelas */

INSERT INTO cliente (cpf, nome, idade, sexo, telefone, email, endereco, bairro, cidade, estado, foto)
VALUES
('12345678910', 'João Silva', 33, 'M', '11 99999-9999', 'joao.silva@gmail.com', 'Rua X, 123', 'Centro', 'São Paulo', 'SP', 'foto_joao'),
('10987654321', 'Maria Oliveira', 44, 'F', '11 98888-8888', 'maria.oliveira@gmail.com', 'Rua Y, 456', 'Jardim', 'São Paulo', 'SP', 'foto_maria'),
('23456789101', 'Carlos Torres', 55, 'M', '11 97777-7777', 'carlos.torres@gmail.com', 'Rua Z, 789', 'Vila', 'São Paulo', 'SP', 'foto_carlos'),
('34567891011', 'Ana Costa', 22, 'F', '11 96666-6666', 'ana.costa@gmail.com', 'Rua A, 111', 'Morumbi', 'São Paulo', 'SP', 'foto_ana'),
('45678910112', 'Luiz Gonzaga', 66, 'M', '11 95555-5555', 'luiz.gonzaga@gmail.com', 'Rua B, 222', 'Itaim', 'São Paulo', 'SP', 'foto_luiz');

INSERT INTO veiculo (placa, modelo, fabricante, chassi, ano, categoria, cpf_cliente)
VALUES
('AAA1111', 'Gol', 'Volkswagen', '9BWZZZ377KT000000', 2020, 'Compacto', '12345678910'),
('BBB2222', 'Uno', 'Fiat', '9BVZZZ377KT000001', 2019, 'Hatch', '10987654321'),
('CCC3333', 'Sandero', 'Renault', '9BXZZZ377KT000002', 2018, 'Sedan', '23456789101'),
('DDD4444', 'Fit', 'Honda', '9BYZZZ377KT000003', 2017, 'Hatch', '34567891011'),
('EEE5555', 'C3', 'Citroen', '9BZZZZ377KT000004', 2016, 'Hatch', '45678910112');

INSERT INTO produto (codigo_do_produto, nome, descricao, valor)
VALUES
(1, 'Oleo de motor', 'Oleo mineral 15W40', 79.99),
(2, 'Pastilha de freio', 'Pastilha de freio traseira', 199.99),
(3, 'Filtro de ar', 'Filtro de ar esportivo', 129.99),
(4, 'Pneu', 'Pneu 175/65 R14', 499.99),
(5, 'Bateria', 'Bateria 12V 55Ah', 249.99);

INSERT INTO estoque (codigo, quantidade, codigo_do_produto) VALUES 
(1, 15, 1),
(2, 20, 2),
(3, 25, 3),
(4, 30, 4),
(5, 35, 5);

INSERT INTO servico (codigo_do_servico, manutencao, revisao, descricao, valor) VALUES
(1, 'troca de óleo', 'nenhuma', 'descrição do serviço 1', 100.00),
(2, 'troca de filtros', 'revisão geral', 'descrição do serviço 2', 200.00),
(3, 'troca de pneus', 'revisão geral', 'descrição do serviço 3', 300.00),
(4, 'troca de bateria', 'nenhuma', 'descrição do serviço 4', 400.00),
(5, 'troca de correia dentada', 'revisão geral', 'descrição do serviço 5', 500.00);

INSERT INTO servico_concluido (codigo_concluido, codigo_servico, cpf_cliente, placa_veiculo, valor, data) VALUES
(1, 1, '12345678910', 'AAA1111', 100.00, '2022-01-01'),
(2, 2, '10987654321', 'BBB2222', 200.00, '2022-02-02'),
(3, 3, '23456789101', 'CCC3333', 300.00, '2022-03-03'),
(4, 4, '34567891011', 'DDD4444', 400.00, '2022-04-04'),
(5, 5, '45678910112', 'EEE5555', 500.00, '2022-05-05');

-- Tabela setor
INSERT INTO setor (codigo, nome)
VALUES
(1, 'Manutenção'),
(2, 'Eletricista'),
(3, 'Mecânico'),
(4, 'Funilaria'),
(5, 'Pintura');

INSERT INTO funcionario (cpf, nome, sexo, idade, especialidade, telefone, codigo_setor, departamento) VALUES
(12345678901, 'Maurilio', 'masculino', 30, 'mecânico', '11 91234-5678', 1, 'Oficina'),
(23456789012, 'Valeria', 'feminino', 35, 'administrativo', '11 92345-6789', 2, 'Financeiro'),
(34567890123, 'Matheus', 'masculino', 40, 'eletricista', '11 93456-7890', 3, 'Oficina'),
(45678901234, 'Lucia', 'feminino', 45, 'recepcionista', '11 94567-8901', 4, 'Atendimento ao Cliente'),
(56789012345, 'Thiago', 'masculino', 50, 'gerente', '11 95678-9012', 5, 'Gerencia Geral');

INSERT INTO agendamento (codigo_do_agendamento, data, hora, placa_veiculo, cpf_cliente, codigo_servico)VALUES 
(1, '2022-01-01', '10:00:00', 'AAA1111', '12345678910', 1),
(2, '2022-01-01', '11:00:00', 'BBB2222', '10987654321', 2),
(3, '2022-01-02', '10:00:00', 'CCC3333', '23456789101', 3),
(4, '2022-01-02', '11:00:00', 'DDD4444', '34567891011', 4),
(5, '2022-01-03', '10:00:00', 'EEE5555', '45678910112', 5);

INSERT INTO pagamento (codigo_pagamento, valor, data, codigo_concluido) VALUES 
(1, 100.00, '2022-01-01', 1),
(2, 150.00, '2022-01-01', 2),
(3, 1200.00, '2022-01-02', 3),
(4, 450.00, '2022-01-02', 4),
(5, 300.00, '2022-01-03', 5);

/* mostrando as tabelas com as novas colunas */
SELECT * FROM cliente;
SELECT * FROM veiculo;
SELECT * FROM produto;
SELECT * FROM estoque;
SELECT * FROM servico;
SELECT * FROM servico_concluido;
SELECT * FROM funcionario;
SELECT * FROM agendamento;
SELECT * FROM pagamento;