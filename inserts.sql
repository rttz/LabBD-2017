INSERT INTO Exame ('nroExame', 'dia', 'hora', 'responsavel', 'endereco', 'tipo', 'telefone', 'resultado', 'email') 
    VALUES ('489050', '2017-05-21', '15:30', 'Lucas Gouveia', 'Rua Adolfo 1500', 'Cardiologia', '34127803', '130bpm', 'lucas2gouveia@gmail.com'); 
INSERT INTO Exame ('nroExame', 'dia', 'hora', 'responsavel', 'endereco', 'tipo', 'telefone', 'resultado', 'email') 
    VALUES ('489051', '2017-06-15', '14:30', 'Alberto', 'Rua Alvarenga 150', 'Teste Físico', '38593020', 'Aprovado', 'alberto@gmail.com');
INSERT INTO Exame ('nroExame', 'dia', 'hora', 'responsavel', 'endereco', 'tipo', 'telefone', 'resultado', 'email') 
    VALUES ('489052', '2017-03-12', '16:30', 'Thiago', 'Rua Sao Paulo 15', 'Teste de Miopia', '38123451', 'Negativo', 'thiago10@gmail.com');


INSERT INTO Consulta(dia, hora, codigo)
VALUES(str_to_date('01/07/2017','%d/%m/%Y'),'08:00', 1);
INSERT INTO Consulta(dia, hora, codigo)
VALUES(str_to_date('01/07/2017','%d/%m/%Y'),'10:00', 2);
INSERT INTO Consulta(dia, hora, codigo)
VALUES(str_to_date('02/07/2017','%d/%m/%Y'),'10:00', 3);
INSERT INTO Consulta(dia, hora, codigo)
VALUES(str_to_date('05/07/2017','%d/%m/%Y'),'08:00', 4);
INSERT INTO Consulta(dia, hora, codigo)
VALUES(str_to_date('08/07/2017','%d/%m/%Y'),'08:00', 5);


INSERT INTO Medicamento(codigoConsulta, dia, hora, posologia, dataCompra)
VALUES(1,str_to_date('01/07/2017','%d/%m/%Y'),'08:00', '8h - 3x ao dia',str_to_date('01/07/2017','%d/%m/%Y'));
INSERT INTO Medicamento(codigoConsulta, dia, hora, posologia, dataCompra)
VALUES(2,str_to_date('01/07/2017','%d/%m/%Y'),'10:00', '8h - 3x ao dia',str_to_date('01/07/2017','%d/%m/%Y'));
INSERT INTO Medicamento(codigoConsulta, dia, hora, posologia, dataCompra)
VALUES(3,str_to_date('02/07/2017','%d/%m/%Y'),'10:00', '8h - 3x ao dia',str_to_date('02/07/2017','%d/%m/%Y'));
INSERT INTO Medicamento(codigoConsulta, dia, hora, posologia, dataCompra)
VALUES(4,str_to_date('05/07/2017','%d/%m/%Y'),'08:00', '8h - 3x ao dia',str_to_date('06/07/2017','%d/%m/%Y'));
INSERT INTO Medicamento(codigoConsulta, dia, hora, posologia, dataCompra)
VALUES(5,str_to_date('08/07/2017','%d/%m/%Y'),'08:00', '8h - 3x ao dia', str_to_date('08/07/2017','%d/%m/%Y'));


insert into Pessoa VALUES("57475365400","Joao", "Oliveira", "12345678901","Rua XV",123,"Sao Carlos", "SP","5555555","5555555","5555555","5555555");
insert into Pessoa VALUES("24254667799","Maria", "Oliveira", "12345678901","Rua XV",123,"Sao Carlos", "SP","5555555","5555555","5555555","5555556");
insert into Pessoa VALUES("23465434511","Jose", "Bezerra", "12345678901","Rua XII",321,"Ibate", "SP","98765432","34560987","98765432","98765432");
insert into Familiar Values (300,"24254667799","57475365400","Irma","Diabetica");
insert into NaoFamiliar VALUES(157, "23465434511","57475365400","Amigo");

insert into Informal(idCuidador, cpf, funcao) 
values (001, 12345678910, 'auxílio doméstico'); 
 
insert into Informal(idCuidador, cpf, funcao) 
values (002, 11223456789, 'controlar remédios'); 


insert into examesSolicitados(dia, hora, codigo)
    values (to_date('05/10/2015','dd/mm/yyyy'),TIME_TO_SEC('14:00:00') , 1, "Sangue");

insert into examesSolicitados(dia, hora, codigo)
    values (to_date('10/11/2015','dd/mm/yyyy'),TIME_TO_SEC('15:00:00') ,2,"Urina");

insert into examesSolicitados(dia, hora, codigo)
    values (to_date('08/11/2015','dd/mm/yyyy'),TIME_TO_SEC('16:30:00') ,3, "Rim");

insert into NaoConsanguineo(cpf, idRelacionado, dadosMedicos, parentesco)
    values("43762963843", 22, "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", "Esposa");

insert into NaoConsanguineo(cpf, idRelacionado, dadosMedicos, parentesco)
    values("06481339820", 33, "yyyyyyyyyyyyyyyyyyyyyyyyyyyyyy", "Filho");

insert into NaoConsanguineo(cpf, idRelacionado, dadosMedicos, parentesco)
    values("0130425809", 44, "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzz", "Marido");


INSERT INTO Pessoa (cpf, prNome, sobrenome, cep, rua, numero, cidade, estado)
    VALUES ("12345678901", "Joao", "A", "12345678", "Rua A", "10", "São Carlos", "SP");
INSERT INTO Pessoa (cpf, prNome, sobrenome, cep, rua, numero, cidade, estado)
    VALUES ("23456789012", "Ana", "B", "23456789", "Rua B", "20", "São Carlos", "SP");
INSERT INTO Pessoa (cpf, prNome, sobrenome, cep, rua, numero, cidade, estado)
    VALUES ("34567890123", "José", "C", "34567890", "Rua C", "30", "Bauru", "SP");
INSERT INTO Pessoa (cpf, prNome, sobrenome, cep, rua, numero, cidade, estado)
    VALUES ("45678901234", "Maria", "D", "45678901", "Rua D", "40", "Bauru", "SP");
INSERT INTO Pessoa (cpf, prNome, sobrenome, cep, rua, numero, cidade, estado)
    VALUES ("56789012345", "Joana", "E", "56789012", "Rua E", "50", "São Paulo", "SP");

INSERT INTO Medico (cpf, crm, especialidade, email, paginaWeb)
    VALUES ("12345678901", "12312312344", "Geral", "geral@email.com", "www.geral.com");
INSERT INTO Medico (cpf, crm, especialidade, email, paginaWeb)
    VALUES ("23456789012", "23423423455", "Cardio", "cardio@email.com", "www.cardio.com");
INSERT INTO Medico (cpf, crm, especialidade, email, paginaWeb)
    VALUES ("34567890123", "34534534566", "Neuro", "neuro@email.com", "www.neuro.com");
INSERT INTO Medico (cpf, crm, especialidade, email, paginaWeb)
    VALUES ("45678901234", "45645645677", "Gastro", "gastro@email.com", "www.gastro.com");
INSERT INTO Medico (cpf, crm, especialidade, email, paginaWeb)
    VALUES ("56789012345", "56756756788", "Uro", "uro@email.com", "www.uro.com");

INSERT INTO Paciente (cpf)
    VALUES ("12345678901");
INSERT INTO Paciente (cpf)
    VALUES ("23456789012");
INSERT INTO Paciente (cpf)
    VALUES ("34567890123");

INSERT INTO Anamnese (cpf, dataAlteracao, tipoSanguineo, historicoDoencas)
    VALUES ("12345678901", "1991-12-31", "A+", "historico");
INSERT INTO Anamnese (cpf, dataAlteracao, tipoSanguineo, historicoDoencas)
    VALUES ("23456789012", "1991-12-31", "A+", "historico");
INSERT INTO Anamnese (cpf, dataAlteracao, tipoSanguineo, historicoDoencas)
    VALUES ("34567890123", "1991-12-31", "A+", "historico");

INSERT INTO Edita (crm, cpf, idAnamnese)
    VALUES ("12312312344", "12345678901", 1);
INSERT INTO Edita (crm, cpf, idAnamnese)
    VALUES ("23423423455", "23456789012", 2);
INSERT INTO Edita (crm, cpf, idAnamnese)
    VALUES ("34534534566", "34567890123", 3);


INSERT INTO PlanoDeSaude VALUES('58215638000120', 'UNIMED', 'São Carlos', 'Médico', '(16)34567891');
INSERT INTO PlanoDeSaude VALUES('64955271000183', 'São Francisco', 'São Carlos', 'Médico', '(16)33717898');
INSERT INTO PlanoDeSaude VALUES('41727816000107', 'UNIODONTO', 'São Carlos', 'Odontológico', '(16)34567891');

INSERT INTO Servicos VALUES('58215638000120', 1, 'Hospitalar', STR_TO_DATE( "30/08/2017", "%d/%m/%Y" ), 70.9, 65);
INSERT INTO Servicos VALUES('58215638000120', 2, 'Ambulatorial', STR_TO_DATE( "30/07/2017", "%d/%m/%Y" ), 30, 25);
INSERT INTO Servicos VALUES('64955271000183', 1, 'Hospitalar', STR_TO_DATE( "30/06/2017", "%d/%m/%Y" ), 80, 70);
INSERT INTO Servicos VALUES('64955271000183', 2, 'Ambulatorial', STR_TO_DATE( "30/05/2017", "%d/%m/%Y" ), 25, 23);
INSERT INTO Servicos VALUES('41727816000107', 1, 'Limpeza Bucal', STR_TO_DATE( "30/05/2017", "%d/%m/%Y" ), 30, 25);
INSERT INTO Servicos VALUES('41727816000107', 2, 'Clareamento', STR_TO_DATE( "30/05/2017", "%d/%m/%Y" ), 60, 55);


INSERT INTO Pessoa VALUES('44196565816', 'Igor', 'Bianchi', '13.563-330', 'Joaquim Augusto R. de Souza', 
1207, 'São Carlos', 'São Paulo', NULL, NULL, '(16)982391875', '(16)98239-1875');
INSERT INTO Pessoa VALUES('03520550814', 'Isabel', 'Bianchi', '13.563-330', 'Joaquim Augusto R. de Souza', 
1207, 'São Carlos', 'São Paulo', NULL, '(16)33724993', NULL, NULL);
INSERT INTO Pessoa VALUES('04154335847', 'José', 'Bianchi', '13.563-330', 'Joaquim Augusto R. de Souza', 
1207, 'São Carlos', 'São Paulo', NULL, NULL, '(16)982387907', NULL);
INSERT INTO Pessoa VALUES('56787612334', 'João', 'Vieira', '17.987-222', 'Marginal Tietê', 
13543, 'São Paulo', 'São Paulo', NULL, NULL, '(11)997867777', '(11)997867777');
INSERT INTO Pessoa VALUES('78865543312', 'Felipe', 'Chinen', '25.183-544', 'Não Sei Onde Ele Mora', 
208, 'Araraquara', 'São Paulo', NULL, NULL, '(16)976665544', '(16)976665544');

INSERT INTO Paciente VALUES('44196565816');
INSERT INTO Paciente VALUES('03520550814');
INSERT INTO Paciente VALUES('04154335847');
INSERT INTO Paciente VALUES('56787612334');
INSERT INTO Paciente VALUES('78865543312');

INSERT INTO Vinculado VALUES('44196565816', '58215638000120', 256.70, STR_TO_DATE( "31/05/2017", "%d/%m/%Y" ), 
							STR_TO_DATE( "31/05/2014", "%d/%m/%Y" ), 'Ambulatorial');
INSERT INTO Vinculado VALUES('03520550814', '64955271000183', 500.5, STR_TO_DATE( "30/12/2016", "%d/%m/%Y" ), 
							STR_TO_DATE( "15/10/2005", "%d/%m/%Y" ), 'Ambulatorial + Hospitalar sem obstetrícia'); 
INSERT INTO Vinculado VALUES('04154335847', '41727816000107', 120, STR_TO_DATE( "30/12/2015", "%d/%m/%Y" ), 
							STR_TO_DATE( "15/10/1999", "%d/%m/%Y" ), 'Urgência + Prevenção');     
INSERT INTO Vinculado VALUES('56787612334', '64955271000183', 230.7, STR_TO_DATE( "30/03/2017", "%d/%m/%Y" ), 
							STR_TO_DATE( "23/05/2009", "%d/%m/%Y" ), 'Hospitalar sem obstetrícia');                             
INSERT INTO Vinculado VALUES('78865543312', '58215638000120', 800.80, STR_TO_DATE( "30/03/2016", "%d/%m/%Y" ), 
							STR_TO_DATE( "23/05/2011", "%d/%m/%Y" ), 'Ambulatorial + Hospitalar com obstetrícia');


insert into AlteraAnamnese(codigoCategoria, idAnamnese)
values (4, 3);
 
insert into AlteraAnamnese(codigoCategoria, idAnamnese)
values (1, 2);


INSERT INTO Paciente VALUES("12345678910");
INSERT INTO Paciente VALUES("12345678911");


INSERT INTO Pessoa VALUES("12345678910","Pedro", "Augusto", "13000225","Rua Flores Novas", 111, "Sao Carlos", "SP","3333335","3333338","99999991","99999992");
INSERT INTO Pessoa VALUES("12345678911","Flavio", "Pereira", "13000223","Rua Flores Velhas", 646, "Sao Carlos", "SP","3333338","3333331","99999995","99999996");
INSERT INTO Pessoa VALUES("12345678912","Antonio", "Santos", "13000223","Rua Flores Velhas", 650, "Sao Carlos", "SP","3333350","3333350","99999950","99999951");