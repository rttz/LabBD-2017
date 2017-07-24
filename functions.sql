DELIMITER //
create FUNCTION ConsultaIdRelacionadoF (consultaId char(11)) RETURNS INT

BEGIN
DECLARE mostraId INT;
    SELECT idRelacionado into mostraId
    FROM Familiar
    WHERE cpfFamiliar = consultaId;
    
    return mostraId;
END
DELIMITER ;


DELIMITER //
create FUNCTION ConsultaIdRelacionadoNF (consultaId char(11)) RETURNS INT

BEGIN
DECLARE mostraId INT;
    SELECT idRelacionado into mostraId
    FROM NaoFamiliar
    WHERE cpfNFamiliar = consultaId;
    
    return mostraId;
END
DELIMITER ;


DELIMITER //

    INSERT INTO Familiar VALUES (idRelacionado, CPFp, CPFf,relacao, dadosMedicos);
    RETURN 'O familiar foi adicionado com sucesso.';
            
END//
DELIMITER ;


DELIMITER //
CREATE FUNCTION f_insereNFamiliar ( idRelacionado int,CPFf varchar(11), CPFp varchar(11),relacao varchar(30)) 	
RETURNS char(60)

BEGIN
	DECLARE verifica int;
	SELECT COUNT(*) INTO verifica FROM Pessoa WHERE CPFf = Pessoa.cpf;
   	IF (verifica = 0) THEN
		RETURN 'Nao existe pessoa cadastrada com esse CPF.';
    END IF;
        
	SELECT COUNT(*) INTO verifica FROM Pessoa WHERE CPFp = Pessoa.cpf;
    IF (verifica = 0) THEN
		RETURN 'Nao existe paciente cadastrado com esse CPF.';
    END IF; 
        
    INSERT INTO naoFamiliar VALUES (idRelacionado, CPFf, CPFp,relacao);
        
    RETURN 'O nao familiar foi adicionado com sucesso.';
            
END //
DELIMITER ;


DELIMITER //
CREATE FUNCTION mostraFamiliares (cpfPac char(11)) 	RETURNS char(60)
BEGIN
DECLARE aux varchar(20);

SELECT CONCAT (Pessoa.prNome,Pessoa.sobrenome) into aux
FROM Familiar, Pessoa
Where Familiar.cpfPaciente = cpfPac AND Familiar.cpfFamiliar = Pessoa.cpf;

RETURN aux;
END //
DELIMITER ;


DELIMITER //
CREATE FUNCTION mostraNFamiliares (cpfPac char(11)) 	RETURNS char(60)
BEGIN
DECLARE aux varchar(20);

SELECT CONCAT (Pessoa.prNome,Pessoa.sobrenome) into aux
FROM NaoFamiliar, Pessoa
Where NaoFamiliar.cpfPaciente = cpfPac AND NaoFamiliar.cpfNFamiliar = Pessoa.cpf;

RETURN aux;
END //
DELIMITER ; 


DELIMITER $$
create FUNCTION Busca_ID_Informal (aux char(11)) RETURNS INT

BEGIN
DECLARE mostrador_ID INT;
    SELECT idCuidador INTO mostrador_ID
    FROM Informal
    WHERE cpf = aux;
    
    return mostrador_ID;
END;
DELIMITER ; 


DELIMITER $$
CREATE FUNCTION getEmailMedico (crm CHAR(11))
    RETURNS VARCHAR(30)
BEGIN
    DECLARE selectedEmail VARCHAR(30);

    SELECT email
    INTO selectedEmail
    FROM Medico
    WHERE Medico.crm = crm;

    RETURN selectedEmail;
END$$
DELIMETER ;


DELIMITER $$
CREATE FUNCTION getMedicosAnamnese (idAnamense INTEGER)
    RETURNS INTEGER
BEGIN
    DECLARE qtde INTEGER;

    SELECT COUNT(crm)
    INTO selectedMedico
    FROM Edita
    WHERE Edita.idAnamnese = idAnamnese;

    RETURN qtde;
END$$
DELIMITER ;


CREATE FUNCTION totalMensal(fcpf CHAR(11)) RETURNS float
	BEGIN
		DECLARE
			total float;

		SELECT sum(valor) 
        into total
        FROM Vinculado 
        WHERE Vinculado.cpf = fcpf;
        return total;
	END$$