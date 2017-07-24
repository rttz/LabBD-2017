/*********
Dropando tabelas
*********/

DROP TABLE Responde;
DROP TABLE Altera;
DROP TABLE Edita;
DROP TABLE Servicos;
DROP TABLE Vinculado;
DROP TABLE PlanoDeSaude;
DROP TABLE Questoes;
DROP TABLE AlteraAnamnese;
DROP TABLE NaoConsanguineo;
DROP TABLE Consanguineo;
DROP TABLE Anamnese;
DROP TABLE NaoFamiliar;
DROP TABLE Familiar;
DROP TABLE ExamesSolicitados;
DROP TABLE Medicamento;
DROP TABLE Consulta;
DROP TABLE Exame;
DROP TABLE Atendimento;
DROP TABLE Medico;
DROP TABLE IntercorrenciaCuida;
DROP TABLE HorarioCuida;
DROP TABLE Cuida;
DROP TABLE Informal;
DROP TABLE Profissional;
DROP TABLE Cuidador;
DROP TABLE Paciente;
DROP TABLE Pessoa; 

CREATE TABLE IF NOT EXISTS Pessoa ( 	
	cpf CHAR(11) NOT NULL,
	prNome VARCHAR (30) NOT NULL,
	sobrenome VARCHAR(30) NOT NULL,
	cep CHAR(11) NOT NULL,
	rua VARCHAR(50) NOT NULL,
	numero INTEGER NOT NULL,
	cidade VARCHAR (30) NOT NULL,
	estado VARCHAR (20) NOT NULL,
	comercial CHAR(14),
	fixo CHAR(14),
	celular CHAR(14),
	whatsapp CHAR(14),
	PRIMARY KEY (cpf)
);

CREATE TABLE IF NOT EXISTS Paciente (
	cpf CHAR(11) NOT NULL,
	FOREIGN KEY (cpf) REFERENCES Pessoa (cpf),
	PRIMARY KEY (cpf)
);

CREATE TABLE IF NOT EXISTS Cuidador (
	cpf CHAR(11) NOT NULL,
	idCuidador INTEGER NOT NULL auto_increment,
	numero VARCHAR(10),
	bairro VARCHAR(20),
	cep CHAR(8),
	cidade VARCHAR(30),
	estado VARCHAR(20),
	rua VARCHAR(50),
	FOREIGN KEY (cpf) REFERENCES Pessoa (cpf),
	CONSTRAINT pessoa UNIQUE(cpf),
	PRIMARY KEY (idCuidador)
);

CREATE TABLE IF NOT EXISTS Profissional (
	codigoCategoria INTEGER NOT NULL auto_increment,
	idCuidador INTEGER NOT NULL,
	cpf CHAR(11) NOT NULL,
	especialidade varchar(30) NOT NULL,
	FOREIGN KEY (idCuidador) REFERENCES Cuidador(idCuidador),
	CONSTRAINT cuidador UNIQUE(idCuidador),
	PRIMARY KEY (codigoCategoria)
);

CREATE TABLE IF NOT EXISTS Informal (
	idCuidador INTEGER NOT NULL,
	cpf CHAR(11) NOT NULL,
	funcao varchar(30) NOT NULL,
	FOREIGN KEY (idCuidador) REFERENCES Cuidador(idCuidador),
	CONSTRAINT cuidador UNIQUE(idCuidador),
	PRIMARY KEY (idCuidador)
);

CREATE TABLE IF NOT EXISTS Cuida (
	cpf CHAR(11) NOT NULL,
	idCuidador INTEGER NOT NULL,
	periodicidade CHAR(20),
	local CHAR(20),
	FOREIGN KEY (cpf) REFERENCES Paciente (cpf) ON DELETE CASCADE,
	FOREIGN KEY (idCuidador) REFERENCES Cuidador (idCuidador) ON DELETE CASCADE,
	PRIMARY KEY (cpf, idCuidador)
	
);

CREATE TABLE IF NOT EXISTS HorarioCuida (
	cpf CHAR(11) NOT NULL,
	idCuidador INTEGER NOT NULL,
	horarioNro INTEGER NOT NULL auto_increment,
	inicio TIME NOT NULL,
	termino TIME NOT NULL,
	FOREIGN KEY (cpf, idCuidador) REFERENCES Cuida (cpf, idCuidador) ON DELETE CASCADE,
	PRIMARY KEY (horarioNro)
);

CREATE TABLE IF NOT EXISTS IntercorrenciaCuida (
	cpf CHAR(11) NOT NULL,
	idCuidador INTEGER NOT NULL,
	intercorrenciaNro INTEGER NOT NULL auto_increment,
	descricao CHAR(250) NOT NULL,
	FOREIGN KEY (cpf, idCuidador) REFERENCES Cuida (cpf, idCuidador) ON DELETE CASCADE,
	PRIMARY KEY (intercorrenciaNro)
);

CREATE TABLE IF NOT EXISTS Medico (
	cpf CHAR(11) NOT NULL,
	crm VARCHAR(11) NOT NULL,
	especialidade VARCHAR(20),
	email VARCHAR(30),
	paginaWeb VARCHAR(30),
	FOREIGN KEY (cpf) REFERENCES Pessoa (cpf),
	CONSTRAINT pessoa UNIQUE(cpf),
	PRIMARY KEY (crm)
);

CREATE TABLE IF NOT EXISTS Atendimento (
	dia date NOT NULL,
	hora time NOT NULL,
	cpf CHAR(11) NOT NULL,
	crm VARCHAR(11) NOT NULL,
	estado varchar(15) NOT NULL,
	nomeClinica varchar(30) NOT NULL,
	logradouro varchar(30) NOT NULL,
	cidade varchar(25) NOT NULL,
	bairro varchar(20) NOT NULL,
	FOREIGN KEY (crm) REFERENCES Medico (crm),
	FOREIGN KEY (cpf) REFERENCES Paciente (cpf),
	PRIMARY KEY (dia, hora)
);

CREATE TABLE IF NOT EXISTS Exame (
	nroExame INTEGER NOT NULL auto_increment,
	dia date NOT NULL,
	hora time NOT NULL,
	responsavel varchar(30) NOT NULL,
	endereco varchar(25) NOT NULL,
	tipo varchar(15) NOT NULL,
	telefone varchar(15) NOT NULL,
	resultado varchar(50) NOT NULL,
	email varchar(30) NOT NULL,
	FOREIGN KEY (dia, hora) REFERENCES Atendimento(dia, hora),
	CONSTRAINT atendimento UNIQUE(dia, hora),
	PRIMARY KEY (nroExame)
);

CREATE TABLE IF NOT EXISTS Consulta (
	dia date NOT NULL,
	hora time NOT NULL,
	codigo INTEGER NOT NULL,
	FOREIGN KEY (dia, hora) REFERENCES Atendimento(dia, hora),
	CONSTRAINT atendimento UNIQUE(dia, hora),
	PRIMARY KEY (codigo)
);

CREATE TABLE IF NOT EXISTS Medicamento (
	codigo INTEGER NOT NULL auto_increment,
	codigoConsulta INTEGER NOT NULL,
	dia date NOT NULL,
	hora time NOT NULL,
	posologia varchar(50) NOT NULL,
	dataCompra date NOT NULL,
	FOREIGN KEY (codigoConsulta) REFERENCES Consulta (codigo),
	PRIMARY KEY (codigo)
);

CREATE TABLE IF NOT EXISTS ExamesSolicitados (
	dia date NOT NULL,
	hora time NOT NULL,
	codigo INTEGER NOT NULL,
	nomeExame varchar(30) NOT NULL,
	FOREIGN KEY (codigo) REFERENCES Consulta(codigo),
	PRIMARY KEY (codigo, nomeExame)
);

CREATE TABLE IF NOT EXISTS Familiar (
	idRelacionado INT NOT NULL,
	cpfFamiliar CHAR(11),
	cpfPaciente CHAR(11),
	relacao VARCHAR(30),
	dadosMedicos VARCHAR(60),
	PRIMARY KEY (idRelacionado),
	FOREIGN KEY (cpfFamiliar) REFERENCES Pessoa (cpf),
	FOREIGN KEY (cpfPaciente) REFERENCES Pessoa (cpf)
	
);

CREATE TABLE IF NOT EXISTS NaoFamiliar (
	idRelacionado INT NOT NULL,
	cpfNFamiliar CHAR(11) NOT NULL,
	cpfPaciente CHAR(11) NOT NULL,
	relacao VARCHAR(30),
	PRIMARY KEY (idRelacionado),
	FOREIGN KEY (cpfNFamiliar) REFERENCES Pessoa (cpf),
	FOREIGN KEY (cpfPaciente) REFERENCES Pessoa (cpf)
	
);


CREATE TABLE IF NOT EXISTS Anamnese (
	cpf CHAR(11) NOT NULL,
	idAnamnese INTEGER NOT NULL auto_increment,
	dataAlteracao DATE NOT NULL,
	tipoSanguineo CHAR(3) NOT NULL,
	historicoDoencas CHAR(100),
	FOREIGN KEY (cpf) REFERENCES Paciente (cpf),
	PRIMARY KEY (idAnamnese)
);

CREATE TABLE IF NOT EXISTS Consanguineo (
	idAnamnese INTEGER NOT NULL,
	idRelacionado INTEGER NOT NULL,
	dadosMedicos VARCHAR(60),
	parentesco VARCHAR(30) NOT NULL,
	historico VARCHAR(50) NOT NULL,
	FOREIGN KEY (idRelacionado) REFERENCES Familiar(idRelacionado),
	CONSTRAINT familiar UNIQUE(idRelacionado),
	FOREIGN KEY (idAnamnese) REFERENCES Anamnese (idAnamnese),
	PRIMARY KEY (idAnamnese, idRelacionado)
);

CREATE TABLE IF NOT EXISTS NaoConsanguineo (
	cpf CHAR(11) NOT NULL,
	idRelacionado INTEGER NOT NULL,
	dadosMedicos VARCHAR(60),
	parentesco VARCHAR(30) NOT NULL,
	FOREIGN KEY (cpf) REFERENCES Familiar(cpf),
	CONSTRAINT familiar UNIQUE(idRelacionado),
	PRIMARY KEY (idRelacionado)
);

CREATE TABLE IF NOT EXISTS AlteraAnamnese (
	idAnamnese INTEGER NOT NULL,
	codigoCategoria INTEGER NOT NULL,
	FOREIGN KEY (idAnamnese) REFERENCES Anamnese(idAnamnese),
	FOREIGN KEY (codigoCategoria) REFERENCES Profissional(codigoCategoria),
	PRIMARY KEY (idAnamnese, codigoCategoria)
);

CREATE TABLE IF NOT EXISTS Questoes (
	idAnamnese INTEGER NOT NULL,
	questaoNro INTEGER NOT NULL auto_increment,
	pergunta VARCHAR(150),
	resposta VARCHAR(150),
	nomeInterrogador VARCHAR(30),
	FOREIGN KEY  (idAnamnese) REFERENCES Anamnese (idAnamnese),
	PRIMARY KEY (questaoNro)
);

CREATE TABLE IF NOT EXISTS PlanoDeSaude (
	cnpj CHAR(14) NOT NULL,
	nome CHAR(30),
	local CHAR(30),
	tipoPlano CHAR(20),
	telfixoPlano CHAR(20),  
	PRIMARY KEY (cnpj)
);

CREATE TABLE IF NOT EXISTS Vinculado (
	cpf CHAR(11) NOT NULL,
	cnpj CHAR(14) NOT NULL,
	valor FLOAT NOT NULL,
	dataValor DATE NOT NULL,
	dataContrato DATE NOT NULL,
	cobertura VARCHAR(100),
	FOREIGN KEY (cpf) REFERENCES Paciente (cpf),
	FOREIGN KEY (cnpj) REFERENCES PlanoDeSaude (cnpj),
	PRIMARY KEY (cpf, cnpj)
);

CREATE TABLE IF NOT EXISTS Servicos (
	cnpj CHAR(14) NOT NULL,
	idServico INTEGER NOT NULL auto_increment,
	tipo VARCHAR(20) NOT NULL,
	carencia DATE NOT NULL,
	valorAtual FLOAT NOT NULL,
	valorContratado FLOAT NOT NULL,
	FOREIGN KEY (cnpj) REFERENCES PlanodeSaude (cnpj),
	PRIMARY KEY (idServico, cnpj)
);

CREATE TABLE IF NOT EXISTS Edita (
	crm VARCHAR(11) NOT NULL,
	cpf CHAR(11) NOT NULL,
	idAnamnese INTEGER NOT NULL,
	FOREIGN KEY (idAnamnese) REFERENCES Anamnese (idAnamnese),
	FOREIGN KEY (crm) REFERENCES Medico (crm),
	PRIMARY KEY (crm, idAnamnese)
);

CREATE TABLE IF NOT EXISTS Altera (
	idAnamnese INTEGER NOT NULL,
	codigoCategoria INTEGER NOT NULL,	
	FOREIGN KEY(codigoCategoria) REFERENCES Profissional (codigoCategoria),
	FOREIGN KEY(idAnamnese) REFERENCES Anamnese (idAnamnese),
	PRIMARY KEY(idAnamnese, codigoCategoria)
);

CREATE TABLE IF NOT EXISTS Responde (
	cpf CHAR(11) NOT NULL,
	idRelacionado INTEGER NOT NULL,
	FOREIGN KEY (cpf) REFERENCES Pessoa (cpf),
	FOREIGN KEY (idRelacionado) REFERENCES Familiar(idRelacionado),
	PRIMARY KEY (idRelacionado, cpf)
);