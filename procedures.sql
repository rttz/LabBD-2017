DELIMITER $$
CREATE PROCEDURE insere_cuidaCompleto (IN p_cpf CHAR(11),IN p_idCuidador INTEGER,IN p_periodicidade CHAR(20),
IN p_local_cuida CHAR(20),
IN p_inicio TIME, IN p_termino TIME,IN p_descricao CHAR(250))
BEGIN 
INSERT INTO Cuida (cpf,idCuidador, periodicidade,local_cuida) VALUES (p_cpf, p_idCuidador, p_periodicidade,p_local_cuida);
INSERT INTO HorarioCuida (cpf, idCuidador, inicio, termino) VALUES (p_cpf, p_idCuidador, p_inicio, p_termino);
INSERT INTO IntercorrenciaCuida (cpf, idCuidador, descricao) VALUES (p_cpf, p_idCuidador, p_descricao);
END;


DELIMITER $$
CREATE PROCEDURE delete_cuidaCompleto (IN p_cpf CHAR(11),IN p_idCuidador INTEGER)
BEGIN
DELETE FROM Cuida WHERE Cuida.cpf = p_cpf AND Cuida.idCuidador = p_idCuidador;
DELETE FROM IntercorrenciaCuida WHERE IntercorrenciaCuida.cpf = p_cpf AND IntercorrenciaCuida.idCuidador = p_idCuidador;
DELETE FROM HorarioCuida WHERE HorarioCuida.cpf = p_cpf AND HorarioCuida.idCuidador = p_idCuidador;
END;


DELIMITER $$
CREATE PROCEDURE insert_atendimentoMedico (IN pcd_crm VARCHAR(11), IN pcd_especialidade VARCHAR(20), IN pcd_cpf CHAR(11), IN pcd_prNome CHAR(30),IN pcd_sobrenome VARCHAR(30),
IN pcd_dia DATE, IN pcd_hora TIME, IN pcd_estado VARCHAR(15), IN pcd_nomeClinica VARCHAR(30), IN pcd_logradouro VARCHAR(30), IN pcd_cidade VARCHAR(25),
IN pcd_bairro VARCHAR(20), IN pcdp_cep CHAR(11), IN pcdp_rua VARCHAR(50), IN pcdp_numero INTEGER, IN pcdp_cidade VARCHAR(30), IN pcdp_estado VARCHAR(20))
BEGIN
INSERT INTO Pessoa (cpf, prNome, sobrenome, cep, rua, numero, cidadePessoa, estadoPessoa) VALUES (pcd_cpf, pcd_prNome, pcd_sobrenome, pcdp_cep, pcdp_rua, pcdp_numero, pcdp_cidade, pcdp_estado);
INSERT INTO Medico (cpf, crm, especialidade) VALUES (pcd_cpf, pcd_crm, pcd_especialidade);
INSERT INTO Paciente (cpf) VALUES (pcd_cpf);
INSERT INTO Atendimento(dia, hora, cpf, crm, estado, nomeClinica, logradouro, cidade, bairro) VALUES (pcd_dia, pcd_hora, pcd_cpf, pcd_crm, pcd_estado, pcd_nomeClinica,
pcd_logradouro, pcd_cidade, pcd_bairro);
END;


DELIMITER $$
CREATE PROCEDURE delete_atendimentoMedico (IN pcd_cpf CHAR(11),IN pcd_crm CHAR(11))
BEGIN
DELETE FROM Atendimento WHERE Atendimento.cpf = pcd_cpf AND Atendimento.crm = pcd_crm; 
DELETE FROM Paciente WHERE Paciente.cpf = pcd_cpf;
DELETE FROM Medico WHERE Medico.cpf = pcd_cpf AND  Medico.crm = pcd_crm;
DELETE FROM Pessoa WHERE Pessoa.cpf = pcd_cpf;
END;


DELIMITER %%
CREATE PROCEDURE DadosExame (cpf CHAR(11))
BEGIN
IF (!cpf) THEN
	SELECT Exame.responsavel, Exame.endereco, Exame.tipo, Exame.resultado, Exame.email, Exame.telefone, Exame.dia, Exame.hora
	FROM Exame, Atendimento, Paciente
	WHERE Exame.dia = Atendimento.dia AND Exame.hora = Atendimento.hora AND Atendimento.cpf = Paciente.cpf;
END IF;
END;


DELIMITER $$
DROP PROCEDURE IF EXISTS `insere_HorarioCuida` $$

CREATE PROCEDURE insere_HorarioCuida (IN i_cpf CHAR(11), IN i_idCuidador INTEGER, IN i_horarioNro INTEGER, IN i_inicio TIME,IN i_termino TIME)
BEGIN 
INSERT INTO HorarioCuida (cpf, idCuidador, horarioNro, inicio,termino) VALUES (i_cpf, i_idCuidador, i_horarioNro, i_inicio, i_termino);
END;

call insere_HorarioCuida('11122233344','1','2','01:00:00', '02:00:00');


DELIMITER $$
DROP PROCEDURE IF EXISTS `insere_IntercorrenciaCuida` $$

CREATE PROCEDURE insere_IntercorrenciaCuida (IN i_cpf CHAR(11), IN i_idCuidador INTEGER, IN i_intercorrenciaNro INTEGER, IN i_descricao CHAR(11))
BEGIN 
INSERT INTO IntercorrenciaCuida (cpf, idCuidador, intercorrenciaNro, descricao,) VALUES (i_cpf, i_idCuidador, i_intercorrenciaNro, i_descricao);
END;

call insere_IntercorrenciaCuida('38622244411','2','321', 'febre');

DELIMITER $$
DROP PROCEDURE IF EXISTS `c_Id` $$

create PROCEDURE c_Id (consultaId INTEGER) 

BEGIN
    SELECT descricao
    FROM IntercorrenciaCuida
    WHERE intercorrenciaNro = consultaId;
END


CREATE PROCEDURE insere_Medicamentos (IN med_codigoConsulta INTEGER, IN med_dia DATE, IN med_hora TIME, IN med_posologia VARCHAR(50), IN med_dataCompra DATE)
	BEGIN
    	INSERT INTO Medicamento(codigoConsulta, dia, hora, posologia, dataCompra) VALUES (med_codigoConsulta, med_dia, med_hora, med_posologia, med_dataCompra);
	END;


CREATE PROCEDURE todasConsultPac(cpf_pac varchar2)
IS
	CURSOR consultPac (cpf_pac in varchar2) IS
     	SELECT cpf
     	FROM Paciente
     	WHERE cpf = cpf_pac;
	result_cpf Paciente.cpf %type;
BEGIN
	OPEN consultPac (cpf_pac);
	FETCH consultPac INTO result_cpf;
	WHILE consultPac %found LOOP
    	FETCH consultPac INTO result_cpf;
	END LOOP;
	dbms_output.put_line('Paciente = '|| cpf_pac ||' efetuou '||
    	to_char(consultPac %rowcount) ||' consultas');
	CLOSE consultPac;
END;
/


DELIMITER $$
CREATE PROCEDURE Informal_As_Paciente (IN p_cpf CHAR(11))
SELECT Informal.idCuidador, Informal.cpf 
FROM Informal, Paciente 
WHERE Informal.cpf = Paciente.cpf;
END;


DELIMITER $$ 
CREATE PROCEDURE Informal_As_Familiar (IN p_cpf CHAR(11))
SELECT Informal.idCuidador, Informal.cpf 
FROM Informal, Familiar 
WHERE Informal.cpf = Familiar.cpf; 
END;


delimiter $$
CREATE PROCEDURE InsereAnmneseComPerguntas (IN a_idAnamnese INTEGER, IN a_dataAlteracao DATE, IN a_tipoSanguineo CHAR(3), IN a_historicoDoencas VARCHAR(100), IN a_pergunta VARCHAR(50), IN a_resposta VARCHAR(150), IN a_nomeInterrogador VARCHAR(30)  )
BEGIN
	INSERT INTO Anamnese (idAnamnese, dataAlteracao, tipoSanguineo, historicoDoencas, pergunta, resposta, nomeInterrogador) VALUES (a_idAnamnese, a_dataAlteracao, a_tipoSanguineo, a_historicoDoencas);
	INSERT INTO Questoes (idAnmnese, pergunta, resposta, nomeInterrogador ) VALUES (a_idAnamnese, a_pergunta, a_resposta, a_nomeInterrogador);
END;


delimiter %%

CREATE PROCEDURE DeleteAnmneseComPerguntas (IN a_idAnamnese INTEGER)
BEGIN
	DELETE FROM Anamnese WHERE idAnamnese = a_idAnamnese;
	DELETE FROM Questao WHERE idAnamnese = a_idAnamnese;
END;


DELIMITER $$
CREATE PROCEDURE insertMedico (
    cpfParam CHAR(11),
    prNomeParam VARCHAR (30),
    sobrenomeParam VARCHAR(30),
    cepParam CHAR(11),
    ruaParam VARCHAR(50),
    numeroParam INTEGER,
    cidadeParam VARCHAR (30),
    estadoParam VARCHAR (20),
    comercialParam CHAR(14),
    fixoParam CHAR(14),
    celularParam CHAR(14),
    whatsappParam CHAR(14),
    crmParam VARCHAR(11),
    especialidadeParam VARCHAR(20),
    emailParam VARCHAR(30),
    paginaWebParam VARCHAR(30))
BEGIN
    INSERT INTO Pessoa (cpf, prNome, sobrenome, cep, rua, numero, cidade, estado, comercial, fixo, celular, whatsapp)
        VALUES (cpfParam, prNomeParam, sobrenomeParam, cepParam, ruaParam, numeroParam, cidadeParam, estadoParam, comercialParam, fixoParam, celularParam, whatsappParam);

    INSERT INTO Medico (cpf, crm, especialidade, email, paginaWeb)
        VALUES (cpfParam, crmParam, especialidadeParam, emailParam, paginaWebParam);
END$$
DELIMETER ;

DELIMITER $$
CREATE PROCEDURE insertEdicao (
    crmParam VARCHAR(11),
    cpfParam CHAR(11),
    idAnamneseParam INTEGER)
BEGIN
    INSERT INTO Edita (crm, cpf, idAnamnese)
        VALUES (crmParam, cpfParam, idAnamneseParam);
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS novo_plano$$
CREATE PROCEDURE novo_plano(cnpj CHAR(14), nome CHAR(30), lugar CHAR(30), tipo CHAR(20), tel CHAR(20))
	BEGIN
		INSERT INTO PlanoDeSaude
        VALUES (cnpj, nome, lugar, tipo, tel);
END$$

DROP PROCEDURE IF EXISTS novo_servico$$
CREATE PROCEDURE novo_servico(cnpj CHAR(14), tipo VARCHAR(20), carencia CHAR(10), valoratual FLOAT, valorcontratado FLOAT)
	BEGIN
		INSERT INTO Servicos(cnpj, idServico, tipo, carencia, valorAtual,valorContratado)
        VALUES (pcnpj, NULL, ptipo, STR_TO_DATE(pcarencia, "%d/%m/%Y"), pvaloratual, pvalorcontratado);
	END$$


DROP PROCEDURE IF EXISTS atualizaValorServico$$
CREATE PROCEDURE atualizaValorServico(pcnpj CHAR(14), pid INTEGER, pvalor FLOAT, pvalorcontratado FLOAT)
	BEGIN
		
		UPDATE Servicos
        SET Servicos.valorAtual = pvalor, Servicos.valorContratado = pvalorcontratado
        WHERE Servicos.idServico = pid AND Servicos.cnpj = pcnpj;
	END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS novo_vinculo;
DROP PROCEDURE IF EXISTS novo_servico;


DELIMITER $$
CREATE PROCEDURE novo_vinculo(cpf CHAR(11), cnpj CHAR(14), valor FLOAT, dataValor CHAR(10), dataContrato CHAR(10),
								cobertura VARCHAR(100))
	BEGIN
		INSERT INTO Vinculado
        VALUES (cpf, cnpj, valor, STR_TO_DATE(dataValor, "%d/%m/%Y"), 
				STR_TO_DATE(dataContrato, "%d/%m/%Y" ), cobertura);
	END$$

CREATE PROCEDURE mostra_planos_contratados(IN pcnpj CHAR(14), OUT pcpf CHAR(11), OUT pvalor FLOAT, OUT pdataValor date,
											OUT pdataContrato DATE, OUT pcobertura VARCHAR(100))
	BEGIN
		SELECT cpf,
			   valor,
               dataValor,
               dataContrato,
               cobertura
		INTO pcpf,
			 pvalor,
             pdatavalor,
             pdatacontrato,
             pcobertura
		FROM Vinculado
		WHERE Vinculado.cnpj = pcnpj;
    END$$

CREATE PROCEDURE deletaVinculo(pcpf CHAR(11), pcnpj CHAR(14))
	BEGIN
		DELETE FROM Vinculado WHERE Vinculado.cpf = pcpf AND Vinculado.cnpj = pcnpj;
	END$$

CREATE PROCEDURE atualizaValorVinculado(pcpf char(11), pcnpj char(14), pvalor FLOAT)
	BEGIN
		UPDATE Vinculado 
        SET Vinculado.valor = pvalor
        WHERE Vinculado.cpf = pcpf AND Vinculado.cnpj = pcnpj;
	END$$
    
CREATE PROCEDURE atualizaContratoVinculo(pcnpj CHAR(14), pcpf CHAR(11), pValor FLOAT, pdataValor CHAR(10),
										pdataContrato CHAR(10), pcobertura VARCHAR(100))
	BEGIN
		UPDATE Vinculado
        SET vinculado.valor = pvalor, vinculado.datavalor = STR_TO_DATE(pdataValor, "%d/%m/%Y"),
			vinculado.datacontrato = STR_TO_DATE(pdatacontrato, "%d/%m/%Y"), vinculado.cobertura = pcobertura
		WHERE vinculado.cnpj = pcnpj AND Vinculado.cpf = pcpf;
	END$$
DELIMITER $$


DELIMITER $$
CREATE PROCEDURE insertAltera (
	idAnamnese INTEGER NOT NULL,
	codigoCategoria INTEGER NOT NULL,
)
BEGIN
	INSERT INTO AlteraAnamnese (idAnamnese, codigoCategoria)
    	VALUES (idAnamnese, codigoCategoria);
END$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE verificaConsang (cpf CHAR(11))
BEGIN
	IF (!EXISTS(SELECT 1 FROM Consanguineo WHERE cpf = NEW.cpf)) THEN
    	SIGNAL SQLSTATE VALUE '45000' SET MESSAGE_TEXT = 'Não é consanguineo';
  	END IF;
END;


DELIMITER $$
CREATE PROCEDURE deletaCuidador (IN cpf CHAR(11))
BEGIN
	DELETE FROM Cuidador WHERE Cuidador.cpf = cpf;
	DELETE FROM Pessoa WHERE Pessoa.cpf = cpf;
END;
DELIMITER;

CREATE PROCEDURE insere_ExamesSolicitados(IN `ex_codigo` INT, IN `ex_dia` DATE, IN `ex_hora` TIME, IN `ex_nomeExame` VARCHAR(30)) NOT DETERMINISTIC CONTAINS SQL SQL SECURITY DEFINER 
BEGIN 
INSERT INTO ExamesSolicitados(codigo, dia, hora,nomeExame) 
VALUES (ex_codigo, ex_dia, ex_hora, ex_nomeExame);
 END

DROP PROCEDURE IF EXISTS insereProfissional;

DELIMITER $$
CREATE PROCEDURE insereProfissional(
    cpfAux CHAR(11),
    prNomeAux VARCHAR (30),
    sobrenomeAux VARCHAR(30),
    cepAux CHAR(11),
    ruaAux VARCHAR(50),
    numeroAux INTEGER,
    cidadeAux VARCHAR (30),
    estadoAux VARCHAR (20),
    comercialAux CHAR(14),
    fixoAux CHAR(14),
    celularAux CHAR(14),
    whatsappAux CHAR(14),
    codigoCategoriaAux INTEGER,
    idCuidadorAux INTEGER,
    especialidadeAux VARCHAR(30))
BEGIN
    INSERT INTO Pessoa (cpf, prNome, sobrenome, cep, rua, numero, cidade, estado, comercial, fixo, celular, whatsapp)
        VALUES (cpfAux, prNomeAux, sobrenomeAux, cepAux, ruaAux, numeroAux, cidadeAux, estadoAux, comercialAux, fixoAux, celularAux, whatsappAux);

    INSERT INTO Profissional (codigoCategoria, idCuidador, cpf, especialidade)
        VALUES (codigoCategoriaAux, idCuidadorAux, cpfAux, especialidadeAux);
END$$


DROP PROCEDURE IF EXISTS deletaProfissional;

DELIMITER $$
CREATE PROCEDURE deletaProfissional (IN cpf CHAR(11), IN codigoCategoria INTEGER)
BEGIN
	DELETE FROM Profissional WHERE Profissional.cpf = cpf AND Profissional.codigoCategoria = codigoCategoria;
	DELETE FROM Pessoa WHERE Pessoa.cpf = cpf;
END;

DROP PROCEDURE IF EXISTS inserePaciente;

DELIMITER $$
CREATE PROCEDURE inserePaciente (
    cpfAux CHAR(11),
    prNomeAux VARCHAR (30),
    sobrenomeAux VARCHAR(30),
    cepAux CHAR(11),
    ruaAux VARCHAR(50),
    numeroAux INTEGER,
    cidadeAux VARCHAR (30),
    estadoAux VARCHAR (20),
    comercialAux CHAR(14),
    fixoAux CHAR(14),
    celularAux CHAR(14),
    whatsappAux CHAR(14))
BEGIN
    INSERT INTO Pessoa (cpf, prNome, sobrenome, cep, rua, numero, cidade, estado, comercial, fixo, celular, whatsapp)
        VALUES (cpfAux, prNomeAux, sobrenomeAux, cepAux, ruaAux, numeroAux, cidadeAux, estadoAux, comercialAux, fixoAux, celularAux, whatsappAux);

    INSERT INTO Paciente (cpf)
        VALUES (cpfAux);
END$$


DROP PROCEDURE IF EXISTS deletaPaciente;

DELIMITER $$
CREATE PROCEDURE deletaPaciente (IN cpf CHAR(11))
BEGIN
	DELETE FROM Paciente WHERE Paciente.cpf = cpf;
	DELETE FROM Pessoa WHERE Pessoa.cpf = cpf;
END;


DROP PROCEDURE IF EXISTS insereConsanguineo;

DELIMITER $$
CREATE PROCEDURE insereConsanguineo (
    cpfAux CHAR(11),
    prNomeAux VARCHAR (30),
    sobrenomeAux VARCHAR(30),
    cepAux CHAR(11),
    ruaAux VARCHAR(50),
    numeroAux INTEGER,
    cidadeAux VARCHAR (30),
    estadoAux VARCHAR (20),
    comercialAux CHAR(14),
    fixoAux CHAR(14),
    celularAux CHAR(14),
    whatsappAux CHAR(14),
    idRelacionadoAux INTEGER,
    relacaoAux VARCHAR(30),
    dadosMedicosAux VARCHAR(60),
    idAnamneseAux INTEGER,
    parentescoAux VARCHAR(30),
    historicoAuxAux VARCHAR(50))
BEGIN
    INSERT INTO Pessoa (cpf, prNome, sobrenome, cep, rua, numero, cidade, estado, comercial, fixo, celular, whatsapp)
        VALUES (cpfAux, prNomeAux, sobrenomeAux, cepAux, ruaAux, numeroAux, cidadeAux, estadoAux, comercialAux, fixoAux, celularAux, whatsappAux);

    INSERT INTO Familiar (idRelacionado, cpfFamiliar, cpfPaciente, relacao, dadosMedicos)
    	VALUES (idRelacionadoAux, cpfAux, cpfAux, relacaoAux, dadosMedicos);

    INSERT INTO Consanguineo (idAnamnese, idRelacionado, dadosMedicos, parentesco, historico)
    	VALUES (idAnamneseAux);
END$$


DELIMITER $$
CREATE PROCEDURE deletaConsanguineo (IN cpf CHAR(11), IN idAnamnese INTEGER, IN idRelacionado INTEGER)
BEGIN
	DELETE FROM Consanguineo WHERE Consanguineo.idAnamnese = idAnamnese AND Consanguineo.idRelacionado = idRelacionado;
	DELETE FROM Familiar WHERE Familiar.idRelacionado = idRelacionado AND Familiar.cpfFamiliar = cpf;
	DELETE FROM Pessoa WHERE Pessoa.cpf = cpf;
END$$


CREATE PROCEDURE `insere_NaoConsanguineo`(IN `nc_cpf` CHAR(11), IN `nc_idRelacionado` INT, IN `nc_dadosMedicos` VARCHAR(60), IN `nc_parentesco` VARCHAR(30)) NOT DETERMINISTIC NO SQL SQL SECURITY DEFINER 
BEGIN 
INSERT into NaoConsanguineo(cpf,idRelacionado,dadosMedicos,parentesco) 
VALUES (nc_cpf,nc_idRelacionado,nc_dadosMedicos,nc_parentesco); 
end


CREATE PROCEDURE cur_CuidPacientes (IN cpf_pac CHAR(12))
BEGIN
  DECLARE paciente_cpf CHAR(12);
  DECLARE cuidador_id INTEGER;
  DECLARE cpf_resultado INTEGER;

  DECLARE cuidaPac CURSOR FOR SELECT cpf FROM Paciente, Cuidador WHERE Paciente.cpf = paciente_cpf AND Cuidador.idCuidador = cuidador_id;
  
  SET paciente_cpf = cpf_pac;

  OPEN paciente;
  	
  	FETCH paciente INTO cpf_resultado;
    
	WHILE sem_resultado = 0 DO
    	FETCH paciente
    	INTO cpf_resultado;
	END WHILE;

	SELECT (CONCAT('Paciente = ', IFNULL(cpf_pac, ''), ' possui ', IFNULL(to_char(paciente % rowcount), ''),' cuidadores'));
  
  CLOSE consultpac;
END

ELIMITER $$
CREATE PROCEDURE insertAtedimento ( IN n_dia DATE, IN n_hora TIME, IN n_cpf CHAR(11), IN n_crm VARCHAR(11), IN n_estado VARCHAR (15), IN n_nomeClinica VARCHAR(30),
IN n_logradouro  VARCHAR(30), IN n_cidade VARCHAR(25), IN n_bairro VARCHAR(20))
BEGIN
INSERT INTO Atendimento(dia, hora, cpf, crm, estado, nomeClinica, logradouro, cidade, bairro)
VALUES (n_dia, n_hora, n_cpf, n_crm, n_nomeClinica, n_logradouro, n_cidade, n_bairro);
END;

DELIMITER $$
CREATE PROCEDURE atualizaAtendimento ( IN a_dia DATE, IN a_hora TIME, IN a_cpf CHAR(11), IN a_crm VARCHAR(11), IN a_estado VARCHAR (15), IN a_nomeClinica VARCHAR(30),
IN a_logradouro  VARCHAR(30), IN a_cidade VARCHAR(25), IN a_bairro VARCHAR(20))
BEGIN
UPDATE Atendimento
SET Atendimento.dia = a_dia, Atendimento.hora = a_hora, Atendimento.cpf = a_cpf, Atendimento.crm = a_crm, Atendimento.estado = a_estado, Atendimento.nomeClinica = a_nomeClinica,
Atendimento.logradouro = a_logradouro, Atendimento.cidade = a_cidade, Atendimento.bairro = a_bairro;
END;
