DELIMITER $$ 


CREATE TRIGGER `dataDisponivel` 
BEFORE INSERT ON `ExamesSolicitados` 
FOR EACH ROW 
Begin
 if NEW.dia = dia and NEW.hora = hora then
 SIGNAL SQLSTATE VALUE '45000' SET MESSAGE_TEXT = 'HORÁRIO NÃO DISPÓNIVEL'; 
end if; 
End;

CREATE TRIGGER `dataValida` 
BEFORE INSERT ON `ExamesSolicitados` 
FOR EACH ROW
begin
  if date(NEW.dia) < date(NOW()) then
      SIGNAL SQLSTATE VALUE '45000' SET MESSAGE_TEXT = 'HORÁRIO NÃO DISPÓNIVEL';
  end if;
  
end


DROP TRIGGER IF EXISTS t_i_ServAtualNegativo$$
CREATE TRIGGER t_i_ServAtualNegativo BEFORE INSERT ON Servicos 
	FOR EACH ROW
    BEGIN
		declare msg varchar(128);
		IF NEW.valorAtual < 0 THEN
			SET msg = concat('Error: Tentando inserir um valor atual negativo: ', cast(new.valorAtual as char));
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
		END IF;
    END$$

DROP TRIGGER IF EXISTS t_i_ServContratNegativo$$
CREATE TRIGGER t_i_ServContratNegativo BEFORE INSERT ON Servicos 
	FOR EACH ROW
    BEGIN
		declare msg varchar(128);
		IF NEW.valorContratado < 0 THEN
			SET msg = concat('Error: Tentando inserir um valor contratado negativo: ', cast(new.valorContratado as char));
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
		END IF;
    END$$

DROP TRIGGER IF EXISTS t_u_ServAtualNegativo$$
CREATE TRIGGER t_u_ServAtualNegativo BEFORE UPDATE ON Servicos 
	FOR EACH ROW
    BEGIN
		declare msg varchar(128);
		IF NEW.valorAtual < 0 THEN
			SET msg = concat('Error: Tentando inserir um valor atual negativo: ', cast(new.valorAtual as char));
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
		END IF;
    END$$

DROP TRIGGER IF EXISTS t_u_ServContratNegativo$$
CREATE TRIGGER t_u_ServContratNegativo BEFORE UPDATE ON Servicos 
	FOR EACH ROW
    BEGIN
		declare msg varchar(128);
		IF NEW.valorContratado < 0 THEN
			SET msg = concat('Error: Tentando inserir um valor contratado negativo: ', cast(new.valorContratado as char));
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
		END IF;
    END$$

DROP trigger if exists dataValidaupdt$$

CREATE TRIGGER dataValidaupdt
BEFORE UPDATE ON Vinculado
FOR EACH ROW
	BEGIN
		DECLARE msg VARCHAR(100);
		IF date(new.dataValor) > date(NOW()) THEN
			SET msg ='Erro: data da última atualização do valor inválida';
            signal sqlstate '45000' set message_text = msg;
		ELSEIF date(new.dataContrato) > date(now()) THEN
			SET msg = 'Erro: data de contratação inválida';
            signal sqlstate '45000' set message_text = msg;
		END IF;
	END$$


DROP trigger if exists dataValidainst$$

CREATE TRIGGER dataValidainst
BEFORE INSERT ON Vinculado
FOR EACH ROW
	BEGIN
		DECLARE msg VARCHAR(100);
		IF date(new.dataValor) > date(NOW()) THEN
			SET msg ='Erro: data da última atualização do valor inválida';
            signal sqlstate '45000' set message_text = msg;
		ELSEIF date(new.dataContrato) > date(now()) THEN
			SET msg ='Erro: data de contratação inválida';
            signal sqlstate '45000' set message_text = msg;
		END IF;
	END$$



DROP TRIGGER if exists t_i_ValorNegativo;
DROP TRIGGER if exists t_i_ServAtualContratNegativo;

DELIMITER $$

CREATE TRIGGER t_i_VincNegativo BEFORE INSERT ON Vinculado 
	FOR EACH ROW
    BEGIN
		declare msg varchar(128);
		IF NEW.valor < 0 THEN
			SET msg = concat('Error: Tentando inserir um valor negativo: ', cast(new.valor as char));
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
		END IF;
    END$$
    

CREATE TRIGGER t_i_ServAtualContratNegativo BEFORE INSERT ON Servicos 
	FOR EACH ROW
    BEGIN
		declare msg varchar(128);
		IF NEW.valorContratado < NEW.valorAtual THEN
			SET msg = concat('Error: Valor atual maior que o contratado', cast(new.new.valorContratado as char));
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
		END IF;
    END$$

DELIMITER $$


DROP TRIGGER if exists t_u_ValorNegativo;
DROP TRIGGER if exists t_u_ServAtualContratNegativo;

DELIMITER $$

CREATE TRIGGER t_u_VincNegativo BEFORE UPDATE ON Vinculado 
	FOR EACH ROW
    BEGIN
		declare msg varchar(128);
		IF NEW.valor < 0 THEN
			SET msg = concat('Error: Tentando inserir um valor negativo: ', cast(new.valor as char));
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
		END IF;
    END$$
    
CREATE TRIGGER t_u_ServAtualContratNegativo BEFORE UPDATE ON Servicos 
	FOR EACH ROW
    BEGIN
		declare msg varchar(128);
		IF NEW.valorContratado < NEW.valorAtual THEN
			SET msg = concat('Error: Valor atual maior que o contratado', cast(new.new.valorContratado as char));
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
		END IF;
    END$$
DELIMITER $$


DELIMITER //

CREATE TRIGGER _before_insert_altera_anam_idAnam BEFORE INSERT ON AlteraAnamnese FOR EACH ROW
BEGIN
IF (SELECT COUNT(*) FROM Anamnese WHERE Anamnese.idAnamnese=new.idAnamnese) = 0 THEN
	SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 30001, MESSAGE_TEXT = 'Não é possivel inserir dado. IdAnamnese não existe!';
END IF;
END //
DELIMITER ;


DELIMITER //

CREATE TRIGGER _before_insert_altera_anam_codCat BEFORE INSERT ON AlteraAnamnese FOR EACH ROW
BEGIN
IF (SELECT COUNT(*) FROM Profissional WHERE Profissional.CodigoCategoria=new.CodigoCategoria) = 0 THEN
	SIGNAL SQLSTATE '45000' SET MYSQL_ERRNO = 30001, MESSAGE_TEXT = 'Não é possivel inserir dado. CodigoCategoria não existe!';
END IF;
END //
DELIMITER ;


DELIMITER $$

CREATE TRIGGER paciente_existe BEFORE INSERT ON Paciente
	FOR EACH ROW
	BEGIN
  		IF (EXISTS(SELECT 1 FROM Paciente WHERE cpf = NEW.cpf)) THEN
    		SIGNAL SQLSTATE VALUE '45000' SET MESSAGE_TEXT = 'Inserção falhou, paciente duplicado';
  END IF;
END$$
DELIMITER;


DELIMITER $$

CREATE TRIGGER cuidador_existe BEFORE INSERT ON Cuidador
	FOR EACH ROW
	BEGIN
  		IF (EXISTS(SELECT 1 FROM Cuidador WHERE cpf = NEW.cpf)) THEN
    		SIGNAL SQLSTATE VALUE '45000' SET MESSAGE_TEXT = 'Inserção falhou, cuidador duplicado';
  		END IF;
END$$
DELIMITER;


DELIMITER $$   
CREATE TRIGGER cpf_iguais_familiar BEFORE INSERT ON Familiar
	FOR EACH ROW 
	BEGIN 
      	IF (NEW.cpfPaciente = NEW.cpfFamiliar) THEN 
        	SIGNAL SQLSTATE VALUE '45000' SET MESSAGE_TEXT = 'Inserção falhou, Familiar nao pode ser o proprio Paciente'; 
          END IF; 
END$$ 
DELIMITER ;


DELIMITER $$ 
CREATE TRIGGER cpf_iguais_Nfamiliar BEFORE INSERT ON NaoFamiliar
	FOR EACH ROW 
	BEGIN 
      	IF (NEW.cpfPaciente = NEW.cpfNFamiliar) THEN 
        	SIGNAL SQLSTATE VALUE '45000' SET MESSAGE_TEXT = 'Inserção falhou, Nao-Familiar nao pode ser o proprio Paciente'; 
          END IF; 
END$$ 
DELIMITER ;

DELIMITER $$
CREATE TRIGGER consanguineo_existe BEFORE INSERT ON Consanguineo
	FOR EACH ROW
	BEGIN
  		IF (EXISTS(SELECT 1 FROM Consanguineo WHERE idAnamnese = NEW.idAnamnese AND idRelacionado = NEW.idRelacionado)) THEN
    		SIGNAL SQLSTATE VALUE '45000' SET MESSAGE_TEXT = 'Inserção falhou, consanguineo já existente';
  		END IF;
END$$
