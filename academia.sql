CREATE DATABASE IF NOT EXISTS academia;
USE academia;

DROP TABLE IF EXISTS Turma;
DROP TABLE IF EXISTS Item_Treino;
DROP TABLE IF EXISTS Exercicio;
DROP TABLE IF EXISTS Treino;
DROP TABLE IF EXISTS Parcela;
DROP TABLE IF EXISTS Pagamento;
DROP TABLE IF EXISTS Matricula;
DROP TABLE IF EXISTS Sala;
DROP TABLE IF EXISTS Modalidade;
DROP TABLE IF EXISTS Plano;
DROP TABLE IF EXISTS Administrativo;
DROP TABLE IF EXISTS Professor;
DROP TABLE IF EXISTS Funcionario;
DROP TABLE IF EXISTS Aluno;
DROP TABLE IF EXISTS Telefone_Pessoa;
DROP TABLE IF EXISTS Pessoa;

CREATE TABLE Pessoa (
    id_pessoa INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    email VARCHAR(100) UNIQUE,
    data_nasc DATE NOT NULL,
    bairro VARCHAR(80),
    rua VARCHAR(100),
    numero VARCHAR(10)
);

CREATE TABLE Telefone_Pessoa (
    id_pessoa INT NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_pessoa, telefone),
    FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id_pessoa)
);

CREATE TABLE Aluno (
    id_pessoa INT PRIMARY KEY,
    data_cadastro DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id_pessoa)
);

CREATE TABLE Funcionario (
    id_pessoa INT PRIMARY KEY,
    mat_func VARCHAR(20) NOT NULL UNIQUE,
    cargo VARCHAR(50) NOT NULL,
    data_contratacao DATE NOT NULL,
    salario DECIMAL(10,2) NOT NULL,
    id_supervisor INT,
    FOREIGN KEY (id_pessoa) REFERENCES Pessoa(id_pessoa),
    FOREIGN KEY (id_supervisor) REFERENCES Funcionario(id_pessoa)
);

CREATE TABLE Professor (
    id_pessoa INT PRIMARY KEY,
    cref VARCHAR(20) NOT NULL UNIQUE,
    FOREIGN KEY (id_pessoa) REFERENCES Funcionario(id_pessoa)
);

CREATE TABLE Administrativo (
    id_pessoa INT PRIMARY KEY,
    setor VARCHAR(50) NOT NULL,
    nivel_acesso VARCHAR(30) NOT NULL,
    FOREIGN KEY (id_pessoa) REFERENCES Funcionario(id_pessoa)
);

CREATE TABLE Plano (
    id_plano INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    valor_mensal DECIMAL(10,2) NOT NULL,
    duracao INT NOT NULL
);

CREATE TABLE Matricula (
    id_matricula INT PRIMARY KEY,
    id_aluno INT NOT NULL,
    id_plano INT NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_aluno) REFERENCES Aluno(id_pessoa),
    FOREIGN KEY (id_plano) REFERENCES Plano(id_plano)
);

CREATE TABLE Pagamento (
    id_pagamento INT PRIMARY KEY,
    id_matricula INT NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    data DATE NOT NULL,
    forma_pagamento VARCHAR(30) NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_matricula) REFERENCES Matricula(id_matricula)
);

CREATE TABLE Parcela (
    id_pagamento INT NOT NULL,
    numero_parcela INT NOT NULL,
    data_vencimento DATE NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_pagamento, numero_parcela),
    FOREIGN KEY (id_pagamento) REFERENCES Pagamento(id_pagamento)
);

CREATE TABLE Treino (
    id_treino INT PRIMARY KEY,
    id_aluno INT NOT NULL,
    id_professor INT NOT NULL,
    data_criacao DATE NOT NULL,
    objetivo VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_aluno) REFERENCES Aluno(id_pessoa),
    FOREIGN KEY (id_professor) REFERENCES Professor(id_pessoa)
);

CREATE TABLE Exercicio (
    id_exercicio INT PRIMARY KEY,
    nome VARCHAR(80) NOT NULL,
    grupo_muscular VARCHAR(50) NOT NULL
);

CREATE TABLE Item_Treino (
    id_treino INT NOT NULL,
    numero_item INT NOT NULL,
    id_exercicio INT NOT NULL,
    series INT NOT NULL,
    repeticoes INT NOT NULL,
    carga DECIMAL(6,2),
    tempo_descanso INT,
    PRIMARY KEY (id_treino, numero_item),
    FOREIGN KEY (id_treino) REFERENCES Treino(id_treino),
    FOREIGN KEY (id_exercicio) REFERENCES Exercicio(id_exercicio)
);

CREATE TABLE Modalidade (
    id_modalidade INT PRIMARY KEY,
    nome VARCHAR(60) NOT NULL
);

CREATE TABLE Sala (
    id_sala INT PRIMARY KEY,
    numero VARCHAR(10) NOT NULL,
    capacidade INT NOT NULL,
    tipo VARCHAR(50) NOT NULL
);

CREATE TABLE Turma (
    id_turma INT PRIMARY KEY,
    id_professor INT NOT NULL,
    id_modalidade INT NOT NULL,
    id_sala INT NOT NULL,
    dia VARCHAR(20) NOT NULL,
    horario_inicio TIME NOT NULL,
    horario_fim TIME NOT NULL,
    capacidade_max INT NOT NULL,
    FOREIGN KEY (id_professor) REFERENCES Professor(id_pessoa),
    FOREIGN KEY (id_modalidade) REFERENCES Modalidade(id_modalidade),
    FOREIGN KEY (id_sala) REFERENCES Sala(id_sala)
);

INSERT INTO Pessoa VALUES
(1, 'Carlos Almeida', '111.111.111-11', 'carlos@academia.com', '1985-03-10', 'Centro', 'Rua A', '100'),
(2, 'Ana Souza', '222.222.222-22', 'ana@academia.com', '1990-07-15', 'Jardim', 'Rua B', '200'),
(3, 'João Pereira', '333.333.333-33', 'joao@email.com', '2001-05-20', 'Centro', 'Rua C', '300'),
(4, 'Maria Oliveira', '444.444.444-44', 'maria@email.com', '1998-11-02', 'Vila Nova', 'Rua D', '400'),
(5, 'Pedro Santos', '555.555.555-55', 'pedro@academia.com', '1988-09-25', 'Centro', 'Rua E', '500'),
(6, 'Juliana Lima', '666.666.666-66', 'juliana@academia.com', '1995-12-01', 'Jardim', 'Rua F', '600');

INSERT INTO Telefone_Pessoa VALUES
(1, '(21) 99999-1111'),
(1, '(21) 98888-1111'),
(2, '(21) 99999-2222'),
(3, '(21) 99999-3333'),
(4, '(21) 99999-4444'),
(5, '(21) 99999-5555'),
(6, '(21) 99999-6666');

INSERT INTO Aluno VALUES
(3, '2026-01-10', 'ativo'),
(4, '2026-02-05', 'ativo');

INSERT INTO Funcionario VALUES
(1, 'FUNC001', 'Gerente', '2022-01-15', 5000.00, NULL),
(2, 'FUNC002', 'Professor', '2023-03-10', 3200.00, 1),
(5, 'FUNC003', 'Professor', '2023-08-20', 3000.00, 1),
(6, 'FUNC004', 'Recepcionista', '2024-01-12', 1800.00, 1);

INSERT INTO Professor VALUES
(2, 'CREF-12345'),
(5, 'CREF-67890');

INSERT INTO Administrativo VALUES
(1, 'Gerência', 'alto'),
(6, 'Recepção', 'medio');

INSERT INTO Plano VALUES
(1, 'Plano Mensal', 120.00, 1),
(2, 'Plano Trimestral', 330.00, 3),
(3, 'Plano Semestral', 600.00, 6),
(4, 'Plano Anual', 1000.00, 12);

INSERT INTO Matricula VALUES
(1, 3, 1, '2026-01-10', '2026-02-10', 'ativa'),
(2, 4, 2, '2026-02-05', '2026-05-05', 'ativa');

INSERT INTO Pagamento VALUES
(1, 1, 120.00, '2026-01-10', 'Pix', 'pago'),
(2, 2, 330.00, '2026-02-05', 'Cartão de crédito', 'pendente');

INSERT INTO Parcela VALUES
(1, 1, '2026-01-10', 120.00, 'paga'),
(2, 1, '2026-02-05', 110.00, 'paga'),
(2, 2, '2026-03-05', 110.00, 'pendente'),
(2, 3, '2026-04-05', 110.00, 'pendente');

INSERT INTO Treino VALUES
(1, 3, 2, '2026-01-12', 'Hipertrofia'),
(2, 4, 5, '2026-02-07', 'Condicionamento físico');

INSERT INTO Exercicio VALUES
(1, 'Supino reto', 'Peitoral'),
(2, 'Agachamento', 'Pernas'),
(3, 'Puxada frontal', 'Costas'),
(4, 'Rosca direta', 'Bíceps'),
(5, 'Esteira', 'Cardiorrespiratório');

INSERT INTO Item_Treino VALUES
(1, 1, 1, 4, 10, 40.00, 60),
(1, 2, 2, 4, 12, 60.00, 90),
(1, 3, 4, 3, 10, 20.00, 60),
(2, 1, 5, 1, 20, NULL, 0),
(2, 2, 3, 3, 12, 35.00, 60);

INSERT INTO Modalidade VALUES
(1, 'Musculação'),
(2, 'Spinning'),
(3, 'Funcional'),
(4, 'Dança'),
(5, 'Jiu-jitsu');

INSERT INTO Sala VALUES
(1, '101', 30, 'Musculação'),
(2, '102', 20, 'Spinning'),
(3, '103', 25, 'Funcional'),
(4, '104', 30, 'Dança'),
(5, '105', 20, 'Lutas');

INSERT INTO Turma VALUES
(1, 2, 2, 2, 'Segunda-feira', '19:00:00', '20:00:00', 20),
(2, 2, 3, 3, 'Quarta-feira', '18:00:00', '19:00:00', 25),
(3, 5, 5, 5, 'Terça-feira', '20:00:00', '21:00:00', 20),
(4, 5, 1, 1, 'Sexta-feira', '17:00:00', '18:00:00', 30);
