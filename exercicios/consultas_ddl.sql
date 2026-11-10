CREATE TABLE pessoa (
  cpf CHAR(11) PRIMARY KEY,
  email VARCHAR(50) NOT NULL,
  nome VARCHAR(150) NOT NULL,
  data_nasc DATE NOT NULL,
  endereco VARCHAR(300) NOT NULL,
  telefone VARCHAR(15),
  UNIQUE (email, nome)
);

CREATE TABLE paciente (
  codigo INT PRIMARY KEY,
  cpf CHAR(11) NOT NULL REFERENCES pessoa(cpf),
  senha VARCHAR(10) NOT NULL,
  plano_saude BOOLEAN NOT NULL
);

CREATE TABLE medico (
  crm VARCHAR(10) PRIMARY KEY,
  cpf CHAR(11) NOT NULL REFERENCES pessoa(cpf)
);

CREATE TABLE especialidade (
  id INT PRIMARY KEY,
  descricao VARCHAR(100) NOT NULL
);

CREATE TABLE medico_especialidade (
  crm VARCHAR(10) REFERENCES medico(crm),
  id_especialidade INT REFERENCES especialidade(id),
  PRIMARY KEY (crm, id_especialidade)
);

CREATE TABLE agendamento (
  codigo_paciente INT REFERENCES paciente(codigo),
  crm VARCHAR(10) REFERENCES medico(crm),
  dt_consulta TIMESTAMP,
  dt_agendamento TIMESTAMP NOT NULL,
  valor_consulta NUMERIC(8,2) NOT NULL,
  PRIMARY KEY (codigo_paciente, crm, dt_consulta)
);