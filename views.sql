CREATE VIEW cuidaCompleto as
SELECT Cuida.cpf,Cuida.idCuidador,periodicidade,
local_cuida, horarioNro,
inicio, termino,descricao
FROM Cuida, HorarioCuida, IntercorrenciaCuida
WHERE Cuida.cpf = IntercorrenciaCuida.cpf AND Cuida.cpf = HorarioCuida.cpf AND 
Cuida.idCuidador = IntercorrenciaCuida.idCuidador AND Cuida.idCuidador = HorarioCuida.idCuidador;


CREATE VIEW viewAtendimentomedico as 
SELECT Atendimento.crm, Medico.especialidade, Pessoa.prNome, Pessoa.sobrenome, Atendimento.cpf, dia, hora, Atendimento.estado,
nomeClinica, Atendimento.logradouro, Atendimento.cidade, Atendimento.bairro
FROM Pessoa, Medico, Paciente, Atendimento
WHERE Atendimento.cpf = Paciente.cpf AND Paciente.cpf = Pessoa.cpf AND Atendimento.crm = Medico.crm AND Medico.cpf = Pessoa.cpf;


CREATE VIEW viewInsere_Atendimentomedico as 
SELECT Atendimento.crm, Medico.especialidade, Atendimento.cpf, Pessoa.prNome, Pessoa.sobrenome, dia, hora, Atendimento.estado,
nomeClinica, Atendimento.logradouro, Atendimento.cidade, Atendimento.bairro, Pessoa.cep, Pessoa.rua, Pessoa.numero, Pessoa.cidade as cidadePessoa, Pessoa.estado as estadoPessoa
FROM Pessoa, Medico, Paciente, Atendimento
WHERE Atendimento.cpf = Paciente.cpf AND Paciente.cpf = Pessoa.cpf AND Atendimento.crm = Medico.crm AND Medico.cpf = Pessoa.cpf;


CREATE VIEW ConsultasMedicam AS
	SELECT Consulta.codigo, Consulta.dia, Consulta.hora, Medicamento.codigo AS CodMedicam
	FROM Consulta, Medicamento
	WHERE Consulta.dia = Medicamento.dia AND Consulta.hora = Medicamento.hora
	GROUP BY Consulta.dia;

CREATE VIEW v_infoFamiliar AS 
SELECT f.cpfFamiliar, f.idRelacionado,f.relacao, pe.prNome, pe.sobrenome  
FROM Familiar f INNER JOIN Pessoa pe ON f.cpfFamiliar = pe.cpf 

CREATE VIEW v_idRelacionadoFamiliar AS 
SELECT f.cpfFamiliar, f.idRelacionado 
FROM Familiar f
INNER JOIN Pessoa pe ON f.cpfFamiliar = pe.cpf 

CREATE VIEW v_infoNFamiliar AS 
SELECT nf.cpfNFamiliar, nf.idRelacionado, nf.relacao, pe.prNome, pe.sobrenome 
FROM NaoFamiliar nf
INNER JOIN Pessoa pe ON nf.cpfNFamiliar = pe.cpf 

CREATE VIEW v_idRelacionadoNF AS 
SELECT nf.cpfNFamiliar, nf.idRelacionado 
FROM NaoFamiliar nf
INNER JOIN Pessoa pe ON nf.cpfNFamiliar = pe.cpf 


CREATE view dados_Informal AS 
SELECT idCuidador, cpf, funcao 
FROM Informal


CREATE VIEW PacienteAnamneseCompleta AS SELECT
pa.cpf, p.prNome ,p.sobrenome, tipoSanguineo, historicoDoencas ,pergunta, resposta, nomeInterrogador 
FROM Pessoa p , Paciente pa ,Anamnese a, Questoes q
WHERE (a.idAnamnese = q.idAnamnese) 
AND (p.cpf = pa.cpf );


CREATE VIEW AnmneseComPerguntas AS SELECT
a.idAnamnese, tipoSanguineo, historicoDoencas, pergunta, resposta, nomeInterrogador
FROM Anamnese a, Questoes q
WHERE (a.idAnamnese = q.idAnamnese);


CREATE VIEW View_examesSolicitados
AS select codigo as 'IDExame', 
nomeExame as 'Exame', 
dia as 'dia' ,
hora as 'hora'
from ExamesSolicitados
order by nomeExame


CREATE VIEW medicosView AS
SELECT Pessoa.prNome, Pessoa.sobrenome, Medico.especialidade, Medico.crm, Medico.email
FROM Medico
INNER JOIN Pessoa ON Medico.cpf = Pessoa.cpf
ORDER BY Medico.especialidade, Pessoa.prNome;


CREATE VIEW editaAnamneseView AS
SELECT cpf, crm
FROM Edita
ORDER BY cpf;


DROP VIEW if exists vPlanoServico;
CREATE VIEW vPlanoServico (cnpj, tipoServico, valorAtualServico, nomePlano, tipoPlano) AS(
	SELECT s.cnpj, s.tipo, s.valorAtual, ps.nome, ps.tipoplano 
    FROM servicos s, PlanodeSaude ps
    WHERE  ps.CNPJ = s.cnpj 
    ORDER BY s.cnpj
);


DELIMITER $$


DROP VIEW if exists vPlanoPaciente;

CREATE VIEW vPlanoPaciente AS(
	SELECT v.cpf, p.prNome, p.sobrenome, p.fixo, ps.tipoPlano, v.cobertura
    FROM Pessoa p, planodesaude ps, Vinculado v
    WHERE p.cpf = v.cpf and ps.CNPJ = v.cnpj 
    GROUP BY p.prNome, ps.nome
);


CREATE VIEW v_ConsangInfo AS 
	SELECT C.idAnamnese, C.idRelacionado, C.dadosMedicos, C.parentesco, C.historico 
	FROM Consanguineo C 
	INNER JOIN Familiar F ON C.idRelacionado = F.idRelacionado;

CREATE VIEW v_Profissional AS
	SELECT Pessoa.prNome, Pessoa.sobrenome, Profissional.codigoCategoria, Profissional.idCuidador, Profissional.cpf, Profissional.especialidade 
	FROM Profissional
	INNER JOIN Pessoa ON Profissional.cpf = Pessoa.cpf
	ORDER BY Profissional.especialidade, Pessoa.prNome;

CREATE VIEW v_Paciente AS
	SELECT Pessoa.prNome, Pessoa.sobrenome, Paciente.cpf
	FROM Paciente
	INNER JOIN Pessoa ON Paciente.cpf = Pessoa.cpf
	ORDER BY Paciente.cpf, Pessoa.prNome;


DELIMITER $$
CREATE VIEW pessoaCuidador AS
	SELECT *
	FROM Pessoa
	GROUP BY cpf
	UNION
    	SELECT *
    	FROM Cuidador
    	WHERE Cuidador.cpf = Pessoa.cpf;
DELIMITER ;


CREATE VIEW viewExame as 
SELECT Exame.nroExame, Exame.dia, Exame.hora, Exame.responsavel, Exame.endereco, Exame.tipo, Exame.telefone, Exame.resultado, Exame.email
FROM Exame, Atendimento, Paciente
WHERE Exame.dia = Atendimento.dia AND Exame.hora = Atendimento.hora AND Atendimento.cpf = Paciente.cpf;


CREATE VIEW View_NaoConsanguineo AS
SELECT * FROM `NaoConsanguineo`
ORDER BY NaoConsanguineo.parentesco
