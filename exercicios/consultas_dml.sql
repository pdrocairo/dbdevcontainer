insert into pessoa (cpf, email, nome, data_nasc, endereco, telefone)
values ('002','pp@email.com', 'D Pedro I', '1479-01-10', 'R. Vasco', null),
('003', 'ps@email.com', 'Pedro II', '1516-02-10', 'R. Flamengo', '5501'),
('001', 'dj@email.com', 'D João VI', '1415-12-01', 'R. Portugal', null),
('004', 'jj@email.com', 'JJ Xavier', '1746-11-12', 'R. Minas', '5502');

insert into paciente (cpf, senha, plano_saude)
values ('002', 'senha1', FALSE),
('003', 'senha2', TRUE);

insert into medico(cpf, crm)
values ('001', '111'),
('004', '112');

insert into especialidade(descricao)
values ('Pediatra'),
('Cardiologista'),
('Ortopedista');

insert into medico_especialidade(crm, id_especialidade)
values ((select crm from medico where cpf = '001'), 01),
((select crm from medico where cpf = '004'), 02),
((select crm from medico where cpf = '004'), 03);

insert into agendamento(codigo_paciente, crm, dt_consulta, dt_agendamento, valor_consulta)
values ((select codigo from paciente where cpf = '002'), 
(select crm from medico where cpf = '001'), 
'1782-04-14 16:00:00', '1782-03-14 10:04:45', 80),

((select codigo from paciente where cpf = '002'),
(select crm from medico where cpf = '004'),
'1782-04-15 10:00:00',
'1782-03-14 10:04:45',
100
),

(
    (select codigo from paciente where cpf = '002'),
    (select crm from medico where cpf = '004'),
    '1783-05-17 08:00:00',
    '1783-05-10 16:32:00',
    100
),

(
    (select codigo from paciente where cpf = '003'),
    (select crm from medico where cpf = '001'),
    '1783-05-17 08:30:00',
    '1783-05-09 09:05:56',
    0
);



update pessoa
set data_nasc = '1416-12-01'
where nome = 'D João VI';

update pessoa
set telefone = '5503', email = 'pf@email.com'
where nome = 'D Pedro I';

update pessoa
set telefone = '9' || telefone
where telefone is not null;

update agendamento
set dt_consulta = dt_consulta + '2 days', valor_consulta = 150
where dt_consulta::date = '1783-05-17';


update medico_especialidade
set id_especialidade = 1
where id_especialidade = 2 and crm = (
    select crm from medico
    where cpf = (
        select cpf from pessoa
        where nome = 'JJ Xavier'
    )
);

delete from agendamento
where codigo_paciente = (
    select codigo from paciente
    where cpf = (
        select cpf from pessoa
        where nome = 'D Pedro I'
    )
) and dt_consulta::date = '1783-05-19';


delete from agendamento
where crm = (
    select crm from medico
    where cpf = (
        select cpf from pessoa
        where nome = 'D João VI'
    )
) and valor_consulta = 0;


delete from paciente
where plano_saude = true
or cpf = (
    select cpf from pessoa
    where telefone is null
);



delete from agendamento
where crm = (
    select crm from medico
    where cpf = (
        select cpf from pessoa
        where nome = 'JJ Xavier'
    )
);

delete from medico_especialidade
where crm = (
    select crm from medico
    where cpf = (
        select cpf from pessoa
        where nome = 'JJ Xavier'
    )
);

delete from medico
where cpf = (
    select cpf from pessoa
    where nome = 'JJ Xavier'
);

delete from pessoa
where nome = 'JJ Xavier';