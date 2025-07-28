
-- Banco de dados:

CREATE DATABASE gerencimento_oficinas;

-- Criando e definindo o esquema

CREATE SCHEMA Oficinas;

SET SCHEMA 'Oficinas';



-- Tabela base para pessoas (superclasse)
CREATE TABLE Pessoa (
    id_pessoa SERIAL PRIMARY KEY,
    pnome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    foto TEXT,
    bio TEXT,
    sobrenome VARCHAR(100) NOT NULL
);

-- Subclasse Aluno (herança total e disjunta de Pessoa)
CREATE TABLE Aluno (
    id_aluno INT PRIMARY KEY REFERENCES Pessoa(id_pessoa),
    dataNascimento DATE NOT NULL,
    matricula VARCHAR(20) UNIQUE NOT NULL
);

-- Subclasse Professor (também herda de Pessoa)
CREATE TABLE Professor (
    id_professor INT PRIMARY KEY REFERENCES Pessoa(id_pessoa)
);

-- Tabela de Formação Acadêmica
CREATE TABLE Formacao (
    id_formacao SERIAL PRIMARY KEY,
    curso VARCHAR(100) NOT NULL,
    tempo INT NOT NULL,
    local VARCHAR(100),
    ira FLOAT
);

-- Tabela de Experiência Profissional
CREATE TABLE Experiencia (
    id_experiencia SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    duracao INT NOT NULL
);

-- Tabela de Oficina
CREATE TABLE Oficina (
    id_oficina SERIAL PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    descricao TEXT,
    limiteVagas INT,
    status VARCHAR(50),
    cargaHoraria INT,
    id_professor INT NOT NULL
);

-- Tabela de Aula
CREATE TABLE Aula (
    id_aula SERIAL PRIMARY KEY,
    data DATE NOT NULL,
    horario TIME NOT NULL,
    id_oficina INT NOT NULL
);

-- Tabela de Categoria
CREATE TABLE Categoria (
    id_categoria SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

-- Tabela de Avaliação de Oficinas
CREATE TABLE Avaliacao (
    id_avaliacao SERIAL PRIMARY KEY,
    nota DECIMAL(3,1) NOT NULL,
    dataAvaliacao DATE NOT NULL,
    comentario TEXT,
    id_aluno INT NOT NULL,
    id_oficina INT NOT NULL
);

-- Tabela de Certificados
CREATE TABLE Certificado (
    id_certificado SERIAL PRIMARY KEY,
    dataEmissao DATE NOT NULL,
    arquivo TEXT NOT NULL
);

-- Relaciona Professor com suas Formações (N:N)
CREATE TABLE Formacao_Professor (
    id_professor INT NOT NULL,
    id_formacao INT NOT NULL,
    PRIMARY KEY (id_professor, id_formacao)
);

-- Relaciona Professor com suas Experiências (N:N)
CREATE TABLE Experiencia_Professor (
    id_professor INT NOT NULL,
    id_experiencia INT NOT NULL,
    PRIMARY KEY (id_professor, id_experiencia)
);

-- Relaciona Oficina com Categorias (N:N)
CREATE TABLE Oficina_Categorias (
    id_oficina INT NOT NULL,
    id_categoria INT NOT NULL,
    PRIMARY KEY (id_oficina, id_categoria)
);

-- Marca oficinas favoritas de um aluno
CREATE TABLE FavoritoOficina (
    id_favorito SERIAL PRIMARY KEY,
    dataFavoritado DATE,
    id_oficina INT NOT NULL,
    id_aluno INT NOT NULL
);

-- Marca professores favoritos de um aluno
CREATE TABLE FavoritoProfessor (
    id_favorito SERIAL PRIMARY KEY,
    dataFavoritado DATE,
    id_professor INT NOT NULL,
    id_aluno INT NOT NULL
);

-- Representa a matrícula do aluno em uma oficina
CREATE TABLE ListaMatricula (
    id_matricula SERIAL PRIMARY KEY,
    data_entrada DATE NOT NULL,
    presenca BOOLEAN,
    id_aluno INT NOT NULL,
    id_oficina INT NOT NULL
);

-- Histórico de participação com certificado
CREATE TABLE HistoricoParticipacao (
    id_historico SERIAL PRIMARY KEY,
    id_certificado INT,
    id_aluno INT NOT NULL,
    id_oficina INT NOT NULL
);
-- Relacionamentos de Oficina
ALTER TABLE Oficina
ADD CONSTRAINT fk_oficina_professor FOREIGN KEY (id_professor) REFERENCES Professor(id_professor);

-- Relacionamentos de Aula
ALTER TABLE Aula
ADD CONSTRAINT fk_aula_oficina FOREIGN KEY (id_oficina) REFERENCES Oficina(id_oficina);

-- Relacionamentos de Avaliacao
ALTER TABLE Avaliacao
ADD CONSTRAINT fk_avaliacao_aluno FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno),
ADD CONSTRAINT fk_avaliacao_oficina FOREIGN KEY (id_oficina) REFERENCES Oficina(id_oficina);

-- Relacionamentos de Formacao_Professor
ALTER TABLE Formacao_Professor
ADD CONSTRAINT fk_fp_professor FOREIGN KEY (id_professor) REFERENCES Professor(id_professor),
ADD CONSTRAINT fk_fp_formacao FOREIGN KEY (id_formacao) REFERENCES Formacao(id_formacao);

-- Relacionamentos de Experiencia_Professor
ALTER TABLE Experiencia_Professor
ADD CONSTRAINT fk_ep_professor FOREIGN KEY (id_professor) REFERENCES Professor(id_professor),
ADD CONSTRAINT fk_ep_experiencia FOREIGN KEY (id_experiencia) REFERENCES Experiencia(id_experiencia);

-- Relacionamentos de Oficina_Categorias
ALTER TABLE Oficina_Categorias
ADD CONSTRAINT fk_oc_oficina FOREIGN KEY (id_oficina) REFERENCES Oficina(id_oficina),
ADD CONSTRAINT fk_oc_categoria FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria);

-- Relacionamentos de FavoritoOficina
ALTER TABLE FavoritoOficina
ADD CONSTRAINT fk_fav_oficina FOREIGN KEY (id_oficina) REFERENCES Oficina(id_oficina),
ADD CONSTRAINT fk_fav_oficina_aluno FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno);

-- Relacionamentos de FavoritoProfessor
ALTER TABLE FavoritoProfessor
ADD CONSTRAINT fk_fav_professor FOREIGN KEY (id_professor) REFERENCES Professor(id_professor),
ADD CONSTRAINT fk_fav_professor_aluno FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno);

-- Relacionamentos de ListaMatricula
ALTER TABLE ListaMatricula
ADD CONSTRAINT fk_matricula_aluno FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno),
ADD CONSTRAINT fk_matricula_oficina FOREIGN KEY (id_oficina) REFERENCES Oficina(id_oficina);

-- Relacionamentos de HistoricoParticipacao
ALTER TABLE HistoricoParticipacao
ADD CONSTRAINT fk_hist_cert FOREIGN KEY (id_certificado) REFERENCES Certificado(id_certificado),
ADD CONSTRAINT fk_hist_aluno FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno),
ADD CONSTRAINT fk_hist_oficina FOREIGN KEY (id_oficina) REFERENCES Oficina(id_oficina);
