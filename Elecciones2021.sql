use master
go

if DB_ID('Elecciones_2021') is not null
    drop database Elecciones_2021
go

create Database Elecciones_2021
go

use Elecciones_2021
go

if object_id('tb_pais') is not null
 drop table tb_pais
go

if object_id('tb_departamento') is not null
 drop table tb_departamento
go

if object_id('tb_provincia') is not null
 drop table tb_provincia
go

if object_id('tb_distrito') is not null
 drop table tb_distrito
go


if object_id('tb_estado_civil') is not null
 drop table tb_estado_civil
go


if object_id('tb_persona') is not null
 drop table tb_persona
go

if object_id('tb_hoja_vida_persona') is not null
 drop table tb_hoja_vida_persona
go


if object_id('tb_edu_basica_hoja_vida') is not null
 drop table tb_edu_basica_hoja_vida
go

if object_id('tb_est_tecnico_hoja_vida') is not null
 drop table tb_est_tecnico_hoja_vida
go

if object_id('tb_est_nouniversitario_hoja_vida') is not null
 drop table tb_est_nouniversitario_hoja_vida
go

if object_id('tb_est_universitario_hoja_vida') is not null
 drop table tb_est_universitario_hoja_vida
go

if object_id('tb_est_postgrado_hoja_vida') is not null
 drop table tb_est_postgrado_hoja_vida
go

if object_id('tb_trabajos_hoja_vida') is not null
 drop table tb_trabajos_hoja_vida
go

if object_id('tb_modalidad_ambito_penal') is not null
 drop table tb_modalidad_ambito_penal
go

if object_id('tb_ambito_penal_hoja_vida') is not null
 drop table tb_ambito_penal_hoja_vida
go

if object_id('tb_otras_sentencias_hoja_vida') is not null
 drop table tb_otras_sentencias_hoja_vida
go

if object_id('tb_plan_gobierno') is not null
 drop table tb_plan_gobierno
go

if object_id('tb_partidopolitico') is not null
 drop table tb_partidopolitico
go


if object_id('tb_eleccion') is not null
 drop table tb_eleccion
go


if object_id('tb_cargo') is not null
 drop table tb_cargo
go


if object_id('tb_candidato') is not null
 drop table tb_candidato
go

if object_id('tb_partpolitico_elecciones') is not null
 drop table tb_partpolitico_elecciones
go

set dateformat ymd
go

-- PAIS
create table tb_pais (
 cod_pai int primary key not null,
 nom_pai varchar(50) not null
)
go

-- DEPARTAMENTO
create table  tb_departamento (
  id_dep varchar(2) primary key NOT NULL,
  nom_dep varchar(45) NOT NULL
)
go

-- PROVINCIA
create table tb_provincia (
  id_pro varchar(4) NOT NULL,
  nom_pro varchar(45) NOT NULL,
  id_dep varchar(2) not null,
  primary key (id_dep, id_pro),
  foreign key (id_dep) references tb_departamento (id_dep)
)
go

-- DISTRITO
create table tb_distrito (
    id_dis varchar(6) NOT NULL,
    nom_dis varchar(45) DEFAULT NULL,
    id_pro varchar(4) DEFAULT NULL,
    id_dep varchar(2) DEFAULT NULL,
	primary key(id_dep, id_pro,id_dis),
	foreign key (id_dep,id_pro) references tb_provincia (id_dep, id_pro)
)
go


-- ESTADO CIVIL PERSONA
create table tb_estado_civil(
cod_est_civ varchar(2) not null primary key,
des_est_civ varchar(20) not null
)
go

-- PADRE DE LA TABLA CANDIDATOS, PERSONA
create table tb_persona(
 id_per int identity(1,1) primary key,
 dni_per char(8) not null,
 cui_per	char(1) not null,
 nom_per  varchar(100) not null,
 apepat_per varchar(25) not null,
 apemat_per varchar(25) not null,
 fechanac_per  date not null,
 fechaemi_per  date not null,
 foto_per varchar(255) null,
 sexo_per	char(1) not null,
 codEstadoCivil varchar(2) references tb_estado_civil null,
 cod_pai_nac int not null references tb_pais,
 cod_dep_nac varchar(2) null,
 cod_pro_nac varchar(4) null,
 cod_dist_nac varchar(6) null,
 cod_pai_res int not null references tb_pais,
 cod_dep_res varchar(2) null,
 cod_pro_res varchar(4) null,
 cod_dis_res varchar(6) null,
 dir_res varchar(90) null,
 voto int default 0,
 foreign key(cod_dep_nac, cod_pro_nac, cod_dist_nac) references tb_distrito(id_dep, id_pro,id_dis),
 foreign key(cod_dep_res, cod_pro_res, cod_dis_res) references tb_distrito(id_dep, id_pro, id_dis)
)
go

---------------HOJAS DE VIDA DE PERSONAS ------------------
-- TABLA HOJA VIDA
create table tb_hoja_vida_persona(
 cod_hoja int identity(1,1),
 cod_per int references tb_persona unique,
 hoja_vida_pdf varchar(80) null,
 fecha_act datetime null,
 primary key(cod_hoja)
)
go


-----INFORMACION ACADEMICA---------

-- EDUCACION BASICA
create table tb_edu_basica_hoja_vida(
 cod_hoja int,
 primaria  char(2),
 secundaria char(2),
 foreign key(cod_hoja) references tb_hoja_vida_persona,
 primary key(cod_hoja)
)
go


-- ESTUDIOS TECNICOS
create table tb_est_tecnico_hoja_vida(
 cod_hoja int,
 nro_item int,
 cen_est_tec varchar(100),
 car_tec varchar(100),
 con_tec char(2),
 primary key(cod_hoja, nro_item),
 foreign key(cod_hoja) references tb_hoja_vida_persona
)
go

-- ESTUDIOS NO UNIVERSITARIOS
create table tb_est_nouniversitario_hoja_vida(
 cod_hoja int,
 nro_item int,
 cen_est_nouni varchar(100),
 car_nouni varchar(100),
 con_nouni char(2),
 primary key(cod_hoja, nro_item),
 foreign key(cod_hoja) references tb_hoja_vida_persona
)
go

-- ESTUDIOS UNIVERSITARIOS
create table tb_est_universitario_hoja_vida(
 cod_hoja int,
 nro_item int,
 cen_est_uni varchar(100),
 car_uni varchar(100),
 con_uni char(2),
 primary key(cod_hoja, nro_item),
 foreign key(cod_hoja) references tb_hoja_vida_persona
)
go

-- ESTUDIOS POSTGRADO
create table tb_est_postgrado_hoja_vida(
 cod_hoja int,
 nro_item int,
 cen_est_pos varchar(80),
 esp_pos varchar(80),
 con_pos char(2),
 gra_pos varchar(30),
 primary key(cod_hoja, nro_item),
 foreign key(cod_hoja) references tb_hoja_vida_persona
)
go
--------------------------------------------------------
------EXPERIENCIA LABORAL-------
-- DETALLES DE TRABAJO
create table tb_trabajos_hoja_vida(
 cod_hoja int,
 nro_tra int,
 cen_tra varchar(80),
 ocu_tra varchar(255),
 per_tra varchar(30),
 primary key(cod_hoja, nro_tra),
 foreign key(cod_hoja) references tb_hoja_vida_persona
)
go
-------------------------------------------------------
create table tb_modalidad_ambito_penal(
 nro_mod int identity(1,1) not null,
 des_mod varchar(20) not null,
 primary key(nro_mod)
)
go
insert tb_modalidad_ambito_penal(des_mod) values('simple'), ('agravada'), ('suspendida')
go
---------------RELACION DE SENTENCIAS------------------
--- AMBITOS PENALES
create table tb_ambito_penal_hoja_vida(
 cod_hoja int,
 nro_amb_pen int,
 del_amb_pen varchar(255),
 fal_amb_pen varchar(255),
 cod_mod_amb_pen int references tb_modalidad_ambito_penal,
 cum_amb_pen varchar(255),
 primary key(cod_hoja, nro_amb_pen),
 foreign key(cod_hoja) references tb_hoja_vida_persona
)
go

-- OTRAS SENTENCIAS
create table tb_otras_sentencias_hoja_vida(
 cod_hoja int,
 nro_otro_sen int,
 del_otro_sen varchar(80),
 fal_otro_sen varchar(100),
 primary key (cod_hoja, nro_otro_sen),
 foreign key(cod_hoja) references tb_hoja_vida_persona
)
go
------------------------------------------------------
-- PARTIDOS
create table tb_partidopolitico(
 cod_Partido    int identity(1,1)    primary key,
 imagen_partido varchar(80) not null,
 nombre_Partido varchar(70) not null,
 pdf_partido varchar(120) null,
 pag_partido varchar(80) null
)
go

create table tb_plan_gobierno(
 cod_par  int not null,
 nro_pro int not null,
 soc_pro varchar(500) null,
 eco_pro varchar(500) null,
 nat_pro varchar(500) null,
 ins_pro varchar(500) null,
 primary key(cod_par, nro_pro),
 foreign key (cod_par) references tb_partidopolitico(cod_partido)
)
go


-- PRESIDNETE, VICE,SEG VICE, CONGRESI, PARLAMENTO ANDINO
create table tb_cargo(
	id_Cargo int identity(1,1) primary key,
	desc_cargo varchar(50) not null
)
go

-- CANDIDATOS HIJOS DE PERSONA
create table tb_candidato(
	id_can  int identity(1,1) primary key,
	id_per  int references tb_persona,
	cod_par int references tb_partidopolitico not null,
	nro_can int default 0,
	id_dep_lug varchar(2)  null references tb_departamento,
	id_cargo int references tb_cargo not null,
	cant_voto  int default 0
)
go

-- ELECCION GENERAL
create table tb_eleccion(
nro_eleccion int primary key,
cod_per	 int  references  tb_persona not null,
fecha_voto datetime not null
)
go

-- VOTOS   PRESIDENTE, CONGRESISTAS, ANDINO
create table tb_partpolitico_elecciones(
 nro_eleccion int references tb_eleccion not null,
 id_cargo   int references tb_cargo not null,   -- DE ACA DERIVA   COMO PRESIDENTE, CONGRESISTAS, ANDINO
 id_part int references tb_partidopolitico not null,
 nropart1  int default 0,
 nropart2 int default 0,
 primary key(nro_eleccion, id_cargo)
)
go

-- -----------------------------------------INSERCCIONES--------------------------------------------
------------------------PAIS------------------------------
insert tb_pais values (1, 'Peru')
insert tb_pais values (2, 'Argentina')
insert tb_pais values (3, 'Venezuela')
go
-----------------------DEPARTAMENTOS----------------------
--PERU
INSERT INTO tb_departamento(id_dep, nom_dep) VALUES
('01', 'Amazonas'),
('02', 'Áncash'),
('03', 'Apurímac'),
('04', 'Arequipa'),
('05', 'Ayacucho'),
('06', 'Cajamarca'),
('07', 'Callao'),
('08', 'Cusco'),
('09', 'Huancavelica'),
('10', 'Huánuco'),
('11', 'Ica'),
('12', 'Junín'),
('13', 'La Libertad'),
('14', 'Lambayeque'),
('27', 'Lima Provincias'),
('15', 'Lima'),
('16', 'Loreto'),
('17', 'Madre de Dios'),
('18', 'Moquegua'),
('19', 'Pasco'),
('20', 'Piura'),
('21', 'Puno'),
('22', 'San Martín'),
('23', 'Tacna'),
('24', 'Tumbes'),
('25', 'Ucayali'),
('26', 'Peruanos residentes en el extranjero');


-- --------------------------------------------------------

-----------------------PROVINCIAS------------------------

INSERT INTO tb_provincia(id_pro, nom_pro, id_dep) VALUES
('0101', 'Chachapoyas', '01'),
('0102', 'Bagua', '01'),
('0103', 'Bongará', '01'),
('0104', 'Condorcanqui', '01'),
('0105', 'Luya', '01'),
('0106', 'Rodríguez de Mendoza', '01'),
('0107', 'Utcubamba', '01'),
('0201', 'Huaraz', '02'),
('0202', 'Aija', '02'),
('0203', 'Antonio Raymondi', '02'),
('0204', 'Asunción', '02'),
('0205', 'Bolognesi', '02'),
('0206', 'Carhuaz', '02'),
('0207', 'Carlos Fermín Fitzcarrald', '02'),
('0208', 'Casma', '02'),
('0209', 'Corongo', '02'),
('0210', 'Huari', '02'),
('0211', 'Huarmey', '02'),
('0212', 'Huaylas', '02'),
('0213', 'Mariscal Luzuriaga', '02'),
('0214', 'Ocros', '02'),
('0215', 'Pallasca', '02'),
('0216', 'Pomabamba', '02'),
('0217', 'Recuay', '02'),
('0218', 'Santa', '02'),
('0219', 'Sihuas', '02'),
('0220', 'Yungay', '02'),
('0301', 'Abancay', '03'),
('0302', 'Andahuaylas', '03'),
('0303', 'Antabamba', '03'),
('0304', 'Aymaraes', '03'),
('0305', 'Cotabambas', '03'),
('0306', 'Chincheros', '03'),
('0307', 'Grau', '03'),
('0401', 'Arequipa', '04'),
('0402', 'Camaná', '04'),
('0403', 'Caravelí', '04'),
('0404', 'Castilla', '04'),
('0405', 'Caylloma', '04'),
('0406', 'Condesuyos', '04'),
('0407', 'Islay', '04'),
('0408', 'La Uniòn', '04'),
('0501', 'Huamanga', '05'),
('0502', 'Cangallo', '05'),
('0503', 'Huanca Sancos', '05'),
('0504', 'Huanta', '05'),
('0505', 'La Mar', '05'),
('0506', 'Lucanas', '05'),
('0507', 'Parinacochas', '05'),
('0508', 'Pàucar del Sara Sara', '05'),
('0509', 'Sucre', '05'),
('0510', 'Víctor Fajardo', '05'),
('0511', 'Vilcas Huamán', '05'),
('0601', 'Cajamarca', '06'),
('0602', 'Cajabamba', '06'),
('0603', 'Celendín', '06'),
('0604', 'Chota', '06'),
('0605', 'Contumazá', '06'),
('0606', 'Cutervo', '06'),
('0607', 'Hualgayoc', '06'),
('0608', 'Jaén', '06'),
('0609', 'San Ignacio', '06'),
('0610', 'San Marcos', '06'),
('0611', 'San Miguel', '06'),
('0612', 'San Pablo', '06'),
('0613', 'Santa Cruz', '06'),
('0701', 'Prov. Const. del Callao', '07'),
('0801', 'Cusco', '08'),
('0802', 'Acomayo', '08'),
('0803', 'Anta', '08'),
('0804', 'Calca', '08'),
('0805', 'Canas', '08'),
('0806', 'Canchis', '08'),
('0807', 'Chumbivilcas', '08'),
('0808', 'Espinar', '08'),
('0809', 'La Convención', '08'),
('0810', 'Paruro', '08'),
('0811', 'Paucartambo', '08'),
('0812', 'Quispicanchi', '08'),
('0813', 'Urubamba', '08'),
('0901', 'Huancavelica', '09'),
('0902', 'Acobamba', '09'),
('0903', 'Angaraes', '09'),
('0904', 'Castrovirreyna', '09'),
('0905', 'Churcampa', '09'),
('0906', 'Huaytará', '09'),
('0907', 'Tayacaja', '09'),
('1001', 'Huánuco', '10'),
('1002', 'Ambo', '10'),
('1003', 'Dos de Mayo', '10'),
('1004', 'Huacaybamba', '10'),
('1005', 'Huamalíes', '10'),
('1006', 'Leoncio Prado', '10'),
('1007', 'Marañón', '10'),
('1008', 'Pachitea', '10'),
('1009', 'Puerto Inca', '10'),
('1010', 'Lauricocha ', '10'),
('1011', 'Yarowilca ', '10'),
('1101', 'Ica ', '11'),
('1102', 'Chincha ', '11'),
('1103', 'Nasca ', '11'),
('1104', 'Palpa ', '11'),
('1105', 'Pisco ', '11'),
('1201', 'Huancayo ', '12'),
('1202', 'Concepción ', '12'),
('1203', 'Chanchamayo ', '12'),
('1204', 'Jauja ', '12'),
('1205', 'Junín ', '12'),
('1206', 'Satipo ', '12'),
('1207', 'Tarma ', '12'),
('1208', 'Yauli ', '12'),
('1209', 'Chupaca ', '12'),
('1301', 'Trujillo ', '13'),
('1302', 'Ascope ', '13'),
('1303', 'Bolívar ', '13'),
('1304', 'Chepén ', '13'),
('1305', 'Julcán ', '13'),
('1306', 'Otuzco ', '13'),
('1307', 'Pacasmayo ', '13'),
('1308', 'Pataz ', '13'),
('1309', 'Sánchez Carrión ', '13'),
('1310', 'Santiago de Chuco ', '13'),
('1311', 'Gran Chimú ', '13'),
('1312', 'Virú ', '13'),
('1401', 'Chiclayo ', '14'),
('1402', 'Ferreñafe ', '14'),
('1403', 'Lambayeque ', '14'),
('1501', 'Lima ', '15'),
('1502', 'Barranca ', '15'),
('1503', 'Cajatambo ', '15'),
('1504', 'Canta ', '15'),
('1505', 'Cañete ', '15'),
('1506', 'Huaral ', '15'),
('1507', 'Huarochirí ', '15'),
('1508', 'Huaura ', '15'),
('1509', 'Oyón ', '15'),
('1510', 'Yauyos ', '15'),
('1601', 'Maynas ', '16'),
('1602', 'Alto Amazonas ', '16'),
('1603', 'Loreto ', '16'),
('1604', 'Mariscal Ramón Castilla ', '16'),
('1605', 'Requena ', '16'),
('1606', 'Ucayali ', '16'),
('1607', 'Datem del Marañón ', '16'),
('1608', 'Putumayo', '16'),
('1701', 'Tambopata ', '17'),
('1702', 'Manu ', '17'),
('1703', 'Tahuamanu ', '17'),
('1801', 'Mariscal Nieto ', '18'),
('1802', 'General Sánchez Cerro ', '18'),
('1803', 'Ilo ', '18'),
('1901', 'Pasco ', '19'),
('1902', 'Daniel Alcides Carrión ', '19'),
('1903', 'Oxapampa ', '19'),
('2001', 'Piura ', '20'),
('2002', 'Ayabaca ', '20'),
('2003', 'Huancabamba ', '20'),
('2004', 'Morropón ', '20'),
('2005', 'Paita ', '20'),
('2006', 'Sullana ', '20'),
('2007', 'Talara ', '20'),
('2008', 'Sechura ', '20'),
('2101', 'Puno ', '21'),
('2102', 'Azángaro ', '21'),
('2103', 'Carabaya ', '21'),
('2104', 'Chucuito ', '21'),
('2105', 'El Collao ', '21'),
('2106', 'Huancané ', '21'),
('2107', 'Lampa ', '21'),
('2108', 'Melgar ', '21'),
('2109', 'Moho ', '21'),
('2110', 'San Antonio de Putina ', '21'),
('2111', 'San Román ', '21'),
('2112', 'Sandia ', '21'),
('2113', 'Yunguyo ', '21'),
('2201', 'Moyobamba ', '22'),
('2202', 'Bellavista ', '22'),
('2203', 'El Dorado ', '22'),
('2204', 'Huallaga ', '22'),
('2205', 'Lamas ', '22'),
('2206', 'Mariscal Cáceres ', '22'),
('2207', 'Picota ', '22'),
('2208', 'Rioja ', '22'),
('2209', 'San Martín ', '22'),
('2210', 'Tocache ', '22'),
('2301', 'Tacna ', '23'),
('2302', 'Candarave ', '23'),
('2303', 'Jorge Basadre ', '23'),
('2304', 'Tarata ', '23'),
('2401', 'Tumbes ', '24'),
('2402', 'Contralmirante Villar ', '24'),
('2403', 'Zarumilla ', '24'),
('2501', 'Coronel Portillo ', '25'),
('2502', 'Atalaya ', '25'),
('2503', 'Padre Abad ', '25'),
('2504', 'Purús', '25');
----------------------------------------------------------

---------------------- DISTRITOS-------------------------
INSERT INTO tb_distrito(id_dis, nom_dis,id_pro, id_dep) VALUES
('010101', 'Chachapoyas', '0101', '01'),
('010102', 'Asunción', '0101', '01'),
('010103', 'Balsas', '0101', '01'),
('010104', 'Cheto', '0101', '01'),
('010105', 'Chiliquin', '0101', '01'),
('010106', 'Chuquibamba', '0101', '01'),
('010107', 'Granada', '0101', '01'),
('010108', 'Huancas', '0101', '01'),
('010109', 'La Jalca', '0101', '01'),
('010110', 'Leimebamba', '0101', '01'),
('010111', 'Levanto', '0101', '01'),
('010112', 'Magdalena', '0101', '01'),
('010113', 'Mariscal Castilla', '0101', '01'),
('010114', 'Molinopampa', '0101', '01'),
('010115', 'Montevideo', '0101', '01'),
('010116', 'Olleros', '0101', '01'),
('010117', 'Quinjalca', '0101', '01'),
('010118', 'San Francisco de Daguas', '0101', '01'),
('010119', 'San Isidro de Maino', '0101', '01'),
('010120', 'Soloco', '0101', '01'),
('010121', 'Sonche', '0101', '01'),
('010201', 'Bagua', '0102', '01'),
('010202', 'Aramango', '0102', '01'),
('010203', 'Copallin', '0102', '01'),
('010204', 'El Parco', '0102', '01'),
('010205', 'Imaza', '0102', '01'),
('010206', 'La Peca', '0102', '01'),
('010301', 'Jumbilla', '0103', '01'),
('010302', 'Chisquilla', '0103', '01'),
('010303', 'Churuja', '0103', '01'),
('010304', 'Corosha', '0103', '01'),
('010305', 'Cuispes', '0103', '01'),
('010306', 'Florida', '0103', '01'),
('010307', 'Jazan', '0103', '01'),
('010308', 'Recta', '0103', '01'),
('010309', 'San Carlos', '0103', '01'),
('010310', 'Shipasbamba', '0103', '01'),
('010311', 'Valera', '0103', '01'),
('010312', 'Yambrasbamba', '0103', '01'),
('010401', 'Nieva', '0104', '01'),
('010402', 'El Cenepa', '0104', '01'),
('010403', 'Río Santiago', '0104', '01'),
('010501', 'Lamud', '0105', '01'),
('010502', 'Camporredondo', '0105', '01'),
('010503', 'Cocabamba', '0105', '01'),
('010504', 'Colcamar', '0105', '01'),
('010505', 'Conila', '0105', '01'),
('010506', 'Inguilpata', '0105', '01'),
('010507', 'Longuita', '0105', '01'),
('010508', 'Lonya Chico', '0105', '01'),
('010509', 'Luya', '0105', '01'),
('010510', 'Luya Viejo', '0105', '01'),
('010511', 'María', '0105', '01'),
('010512', 'Ocalli', '0105', '01'),
('010513', 'Ocumal', '0105', '01'),
('010514', 'Pisuquia', '0105', '01'),
('010515', 'Providencia', '0105', '01'),
('010516', 'San Cristóbal', '0105', '01'),
('010517', 'San Francisco de Yeso', '0105', '01'),
('010518', 'San Jerónimo', '0105', '01'),
('010519', 'San Juan de Lopecancha', '0105', '01'),
('010520', 'Santa Catalina', '0105', '01'),
('010521', 'Santo Tomas', '0105', '01'),
('010522', 'Tingo', '0105', '01'),
('010523', 'Trita', '0105', '01'),
('010601', 'San Nicolás', '0106', '01'),
('010602', 'Chirimoto', '0106', '01'),
('010603', 'Cochamal', '0106', '01'),
('010604', 'Huambo', '0106', '01'),
('010605', 'Limabamba', '0106', '01'),
('010606', 'Longar', '0106', '01'),
('010607', 'Mariscal Benavides', '0106', '01'),
('010608', 'Milpuc', '0106', '01'),
('010609', 'Omia', '0106', '01'),
('010610', 'Santa Rosa', '0106', '01'),
('010611', 'Totora', '0106', '01'),
('010612', 'Vista Alegre', '0106', '01'),
('010701', 'Bagua Grande', '0107', '01'),
('010702', 'Cajaruro', '0107', '01'),
('010703', 'Cumba', '0107', '01'),
('010704', 'El Milagro', '0107', '01'),
('010705', 'Jamalca', '0107', '01'),
('010706', 'Lonya Grande', '0107', '01'),
('010707', 'Yamon', '0107', '01'),
('020101', 'Huaraz', '0201', '02'),
('020102', 'Cochabamba', '0201', '02'),
('020103', 'Colcabamba', '0201', '02'),
('020104', 'Huanchay', '0201', '02'),
('020105', 'Independencia', '0201', '02'),
('020106', 'Jangas', '0201', '02'),
('020107', 'La Libertad', '0201', '02'),
('020108', 'Olleros', '0201', '02'),
('020109', 'Pampas Grande', '0201', '02'),
('020110', 'Pariacoto', '0201', '02'),
('020111', 'Pira', '0201', '02'),
('020112', 'Tarica', '0201', '02'),
('020201', 'Aija', '0202', '02'),
('020202', 'Coris', '0202', '02'),
('020203', 'Huacllan', '0202', '02'),
('020204', 'La Merced', '0202', '02'),
('020205', 'Succha', '0202', '02'),
('020301', 'Llamellin', '0203', '02'),
('020302', 'Aczo', '0203', '02'),
('020303', 'Chaccho', '0203', '02'),
('020304', 'Chingas', '0203', '02'),
('020305', 'Mirgas', '0203', '02'),
('020306', 'San Juan de Rontoy', '0203', '02'),
('020401', 'Chacas', '0204', '02'),
('020402', 'Acochaca', '0204', '02'),
('020501', 'Chiquian', '0205', '02'),
('020502', 'Abelardo Pardo Lezameta', '0205', '02'),
('020503', 'Antonio Raymondi', '0205', '02'),
('020504', 'Aquia', '0205', '02'),
('020505', 'Cajacay', '0205', '02'),
('020506', 'Canis', '0205', '02'),
('020507', 'Colquioc', '0205', '02'),
('020508', 'Huallanca', '0205', '02'),
('020509', 'Huasta', '0205', '02'),
('020510', 'Huayllacayan', '0205', '02'),
('020511', 'La Primavera', '0205', '02'),
('020512', 'Mangas', '0205', '02'),
('020513', 'Pacllon', '0205', '02'),
('020514', 'San Miguel de Corpanqui', '0205', '02'),
('020515', 'Ticllos', '0205', '02'),
('020601', 'Carhuaz', '0206', '02'),
('020602', 'Acopampa', '0206', '02'),
('020603', 'Amashca', '0206', '02'),
('020604', 'Anta', '0206', '02'),
('020605', 'Ataquero', '0206', '02'),
('020606', 'Marcara', '0206', '02'),
('020607', 'Pariahuanca', '0206', '02'),
('020608', 'San Miguel de Aco', '0206', '02'),
('020609', 'Shilla', '0206', '02'),
('020610', 'Tinco', '0206', '02'),
('020611', 'Yungar', '0206', '02'),
('020701', 'San Luis', '0207', '02'),
('020702', 'San Nicolás', '0207', '02'),
('020703', 'Yauya', '0207', '02'),
('020801', 'Casma', '0208', '02'),
('020802', 'Buena Vista Alta', '0208', '02'),
('020803', 'Comandante Noel', '0208', '02'),
('020804', 'Yautan', '0208', '02'),
('020901', 'Corongo', '0209', '02'),
('020902', 'Aco', '0209', '02'),
('020903', 'Bambas', '0209', '02'),
('020904', 'Cusca', '0209', '02'),
('020905', 'La Pampa', '0209', '02'),
('020906', 'Yanac', '0209', '02'),
('020907', 'Yupan', '0209', '02'),
('021001', 'Huari', '0210', '02'),
('021002', 'Anra', '0210', '02'),
('021003', 'Cajay', '0210', '02'),
('021004', 'Chavin de Huantar', '0210', '02'),
('021005', 'Huacachi', '0210', '02'),
('021006', 'Huacchis', '0210', '02'),
('021007', 'Huachis', '0210', '02'),
('021008', 'Huantar', '0210', '02'),
('021009', 'Masin', '0210', '02'),
('021010', 'Paucas', '0210', '02'),
('021011', 'Ponto', '0210', '02'),
('021012', 'Rahuapampa', '0210', '02'),
('021013', 'Rapayan', '0210', '02'),
('021014', 'San Marcos', '0210', '02'),
('021015', 'San Pedro de Chana', '0210', '02'),
('021016', 'Uco', '0210', '02'),
('021101', 'Huarmey', '0211', '02'),
('021102', 'Cochapeti', '0211', '02'),
('021103', 'Culebras', '0211', '02'),
('021104', 'Huayan', '0211', '02'),
('021105', 'Malvas', '0211', '02'),
('021201', 'Caraz', '0212', '02'),
('021202', 'Huallanca', '0212', '02'),
('021203', 'Huata', '0212', '02'),
('021204', 'Huaylas', '0212', '02'),
('021205', 'Mato', '0212', '02'),
('021206', 'Pamparomas', '0212', '02'),
('021207', 'Pueblo Libre', '0212', '02'),
('021208', 'Santa Cruz', '0212', '02'),
('021209', 'Santo Toribio', '0212', '02'),
('021210', 'Yuracmarca', '0212', '02'),
('021301', 'Piscobamba', '0213', '02'),
('021302', 'Casca', '0213', '02'),
('021303', 'Eleazar Guzmán Barron', '0213', '02'),
('021304', 'Fidel Olivas Escudero', '0213', '02'),
('021305', 'Llama', '0213', '02'),
('021306', 'Llumpa', '0213', '02'),
('021307', 'Lucma', '0213', '02'),
('021308', 'Musga', '0213', '02'),
('021401', 'Ocros', '0214', '02'),
('021402', 'Acas', '0214', '02'),
('021403', 'Cajamarquilla', '0214', '02'),
('021404', 'Carhuapampa', '0214', '02'),
('021405', 'Cochas', '0214', '02'),
('021406', 'Congas', '0214', '02'),
('021407', 'Llipa', '0214', '02'),
('021408', 'San Cristóbal de Rajan', '0214', '02'),
('021409', 'San Pedro', '0214', '02'),
('021410', 'Santiago de Chilcas', '0214', '02'),
('021501', 'Cabana', '0215', '02'),
('021502', 'Bolognesi', '0215', '02'),
('021503', 'Conchucos', '0215', '02'),
('021504', 'Huacaschuque', '0215', '02'),
('021505', 'Huandoval', '0215', '02'),
('021506', 'Lacabamba', '0215', '02'),
('021507', 'Llapo', '0215', '02'),
('021508', 'Pallasca', '0215', '02'),
('021509', 'Pampas', '0215', '02'),
('021510', 'Santa Rosa', '0215', '02'),
('021511', 'Tauca', '0215', '02'),
('021601', 'Pomabamba', '0216', '02'),
('021602', 'Huayllan', '0216', '02'),
('021603', 'Parobamba', '0216', '02'),
('021604', 'Quinuabamba', '0216', '02'),
('021701', 'Recuay', '0217', '02'),
('021702', 'Catac', '0217', '02'),
('021703', 'Cotaparaco', '0217', '02'),
('021704', 'Huayllapampa', '0217', '02'),
('021705', 'Llacllin', '0217', '02'),
('021706', 'Marca', '0217', '02'),
('021707', 'Pampas Chico', '0217', '02'),
('021708', 'Pararin', '0217', '02'),
('021709', 'Tapacocha', '0217', '02'),
('021710', 'Ticapampa', '0217', '02'),
('021801', 'Chimbote', '0218', '02'),
('021802', 'Cáceres del Perú', '0218', '02'),
('021803', 'Coishco', '0218', '02'),
('021804', 'Macate', '0218', '02'),
('021805', 'Moro', '0218', '02'),
('021806', 'Nepeña', '0218', '02'),
('021807', 'Samanco', '0218', '02'),
('021808', 'Santa', '0218', '02'),
('021809', 'Nuevo Chimbote', '0218', '02'),
('021901', 'Sihuas', '0219', '02'),
('021902', 'Acobamba', '0219', '02'),
('021903', 'Alfonso Ugarte', '0219', '02'),
('021904', 'Cashapampa', '0219', '02'),
('021905', 'Chingalpo', '0219', '02'),
('021906', 'Huayllabamba', '0219', '02'),
('021907', 'Quiches', '0219', '02'),
('021908', 'Ragash', '0219', '02'),
('021909', 'San Juan', '0219', '02'),
('021910', 'Sicsibamba', '0219', '02'),
('022001', 'Yungay', '0220', '02'),
('022002', 'Cascapara', '0220', '02'),
('022003', 'Mancos', '0220', '02'),
('022004', 'Matacoto', '0220', '02'),
('022005', 'Quillo', '0220', '02'),
('022006', 'Ranrahirca', '0220', '02'),
('022007', 'Shupluy', '0220', '02'),
('022008', 'Yanama', '0220', '02'),
('030101', 'Abancay', '0301', '03'),
('030102', 'Chacoche', '0301', '03'),
('030103', 'Circa', '0301', '03'),
('030104', 'Curahuasi', '0301', '03'),
('030105', 'Huanipaca', '0301', '03'),
('030106', 'Lambrama', '0301', '03'),
('030107', 'Pichirhua', '0301', '03'),
('030108', 'San Pedro de Cachora', '0301', '03'),
('030109', 'Tamburco', '0301', '03'),
('030201', 'Andahuaylas', '0302', '03'),
('030202', 'Andarapa', '0302', '03'),
('030203', 'Chiara', '0302', '03'),
('030204', 'Huancarama', '0302', '03'),
('030205', 'Huancaray', '0302', '03'),
('030206', 'Huayana', '0302', '03'),
('030207', 'Kishuara', '0302', '03'),
('030208', 'Pacobamba', '0302', '03'),
('030209', 'Pacucha', '0302', '03'),
('030210', 'Pampachiri', '0302', '03'),
('030211', 'Pomacocha', '0302', '03'),
('030212', 'San Antonio de Cachi', '0302', '03'),
('030213', 'San Jerónimo', '0302', '03'),
('030214', 'San Miguel de Chaccrampa', '0302', '03'),
('030215', 'Santa María de Chicmo', '0302', '03'),
('030216', 'Talavera', '0302', '03'),
('030217', 'Tumay Huaraca', '0302', '03'),
('030218', 'Turpo', '0302', '03'),
('030219', 'Kaquiabamba', '0302', '03'),
('030220', 'José María Arguedas', '0302', '03'),
('030301', 'Antabamba', '0303', '03'),
('030302', 'El Oro', '0303', '03'),
('030303', 'Huaquirca', '0303', '03'),
('030304', 'Juan Espinoza Medrano', '0303', '03'),
('030305', 'Oropesa', '0303', '03'),
('030306', 'Pachaconas', '0303', '03'),
('030307', 'Sabaino', '0303', '03'),
('030401', 'Chalhuanca', '0304', '03'),
('030402', 'Capaya', '0304', '03'),
('030403', 'Caraybamba', '0304', '03'),
('030404', 'Chapimarca', '0304', '03'),
('030405', 'Colcabamba', '0304', '03'),
('030406', 'Cotaruse', '0304', '03'),
('030407', 'Ihuayllo', '0304', '03'),
('030408', 'Justo Apu Sahuaraura', '0304', '03'),
('030409', 'Lucre', '0304', '03'),
('030410', 'Pocohuanca', '0304', '03'),
('030411', 'San Juan de Chacña', '0304', '03'),
('030412', 'Sañayca', '0304', '03'),
('030413', 'Soraya', '0304', '03'),
('030414', 'Tapairihua', '0304', '03'),
('030415', 'Tintay', '0304', '03'),
('030416', 'Toraya', '0304', '03'),
('030417', 'Yanaca', '0304', '03'),
('030501', 'Tambobamba', '0305', '03'),
('030502', 'Cotabambas', '0305', '03'),
('030503', 'Coyllurqui', '0305', '03'),
('030504', 'Haquira', '0305', '03'),
('030505', 'Mara', '0305', '03'),
('030506', 'Challhuahuacho', '0305', '03'),
('030601', 'Chincheros', '0306', '03'),
('030602', 'Anco_Huallo', '0306', '03'),
('030603', 'Cocharcas', '0306', '03'),
('030604', 'Huaccana', '0306', '03'),
('030605', 'Ocobamba', '0306', '03'),
('030606', 'Ongoy', '0306', '03'),
('030607', 'Uranmarca', '0306', '03'),
('030608', 'Ranracancha', '0306', '03'),
('030609', 'Rocchacc', '0306', '03'),
('030610', 'El Porvenir', '0306', '03'),
('030611', 'Los Chankas', '0306', '03'),
('030701', 'Chuquibambilla', '0307', '03'),
('030702', 'Curpahuasi', '0307', '03'),
('030703', 'Gamarra', '0307', '03'),
('030704', 'Huayllati', '0307', '03'),
('030705', 'Mamara', '0307', '03'),
('030706', 'Micaela Bastidas', '0307', '03'),
('030707', 'Pataypampa', '0307', '03'),
('030708', 'Progreso', '0307', '03'),
('030709', 'San Antonio', '0307', '03'),
('030710', 'Santa Rosa', '0307', '03'),
('030711', 'Turpay', '0307', '03'),
('030712', 'Vilcabamba', '0307', '03'),
('030713', 'Virundo', '0307', '03'),
('030714', 'Curasco', '0307', '03'),
('040101', 'Arequipa', '0401', '04'),
('040102', 'Alto Selva Alegre', '0401', '04'),
('040103', 'Cayma', '0401', '04'),
('040104', 'Cerro Colorado', '0401', '04'),
('040105', 'Characato', '0401', '04'),
('040106', 'Chiguata', '0401', '04'),
('040107', 'Jacobo Hunter', '0401', '04'),
('040108', 'La Joya', '0401', '04'),
('040109', 'Mariano Melgar', '0401', '04'),
('040110', 'Miraflores', '0401', '04'),
('040111', 'Mollebaya', '0401', '04'),
('040112', 'Paucarpata', '0401', '04'),
('040113', 'Pocsi', '0401', '04'),
('040114', 'Polobaya', '0401', '04'),
('040115', 'Quequeña', '0401', '04'),
('040116', 'Sabandia', '0401', '04'),
('040117', 'Sachaca', '0401', '04'),
('040118', 'San Juan de Siguas', '0401', '04'),
('040119', 'San Juan de Tarucani', '0401', '04'),
('040120', 'Santa Isabel de Siguas', '0401', '04'),
('040121', 'Santa Rita de Siguas', '0401', '04'),
('040122', 'Socabaya', '0401', '04'),
('040123', 'Tiabaya', '0401', '04'),
('040124', 'Uchumayo', '0401', '04'),
('040125', 'Vitor', '0401', '04'),
('040126', 'Yanahuara', '0401', '04'),
('040127', 'Yarabamba', '0401', '04'),
('040128', 'Yura', '0401', '04'),
('040129', 'José Luis Bustamante Y Rivero', '0401', '04'),
('040201', 'Camaná', '0402', '04'),
('040202', 'José María Quimper', '0402', '04'),
('040203', 'Mariano Nicolás Valcárcel', '0402', '04'),
('040204', 'Mariscal Cáceres', '0402', '04'),
('040205', 'Nicolás de Pierola', '0402', '04'),
('040206', 'Ocoña', '0402', '04'),
('040207', 'Quilca', '0402', '04'),
('040208', 'Samuel Pastor', '0402', '04'),
('040301', 'Caravelí', '0403', '04'),
('040302', 'Acarí', '0403', '04'),
('040303', 'Atico', '0403', '04'),
('040304', 'Atiquipa', '0403', '04'),
('040305', 'Bella Unión', '0403', '04'),
('040306', 'Cahuacho', '0403', '04'),
('040307', 'Chala', '0403', '04'),
('040308', 'Chaparra', '0403', '04'),
('040309', 'Huanuhuanu', '0403', '04'),
('040310', 'Jaqui', '0403', '04'),
('040311', 'Lomas', '0403', '04'),
('040312', 'Quicacha', '0403', '04'),
('040313', 'Yauca', '0403', '04'),
('040401', 'Aplao', '0404', '04'),
('040402', 'Andagua', '0404', '04'),
('040403', 'Ayo', '0404', '04'),
('040404', 'Chachas', '0404', '04'),
('040405', 'Chilcaymarca', '0404', '04'),
('040406', 'Choco', '0404', '04'),
('040407', 'Huancarqui', '0404', '04'),
('040408', 'Machaguay', '0404', '04'),
('040409', 'Orcopampa', '0404', '04'),
('040410', 'Pampacolca', '0404', '04'),
('040411', 'Tipan', '0404', '04'),
('040412', 'Uñon', '0404', '04'),
('040413', 'Uraca', '0404', '04'),
('040414', 'Viraco', '0404', '04'),
('040501', 'Chivay', '0405', '04'),
('040502', 'Achoma', '0405', '04'),
('040503', 'Cabanaconde', '0405', '04'),
('040504', 'Callalli', '0405', '04'),
('040505', 'Caylloma', '0405', '04'),
('040506', 'Coporaque', '0405', '04'),
('040507', 'Huambo', '0405', '04'),
('040508', 'Huanca', '0405', '04'),
('040509', 'Ichupampa', '0405', '04'),
('040510', 'Lari', '0405', '04'),
('040511', 'Lluta', '0405', '04'),
('040512', 'Maca', '0405', '04'),
('040513', 'Madrigal', '0405', '04'),
('040514', 'San Antonio de Chuca', '0405', '04'),
('040515', 'Sibayo', '0405', '04'),
('040516', 'Tapay', '0405', '04'),
('040517', 'Tisco', '0405', '04'),
('040518', 'Tuti', '0405', '04'),
('040519', 'Yanque', '0405', '04'),
('040520', 'Majes', '0405', '04'),
('040601', 'Chuquibamba', '0406', '04'),
('040602', 'Andaray', '0406', '04'),
('040603', 'Cayarani', '0406', '04'),
('040604', 'Chichas', '0406', '04'),
('040605', 'Iray', '0406', '04'),
('040606', 'Río Grande', '0406', '04'),
('040607', 'Salamanca', '0406', '04'),
('040608', 'Yanaquihua', '0406', '04'),
('040701', 'Mollendo', '0407', '04'),
('040702', 'Cocachacra', '0407', '04'),
('040703', 'Dean Valdivia', '0407', '04'),
('040704', 'Islay', '0407', '04'),
('040705', 'Mejia', '0407', '04'),
('040706', 'Punta de Bombón', '0407', '04'),
('040801', 'Cotahuasi', '0408', '04'),
('040802', 'Alca', '0408', '04'),
('040803', 'Charcana', '0408', '04'),
('040804', 'Huaynacotas', '0408', '04'),
('040805', 'Pampamarca', '0408', '04'),
('040806', 'Puyca', '0408', '04'),
('040807', 'Quechualla', '0408', '04'),
('040808', 'Sayla', '0408', '04'),
('040809', 'Tauria', '0408', '04'),
('040810', 'Tomepampa', '0408', '04'),
('040811', 'Toro', '0408', '04'),
('050101', 'Ayacucho', '0501', '05'),
('050102', 'Acocro', '0501', '05'),
('050103', 'Acos Vinchos', '0501', '05'),
('050104', 'Carmen Alto', '0501', '05'),
('050105', 'Chiara', '0501', '05'),
('050106', 'Ocros', '0501', '05'),
('050107', 'Pacaycasa', '0501', '05'),
('050108', 'Quinua', '0501', '05'),
('050109', 'San José de Ticllas', '0501', '05'),
('050110', 'San Juan Bautista', '0501', '05'),
('050111', 'Santiago de Pischa', '0501', '05'),
('050112', 'Socos', '0501', '05'),
('050113', 'Tambillo', '0501', '05'),
('050114', 'Vinchos', '0501', '05'),
('050115', 'Jesús Nazareno', '0501', '05'),
('050116', 'Andrés Avelino Cáceres Dorregaray', '0501', '05'),
('050201', 'Cangallo', '0502', '05'),
('050202', 'Chuschi', '0502', '05'),
('050203', 'Los Morochucos', '0502', '05'),
('050204', 'María Parado de Bellido', '0502', '05'),
('050205', 'Paras', '0502', '05'),
('050206', 'Totos', '0502', '05'),
('050301', 'Sancos', '0503', '05'),
('050302', 'Carapo', '0503', '05'),
('050303', 'Sacsamarca', '0503', '05'),
('050304', 'Santiago de Lucanamarca', '0503', '05'),
('050401', 'Huanta', '0504', '05'),
('050402', 'Ayahuanco', '0504', '05'),
('050403', 'Huamanguilla', '0504', '05'),
('050404', 'Iguain', '0504', '05'),
('050405', 'Luricocha', '0504', '05'),
('050406', 'Santillana', '0504', '05'),
('050407', 'Sivia', '0504', '05'),
('050408', 'Llochegua', '0504', '05'),
('050409', 'Canayre', '0504', '05'),
('050410', 'Uchuraccay', '0504', '05'),
('050411', 'Pucacolpa', '0504', '05'),
('050412', 'Chaca', '0504', '05'),
('050501', 'San Miguel', '0505', '05'),
('050502', 'Anco', '0505', '05'),
('050503', 'Ayna', '0505', '05'),
('050504', 'Chilcas', '0505', '05'),
('050505', 'Chungui', '0505', '05'),
('050506', 'Luis Carranza', '0505', '05'),
('050507', 'Santa Rosa', '0505', '05'),
('050508', 'Tambo', '0505', '05'),
('050509', 'Samugari', '0505', '05'),
('050510', 'Anchihuay', '0505', '05'),
('050511', 'Oronccoy', '0505', '05'),
('050601', 'Puquio', '0506', '05'),
('050602', 'Aucara', '0506', '05'),
('050603', 'Cabana', '0506', '05'),
('050604', 'Carmen Salcedo', '0506', '05'),
('050605', 'Chaviña', '0506', '05'),
('050606', 'Chipao', '0506', '05'),
('050607', 'Huac-Huas', '0506', '05'),
('050608', 'Laramate', '0506', '05'),
('050609', 'Leoncio Prado', '0506', '05'),
('050610', 'Llauta', '0506', '05'),
('050611', 'Lucanas', '0506', '05'),
('050612', 'Ocaña', '0506', '05'),
('050613', 'Otoca', '0506', '05'),
('050614', 'Saisa', '0506', '05'),
('050615', 'San Cristóbal', '0506', '05'),
('050616', 'San Juan', '0506', '05'),
('050617', 'San Pedro', '0506', '05'),
('050618', 'San Pedro de Palco', '0506', '05'),
('050619', 'Sancos', '0506', '05'),
('050620', 'Santa Ana de Huaycahuacho', '0506', '05'),
('050621', 'Santa Lucia', '0506', '05'),
('050701', 'Coracora', '0507', '05'),
('050702', 'Chumpi', '0507', '05'),
('050703', 'Coronel Castañeda', '0507', '05'),
('050704', 'Pacapausa', '0507', '05'),
('050705', 'Pullo', '0507', '05'),
('050706', 'Puyusca', '0507', '05'),
('050707', 'San Francisco de Ravacayco', '0507', '05'),
('050708', 'Upahuacho', '0507', '05'),
('050801', 'Pausa', '0508', '05'),
('050802', 'Colta', '0508', '05'),
('050803', 'Corculla', '0508', '05'),
('050804', 'Lampa', '0508', '05'),
('050805', 'Marcabamba', '0508', '05'),
('050806', 'Oyolo', '0508', '05'),
('050807', 'Pararca', '0508', '05'),
('050808', 'San Javier de Alpabamba', '0508', '05'),
('050809', 'San José de Ushua', '0508', '05'),
('050810', 'Sara Sara', '0508', '05'),
('050901', 'Querobamba', '0509', '05'),
('050902', 'Belén', '0509', '05'),
('050903', 'Chalcos', '0509', '05'),
('050904', 'Chilcayoc', '0509', '05'),
('050905', 'Huacaña', '0509', '05'),
('050906', 'Morcolla', '0509', '05'),
('050907', 'Paico', '0509', '05'),
('050908', 'San Pedro de Larcay', '0509', '05'),
('050909', 'San Salvador de Quije', '0509', '05'),
('050910', 'Santiago de Paucaray', '0509', '05'),
('050911', 'Soras', '0509', '05'),
('051001', 'Huancapi', '0510', '05'),
('051002', 'Alcamenca', '0510', '05'),
('051003', 'Apongo', '0510', '05'),
('051004', 'Asquipata', '0510', '05'),
('051005', 'Canaria', '0510', '05'),
('051006', 'Cayara', '0510', '05'),
('051007', 'Colca', '0510', '05'),
('051008', 'Huamanquiquia', '0510', '05'),
('051009', 'Huancaraylla', '0510', '05'),
('051010', 'Hualla', '0510', '05'),
('051011', 'Sarhua', '0510', '05'),
('051012', 'Vilcanchos', '0510', '05'),
('051101', 'Vilcas Huaman', '0511', '05'),
('051102', 'Accomarca', '0511', '05'),
('051103', 'Carhuanca', '0511', '05'),
('051104', 'Concepción', '0511', '05'),
('051105', 'Huambalpa', '0511', '05'),
('051106', 'Independencia', '0511', '05'),
('051107', 'Saurama', '0511', '05'),
('051108', 'Vischongo', '0511', '05'),
('060101', 'Cajamarca', '0601', '06'),
('060102', 'Asunción', '0601', '06'),
('060103', 'Chetilla', '0601', '06'),
('060104', 'Cospan', '0601', '06'),
('060105', 'Encañada', '0601', '06'),
('060106', 'Jesús', '0601', '06'),
('060107', 'Llacanora', '0601', '06'),
('060108', 'Los Baños del Inca', '0601', '06'),
('060109', 'Magdalena', '0601', '06'),
('060110', 'Matara', '0601', '06'),
('060111', 'Namora', '0601', '06'),
('060112', 'San Juan', '0601', '06'),
('060201', 'Cajabamba', '0602', '06'),
('060202', 'Cachachi', '0602', '06'),
('060203', 'Condebamba', '0602', '06'),
('060204', 'Sitacocha', '0602', '06'),
('060301', 'Celendín', '0603', '06'),
('060302', 'Chumuch', '0603', '06'),
('060303', 'Cortegana', '0603', '06'),
('060304', 'Huasmin', '0603', '06'),
('060305', 'Jorge Chávez', '0603', '06'),
('060306', 'José Gálvez', '0603', '06'),
('060307', 'Miguel Iglesias', '0603', '06'),
('060308', 'Oxamarca', '0603', '06'),
('060309', 'Sorochuco', '0603', '06'),
('060310', 'Sucre', '0603', '06'),
('060311', 'Utco', '0603', '06'),
('060312', 'La Libertad de Pallan', '0603', '06'),
('060401', 'Chota', '0604', '06'),
('060402', 'Anguia', '0604', '06'),
('060403', 'Chadin', '0604', '06'),
('060404', 'Chiguirip', '0604', '06'),
('060405', 'Chimban', '0604', '06'),
('060406', 'Choropampa', '0604', '06'),
('060407', 'Cochabamba', '0604', '06'),
('060408', 'Conchan', '0604', '06'),
('060409', 'Huambos', '0604', '06'),
('060410', 'Lajas', '0604', '06'),
('060411', 'Llama', '0604', '06'),
('060412', 'Miracosta', '0604', '06'),
('060413', 'Paccha', '0604', '06'),
('060414', 'Pion', '0604', '06'),
('060415', 'Querocoto', '0604', '06'),
('060416', 'San Juan de Licupis', '0604', '06'),
('060417', 'Tacabamba', '0604', '06'),
('060418', 'Tocmoche', '0604', '06'),
('060419', 'Chalamarca', '0604', '06'),
('060501', 'Contumaza', '0605', '06'),
('060502', 'Chilete', '0605', '06'),
('060503', 'Cupisnique', '0605', '06'),
('060504', 'Guzmango', '0605', '06'),
('060505', 'San Benito', '0605', '06'),
('060506', 'Santa Cruz de Toledo', '0605', '06'),
('060507', 'Tantarica', '0605', '06'),
('060508', 'Yonan', '0605', '06'),
('060601', 'Cutervo', '0606', '06'),
('060602', 'Callayuc', '0606', '06'),
('060603', 'Choros', '0606', '06'),
('060604', 'Cujillo', '0606', '06'),
('060605', 'La Ramada', '0606', '06'),
('060606', 'Pimpingos', '0606', '06'),
('060607', 'Querocotillo', '0606', '06'),
('060608', 'San Andrés de Cutervo', '0606', '06'),
('060609', 'San Juan de Cutervo', '0606', '06'),
('060610', 'San Luis de Lucma', '0606', '06'),
('060611', 'Santa Cruz', '0606', '06'),
('060612', 'Santo Domingo de la Capilla', '0606', '06'),
('060613', 'Santo Tomas', '0606', '06'),
('060614', 'Socota', '0606', '06'),
('060615', 'Toribio Casanova', '0606', '06'),
('060701', 'Bambamarca', '0607', '06'),
('060702', 'Chugur', '0607', '06'),
('060703', 'Hualgayoc', '0607', '06'),
('060801', 'Jaén', '0608', '06'),
('060802', 'Bellavista', '0608', '06'),
('060803', 'Chontali', '0608', '06'),
('060804', 'Colasay', '0608', '06'),
('060805', 'Huabal', '0608', '06'),
('060806', 'Las Pirias', '0608', '06'),
('060807', 'Pomahuaca', '0608', '06'),
('060808', 'Pucara', '0608', '06'),
('060809', 'Sallique', '0608', '06'),
('060810', 'San Felipe', '0608', '06'),
('060811', 'San José del Alto', '0608', '06'),
('060812', 'Santa Rosa', '0608', '06'),
('060901', 'San Ignacio', '0609', '06'),
('060902', 'Chirinos', '0609', '06'),
('060903', 'Huarango', '0609', '06'),
('060904', 'La Coipa', '0609', '06'),
('060905', 'Namballe', '0609', '06'),
('060906', 'San José de Lourdes', '0609', '06'),
('060907', 'Tabaconas', '0609', '06'),
('061001', 'Pedro Gálvez', '0610', '06'),
('061002', 'Chancay', '0610', '06'),
('061003', 'Eduardo Villanueva', '0610', '06'),
('061004', 'Gregorio Pita', '0610', '06'),
('061005', 'Ichocan', '0610', '06'),
('061006', 'José Manuel Quiroz', '0610', '06'),
('061007', 'José Sabogal', '0610', '06'),
('061101', 'San Miguel', '0611', '06'),
('061102', 'Bolívar', '0611', '06'),
('061103', 'Calquis', '0611', '06'),
('061104', 'Catilluc', '0611', '06'),
('061105', 'El Prado', '0611', '06'),
('061106', 'La Florida', '0611', '06'),
('061107', 'Llapa', '0611', '06'),
('061108', 'Nanchoc', '0611', '06'),
('061109', 'Niepos', '0611', '06'),
('061110', 'San Gregorio', '0611', '06'),
('061111', 'San Silvestre de Cochan', '0611', '06'),
('061112', 'Tongod', '0611', '06'),
('061113', 'Unión Agua Blanca', '0611', '06'),
('061201', 'San Pablo', '0612', '06'),
('061202', 'San Bernardino', '0612', '06'),
('061203', 'San Luis', '0612', '06'),
('061204', 'Tumbaden', '0612', '06'),
('061301', 'Santa Cruz', '0613', '06'),
('061302', 'Andabamba', '0613', '06'),
('061303', 'Catache', '0613', '06'),
('061304', 'Chancaybaños', '0613', '06'),
('061305', 'La Esperanza', '0613', '06'),
('061306', 'Ninabamba', '0613', '06'),
('061307', 'Pulan', '0613', '06'),
('061308', 'Saucepampa', '0613', '06'),
('061309', 'Sexi', '0613', '06'),
('061310', 'Uticyacu', '0613', '06'),
('061311', 'Yauyucan', '0613', '06'),
('070101', 'Callao', '0701', '07'),
('070102', 'Bellavista', '0701', '07'),
('070103', 'Carmen de la Legua Reynoso', '0701', '07'),
('070104', 'La Perla', '0701', '07'),
('070105', 'La Punta', '0701', '07'),
('070106', 'Ventanilla', '0701', '07'),
('070107', 'Mi Perú', '0701', '07'),
('080101', 'Cusco', '0801', '08'),
('080102', 'Ccorca', '0801', '08'),
('080103', 'Poroy', '0801', '08'),
('080104', 'San Jerónimo', '0801', '08'),
('080105', 'San Sebastian', '0801', '08'),
('080106', 'Santiago', '0801', '08'),
('080107', 'Saylla', '0801', '08'),
('080108', 'Wanchaq', '0801', '08'),
('080201', 'Acomayo', '0802', '08'),
('080202', 'Acopia', '0802', '08'),
('080203', 'Acos', '0802', '08'),
('080204', 'Mosoc Llacta', '0802', '08'),
('080205', 'Pomacanchi', '0802', '08'),
('080206', 'Rondocan', '0802', '08'),
('080207', 'Sangarara', '0802', '08'),
('080301', 'Anta', '0803', '08'),
('080302', 'Ancahuasi', '0803', '08'),
('080303', 'Cachimayo', '0803', '08'),
('080304', 'Chinchaypujio', '0803', '08'),
('080305', 'Huarocondo', '0803', '08'),
('080306', 'Limatambo', '0803', '08'),
('080307', 'Mollepata', '0803', '08'),
('080308', 'Pucyura', '0803', '08'),
('080309', 'Zurite', '0803', '08'),
('080401', 'Calca', '0804', '08'),
('080402', 'Coya', '0804', '08'),
('080403', 'Lamay', '0804', '08'),
('080404', 'Lares', '0804', '08'),
('080405', 'Pisac', '0804', '08'),
('080406', 'San Salvador', '0804', '08'),
('080407', 'Taray', '0804', '08'),
('080408', 'Yanatile', '0804', '08'),
('080501', 'Yanaoca', '0805', '08'),
('080502', 'Checca', '0805', '08'),
('080503', 'Kunturkanki', '0805', '08'),
('080504', 'Langui', '0805', '08'),
('080505', 'Layo', '0805', '08'),
('080506', 'Pampamarca', '0805', '08'),
('080507', 'Quehue', '0805', '08'),
('080508', 'Tupac Amaru', '0805', '08'),
('080601', 'Sicuani', '0806', '08'),
('080602', 'Checacupe', '0806', '08'),
('080603', 'Combapata', '0806', '08'),
('080604', 'Marangani', '0806', '08'),
('080605', 'Pitumarca', '0806', '08'),
('080606', 'San Pablo', '0806', '08'),
('080607', 'San Pedro', '0806', '08'),
('080608', 'Tinta', '0806', '08'),
('080701', 'Santo Tomas', '0807', '08'),
('080702', 'Capacmarca', '0807', '08'),
('080703', 'Chamaca', '0807', '08'),
('080704', 'Colquemarca', '0807', '08'),
('080705', 'Livitaca', '0807', '08'),
('080706', 'Llusco', '0807', '08'),
('080707', 'Quiñota', '0807', '08'),
('080708', 'Velille', '0807', '08'),
('080801', 'Espinar', '0808', '08'),
('080802', 'Condoroma', '0808', '08'),
('080803', 'Coporaque', '0808', '08'),
('080804', 'Ocoruro', '0808', '08'),
('080805', 'Pallpata', '0808', '08'),
('080806', 'Pichigua', '0808', '08'),
('080807', 'Suyckutambo', '0808', '08'),
('080808', 'Alto Pichigua', '0808', '08'),
('080901', 'Santa Ana', '0809', '08'),
('080902', 'Echarate', '0809', '08'),
('080903', 'Huayopata', '0809', '08'),
('080904', 'Maranura', '0809', '08'),
('080905', 'Ocobamba', '0809', '08'),
('080906', 'Quellouno', '0809', '08'),
('080907', 'Kimbiri', '0809', '08'),
('080908', 'Santa Teresa', '0809', '08'),
('080909', 'Vilcabamba', '0809', '08'),
('080910', 'Pichari', '0809', '08'),
('080911', 'Inkawasi', '0809', '08'),
('080912', 'Villa Virgen', '0809', '08'),
('080913', 'Villa Kintiarina', '0809', '08'),
('080914', 'Megantoni', '0809', '08'),
('081001', 'Paruro', '0810', '08'),
('081002', 'Accha', '0810', '08'),
('081003', 'Ccapi', '0810', '08'),
('081004', 'Colcha', '0810', '08'),
('081005', 'Huanoquite', '0810', '08'),
('081006', 'Omachaç', '0810', '08'),
('081007', 'Paccaritambo', '0810', '08'),
('081008', 'Pillpinto', '0810', '08'),
('081009', 'Yaurisque', '0810', '08'),
('081101', 'Paucartambo', '0811', '08'),
('081102', 'Caicay', '0811', '08'),
('081103', 'Challabamba', '0811', '08'),
('081104', 'Colquepata', '0811', '08'),
('081105', 'Huancarani', '0811', '08'),
('081106', 'Kosñipata', '0811', '08'),
('081201', 'Urcos', '0812', '08'),
('081202', 'Andahuaylillas', '0812', '08'),
('081203', 'Camanti', '0812', '08'),
('081204', 'Ccarhuayo', '0812', '08'),
('081205', 'Ccatca', '0812', '08'),
('081206', 'Cusipata', '0812', '08'),
('081207', 'Huaro', '0812', '08'),
('081208', 'Lucre', '0812', '08'),
('081209', 'Marcapata', '0812', '08'),
('081210', 'Ocongate', '0812', '08'),
('081211', 'Oropesa', '0812', '08'),
('081212', 'Quiquijana', '0812', '08'),
('081301', 'Urubamba', '0813', '08'),
('081302', 'Chinchero', '0813', '08'),
('081303', 'Huayllabamba', '0813', '08'),
('081304', 'Machupicchu', '0813', '08'),
('081305', 'Maras', '0813', '08'),
('081306', 'Ollantaytambo', '0813', '08'),
('081307', 'Yucay', '0813', '08'),
('090101', 'Huancavelica', '0901', '09'),
('090102', 'Acobambilla', '0901', '09'),
('090103', 'Acoria', '0901', '09'),
('090104', 'Conayca', '0901', '09'),
('090105', 'Cuenca', '0901', '09'),
('090106', 'Huachocolpa', '0901', '09'),
('090107', 'Huayllahuara', '0901', '09'),
('090108', 'Izcuchaca', '0901', '09'),
('090109', 'Laria', '0901', '09'),
('090110', 'Manta', '0901', '09'),
('090111', 'Mariscal Cáceres', '0901', '09'),
('090112', 'Moya', '0901', '09'),
('090113', 'Nuevo Occoro', '0901', '09'),
('090114', 'Palca', '0901', '09'),
('090115', 'Pilchaca', '0901', '09'),
('090116', 'Vilca', '0901', '09'),
('090117', 'Yauli', '0901', '09'),
('090118', 'Ascensión', '0901', '09'),
('090119', 'Huando', '0901', '09'),
('090201', 'Acobamba', '0902', '09'),
('090202', 'Andabamba', '0902', '09'),
('090203', 'Anta', '0902', '09'),
('090204', 'Caja', '0902', '09'),
('090205', 'Marcas', '0902', '09'),
('090206', 'Paucara', '0902', '09'),
('090207', 'Pomacocha', '0902', '09'),
('090208', 'Rosario', '0902', '09'),
('090301', 'Lircay', '0903', '09'),
('090302', 'Anchonga', '0903', '09'),
('090303', 'Callanmarca', '0903', '09'),
('090304', 'Ccochaccasa', '0903', '09'),
('090305', 'Chincho', '0903', '09'),
('090306', 'Congalla', '0903', '09'),
('090307', 'Huanca-Huanca', '0903', '09'),
('090308', 'Huayllay Grande', '0903', '09'),
('090309', 'Julcamarca', '0903', '09'),
('090310', 'San Antonio de Antaparco', '0903', '09'),
('090311', 'Santo Tomas de Pata', '0903', '09'),
('090312', 'Secclla', '0903', '09'),
('090401', 'Castrovirreyna', '0904', '09'),
('090402', 'Arma', '0904', '09'),
('090403', 'Aurahua', '0904', '09'),
('090404', 'Capillas', '0904', '09'),
('090405', 'Chupamarca', '0904', '09'),
('090406', 'Cocas', '0904', '09'),
('090407', 'Huachos', '0904', '09'),
('090408', 'Huamatambo', '0904', '09'),
('090409', 'Mollepampa', '0904', '09'),
('090410', 'San Juan', '0904', '09'),
('090411', 'Santa Ana', '0904', '09'),
('090412', 'Tantara', '0904', '09'),
('090413', 'Ticrapo', '0904', '09'),
('090501', 'Churcampa', '0905', '09'),
('090502', 'Anco', '0905', '09'),
('090503', 'Chinchihuasi', '0905', '09'),
('090504', 'El Carmen', '0905', '09'),
('090505', 'La Merced', '0905', '09'),
('090506', 'Locroja', '0905', '09'),
('090507', 'Paucarbamba', '0905', '09'),
('090508', 'San Miguel de Mayocc', '0905', '09'),
('090509', 'San Pedro de Coris', '0905', '09'),
('090510', 'Pachamarca', '0905', '09'),
('090511', 'Cosme', '0905', '09'),
('090601', 'Huaytara', '0906', '09'),
('090602', 'Ayavi', '0906', '09'),
('090603', 'Córdova', '0906', '09'),
('090604', 'Huayacundo Arma', '0906', '09'),
('090605', 'Laramarca', '0906', '09'),
('090606', 'Ocoyo', '0906', '09'),
('090607', 'Pilpichaca', '0906', '09'),
('090608', 'Querco', '0906', '09'),
('090609', 'Quito-Arma', '0906', '09'),
('090610', 'San Antonio de Cusicancha', '0906', '09'),
('090611', 'San Francisco de Sangayaico', '0906', '09'),
('090612', 'San Isidro', '0906', '09'),
('090613', 'Santiago de Chocorvos', '0906', '09'),
('090614', 'Santiago de Quirahuara', '0906', '09'),
('090615', 'Santo Domingo de Capillas', '0906', '09'),
('090616', 'Tambo', '0906', '09'),
('090701', 'Pampas', '0907', '09'),
('090702', 'Acostambo', '0907', '09'),
('090703', 'Acraquia', '0907', '09'),
('090704', 'Ahuaycha', '0907', '09'),
('090705', 'Colcabamba', '0907', '09'),
('090706', 'Daniel Hernández', '0907', '09'),
('090707', 'Huachocolpa', '0907', '09'),
('090709', 'Huaribamba', '0907', '09'),
('090710', 'Ñahuimpuquio', '0907', '09'),
('090711', 'Pazos', '0907', '09'),
('090713', 'Quishuar', '0907', '09'),
('090714', 'Salcabamba', '0907', '09'),
('090715', 'Salcahuasi', '0907', '09'),
('090716', 'San Marcos de Rocchac', '0907', '09'),
('090717', 'Surcubamba', '0907', '09'),
('090718', 'Tintay Puncu', '0907', '09'),
('090719', 'Quichuas', '0907', '09'),
('090720', 'Andaymarca', '0907', '09'),
('090721', 'Roble', '0907', '09'),
('090722', 'Pichos', '0907', '09'),
('090723', 'Santiago de Tucuma', '0907', '09'),
('100101', 'Huanuco', '1001', '10'),
('100102', 'Amarilis', '1001', '10'),
('100103', 'Chinchao', '1001', '10'),
('100104', 'Churubamba', '1001', '10'),
('100105', 'Margos', '1001', '10'),
('100106', 'Quisqui (Kichki)', '1001', '10'),
('100107', 'San Francisco de Cayran', '1001', '10'),
('100108', 'San Pedro de Chaulan', '1001', '10'),
('100109', 'Santa María del Valle', '1001', '10'),
('100110', 'Yarumayo', '1001', '10'),
('100111', 'Pillco Marca', '1001', '10'),
('100112', 'Yacus', '1001', '10'),
('100113', 'San Pablo de Pillao', '1001', '10'),
('100201', 'Ambo', '1002', '10'),
('100202', 'Cayna', '1002', '10'),
('100203', 'Colpas', '1002', '10'),
('100204', 'Conchamarca', '1002', '10'),
('100205', 'Huacar', '1002', '10'),
('100206', 'San Francisco', '1002', '10'),
('100207', 'San Rafael', '1002', '10'),
('100208', 'Tomay Kichwa', '1002', '10'),
('100301', 'La Unión', '1003', '10'),
('100307', 'Chuquis', '1003', '10'),
('100311', 'Marías', '1003', '10'),
('100313', 'Pachas', '1003', '10'),
('100316', 'Quivilla', '1003', '10'),
('100317', 'Ripan', '1003', '10'),
('100321', 'Shunqui', '1003', '10'),
('100322', 'Sillapata', '1003', '10'),
('100323', 'Yanas', '1003', '10'),
('100401', 'Huacaybamba', '1004', '10'),
('100402', 'Canchabamba', '1004', '10'),
('100403', 'Cochabamba', '1004', '10'),
('100404', 'Pinra', '1004', '10'),
('100501', 'Llata', '1005', '10'),
('100502', 'Arancay', '1005', '10'),
('100503', 'Chavín de Pariarca', '1005', '10'),
('100504', 'Jacas Grande', '1005', '10'),
('100505', 'Jircan', '1005', '10'),
('100506', 'Miraflores', '1005', '10'),
('100507', 'Monzón', '1005', '10'),
('100508', 'Punchao', '1005', '10'),
('100509', 'Puños', '1005', '10'),
('100510', 'Singa', '1005', '10'),
('100511', 'Tantamayo', '1005', '10'),
('100601', 'Rupa-Rupa', '1006', '10'),
('100602', 'Daniel Alomía Robles', '1006', '10'),
('100603', 'Hermílio Valdizan', '1006', '10'),
('100604', 'José Crespo y Castillo', '1006', '10'),
('100605', 'Luyando', '1006', '10'),
('100606', 'Mariano Damaso Beraun', '1006', '10'),
('100607', 'Pucayacu', '1006', '10'),
('100608', 'Castillo Grande', '1006', '10'),
('100609', 'Pueblo Nuevo', '1006', '10'),
('100610', 'Santo Domingo de Anda', '1006', '10'),
('100701', 'Huacrachuco', '1007', '10'),
('100702', 'Cholon', '1007', '10'),
('100703', 'San Buenaventura', '1007', '10'),
('100704', 'La Morada', '1007', '10'),
('100705', 'Santa Rosa de Alto Yanajanca', '1007', '10'),
('100801', 'Panao', '1008', '10'),
('100802', 'Chaglla', '1008', '10'),
('100803', 'Molino', '1008', '10'),
('100804', 'Umari', '1008', '10'),
('100901', 'Puerto Inca', '1009', '10'),
('100902', 'Codo del Pozuzo', '1009', '10'),
('100903', 'Honoria', '1009', '10'),
('100904', 'Tournavista', '1009', '10'),
('100905', 'Yuyapichis', '1009', '10'),
('101001', 'Jesús', '1010', '10'),
('101002', 'Baños', '1010', '10'),
('101003', 'Jivia', '1010', '10'),
('101004', 'Queropalca', '1010', '10'),
('101005', 'Rondos', '1010', '10'),
('101006', 'San Francisco de Asís', '1010', '10'),
('101007', 'San Miguel de Cauri', '1010', '10'),
('101101', 'Chavinillo', '1011', '10'),
('101102', 'Cahuac', '1011', '10'),
('101103', 'Chacabamba', '1011', '10'),
('101104', 'Aparicio Pomares', '1011', '10'),
('101105', 'Jacas Chico', '1011', '10'),
('101106', 'Obas', '1011', '10'),
('101107', 'Pampamarca', '1011', '10'),
('101108', 'Choras', '1011', '10'),
('110101', 'Ica', '1101', '11'),
('110102', 'La Tinguiña', '1101', '11'),
('110103', 'Los Aquijes', '1101', '11'),
('110104', 'Ocucaje', '1101', '11'),
('110105', 'Pachacutec', '1101', '11'),
('110106', 'Parcona', '1101', '11'),
('110107', 'Pueblo Nuevo', '1101', '11'),
('110108', 'Salas', '1101', '11')
go
insert into tb_distrito values
('110109', 'San José de Los Molinos', '1101', '11'),
('110110', 'San Juan Bautista', '1101', '11'),
('110111', 'Santiago', '1101', '11'),
('110112', 'Subtanjalla', '1101', '11'),
('110113', 'Tate', '1101', '11'),
('110114', 'Yauca del Rosario', '1101', '11'),
('110201', 'Chincha Alta', '1102', '11'),
('110202', 'Alto Laran', '1102', '11'),
('110203', 'Chavin', '1102', '11'),
('110204', 'Chincha Baja', '1102', '11'),
('110205', 'El Carmen', '1102', '11'),
('110206', 'Grocio Prado', '1102', '11'),
('110207', 'Pueblo Nuevo', '1102', '11'),
('110208', 'San Juan de Yanac', '1102', '11'),
('110209', 'San Pedro de Huacarpana', '1102', '11'),
('110210', 'Sunampe', '1102', '11'),
('110211', 'Tambo de Mora', '1102', '11'),
('110301', 'Nasca', '1103', '11'),
('110302', 'Changuillo', '1103', '11'),
('110303', 'El Ingenio', '1103', '11'),
('110304', 'Marcona', '1103', '11'),
('110305', 'Vista Alegre', '1103', '11'),
('110401', 'Palpa', '1104', '11'),
('110402', 'Llipata', '1104', '11'),
('110403', 'Río Grande', '1104', '11'),
('110404', 'Santa Cruz', '1104', '11'),
('110405', 'Tibillo', '1104', '11'),
('110501', 'Pisco', '1105', '11'),
('110502', 'Huancano', '1105', '11'),
('110503', 'Humay', '1105', '11'),
('110504', 'Independencia', '1105', '11'),
('110505', 'Paracas', '1105', '11'),
('110506', 'San Andrés', '1105', '11'),
('110507', 'San Clemente', '1105', '11'),
('110508', 'Tupac Amaru Inca', '1105', '11'),
('120101', 'Huancayo', '1201', '12'),
('120104', 'Carhuacallanga', '1201', '12'),
('120105', 'Chacapampa', '1201', '12'),
('120106', 'Chicche', '1201', '12'),
('120107', 'Chilca', '1201', '12'),
('120108', 'Chongos Alto', '1201', '12'),
('120111', 'Chupuro', '1201', '12'),
('120112', 'Colca', '1201', '12'),
('120113', 'Cullhuas', '1201', '12'),
('120114', 'El Tambo', '1201', '12'),
('120116', 'Huacrapuquio', '1201', '12'),
('120117', 'Hualhuas', '1201', '12'),
('120119', 'Huancan', '1201', '12'),
('120120', 'Huasicancha', '1201', '12'),
('120121', 'Huayucachi', '1201', '12'),
('120122', 'Ingenio', '1201', '12'),
('120124', 'Pariahuanca', '1201', '12'),
('120125', 'Pilcomayo', '1201', '12'),
('120126', 'Pucara', '1201', '12'),
('120127', 'Quichuay', '1201', '12'),
('120128', 'Quilcas', '1201', '12'),
('120129', 'San Agustín', '1201', '12'),
('120130', 'San Jerónimo de Tunan', '1201', '12'),
('120132', 'Saño', '1201', '12'),
('120133', 'Sapallanga', '1201', '12'),
('120134', 'Sicaya', '1201', '12'),
('120135', 'Santo Domingo de Acobamba', '1201', '12'),
('120136', 'Viques', '1201', '12'),
('120201', 'Concepción', '1202', '12'),
('120202', 'Aco', '1202', '12'),
('120203', 'Andamarca', '1202', '12'),
('120204', 'Chambara', '1202', '12'),
('120205', 'Cochas', '1202', '12'),
('120206', 'Comas', '1202', '12'),
('120207', 'Heroínas Toledo', '1202', '12'),
('120208', 'Manzanares', '1202', '12'),
('120209', 'Mariscal Castilla', '1202', '12'),
('120210', 'Matahuasi', '1202', '12'),
('120211', 'Mito', '1202', '12'),
('120212', 'Nueve de Julio', '1202', '12'),
('120213', 'Orcotuna', '1202', '12'),
('120214', 'San José de Quero', '1202', '12'),
('120215', 'Santa Rosa de Ocopa', '1202', '12'),
('120301', 'Chanchamayo', '1203', '12'),
('120302', 'Perene', '1203', '12'),
('120303', 'Pichanaqui', '1203', '12'),
('120304', 'San Luis de Shuaro', '1203', '12'),
('120305', 'San Ramón', '1203', '12'),
('120306', 'Vitoc', '1203', '12'),
('120401', 'Jauja', '1204', '12'),
('120402', 'Acolla', '1204', '12'),
('120403', 'Apata', '1204', '12'),
('120404', 'Ataura', '1204', '12'),
('120405', 'Canchayllo', '1204', '12'),
('120406', 'Curicaca', '1204', '12'),
('120407', 'El Mantaro', '1204', '12'),
('120408', 'Huamali', '1204', '12'),
('120409', 'Huaripampa', '1204', '12'),
('120410', 'Huertas', '1204', '12'),
('120411', 'Janjaillo', '1204', '12'),
('120412', 'Julcán', '1204', '12'),
('120413', 'Leonor Ordóñez', '1204', '12'),
('120414', 'Llocllapampa', '1204', '12'),
('120415', 'Marco', '1204', '12'),
('120416', 'Masma', '1204', '12'),
('120417', 'Masma Chicche', '1204', '12'),
('120418', 'Molinos', '1204', '12'),
('120419', 'Monobamba', '1204', '12'),
('120420', 'Muqui', '1204', '12'),
('120421', 'Muquiyauyo', '1204', '12'),
('120422', 'Paca', '1204', '12'),
('120423', 'Paccha', '1204', '12'),
('120424', 'Pancan', '1204', '12'),
('120425', 'Parco', '1204', '12'),
('120426', 'Pomacancha', '1204', '12'),
('120427', 'Ricran', '1204', '12'),
('120428', 'San Lorenzo', '1204', '12'),
('120429', 'San Pedro de Chunan', '1204', '12'),
('120430', 'Sausa', '1204', '12'),
('120431', 'Sincos', '1204', '12'),
('120432', 'Tunan Marca', '1204', '12'),
('120433', 'Yauli', '1204', '12'),
('120434', 'Yauyos', '1204', '12'),
('120501', 'Junin', '1205', '12'),
('120502', 'Carhuamayo', '1205', '12'),
('120503', 'Ondores', '1205', '12'),
('120504', 'Ulcumayo', '1205', '12'),
('120601', 'Satipo', '1206', '12'),
('120602', 'Coviriali', '1206', '12'),
('120603', 'Llaylla', '1206', '12'),
('120604', 'Mazamari', '1206', '12'),
('120605', 'Pampa Hermosa', '1206', '12'),
('120606', 'Pangoa', '1206', '12'),
('120607', 'Río Negro', '1206', '12'),
('120608', 'Río Tambo', '1206', '12'),
('120609', 'Vizcatan del Ene', '1206', '12'),
('120701', 'Tarma', '1207', '12'),
('120702', 'Acobamba', '1207', '12'),
('120703', 'Huaricolca', '1207', '12'),
('120704', 'Huasahuasi', '1207', '12'),
('120705', 'La Unión', '1207', '12'),
('120706', 'Palca', '1207', '12'),
('120707', 'Palcamayo', '1207', '12'),
('120708', 'San Pedro de Cajas', '1207', '12'),
('120709', 'Tapo', '1207', '12'),
('120801', 'La Oroya', '1208', '12'),
('120802', 'Chacapalpa', '1208', '12'),
('120803', 'Huay-Huay', '1208', '12'),
('120804', 'Marcapomacocha', '1208', '12'),
('120805', 'Morococha', '1208', '12'),
('120806', 'Paccha', '1208', '12'),
('120807', 'Santa Bárbara de Carhuacayan', '1208', '12'),
('120808', 'Santa Rosa de Sacco', '1208', '12'),
('120809', 'Suitucancha', '1208', '12'),
('120810', 'Yauli', '1208', '12'),
('120901', 'Chupaca', '1209', '12'),
('120902', 'Ahuac', '1209', '12'),
('120903', 'Chongos Bajo', '1209', '12'),
('120904', 'Huachac', '1209', '12'),
('120905', 'Huamancaca Chico', '1209', '12'),
('120906', 'San Juan de Iscos', '1209', '12'),
('120907', 'San Juan de Jarpa', '1209', '12'),
('120908', 'Tres de Diciembre', '1209', '12'),
('120909', 'Yanacancha', '1209', '12'),
('130101', 'Trujillo', '1301', '13'),
('130102', 'El Porvenir', '1301', '13'),
('130103', 'Florencia de Mora', '1301', '13'),
('130104', 'Huanchaco', '1301', '13'),
('130105', 'La Esperanza', '1301', '13'),
('130106', 'Laredo', '1301', '13'),
('130107', 'Moche', '1301', '13'),
('130108', 'Poroto', '1301', '13'),
('130109', 'Salaverry', '1301', '13'),
('130110', 'Simbal', '1301', '13'),
('130111', 'Victor Larco Herrera', '1301', '13'),
('130201', 'Ascope', '1302', '13'),
('130202', 'Chicama', '1302', '13'),
('130203', 'Chocope', '1302', '13'),
('130204', 'Magdalena de Cao', '1302', '13'),
('130205', 'Paijan', '1302', '13'),
('130206', 'Rázuri', '1302', '13'),
('130207', 'Santiago de Cao', '1302', '13'),
('130208', 'Casa Grande', '1302', '13'),
('130301', 'Bolívar', '1303', '13'),
('130302', 'Bambamarca', '1303', '13'),
('130303', 'Condormarca', '1303', '13'),
('130304', 'Longotea', '1303', '13'),
('130305', 'Uchumarca', '1303', '13'),
('130306', 'Ucuncha', '1303', '13'),
('130401', 'Chepen', '1304', '13'),
('130402', 'Pacanga', '1304', '13'),
('130403', 'Pueblo Nuevo', '1304', '13'),
('130501', 'Julcan', '1305', '13'),
('130502', 'Calamarca', '1305', '13'),
('130503', 'Carabamba', '1305', '13'),
('130504', 'Huaso', '1305', '13'),
('130601', 'Otuzco', '1306', '13'),
('130602', 'Agallpampa', '1306', '13'),
('130604', 'Charat', '1306', '13'),
('130605', 'Huaranchal', '1306', '13'),
('130606', 'La Cuesta', '1306', '13'),
('130608', 'Mache', '1306', '13'),
('130610', 'Paranday', '1306', '13'),
('130611', 'Salpo', '1306', '13'),
('130613', 'Sinsicap', '1306', '13'),
('130614', 'Usquil', '1306', '13'),
('130701', 'San Pedro de Lloc', '1307', '13'),
('130702', 'Guadalupe', '1307', '13'),
('130703', 'Jequetepeque', '1307', '13'),
('130704', 'Pacasmayo', '1307', '13'),
('130705', 'San José', '1307', '13'),
('130801', 'Tayabamba', '1308', '13'),
('130802', 'Buldibuyo', '1308', '13'),
('130803', 'Chillia', '1308', '13'),
('130804', 'Huancaspata', '1308', '13'),
('130805', 'Huaylillas', '1308', '13'),
('130806', 'Huayo', '1308', '13'),
('130807', 'Ongon', '1308', '13'),
('130808', 'Parcoy', '1308', '13'),
('130809', 'Pataz', '1308', '13'),
('130810', 'Pias', '1308', '13'),
('130811', 'Santiago de Challas', '1308', '13'),
('130812', 'Taurija', '1308', '13'),
('130813', 'Urpay', '1308', '13'),
('130901', 'Huamachuco', '1309', '13'),
('130902', 'Chugay', '1309', '13'),
('130903', 'Cochorco', '1309', '13'),
('130904', 'Curgos', '1309', '13'),
('130905', 'Marcabal', '1309', '13'),
('130906', 'Sanagoran', '1309', '13'),
('130907', 'Sarin', '1309', '13'),
('130908', 'Sartimbamba', '1309', '13'),
('131001', 'Santiago de Chuco', '1310', '13'),
('131002', 'Angasmarca', '1310', '13'),
('131003', 'Cachicadan', '1310', '13'),
('131004', 'Mollebamba', '1310', '13'),
('131005', 'Mollepata', '1310', '13'),
('131006', 'Quiruvilca', '1310', '13'),
('131007', 'Santa Cruz de Chuca', '1310', '13'),
('131008', 'Sitabamba', '1310', '13'),
('131101', 'Cascas', '1311', '13'),
('131102', 'Lucma', '1311', '13'),
('131103', 'Marmot', '1311', '13'),
('131104', 'Sayapullo', '1311', '13'),
('131201', 'Viru', '1312', '13'),
('131202', 'Chao', '1312', '13'),
('131203', 'Guadalupito', '1312', '13'),
('140101', 'Chiclayo', '1401', '14'),
('140102', 'Chongoyape', '1401', '14'),
('140103', 'Eten', '1401', '14'),
('140104', 'Eten Puerto', '1401', '14'),
('140105', 'José Leonardo Ortiz', '1401', '14'),
('140106', 'La Victoria', '1401', '14'),
('140107', 'Lagunas', '1401', '14'),
('140108', 'Monsefu', '1401', '14'),
('140109', 'Nueva Arica', '1401', '14'),
('140110', 'Oyotun', '1401', '14'),
('140111', 'Picsi', '1401', '14'),
('140112', 'Pimentel', '1401', '14'),
('140113', 'Reque', '1401', '14'),
('140114', 'Santa Rosa', '1401', '14'),
('140115', 'Saña', '1401', '14'),
('140116', 'Cayalti', '1401', '14'),
('140117', 'Patapo', '1401', '14'),
('140118', 'Pomalca', '1401', '14'),
('140119', 'Pucala', '1401', '14'),
('140120', 'Tuman', '1401', '14'),
('140201', 'Ferreñafe', '1402', '14'),
('140202', 'Cañaris', '1402', '14'),
('140203', 'Incahuasi', '1402', '14'),
('140204', 'Manuel Antonio Mesones Muro', '1402', '14'),
('140205', 'Pitipo', '1402', '14'),
('140206', 'Pueblo Nuevo', '1402', '14'),
('140301', 'Lambayeque', '1403', '14'),
('140302', 'Chochope', '1403', '14'),
('140303', 'Illimo', '1403', '14'),
('140304', 'Jayanca', '1403', '14'),
('140305', 'Mochumi', '1403', '14'),
('140306', 'Morrope', '1403', '14'),
('140307', 'Motupe', '1403', '14'),
('140308', 'Olmos', '1403', '14'),
('140309', 'Pacora', '1403', '14'),
('140310', 'Salas', '1403', '14'),
('140311', 'San José', '1403', '14'),
('140312', 'Tucume', '1403', '14'),
('150101', 'Lima', '1501', '15'),
('150102', 'Ancón', '1501', '15'),
('150103', 'Ate', '1501', '15'),
('150104', 'Barranco', '1501', '15'),
('150105', 'Breña', '1501', '15'),
('150106', 'Carabayllo', '1501', '15'),
('150107', 'Chaclacayo', '1501', '15'),
('150108', 'Chorrillos', '1501', '15'),
('150109', 'Cieneguilla', '1501', '15'),
('150110', 'Comas', '1501', '15'),
('150111', 'El Agustino', '1501', '15'),
('150112', 'Independencia', '1501', '15'),
('150113', 'Jesús María', '1501', '15'),
('150114', 'La Molina', '1501', '15'),
('150115', 'La Victoria', '1501', '15'),
('150116', 'Lince', '1501', '15'),
('150117', 'Los Olivos', '1501', '15'),
('150118', 'Lurigancho', '1501', '15'),
('150119', 'Lurin', '1501', '15'),
('150120', 'Magdalena del Mar', '1501', '15'),
('150121', 'Pueblo Libre', '1501', '15'),
('150122', 'Miraflores', '1501', '15'),
('150123', 'Pachacamac', '1501', '15'),
('150124', 'Pucusana', '1501', '15'),
('150125', 'Puente Piedra', '1501', '15'),
('150126', 'Punta Hermosa', '1501', '15'),
('150127', 'Punta Negra', '1501', '15'),
('150128', 'Rímac', '1501', '15'),
('150129', 'San Bartolo', '1501', '15'),
('150130', 'San Borja', '1501', '15'),
('150131', 'San Isidro', '1501', '15'),
('150132', 'San Juan de Lurigancho', '1501', '15'),
('150133', 'San Juan de Miraflores', '1501', '15'),
('150134', 'San Luis', '1501', '15'),
('150135', 'San Martín de Porres', '1501', '15'),
('150136', 'San Miguel', '1501', '15'),
('150137', 'Santa Anita', '1501', '15'),
('150138', 'Santa María del Mar', '1501', '15'),
('150139', 'Santa Rosa', '1501', '15'),
('150140', 'Santiago de Surco', '1501', '15'),
('150141', 'Surquillo', '1501', '15'),
('150142', 'Villa El Salvador', '1501', '15'),
('150143', 'Villa María del Triunfo', '1501', '15'),
('150201', 'Barranca', '1502', '15'),
('150202', 'Paramonga', '1502', '15'),
('150203', 'Pativilca', '1502', '15'),
('150204', 'Supe', '1502', '15'),
('150205', 'Supe Puerto', '1502', '15'),
('150301', 'Cajatambo', '1503', '15'),
('150302', 'Copa', '1503', '15'),
('150303', 'Gorgor', '1503', '15'),
('150304', 'Huancapon', '1503', '15'),
('150305', 'Manas', '1503', '15'),
('150401', 'Canta', '1504', '15'),
('150402', 'Arahuay', '1504', '15'),
('150403', 'Huamantanga', '1504', '15'),
('150404', 'Huaros', '1504', '15'),
('150405', 'Lachaqui', '1504', '15'),
('150406', 'San Buenaventura', '1504', '15'),
('150407', 'Santa Rosa de Quives', '1504', '15'),
('150501', 'San Vicente de Cañete', '1505', '15'),
('150502', 'Asia', '1505', '15'),
('150503', 'Calango', '1505', '15'),
('150504', 'Cerro Azul', '1505', '15'),
('150505', 'Chilca', '1505', '15'),
('150506', 'Coayllo', '1505', '15'),
('150507', 'Imperial', '1505', '15'),
('150508', 'Lunahuana', '1505', '15'),
('150509', 'Mala', '1505', '15'),
('150510', 'Nuevo Imperial', '1505', '15'),
('150511', 'Pacaran', '1505', '15'),
('150512', 'Quilmana', '1505', '15'),
('150513', 'San Antonio', '1505', '15'),
('150514', 'San Luis', '1505', '15'),
('150515', 'Santa Cruz de Flores', '1505', '15'),
('150516', 'Zúñiga', '1505', '15'),
('150601', 'Huaral', '1506', '15'),
('150602', 'Atavillos Alto', '1506', '15'),
('150603', 'Atavillos Bajo', '1506', '15'),
('150604', 'Aucallama', '1506', '15'),
('150605', 'Chancay', '1506', '15'),
('150606', 'Ihuari', '1506', '15'),
('150607', 'Lampian', '1506', '15'),
('150608', 'Pacaraos', '1506', '15'),
('150609', 'San Miguel de Acos', '1506', '15'),
('150610', 'Santa Cruz de Andamarca', '1506', '15'),
('150611', 'Sumbilca', '1506', '15'),
('150612', 'Veintisiete de Noviembre', '1506', '15'),
('150701', 'Matucana', '1507', '15'),
('150702', 'Antioquia', '1507', '15'),
('150703', 'Callahuanca', '1507', '15'),
('150704', 'Carampoma', '1507', '15'),
('150705', 'Chicla', '1507', '15'),
('150706', 'Cuenca', '1507', '15'),
('150707', 'Huachupampa', '1507', '15'),
('150708', 'Huanza', '1507', '15'),
('150709', 'Huarochiri', '1507', '15'),
('150710', 'Lahuaytambo', '1507', '15'),
('150711', 'Langa', '1507', '15'),
('150712', 'Laraos', '1507', '15'),
('150713', 'Mariatana', '1507', '15'),
('150714', 'Ricardo Palma', '1507', '15'),
('150715', 'San Andrés de Tupicocha', '1507', '15'),
('150716', 'San Antonio', '1507', '15'),
('150717', 'San Bartolomé', '1507', '15'),
('150718', 'San Damian', '1507', '15'),
('150719', 'San Juan de Iris', '1507', '15'),
('150720', 'San Juan de Tantaranche', '1507', '15'),
('150721', 'San Lorenzo de Quinti', '1507', '15'),
('150722', 'San Mateo', '1507', '15'),
('150723', 'San Mateo de Otao', '1507', '15'),
('150724', 'San Pedro de Casta', '1507', '15'),
('150725', 'San Pedro de Huancayre', '1507', '15'),
('150726', 'Sangallaya', '1507', '15'),
('150727', 'Santa Cruz de Cocachacra', '1507', '15'),
('150728', 'Santa Eulalia', '1507', '15'),
('150729', 'Santiago de Anchucaya', '1507', '15'),
('150730', 'Santiago de Tuna', '1507', '15'),
('150731', 'Santo Domingo de Los Olleros', '1507', '15'),
('150732', 'Surco', '1507', '15'),
('150801', 'Huacho', '1508', '15'),
('150802', 'Ambar', '1508', '15'),
('150803', 'Caleta de Carquin', '1508', '15'),
('150804', 'Checras', '1508', '15'),
('150805', 'Hualmay', '1508', '15'),
('150806', 'Huaura', '1508', '15'),
('150807', 'Leoncio Prado', '1508', '15'),
('150808', 'Paccho', '1508', '15'),
('150809', 'Santa Leonor', '1508', '15'),
('150810', 'Santa María', '1508', '15'),
('150811', 'Sayan', '1508', '15'),
('150812', 'Vegueta', '1508', '15'),
('150901', 'Oyon', '1509', '15'),
('150902', 'Andajes', '1509', '15'),
('150903', 'Caujul', '1509', '15'),
('150904', 'Cochamarca', '1509', '15'),
('150905', 'Navan', '1509', '15'),
('150906', 'Pachangara', '1509', '15'),
('151001', 'Yauyos', '1510', '15'),
('151002', 'Alis', '1510', '15'),
('151003', 'Allauca', '1510', '15'),
('151004', 'Ayaviri', '1510', '15'),
('151005', 'Azángaro', '1510', '15'),
('151006', 'Cacra', '1510', '15'),
('151007', 'Carania', '1510', '15'),
('151008', 'Catahuasi', '1510', '15'),
('151009', 'Chocos', '1510', '15'),
('151010', 'Cochas', '1510', '15'),
('151011', 'Colonia', '1510', '15'),
('151012', 'Hongos', '1510', '15'),
('151013', 'Huampara', '1510', '15'),
('151014', 'Huancaya', '1510', '15'),
('151015', 'Huangascar', '1510', '15'),
('151016', 'Huantan', '1510', '15'),
('151017', 'Huañec', '1510', '15'),
('151018', 'Laraos', '1510', '15'),
('151019', 'Lincha', '1510', '15'),
('151020', 'Madean', '1510', '15'),
('151021', 'Miraflores', '1510', '15'),
('151022', 'Omas', '1510', '15'),
('151023', 'Putinza', '1510', '15'),
('151024', 'Quinches', '1510', '15'),
('151025', 'Quinocay', '1510', '15'),
('151026', 'San Joaquín', '1510', '15'),
('151027', 'San Pedro de Pilas', '1510', '15'),
('151028', 'Tanta', '1510', '15'),
('151029', 'Tauripampa', '1510', '15'),
('151030', 'Tomas', '1510', '15'),
('151031', 'Tupe', '1510', '15'),
('151032', 'Viñac', '1510', '15'),
('151033', 'Vitis', '1510', '15'),
('160101', 'Iquitos', '1601', '16'),
('160102', 'Alto Nanay', '1601', '16'),
('160103', 'Fernando Lores', '1601', '16'),
('160104', 'Indiana', '1601', '16'),
('160105', 'Las Amazonas', '1601', '16'),
('160106', 'Mazan', '1601', '16'),
('160107', 'Napo', '1601', '16'),
('160108', 'Punchana', '1601', '16'),
('160110', 'Torres Causana', '1601', '16'),
('160112', 'Belén', '1601', '16'),
('160113', 'San Juan Bautista', '1601', '16'),
('160201', 'Yurimaguas', '1602', '16'),
('160202', 'Balsapuerto', '1602', '16'),
('160205', 'Jeberos', '1602', '16'),
('160206', 'Lagunas', '1602', '16'),
('160210', 'Santa Cruz', '1602', '16'),
('160211', 'Teniente Cesar López Rojas', '1602', '16'),
('160301', 'Nauta', '1603', '16'),
('160302', 'Parinari', '1603', '16'),
('160303', 'Tigre', '1603', '16'),
('160304', 'Trompeteros', '1603', '16'),
('160305', 'Urarinas', '1603', '16'),
('160401', 'Ramón Castilla', '1604', '16'),
('160402', 'Pebas', '1604', '16'),
('160403', 'Yavari', '1604', '16'),
('160404', 'San Pablo', '1604', '16'),
('160501', 'Requena', '1605', '16'),
('160502', 'Alto Tapiche', '1605', '16'),
('160503', 'Capelo', '1605', '16'),
('160504', 'Emilio San Martín', '1605', '16'),
('160505', 'Maquia', '1605', '16'),
('160506', 'Puinahua', '1605', '16'),
('160507', 'Saquena', '1605', '16'),
('160508', 'Soplin', '1605', '16'),
('160509', 'Tapiche', '1605', '16'),
('160510', 'Jenaro Herrera', '1605', '16'),
('160511', 'Yaquerana', '1605', '16'),
('160601', 'Contamana', '1606', '16'),
('160602', 'Inahuaya', '1606', '16'),
('160603', 'Padre Márquez', '1606', '16'),
('160604', 'Pampa Hermosa', '1606', '16'),
('160605', 'Sarayacu', '1606', '16'),
('160606', 'Vargas Guerra', '1606', '16'),
('160701', 'Barranca', '1607', '16'),
('160702', 'Cahuapanas', '1607', '16'),
('160703', 'Manseriche', '1607', '16'),
('160704', 'Morona', '1607', '16'),
('160705', 'Pastaza', '1607', '16'),
('160706', 'Andoas', '1607', '16'),
('160801', 'Putumayo', '1608', '16'),
('160802', 'Rosa Panduro', '1608', '16'),
('160803', 'Teniente Manuel Clavero', '1608', '16'),
('160804', 'Yaguas', '1608', '16'),
('170101', 'Tambopata', '1701', '17'),
('170102', 'Inambari', '1701', '17'),
('170103', 'Las Piedras', '1701', '17'),
('170104', 'Laberinto', '1701', '17'),
('170201', 'Manu', '1702', '17'),
('170202', 'Fitzcarrald', '1702', '17'),
('170203', 'Madre de Dios', '1702', '17'),
('170204', 'Huepetuhe', '1702', '17'),
('170301', 'Iñapari', '1703', '17'),
('170302', 'Iberia', '1703', '17'),
('170303', 'Tahuamanu', '1703', '17'),
('180101', 'Moquegua', '1801', '18'),
('180102', 'Carumas', '1801', '18'),
('180103', 'Cuchumbaya', '1801', '18'),
('180104', 'Samegua', '1801', '18'),
('180105', 'San Cristóbal', '1801', '18'),
('180106', 'Torata', '1801', '18'),
('180201', 'Omate', '1802', '18'),
('180202', 'Chojata', '1802', '18'),
('180203', 'Coalaque', '1802', '18'),
('180204', 'Ichuña', '1802', '18'),
('180205', 'La Capilla', '1802', '18'),
('180206', 'Lloque', '1802', '18'),
('180207', 'Matalaque', '1802', '18'),
('180208', 'Puquina', '1802', '18'),
('180209', 'Quinistaquillas', '1802', '18'),
('180210', 'Ubinas', '1802', '18'),
('180211', 'Yunga', '1802', '18'),
('180301', 'Ilo', '1803', '18'),
('180302', 'El Algarrobal', '1803', '18'),
('180303', 'Pacocha', '1803', '18'),
('190101', 'Chaupimarca', '1901', '19'),
('190102', 'Huachon', '1901', '19'),
('190103', 'Huariaca', '1901', '19'),
('190104', 'Huayllay', '1901', '19'),
('190105', 'Ninacaca', '1901', '19'),
('190106', 'Pallanchacra', '1901', '19'),
('190107', 'Paucartambo', '1901', '19'),
('190108', 'San Francisco de Asís de Yarusyacan', '1901', '19'),
('190109', 'Simon Bolívar', '1901', '19'),
('190110', 'Ticlacayan', '1901', '19'),
('190111', 'Tinyahuarco', '1901', '19'),
('190112', 'Vicco', '1901', '19'),
('190113', 'Yanacancha', '1901', '19'),
('190201', 'Yanahuanca', '1902', '19'),
('190202', 'Chacayan', '1902', '19'),
('190203', 'Goyllarisquizga', '1902', '19'),
('190204', 'Paucar', '1902', '19'),
('190205', 'San Pedro de Pillao', '1902', '19'),
('190206', 'Santa Ana de Tusi', '1902', '19'),
('190207', 'Tapuc', '1902', '19'),
('190208', 'Vilcabamba', '1902', '19'),
('190301', 'Oxapampa', '1903', '19'),
('190302', 'Chontabamba', '1903', '19'),
('190303', 'Huancabamba', '1903', '19'),
('190304', 'Palcazu', '1903', '19'),
('190305', 'Pozuzo', '1903', '19'),
('190306', 'Puerto Bermúdez', '1903', '19'),
('190307', 'Villa Rica', '1903', '19'),
('190308', 'Constitución', '1903', '19'),
('200101', 'Piura', '2001', '20'),
('200104', 'Castilla', '2001', '20'),
('200105', 'Catacaos', '2001', '20'),
('200107', 'Cura Mori', '2001', '20'),
('200108', 'El Tallan', '2001', '20'),
('200109', 'La Arena', '2001', '20'),
('200110', 'La Unión', '2001', '20'),
('200111', 'Las Lomas', '2001', '20'),
('200114', 'Tambo Grande', '2001', '20'),
('200115', 'Veintiseis de Octubre', '2001', '20'),
('200201', 'Ayabaca', '2002', '20'),
('200202', 'Frias', '2002', '20'),
('200203', 'Jilili', '2002', '20'),
('200204', 'Lagunas', '2002', '20'),
('200205', 'Montero', '2002', '20'),
('200206', 'Pacaipampa', '2002', '20'),
('200207', 'Paimas', '2002', '20'),
('200208', 'Sapillica', '2002', '20'),
('200209', 'Sicchez', '2002', '20'),
('200210', 'Suyo', '2002', '20'),
('200301', 'Huancabamba', '2003', '20'),
('200302', 'Canchaque', '2003', '20'),
('200303', 'El Carmen de la Frontera', '2003', '20'),
('200304', 'Huarmaca', '2003', '20'),
('200305', 'Lalaquiz', '2003', '20'),
('200306', 'San Miguel de El Faique', '2003', '20'),
('200307', 'Sondor', '2003', '20'),
('200308', 'Sondorillo', '2003', '20'),
('200401', 'Chulucanas', '2004', '20'),
('200402', 'Buenos Aires', '2004', '20'),
('200403', 'Chalaco', '2004', '20'),
('200404', 'La Matanza', '2004', '20'),
('200405', 'Morropon', '2004', '20'),
('200406', 'Salitral', '2004', '20'),
('200407', 'San Juan de Bigote', '2004', '20'),
('200408', 'Santa Catalina de Mossa', '2004', '20'),
('200409', 'Santo Domingo', '2004', '20'),
('200410', 'Yamango', '2004', '20'),
('200501', 'Paita', '2005', '20'),
('200502', 'Amotape', '2005', '20'),
('200503', 'Arenal', '2005', '20'),
('200504', 'Colan', '2005', '20'),
('200505', 'La Huaca', '2005', '20'),
('200506', 'Tamarindo', '2005', '20'),
('200507', 'Vichayal', '2005', '20'),
('200601', 'Sullana', '2006', '20'),
('200602', 'Bellavista', '2006', '20'),
('200603', 'Ignacio Escudero', '2006', '20'),
('200604', 'Lancones', '2006', '20'),
('200605', 'Marcavelica', '2006', '20'),
('200606', 'Miguel Checa', '2006', '20'),
('200607', 'Querecotillo', '2006', '20'),
('200608', 'Salitral', '2006', '20'),
('200701', 'Pariñas', '2007', '20'),
('200702', 'El Alto', '2007', '20'),
('200703', 'La Brea', '2007', '20'),
('200704', 'Lobitos', '2007', '20'),
('200705', 'Los Organos', '2007', '20'),
('200706', 'Mancora', '2007', '20'),
('200801', 'Sechura', '2008', '20'),
('200802', 'Bellavista de la Unión', '2008', '20'),
('200803', 'Bernal', '2008', '20'),
('200804', 'Cristo Nos Valga', '2008', '20'),
('200805', 'Vice', '2008', '20'),
('200806', 'Rinconada Llicuar', '2008', '20'),
('210101', 'Puno', '2101', '21'),
('210102', 'Acora', '2101', '21'),
('210103', 'Amantani', '2101', '21'),
('210104', 'Atuncolla', '2101', '21'),
('210105', 'Capachica', '2101', '21'),
('210106', 'Chucuito', '2101', '21'),
('210107', 'Coata', '2101', '21'),
('210108', 'Huata', '2101', '21'),
('210109', 'Mañazo', '2101', '21'),
('210110', 'Paucarcolla', '2101', '21'),
('210111', 'Pichacani', '2101', '21'),
('210112', 'Plateria', '2101', '21'),
('210113', 'San Antonio', '2101', '21'),
('210114', 'Tiquillaca', '2101', '21'),
('210115', 'Vilque', '2101', '21'),
('210201', 'Azángaro', '2102', '21'),
('210202', 'Achaya', '2102', '21'),
('210203', 'Arapa', '2102', '21'),
('210204', 'Asillo', '2102', '21'),
('210205', 'Caminaca', '2102', '21'),
('210206', 'Chupa', '2102', '21'),
('210207', 'José Domingo Choquehuanca', '2102', '21'),
('210208', 'Muñani', '2102', '21'),
('210209', 'Potoni', '2102', '21'),
('210210', 'Saman', '2102', '21'),
('210211', 'San Anton', '2102', '21'),
('210212', 'San José', '2102', '21'),
('210213', 'San Juan de Salinas', '2102', '21'),
('210214', 'Santiago de Pupuja', '2102', '21'),
('210215', 'Tirapata', '2102', '21'),
('210301', 'Macusani', '2103', '21'),
('210302', 'Ajoyani', '2103', '21'),
('210303', 'Ayapata', '2103', '21'),
('210304', 'Coasa', '2103', '21'),
('210305', 'Corani', '2103', '21'),
('210306', 'Crucero', '2103', '21'),
('210307', 'Ituata', '2103', '21'),
('210308', 'Ollachea', '2103', '21'),
('210309', 'San Gaban', '2103', '21'),
('210310', 'Usicayos', '2103', '21'),
('210401', 'Juli', '2104', '21'),
('210402', 'Desaguadero', '2104', '21'),
('210403', 'Huacullani', '2104', '21'),
('210404', 'Kelluyo', '2104', '21'),
('210405', 'Pisacoma', '2104', '21'),
('210406', 'Pomata', '2104', '21'),
('210407', 'Zepita', '2104', '21'),
('210501', 'Ilave', '2105', '21'),
('210502', 'Capazo', '2105', '21'),
('210503', 'Pilcuyo', '2105', '21'),
('210504', 'Santa Rosa', '2105', '21'),
('210505', 'Conduriri', '2105', '21'),
('210601', 'Huancane', '2106', '21'),
('210602', 'Cojata', '2106', '21'),
('210603', 'Huatasani', '2106', '21'),
('210604', 'Inchupalla', '2106', '21'),
('210605', 'Pusi', '2106', '21'),
('210606', 'Rosaspata', '2106', '21'),
('210607', 'Taraco', '2106', '21'),
('210608', 'Vilque Chico', '2106', '21'),
('210701', 'Lampa', '2107', '21'),
('210702', 'Cabanilla', '2107', '21'),
('210703', 'Calapuja', '2107', '21'),
('210704', 'Nicasio', '2107', '21'),
('210705', 'Ocuviri', '2107', '21'),
('210706', 'Palca', '2107', '21'),
('210707', 'Paratia', '2107', '21'),
('210708', 'Pucara', '2107', '21'),
('210709', 'Santa Lucia', '2107', '21'),
('210710', 'Vilavila', '2107', '21'),
('210801', 'Ayaviri', '2108', '21'),
('210802', 'Antauta', '2108', '21'),
('210803', 'Cupi', '2108', '21'),
('210804', 'Llalli', '2108', '21'),
('210805', 'Macari', '2108', '21'),
('210806', 'Nuñoa', '2108', '21'),
('210807', 'Orurillo', '2108', '21'),
('210808', 'Santa Rosa', '2108', '21'),
('210809', 'Umachiri', '2108', '21'),
('210901', 'Moho', '2109', '21'),
('210902', 'Conima', '2109', '21'),
('210903', 'Huayrapata', '2109', '21'),
('210904', 'Tilali', '2109', '21'),
('211001', 'Putina', '2110', '21'),
('211002', 'Ananea', '2110', '21'),
('211003', 'Pedro Vilca Apaza', '2110', '21'),
('211004', 'Quilcapuncu', '2110', '21'),
('211005', 'Sina', '2110', '21'),
('211101', 'Juliaca', '2111', '21'),
('211102', 'Cabana', '2111', '21'),
('211103', 'Cabanillas', '2111', '21'),
('211104', 'Caracoto', '2111', '21'),
('211105', 'San Miguel', '2111', '21'),
('211201', 'Sandia', '2112', '21'),
('211202', 'Cuyocuyo', '2112', '21'),
('211203', 'Limbani', '2112', '21'),
('211204', 'Patambuco', '2112', '21'),
('211205', 'Phara', '2112', '21'),
('211206', 'Quiaca', '2112', '21'),
('211207', 'San Juan del Oro', '2112', '21'),
('211208', 'Yanahuaya', '2112', '21'),
('211209', 'Alto Inambari', '2112', '21'),
('211210', 'San Pedro de Putina Punco', '2112', '21'),
('211301', 'Yunguyo', '2113', '21'),
('211302', 'Anapia', '2113', '21'),
('211303', 'Copani', '2113', '21'),
('211304', 'Cuturapi', '2113', '21'),
('211305', 'Ollaraya', '2113', '21'),
('211306', 'Tinicachi', '2113', '21'),
('211307', 'Unicachi', '2113', '21'),
('220101', 'Moyobamba', '2201', '22'),
('220102', 'Calzada', '2201', '22'),
('220103', 'Habana', '2201', '22'),
('220104', 'Jepelacio', '2201', '22'),
('220105', 'Soritor', '2201', '22'),
('220106', 'Yantalo', '2201', '22'),
('220201', 'Bellavista', '2202', '22'),
('220202', 'Alto Biavo', '2202', '22'),
('220203', 'Bajo Biavo', '2202', '22'),
('220204', 'Huallaga', '2202', '22'),
('220205', 'San Pablo', '2202', '22'),
('220206', 'San Rafael', '2202', '22'),
('220301', 'San José de Sisa', '2203', '22'),
('220302', 'Agua Blanca', '2203', '22'),
('220303', 'San Martín', '2203', '22'),
('220304', 'Santa Rosa', '2203', '22'),
('220305', 'Shatoja', '2203', '22'),
('220401', 'Saposoa', '2204', '22'),
('220402', 'Alto Saposoa', '2204', '22'),
('220403', 'El Eslabón', '2204', '22'),
('220404', 'Piscoyacu', '2204', '22'),
('220405', 'Sacanche', '2204', '22'),
('220406', 'Tingo de Saposoa', '2204', '22'),
('220501', 'Lamas', '2205', '22'),
('220502', 'Alonso de Alvarado', '2205', '22'),
('220503', 'Barranquita', '2205', '22'),
('220504', 'Caynarachi', '2205', '22'),
('220505', 'Cuñumbuqui', '2205', '22'),
('220506', 'Pinto Recodo', '2205', '22'),
('220507', 'Rumisapa', '2205', '22'),
('220508', 'San Roque de Cumbaza', '2205', '22'),
('220509', 'Shanao', '2205', '22'),
('220510', 'Tabalosos', '2205', '22'),
('220511', 'Zapatero', '2205', '22'),
('220601', 'Juanjuí', '2206', '22'),
('220602', 'Campanilla', '2206', '22'),
('220603', 'Huicungo', '2206', '22'),
('220604', 'Pachiza', '2206', '22'),
('220605', 'Pajarillo', '2206', '22'),
('220701', 'Picota', '2207', '22'),
('220702', 'Buenos Aires', '2207', '22'),
('220703', 'Caspisapa', '2207', '22'),
('220704', 'Pilluana', '2207', '22'),
('220705', 'Pucacaca', '2207', '22'),
('220706', 'San Cristóbal', '2207', '22'),
('220707', 'San Hilarión', '2207', '22'),
('220708', 'Shamboyacu', '2207', '22'),
('220709', 'Tingo de Ponasa', '2207', '22'),
('220710', 'Tres Unidos', '2207', '22'),
('220801', 'Rioja', '2208', '22'),
('220802', 'Awajun', '2208', '22'),
('220803', 'Elías Soplin Vargas', '2208', '22'),
('220804', 'Nueva Cajamarca', '2208', '22'),
('220805', 'Pardo Miguel', '2208', '22'),
('220806', 'Posic', '2208', '22'),
('220807', 'San Fernando', '2208', '22'),
('220808', 'Yorongos', '2208', '22'),
('220809', 'Yuracyacu', '2208', '22'),
('220901', 'Tarapoto', '2209', '22'),
('220902', 'Alberto Leveau', '2209', '22'),
('220903', 'Cacatachi', '2209', '22'),
('220904', 'Chazuta', '2209', '22'),
('220905', 'Chipurana', '2209', '22'),
('220906', 'El Porvenir', '2209', '22'),
('220907', 'Huimbayoc', '2209', '22'),
('220908', 'Juan Guerra', '2209', '22'),
('220909', 'La Banda de Shilcayo', '2209', '22'),
('220910', 'Morales', '2209', '22'),
('220911', 'Papaplaya', '2209', '22'),
('220912', 'San Antonio', '2209', '22'),
('220913', 'Sauce', '2209', '22'),
('220914', 'Shapaja', '2209', '22'),
('221001', 'Tocache', '2210', '22'),
('221002', 'Nuevo Progreso', '2210', '22'),
('221003', 'Polvora', '2210', '22'),
('221004', 'Shunte', '2210', '22'),
('221005', 'Uchiza', '2210', '22'),
('230101', 'Tacna', '2301', '23'),
('230102', 'Alto de la Alianza', '2301', '23'),
('230103', 'Calana', '2301', '23'),
('230104', 'Ciudad Nueva', '2301', '23'),
('230105', 'Inclan', '2301', '23'),
('230106', 'Pachia', '2301', '23'),
('230107', 'Palca', '2301', '23'),
('230108', 'Pocollay', '2301', '23'),
('230109', 'Sama', '2301', '23'),
('230110', 'Coronel Gregorio Albarracín Lanchipa', '2301', '23'),
('230111', 'La Yarada los Palos', '2301', '23'),
('230201', 'Candarave', '2302', '23'),
('230202', 'Cairani', '2302', '23'),
('230203', 'Camilaca', '2302', '23'),
('230204', 'Curibaya', '2302', '23'),
('230205', 'Huanuara', '2302', '23'),
('230206', 'Quilahuani', '2302', '23'),
('230301', 'Locumba', '2303', '23'),
('230302', 'Ilabaya', '2303', '23'),
('230303', 'Ite', '2303', '23'),
('230401', 'Tarata', '2304', '23'),
('230402', 'Héroes Albarracín', '2304', '23'),
('230403', 'Estique', '2304', '23'),
('230404', 'Estique-Pampa', '2304', '23'),
('230405', 'Sitajara', '2304', '23'),
('230406', 'Susapaya', '2304', '23'),
('230407', 'Tarucachi', '2304', '23'),
('230408', 'Ticaco', '2304', '23'),
('240101', 'Tumbes', '2401', '24'),
('240102', 'Corrales', '2401', '24'),
('240103', 'La Cruz', '2401', '24'),
('240104', 'Pampas de Hospital', '2401', '24'),
('240105', 'San Jacinto', '2401', '24'),
('240106', 'San Juan de la Virgen', '2401', '24'),
('240201', 'Zorritos', '2402', '24'),
('240202', 'Casitas', '2402', '24'),
('240203', 'Canoas de Punta Sal', '2402', '24'),
('240301', 'Zarumilla', '2403', '24'),
('240302', 'Aguas Verdes', '2403', '24'),
('240303', 'Matapalo', '2403', '24'),
('240304', 'Papayal', '2403', '24'),
('250101', 'Calleria', '2501', '25'),
('250102', 'Campoverde', '2501', '25'),
('250103', 'Iparia', '2501', '25'),
('250104', 'Masisea', '2501', '25'),
('250105', 'Yarinacocha', '2501', '25'),
('250106', 'Nueva Requena', '2501', '25'),
('250107', 'Manantay', '2501', '25'),
('250201', 'Raymondi', '2502', '25'),
('250202', 'Sepahua', '2502', '25'),
('250203', 'Tahuania', '2502', '25'),
('250204', 'Yurua', '2502', '25'),
('250301', 'Padre Abad', '2503', '25'),
('250302', 'Irazola', '2503', '25'),
('250303', 'Curimana', '2503', '25'),
('250304', 'Neshuya', '2503', '25'),
('250305', 'Alexander Von Humboldt', '2503', '25'),
('250401', 'Purus', '2504', '25');

-- --------------------------------------------------------

----------------ESTADO CIVIL--------------
insert into tb_estado_civil values ('S','soltero(a)'),('C','casado(a)'),
('D','divorciado(a)'), ('U','union libre'), ('SE','separado(a)'),  ('V','viudo(a)')
go

------------------PERSONA-----------------
insert into tb_persona 
(dni_per, cui_per, nom_per, apepat_per, apemat_per, fechanac_per, fechaemi_per,foto_per, sexo_per,
codEstadoCivil,cod_pai_nac, cod_dist_nac, cod_pro_nac, cod_dep_nac, cod_pai_res, cod_dep_res, cod_pro_res, cod_dis_res, dir_res)
values ('74469508', '1', 'Piero Alessandro', 'Bermudez', 'Laura', '2001-01-28', '2019-08-08','', 'M', 'S',1, '150117', '1501', '15', 1, '15', '1501', '150117', 'CARLOS MONGE 270 URB. SJM'),   -- VOTANTE
	   ('02835512', '2', 'Maria Rosa', 'Alicante', 'Davila', '1999-12-08', '2014-05-14','', 'F','D',1,'150119','1501','15', 1, '15', '1501', '150120', 'LAS FUCSIAS 4000 MZ. 4 LOTE 5'),  -- VOTANTE

	   -- EQUIPO FUERZA POPULAR
	   ('10001088', '8', 'Keiko Sofia', 'Fujimori', 'Higuchi', '1975-05-25', '1996-06-09','~/Imagenes/candidatos/10001088.jpg', 'F', 'S',1,'150113','1501','15', 1, '15', '1501','150140', 'AV. DE LA FLORESTA 241 DPTO. 301 URB. CHACARILLA DEL ESTANQUE'),   -- PRESIDENTE
	   ('09537000', '0', 'Luis Fernando', 'Galarreta', 'Velarde', '1971-03-12', '2005-12-04','~/Imagenes/candidatos/09537000.jpg', 'M', 'C',1,'150101','1501','15',  1, '15', '1501','150140', 'JR. AMANCAES 466 INT. 303 URB. LAS CASUARINAS SUR'), -- 1ER VICEPRESIDENTE / PARLAMENTO NRO:1
	   ('07831436', '6', 'Carmen Patricia', 'Juarez', 'Gallegos', '1960-07-16', '2015-04-10','~/Imagenes/candidatos/07831436.jpg', 'F', 'C',1,'110304','1103','11', 1,'15', '1501','150122','CALLE PROLG. ARENALES 863 DPTO.202'),  -- 2DO VICEPRESIDENTE / CONGRESISTA LIMA NRO:2
	   ('08232920', '0', 'Carlos Ernesto', 'Bustamante', 'Donayre', '1950-05-19', '2010-03-10','~/Imagenes/candidatos/08232920.jpg', 'M', 'D',1,'150131','1501','15',1,'15', '1501','150122', 'CALLE PIURA 1067 DPTO. F'), -- CONGRESISTA LIMA NRO:3
	   ('09991098', '8', 'Patricia Monica', 'Herrera', 'Barrientos', '1970-05-10', '2019-02-14', '~/Imagenes/candidatos/09991098.jpg', 'F', 'C', 1,'150101','1501','15',1,'07','0701','070106', 'MZ.E LT.08 ASENT.H. CUATRO SUYOS'), -- PARLAMENTO NRO:8

	   -- EQUIPO ACCION POPULAR
	   ('01211014', '4', 'Yonhy', 'Lescano', 'Ancieta', '1959-02-15', '2017-04-12', '~/Imagenes/candidatos/01211014.jpg', 'M', 'C',1,'210101','2101','21',1,'15', '1501','150140', 'CALLE SOR MATE 345 URB.RES. EL ROSAL'), -- PRESIDENTE
	   ('40804904', '4', 'Gisela', 'Tipe', 'De la Cruz', '1981-02-16', '2015-01-20', '~/Imagenes/candidatos/40804904.jpg', 'F', 'C',1,'050101','0501','05',1,'05','0501','050101', 'JR.M.P.DE BELLIDO 756'), -- 1ER VICEPRESIDENTE / CONGRESISTA AYACUCHO NRO:1
	   ('08104229', '9', 'Luis Alberto', 'Velarde', 'Yañez', '1956-06-05', '2018-03-03', '~/Imagenes/candidatos/08104229.jpg', 'M', 'S', 1,'150101','1501','15',1,'15','1501','150122', 'CALLE ELIAS AGUIRRE 141 TORRE C INT 513'), --2DO VICEPRESIDENTE / CONGRESISTA LIMA NRO:25
	   ('06310702', '2', 'Oswaldo Martin', 'Moreno', 'Rivera', '1970-11-06','2019-05-18', '~/Imagenes/candidatos/06310702.jpg', 'M', 'S', 1,'150113','1501','15',1,'15', '1501','150140','AV. LOS PROCERES G1-05 URB. LOS PROCERES'), -- CONGRESISTA LIMA NRO:9
	   ('44242860', '0', 'Leslye Carol', 'Lazon', 'Villon', '1980-10-30', '2013-02-04', '~/Imagenes/candidatos/44242860.jpg', 'F', 'D', 1,'150115','1501','15',1, '15','1501','150130','ASOC. DE VIV. SAN FRANCISCO DE CAYRAN II PISO 2DO SECTOR 2 MZ. J-1 LT. 1'), -- PARLAMENTO NRO:1

	   -- EQUIPO ALIANZA PARA EL PROGRESO
	   ('17903382', '2', 'Cesar', 'Acuña', 'Peralta', '1952-08-11', '2010-07-07', '~/Imagenes/candidatos/17903382.jpg', 'M', 'C', 1,'060417','0604','06',1,'15','1501','150131', 'CALLE BELEN 105-109-113 DPTO. 1602 URB. SANTA TERESITA'), -- PRESIDENTE
	   ('10308752', '2', 'Maria del Carmen', 'Omonte', 'Durand', '1970-08-14', '2015-08-05', '~/Imagenes/candidatos/10308752.jpg', 'F', 'C', 1,'100101','1001','10',1,'15','1501','150122','SAN IGNACIO DE LOYOLA 106 DPTO. 601'), -- 1ER VICEPRESIDENTE
	   ('08194883', '3', 'Luis Carlos Antonio', 'Iberico', 'Nuñez', '1959-01-02', '2004-07-10', '~/Imagenes/candidatos/08194883.jpg', 'M', 'C', 2,null, null, null,1,'15','1501','150114','CALLE SUPERIOR 145'), -- 2DO VICEPRESIDENTE
	   ('07827893', '3', 'Daniel Fernando', 'Abugattas', 'Majluf', '1955-04-14', '2007-08-10', '~/Imagenes/candidatos/07827893.jpg', 'M', 'C', 1,'040101','0401','04',1, '15','1501','150122','PARQUE FEDERICO BLUME 142 DPTO. 701'), -- CONGRESISTA LIMA NRO:4
	   ('18114960', '0', 'Tania Rosalia', 'Rodas', 'Malca', '1972-02-10', '2016-11-10', '~/Imagenes/candidatos/18114960.jpg', 'F', 'S', 1,'130101','1301','13',1, '13','1301','130101', 'CALLE NEW YORK 155 URB.SAN NICOLAS'), -- PARALAMENTO NRO:6

	   -- EQUIPO AVANZA PAIS
	   ('09155583', '3', 'Hernando', 'De Soto', 'Polar', '1941-06-03', '2007-08-20', '~/Imagenes/candidatos/09155583.jpg', 'M', 'C',1,'040101','0401','04',1,'15','1501','150140','CALLE OSA MAYOR 157 URB.GRANADOS'), -- PRESIDENTE
	   ('00478062', '2', 'Corinne Isabelle', 'Flores', 'Lemaire', '1958-01-11', '2010-11-23', '~/Imagenes/candidatos/00478062.jpg', 'F','C', 1,'150101','1501','15',1,'23','2301','230108','AV.CELESTINO VARGAS 546'), -- 1ER VICEPRESIDENTE / CONGRESISTA TACNA NRO:1
	   ('07667076', '6', 'Jaime Oswaldo', 'Salomon', 'Salomon', '1963-11-17', '2008-09-15', '~/Imagenes/candidatos/07667076.jpg', 'M', 'S', 1,'150101','1501','15',1,'15','1501','150114','PSJ.GONDOMAR 15-E URB.LA ESTANCIA'), -- 2DO VICEPRESIDENTE / CONGRESISTA LIMA NRO:8
	   ('43781857', '7', 'Alessandra Camila', 'Krause', 'Alva', '1986-08-24', '2013-09-30', '~/Imagenes/candidatos/43781857.jpg', 'F', 'C', 1,'150131','1501','15',1, '15','1501','150122','CALLE CORONEL INCLAN 361 DPTO. 702'), -- CONGRESISTA LIMA NRO:9
	   ('10314044', '4', 'Juan Carlos', 'Ramirez', 'Larizbeascoa', '1958-10-18', '2020-02-19', '~/Imagenes/candidatos/10314044.jpg', 'M', 'C', 1,'150101','1501','15',1,'15','1501','150122','PSJ. LA MORENA 110 DPTO. 701 ED. LA MORENA'), -- PARLAMENTO NRO:1

	   -- EQUIPO DEMOCRACIA DIRECTA
	   ('19669215', '5', 'Andres Avelino', 'Alcantara', 'Paredes', '1960-02-21', '2018-09-11', '~/Imagenes/candidatos/19669215.jpg', 'M', 'C', 1,'131001','1310','13',1,'15','1501','150101','JR MOQUEGUA NRO. 284 DPTO 212'), --PRESIDENTE
	   ('24965523', '3', 'Elena Emperatriz', 'Arcarza', 'Quispe', '1966-08-18', '2004-08-21', '~/Imagenes/candidatos/24965523.jpg', 'F', 'S', 1,'080106','0801','08',1,'08','0809','080901','PROLG. GENERAL GAMARRA LL-13'), -- 1ER VICEPRESIDENTE / CONGRESISTA CUSCO NRO:1
	   ('09302945', '5', 'Javier Felipe', 'Espinoza', 'Ayaipoma', '1969-01-10', '2014-06-02', '~/Imagenes/candidatos/09302945.jpg', 'M', 'C',1,'200701','2007','20',1,'15','1501','150130', 'GALEON 270 CHACARILLA'), -- 2DO VICEPRESIDENTE / CONGRESISTA LIMA NRO:1
	   ('07787126', '6', 'Maria Evelina', 'Merino', 'Chong', '1962-06-09', '2013-10-03', '~/Imagenes/candidatos/07787126.jpg', 'F', 'C',1,'150121','1501','15',1,'15','1501','150140', 'AV VELAZCO ASTETE 1444 DPTO 2 URB PANCHO FIERRO'), -- CONGRESISTA LIMA NRO:2
	   ('47919213', '3', 'Vladimir Mateo', 'Cardenas', 'Casas', '1993-08-26', '2012-10-30', '~/Imagenes/candidatos/47919213.jpg', 'M', 'S', 1,'120401','1204','12',1,'12','1201','120114','PSJ. AMANCEBADOS 1315'), -- PARLAMENTO NRO:1

	   -- AGREGANDO SOLO A LOS PRESIDENTES
	   --  FRENTE AMPLIO
	   ('26605193', '3', 'Marco Antonio', 'Arana', 'Zegarra','1962-10-20', '2014-11-16', '~/Imagenes/candidatos/26605193.jpg', 'M', 'C', 1,'060101','0601','06', 1, '06','0601','060101','JR.5 ESQUINAS 944'), -- PRESIDENTE
	   -- JUNTOS POR EL PERU
	   ('40765768', '8', 'Veronica Fanny', 'Mendoza', 'Frisch', '1980-12-09', '2014-07-21', '~/Imagenes/candidatos/40765768.jpg', 'F', 'S', 1,'080101','0801','08',1,'08','0801','080105','ASOC. P.V. COVIDUC MZ. A LT. 2'), -- PRESIDENTE
	   -- PARTIDO DEMOCRATICO SOMOS PERU
	   ('18010708', '8', 'Daniel Enrique', 'Salaverry', 'Villa', '1972-08-07', '2019-05-30', '~/Imagenes/candidatos/18010708.jpg','M','S', 1,'130101','1301','13',1, '13','1301','130101','CALLE COLOMBIA 141 PISO 3 URB. EL RECREO'), -- PRESIDENTE
	   -- PARTIDO MORADO
	   ('09337130', '0', 'Julio Armando', 'Guzman', 'Caceres', '1970-07-31', '2016-09-12', '~/Imagenes/candidatos/09337130.jpg', 'M', 'C', 1,'150113','1501','15',1,'15','1501','150131','CALLE PROLONGACION ALFREDO SALAZAR 165 DPTO. 401 URB. SANTA ISABEL'), -- PRESIDENTE
	   -- PARTIDO NACIONALISTA PERUANO
	   ('44123390', '0', 'Ollanta Moises', 'Humala', 'Tasso','1962-06-27','2012-09-10','~/Imagenes/candidatos/44123390.jpg','M','C',1,'150101','1501','15',1,'15','1501','150140','CALLE FERNANDO CASTRAT 177-195 URB.CHAMA'), -- PRESIDENTE
	   
	   -- PARTIDO POLITICO CONTIGO SIN (PRESIDENTE)

	   -- PARTIDO POPULAR CRISTIANO
	   ('06630665', '5', 'Alberto Ismael', 'Beingolea', 'Delgado', '1964-11-19','2017-04-12','~/Imagenes/candidatos/06630665.jpg','M', 'C',1,'150113','1501','15',1,'15','1501','150131','CALLE LUIS ALDANA 270 URB. CORPAC'), -- PRESIDENTE
	   -- PERU LIBRE
	   ('27427864', '4', 'Jose Pedro', 'Castillo', 'Terrones', '1969-10-19', '2019-02-17', '~/Imagenes/candidatos/27427864.jpg', 'M', 'C', 1,'060417','0604','06',1,'06','0604','060417','CASERIO PUÑA'), --´PRESIDENTE
	   -- PERU PATRIA SEGURA
	   ('08274605', '5', 'Rafael Gaton Tadeo Milagros', 'Santos', 'Normand', '1968-08-14', '2017-09-10', '~/Imagenes/candidatos/08274605.jpg', 'M', 'S', 1, '150122','1501','15',1,'15','1501','150131','CALLE TENIENTE ALBERTO CHABRIER 157 DPTO. SS-02 URB. SANTA MONICA'), -- PRESIDENTE
	   -- PODEMOS PERU
	   ('43863835', '5', 'Daniel Belizario', 'Urresti', 'Elera', '1956-08-25', '2015-10-03', '~/Imagenes/candidatos/43863835.jpg', 'M', 'S', 1, '200301','2003','20',1,'15','1501','150114','CALLE PASEO DE LOS REYES 228 URB. LAS LOMAS DE LA MOLINA ETAPA I'), -- PRESIDENTE
	   -- RENACIMIENTO UNIDO PERU
	   ('19813153', '3', 'Ciro Alfredo', 'Galvez', 'herrera', '1949-01-16', '2012-09-30', '~/Imagenes/candidatos/19813153.jpg', 'M', 'C', 1,'090714','0907','09',1,'12','1201','120101','CALLE REAL 583'), -- PRESIDENTE
	   -- RENOVACION POPULAR
	   ('07845838', '8', 'Rafael Bernardo', 'Lopez Aliaga', 'Carzola', '1961-02-11','2019-08-19','~/Imagenes/candidatos/07845838.jpg','M', 'C', 1,'150101','1501','15',1,'15','1501','150122','CALLE MANUEL TOVAR 121 SANTA CRUZ'), -- PRESIDENTE
	   -- UNION POR PERU
	   ('08330968','8', 'Jose Alejandro', 'Vega', 'Antonio', '1957-11-18', '2007-10-09', '~/Imagenes/candidatos/08330968.jpg', 'M', 'S', 1,'150122','1501','15',1,'15','1501','150132','JR. LAS GOLONDRINAS URB. HORIZONTE DE ZARATE MZ. P LT. 9'), -- PRESIDENTE
	   -- VICTORIA NACIONAL
	   ('41265978', '8', 'George Patrick', 'Forsyth', 'Sommer', '1982-06-20', '2017-10-10', '~/Imagenes/candidatos/41265978.jpg', 'M', 'S', 3, null, null, null,1,'15','1501','150115','AV. MANCO CAPAC 1224')   -- PRESIDENTE
go

-----------PARTIDOS POLITICOS----------------
insert into tb_partidopolitico (imagen_partido, nombre_partido, pdf_partido, pag_partido)
values ('~/imagenes/partidos/fuerzapopular.jpg', 'Fuerza Popular', '~/Pdf/Resumen Partido Politico/fuerzapopular2021.pdf', 'https://fuerzapopular.com.pe/'),
	   ('~/imagenes/partidos/accionpopular.jpg', 'Accion Popular', '~/Pdf/Resumen Partido Politico/accionpopular2021.pdf', 'https://www.accionpopular.pe/'),
	   ('~/imagenes/partidos/alianzaparaprogreso.jpg', 'Alianza para el Progreso','~/Pdf/Resumen Partido Politico/alianzaparacongreso2021.pdf' , 'https://app.pe/'),
	   ('~/imagenes/partidos/avanzapais.jpg', 'Avanza Pais - Partido de Integracion Social', '~/Pdf/Resumen Partido Politico/avanzapais2021.pdf', 'https://www.avanzapais.org.pe/'),
	   ('~/imagenes/partidos/democraciadirecta.jpg', 'Democracia Directa', '~/Pdf/Resumen Partido Politico/democraciadirecta2021.pdf', 'https://democraciadirecta.pe/'),
	   ('~/imagenes/partidos/frenteamplio.jpg', 'Frente Amplio por Justicia, Vida y Libertad', '~/Pdf/Resumen Partido Politico/frenteamplio2021.pdf', 'https://frenteamplioperu.pe/'),
	   ('~/imagenes/partidos/frepap.jpg', 'Frente Popular Agricola Fia del Peru - FREPAP', null, 'https://frepap.org.pe/'),
	   ('~/imagenes/partidos/juntosporelperu.jpg', 'Juntos Por El Peru', '~/Pdf/Resumen Partido Politico/juntosporelperu2021.pdf', 'http://www.juntosporelperu.org/'),
	   ('~/imagenes/partidos/somosperu.jpg', 'Partido Democratico Somos Peru', '~/Pdf/Resumen Partido Politico/somosperu2021.pdf', 'http://www.somosperu.pe/'),
	   ('~/imagenes/partidos/partidomorado.jpg', 'Partido Morado', '~/Pdf/Resumen Partido Politico/partidomorado2021.pdf', 'https://www.partidomorado.pe/'),
	   ('~/imagenes/partidos/partidonacionalistaperuano.jpg', 'Partido Nacionalista Peruano', '~/Pdf/Resumen Partido Politico/partidonacionalistaperuano2021.pdf', 'https://partidonacionalistaperuano.org.pe/'),
	   ('~/imagenes/partidos/contigo.jpg', 'Partido Politico Contigo', null, 'https://partidocontigo.pe/'),
	   ('~/imagenes/partidos/PPC.jpg', 'Partido Popular Cristiano - PPC', '~/Pdf/Resumen Partido Politico/partidopopularcristiano2021.pdf', 'https://ppc.partidopopularcristiano.com/'),
	   ('~/imagenes/partidos/perulibre.jpg', 'Peru Libre', '~/Pdf/Resumen Partido Politico/perulibre2021.pdf', 'http://perulibre.pe/'),
	   ('~/imagenes/partidos/perupatriasegura.jpg', 'Peru Patria Segura', '~/Pdf/Resumen Partido Politico/perupatriasegura2021.pdf', 'https://www.perupatriasegura.org/'),
	   ('~/imagenes/partidos/podemosperu.jpg', 'Podemos Peru', '~/Pdf/Resumen Partido Politico/podemosperu2021.pdf', 'https://podemosperu.pe/'),
	   ('~/imagenes/partidos/renacimientounidonacional.jpg', 'Renacimiento Unido Nacional', '~/Pdf/Resumen Partido Politico/renacimientounidonacional2021.pdf', 'https://www.partidoruna.pe/'),
	   ('~/imagenes/partidos/renovacionpopular.jpg', 'Renovacion Popular', '~/Pdf/Resumen Partido Politico/renovacionpopular2021.pdf', 'https://rafaelpresidente.pe/'),
	   ('~/imagenes/partidos/unionporelperu.jpg', 'Union Por El Peru', '~/Pdf/Resumen Partido Politico/unidoporelperu2021.pdf', 'https://www.upp.pe/'),
	   ('~/imagenes/partidos/victorianacional.jpg', 'Victoria Nacional', '~/Pdf/Resumen Partido Politico/victorianacional2021.pdf', 'https://www.forsythperu.pe/')
	
-------------PROPUESTAS DE GOBIERNO---------------------	
insert into tb_plan_gobierno (cod_par, nro_pro, soc_pro, eco_pro, nat_pro, ins_pro)
values
/*prpuestas fuerza popular*/
(1, 1,'1.1 AUMENTAR EL PRESUPUESTO DEL SECTOR. 1.2. REDUCIR LAS BRECHAS DE INFRAESTRUCTURA Y EQUIPAMIENTO. 1.3. IMPLEMENTAR RED INTERCONECTADA DE CENTROS DE ATENCIÓN PRIMARIA. 1.4. DETECCIÓN,
AISLAMIENTO Y SEGUIMIENTO DE INFECTADOS. 1.5. IMPLEMENTAR LA ARTICULACIÓN E INTEROPERABILIDAD DE LOS SISTEMAS.',
'1.1. CRECIMIENTO DEL PBI. 1.2. REALIZAR REFORMAS EN LAS ESTRUCTURAS DE GOBIERNO (PREVISIONAL, TRIBUTARIO, ADMINISTRATIVO-GUBERNAMENTAL,
FINANCIERO Y PROMOCIÓN DEL EMPRENDIMIENTO).',
'1.1 RESTAURAR EL EQUILIBRIO DE LOS ECOSISTEMAS.',
'1.1 SISTEMA INTEGRADO DE DECLARACIONES JURADAS DE BIENES, RENTAS E INTERESES, A CARGO DE LA CONTRALORÍA GENERAL DE LA REPÚBLICA.'),
(1, 2,'2.1. GENERAR INFRAESTRUCTURA EDUCATIVA DE CALIDAD QUE PROPICIE UN CORRECTO APRENDIZAJE. 2.2. AUMENTAR Y MEJORAR LA EJECUCIÓN PRESUPUESTAL.
2.3. FORTALECER UN SISTEMA DE CALIDAD EN TODAS LOS NIVELES EDUCATIVOS.',
'2.1 GENERACIÓN DE PUESTOS DE TRABAJO DIRECTOS E INDIRECTOS.','2.1 ORDENAMIENTO URBANO DE LAS CIUDADES Y PROYECTOS DE VIVIENDAS SOCIALES.',
'2.1 APROBACIÓN DE REFORMAS POLÍTICAS. 2.2. CONTAR CON UN SISTEMA DE DISEÑO DE POLÍTICA PÚBLICA EN BASE A LA EVIDENCIA.'),
(1, 3,'3.1. RESCATAR A LA POBLACIÓN PERUANA DE LA POBREZA. 3.2. RESCATAR A LOS NIÑOS Y ADOLESCENTES DE LAS CALLES.',
'3.1. FORMALIZACIÓN Y CAPACITACIÓN DE MYPES. 3.2. VENTANILLA ÚNICA Y LICENCIAS A COSTO CERO PARA MYPES.',
'3.1 ACUERDO Y ENTENDIMIENTO A TRAVÉS DE LOS SECTORES MINERO, AGRARIO Y AMBIENTAL.','3.1 CREACIÓN DE UN SISTEMA EFECTIVO DE SEGURIDAD CIUDADANA.'),

/*propuestas accion popular*/
(2, 1,'LOGRAR UNA SOCIEDAD LIBRE, DEMOCRATICA Y EQUITATIVA A TRAVES DE UN GOBIERNO HONRADO, ABIERTO Y TRANSPARENTE QUE DICTE MEDIDAS PARA
ATENDER A LOS SECTORES POSTERGADOS Y RESUELVA LAS NECESIDADES DE TODOS LOS PERUANOS.',
'CONSEGUIR QUE EL ESTADO TENGA UNA ECONOMIA QUE ESTE AL SERVICIO DE LOS MILLONES DE PERUANOS, ESTABLECIENDO MEDIDAS QUE DISTRIBUYAN MEJOR NUESTRA RIQUEZA, DESAROLLO DE CAPACIDADES,
APOYANDO EL EMPRENDIMIENTO Y LAS PYMES, INTRODUCIR TECNOLOGIA PARA FORTALECER LA INDUSTRIA Y LA AGRICULTURA NACIONAL',
'MANEJAR RACIONAL Y SOSTENIBLEMENTE NUESTROS RECURSOS NATURALES, LA PROTECCION A LA MEGADIVERSIDAD QUE CUENTA EL PAIS Y EL COMBATE A LAS PRACTICAS ILICITAS, PROTECCION DEL AGUA,
TIERRA Y OXIGENO Y PROMOVER EL USO DE ENERGIAS LIMPIAS.',
'REINSTALAR LA HONRADEZ EN LA POLITICA Y EN LA FUNCION PUBLICA CON UNA DEMOCRACIA GOBERNANTE. DICTADO DE LEYES QUE REFORMEN LAS INSTITUCIONES Y ESTABLEZCAN MECANISMOS DE CONTROL DE
MANERA QUE SEAN MAS EFICIENTES EN LOS SERVICIOS . SANCIONES SEVERAS A FUNCIONARIOS QUE INCURRAN EN ACTOS DE CORRUPCION.'),

/*propuestas alianza para el congreso*/
(3,1,'INTEGRAR LOS SISTEMAS DE ASEGURAMIENTO DEL SIS Y ESSALUD, CONSOLIDANDO UN SISTEMA UNIVERSAL Y MEJORANDO EL FINANCIAMIENTO DEL SISTEMA. MEJORAR EL ALCANCE Y LA CALIDAD DE LOS SERVICIOS DE SALUD,
INTEGRANDO SU GESTIÓN EN UNA SOLO ENTIDAD PRESTADORA. MEJORAR LA INFRAESTRUCTURA DE SALUD.',
'LOGRAR UN CRECIMIENTO SOSTENIDO DE 5% AL AÑO DESPUÉS DE CRECER 10% EN 2021 POR EFECTO REBOTE POST-COVID./PROMOVER LA COMPETITIVIDAD Y PRODUCTIVIDAD DE LA ECONOMÍA./CAMBIAR LA LÓGICA DE CONTRIBUCIONES
SOCIALES CON EL OBJETIVO DE INCENTIVAR LA FORMALIZACIÓN./FORTALECER NUESTRA CAPACIDAD EXPORTADORA',
'HACER DE CEPLAN UN ENTE DE PLANEAMIENTO REAL ADSCRITO AL MINISTERIO DE AMBIENTE ORDENAMIENTO TERRITORIAL Y URBANISMO, GENERANDO A SU VEZ UN SISTEMA DE COORDINACIÓN MACROTERRITORIAL./SE IMPLEMENTA EL PLAN
NACIONAL DE INFRAESTRUCTURA PARA LA COMPETITIVIDAD DEL MEF.',
'UN CONGRESO QUE ELABORE LEYES DE MAYOR CALIDAD./CIUDADANOS MEJOR REPRESENTADOS POR EL PARLAMENTO./UN PODER EJECUTIVO EFICIENTE PARA BRINDAR 
SERVICIOS PÚBLICOS DE CALIDAD Y PARA PROMOVER LA GENERACIÓN DE RIQUEZA.'),
(3,2,'MEJORAR DE MANERA SUSTANTIVA LA CALIDAD DE LA EDUCACIÓN BÁSICA/EXPANDIR EL ACCESO A LA EDUCACIÓN TÉCNICA PÚBLICA Y CONECTARLA CON LA EMPRESA PRIVADA/MEJORAR LA CALIDAD DE LA EDUCACIÓN UNIVERSITARIA ACERCÁNDOLA
A LAS NECESIDADES DE DESARROLLO ECONÓMICO, SOCIAL, CIENTÍFICO Y CULTURAL DEL PAÍS.',
'HACER DE LA PROMOCIÓN DEL EMPRENDIMIENTO UNA POLÍTICA DE ESTADO/IMPLEMENTAR PAQUETES INTEGRALES DE PROGRAMAS DE PROMOCIÓN DEL EMPRENDIMIENTO.',
'SACAR ADELANTE UN SISTEMA QUE PERMITA LOGRAR LA LICENCIA SOCIAL DE LOS PROYECTOS MINEROS, ASEGURANDO EFECTOS POSITIVOS SOBRE EL DESARROLLO DE LAS ZONAS DE INFLUENCIA./FORMALIZACIÓN DE LA PEQUEÑA MINERÍA SUBTERRÁNEA
Y ALUVIAL./MASIFICACIÓN DEL GAS NATURAL Y CAMBIO DE MATRIZ DE GENERACIÓN.',
'TENER UN SISTEMA JUDICIAL EFICIENTE QUE RESUELVA CAUSAS CON CELERIDAD Y TRANSPARENCIA./LOGRAR QUE SER JUEZ EN EL PERÚ SEA UNA ASPIRACIÓN PARA LOS MEJORES ABOGADOS DEL PAÍS, HACIENDO DEL PODER JUDICAL UNA INSTITUCIÓN
RESPETADA POR LOS CIUDADANOS./REDUCIR LOS ESPACIOS A LA CORRUPCION.'),
(3,3,'REDUCIR LA POBREZA MONETARIA /REDUCIR EL NÚMERO DE FEMINICIDIOS./IGUALAR SALARIOS DE MUJERES Y HOMBRES EN MISMOS PUESTOS DE RESPONSABILIDAD./INCREMENTAR LA HABILITACIÓN URBANA FORMAL A TRAVÉS DE LOS PROGRAMAS DE
FOMENTO A LA VIVIENDA SOCIAL-INCREMENTAR EL ACCESO A AGUA POTABLE Y SANEAMIENTO',
'INTEGRAR A LA PEQUEÑA AGRICULTURA A LA GLOBALIZACIÓN. /SE EXPANDE EL AUGE AGROEXPORTADOR CON TRABAJO DIGNO',
'DESARROLLAR EL SECTOR FORESTAL IMPULSANDO LA INVERSIÓN SOSTENIBLE EN CONCESIONES MADERABLES, PERO CONCENTRANDO LAS POLÍTICAS DE PROMOCIÓN EN LAS PLANTACIONES FORESTALES/INCORPORAR
A LOS PEQUEÑOS AGRICULTORES DE CAFÉ Y CACAO EN LA EXPANSIÓN DE LA CADENA DE VALOR DE LA MADERA.',
'CONTAR CON UN NUEVO SISTEMA DE SEGURIDAD NACIONAL QUE INTEGRE ACTIVIDADES HOY DISPERSAS Y SE NUTRA DE EXPERIENCIAS INTERNACIONALES./FORTELECER SEGURIDAD
CIUDADANA./FORTALECER LA SEGURIDAD PÚBLICA./FORTALECER LA SEGURIDAD DEL ESTADO'),

/*propuestas alianza para el progreso*/
(4,1,'INCREMENTAR PROGRESIVAMENTE EL PRESUPUESTO EN SALUD.', 'PRESERVAR LA FORTALEZA MACROECONÓMICA Y EL GRADO DE INVERSIÓN.','REFORMAR Y FORTALECER LAS INSTITUCIONES A CARGO DE LA FORMALIZACIÓN DE LA PROPIEDAD URBANA Y RURAL.',
'POTENCIAR LA OPERATIVIDAD DE LOS ÓRGANOS JURISDICCIONALES Y FISCALÍAS QUE CONOCEN CASOS DE CORRUPCIÓN Y DELITOS CONEXOS.'),
(4,2,'IMPULSAR LA PARTICIPACIÓN CIUDADANA EN EL DISEÑO E IMPLEMENTACIÓN DE LAS PROPUESTAS EN SALUD PARA HACERLAS VIABLES Y SOSTENIBLES EN EL TIEMPO.',
'CONTINUAR DESARROLLANDO EL COMERCIO Y LA DIVERSIFICACIÓN DE DESTINO Y PRODUCTOS DE EXPORTACIÓN.', null, null),

/*propuestas democracia directa*/
(5,1,'AUMENTAR EL ÍNDICE DE DESARROLLO HUMANO AJUSTADO POR DESIGUALDAD, PRIORIZANDO LAS ZONAS DE MAYOR POBREZA (IDH-D)','INCREMENTAR EL PBI NACIONAL, PRIORIZANDO A LAS ZONAS DE MAYOR POBREZA',
'RECUPERAR LOS SUELOS DEGRADADOS O DESERTIFICADOS.', 'LOGRAR LA APROBACIÓN DE LA NUEVA CONSTITUCIÓN POLÍTICA DEL PERÚ VÍA REFERÉNDUM.'),
(5,2,'RESOLVER LOS CONFLICTOS SOCIALES EN TODOS LOS NIVELES DE GOBIERNO.','AUMENTAR LA TASA DE CRECIMIENTO DE LA INVERSIÓN PRIVADA','REDUCIR LOS GASES DE EFECTO INVERNADERO.',
'REDUCIR DE LA CANTIDAD DE FUNCIONARIOS CON INDICIOS DE PRESUNTAS RESPONSABILIDADES DEBIDO A LA DISUASIÓN A LOS FUNCIONARIOS CORRUPTOS POR LAS MEDIDAS IMPLEMENTADAS.'),
(5,3,'ASIGNAR UN PRESUPUESTO INSTITUCIONAL QUE PERMITA IDENTIFICAR, REGISTRAR, ATENDER Y DAR SOLUCIÓN A LOS CONFLICTOS SOCIALES.',
'AUMENTAR LA TASA DE CRECIMIENTO DEL GASTO PÚBLICO, TANTO INVERSIÓN COMO CONSUMO PÚBLICOS.', 'IMPLEMENTAR EL ORDENAMIENTO TERRITORIAL EN TODAS LAS REGIONES.',
'DETECTAR LOS CASOS SOSPECHOSOS DE CORRUPCIÓN DE MANERA OPORTUNA E INMEDIATA (ALFARO, 2015C).'),

/*propuestas frente amplio*/
(6,1, 'LOGRAR LA IGUALDAD MEDIANTE UNA ACCION DEL ESTADO QUE GARANTICE EL EJERCICIO UNIVERSAL DE DERECHOS FUNDAMENTALES Y ACCESO UNIVERSAL A SERVICIOS PUBLICOS GRATUITOS, DE CALIDAD E INTERCULTURALES A TODOS Y TODAS,
Y QUE DESTIERRE TODA DISCRIMINACION', 'INICIAR UNA PROFUNDA TRANSFORMACIÓN DE LA ECONOMÍA PERUANA HACIA UNA MAYOR DIVERSIFICACIÓN DE SU MATRIZ PRODUCTIVA HACIA ACTIVIDADES ECONÓMICAS DE MAYOR IMPACTO EN LA CREACIÓN DE
EMPLEO Y EN LA GENERACIÓN DE AMPLIOS PROCESOS DE INNOVACIÓN TECNOLÓGICA, UTILIZANDO NUESTRA DIVERSIDAD BILOGICA', 'IMPULSAR EL ORDENAMIENTO TERRITORIAL DEL PAÍS, QUE BUSQUE ROMPER EL DIVORCIO ENTRE LO URBANO Y LO RURAL,
QUE PERMITA EL DESARROLLO TERRITORIAL SOSTENIBLE, LA PRESERVACION DE LOS BIENES NATURALES Y LA CONSERVACION DEL MEDIO AMBIENTE; MEDIANTE UNA CULTURA DE PLANIFICACIÓN Y PRVENCION DE RIESGOS',
'CONSTRUCCIÓN DEL SUJETO SOCIAL CONSTITUYENTE QUE HAGA POSIBLE LA APROBACIÓN DE UNA NUEVA CARTA MAGNA QUE AYUDE A CERRAR LA CRISIS DE GOBERNABILIDAD Y LEGITIME LA REESTRUCTURACIÓN DE LA ECONOMÍA NACIONAL PARA PONERLA AL SERVICIO DE LAS PERSONAS Y LOS PUEBLOS'),
(6,2, 'FORTALECER LA EDUCACIÓN BÁSICA ESPECIAL, EDUCACIÓN BÁSICA ALTERNATIVA, EDUCA-CIÓN COMUNITARIA Y LA EDUCACIÓN TÉCNI-COPRODUCTIVA CON UNA POLÍTICA INTEGRAL CREANDO MODELOS DIVERSOS DE GESTIÓN DE UN SERVICIO EDUCATIVO PARA LOS NIÑOS, NIÑAS Y ADOLESCENTES TRABAJADORES Y PARA LOS JÓVENES SIN EBR.',
'INCREMENTO REAL Y SOSTENIDO DE LAS REMUNERACIONES DE LOS TRABAJADORES, EMPLEO DIGNO Y DE CALIDAD CON IGUALDAD DE OPORTUNIDADES; UNIVERSALIZACIÓN DE LA SEGURIDAD SOCIAL Y PLENO RESPETO DE DERECHOS LABORALES DE TRABAJADORES EL ESTADO.',
'FORTALECER LA AUTORIDAD AMBIENTAL EN EL PAÍS, CON UN ENFOQUE TRANSVERSAL, MULTISECTORIAL Y DESCENTRALIZADO DE SU INSTITUCIONALIDAD Y CON UNA REAL CAPACIDAD DE FISCALIZACIÓN Y SANCIÓN',
'GARANTIZAR LOS DERECHOS TERRITORIALES, DE AUTONOMÍA Y REPRESENTACIÓN PROPIA A LOS PUEBLOS ORIGINARIOS Y AFRODESCENDIENTES PARA QUE SE EMPODEREN COMO NACIONES O PUEBLOS AUTÓNOMOS, CON IGUAL DIGNIDAD Y CAPACIDAD PARA GOBERNARSE.'),
(6,3, 'EDUCACIÓN CON PERSPECTIVA DE GÉNERO, NO SEXISTA, SIN ESTEREOTIPOS NI PREJUICIOS DE GÉNERO, Y UNA CULTURA GUBERNAMENTAL LIBRE DE VIOLENCIA DE GENERO', 'PROMOCIÓN DE LA AGRICULTURA FAMILIAR, FOMENTO DE LA SOBERANÍA Y SEGURIDAD ALIMENTARIA, LA ASOCIATIVIDAD, Y MAYORES GARANTÍAS PARA LA PRODUCCIÓN NACIONAL Y EL DESARROLLANDO DEL MERCADO INTERNO EN NUESTRO PAÍS.',
'CONSTRUCCIÓN Y DESARROLLO DE UNA CIUDADANÍA AMBIENTAL Y DE LA SOSTENIBILIDAD, MEDIANTE PROGRAMAS DE EDUCACION AMBIENTAL Y CAMPAÑAS DE COMUNICACION Y DIFUSION MASIVAS',
'RECUPERAR LA CONFIANZA DE LA CIUDADANIA, HACIA LAS INSTITUCIONES DEL ESTADO, ESPECIALMENTE DE LOS JOVENES, MEDIANTE ACCIONES DE TRANSPARENCIA Y RENDICION DE CUENTAS PERIODICAS POR PARTE DEL GOBIERNO.'),
/*propuestas frepap*/

/*propuestas juntos peru*/
(8,1, 'FORTALECER LA EDUCACIÓN PÚBLICA DE CALIDAD CON ENFOQUE DE DERECHOS, GÉNERO E INTERCULTURALIDAD FORTALECER LA INVESTIGACIÓN CIENTÍFICA EN EL PERÚ EN COORDINACIÓN CON UNIVERSIDADES MEJORAR LA CAPACIDAD Y CALIDAD DEL SISTEMA DE SALUD. CREAR EL SISTEMA PERUANO DE CUIDADOS SPC QUE PROMUEVA LA IGUALDAD',
'REACTIVACIÓN ECONÓMICA DIVERSIFICADA Y GENERACIÓN DE EMPLEOS DIGNOS. NUEVO MODELO DE DESARROLLO EQUITATIVO Y AMBIENTALMENTE SOSTENIBLE Y QUE INCORPORA LA ECONOMÍA DE CUIDADO. INNOVACIÓN ACELERADA Y ADOPCIÓN TICS. SEGUNDA REFORMA AGRARIA. SEGURIDAD SOCIAL UNIVERSAL CON ENFOQUE DE GÉNERO.',
'FORTALECER INSTITUCIONALIDAD PARA PROTEGER LA NATURALEZA Y CUIDAR LA SALUD DE LA GENTE. TRANSITAR HACIA ECONOMÍA ECOLÓGICA PROMOVER EVALUACIÓN MULTICRITERIO DE PROYECTOS DE INVERSIÓN REGULARIZAR DERECHOS SOBRE LOS TERRITORIOS EN LOS QUE SE UBICAN LOS BOSQUES FORTALECER EL MANEJO FORESTAL',
'CONSTRUIR ESTADO NACIÓN SOBERANO QUE RESPETA PLURALIDAD DE CULTURAS Y GARANTIZA EJERCICIO DE DERECHOS CON POLÍTICAS NACIONALES FINANCIADAS PARA SALUD, EDUCACIÓN, CUIDADOS, SEGURIDAD ALIMENTARIA. ESTADO EFICIENTE QUE LLEGA A POBLACIÓN Y TERRITORIO DE FORMA DEMOCRÁTICA, DESCENTRALIZADA Y PARTICIPATIVA'),

/*propuestas democratico somos peru*/
(9,1, 'AMPLIAR PROGRESIVAMENTE LA COBERTURA UNIVERSAL DE SALUD EN LA POBLACIÓN DEL PAÍS.', 'RELANZAMIENTO DEL EMPLEO E INVERSIÓN PÚBLICA CON EL PLAN PERÚ 200 QUE AGILIZARÁ LA EJECUCIÓN DE 200 PIP QUE YA ESTÁN APROBADOS O PARCIALMENTE REALIZADOS',
'PONER EN VALOR EL CAPITAL NATURAL A TRAVÉS DE UNA GESTIÓN INTEGRAL DEL TERRITORIO, DIVERSIFICANDO EL APROVECHAMIENTO DE LOS RECURSOS NATURALES DE UNA FORMA EFICIENTE Y GENERANDO EL MENOR IMPACTO AMBIENTAL Y SOCIAL POSIBLE','ELIMINAR LA INMUNIDAD PARLAMENTARIA'),
(9,2, 'INCREMENTAR EL PRESUPUESTO ANUAL DEL PLIEGO EDUCACIÓN PARA EL AÑO 2022 PARA LA IMPLEMENTACIÓN DE UN PLAN DE INVERSIONES EN EL SECTOR.', 'EJECUCIÓN DEL PLAN NACIONAL DE INFRAESTRUCTURA QUE PRIORIZA 50 OBRAS DE ALTO IMPACTO EN LA COMPETITIVIDAD Y EN EL BIENESTAR DE LA POBLACIÓN, OBRAS DE INFRAESTRUCTURA QUE AYUDARÁN A CERRAR BRECHAS A NIVEL NACIONAL',
'APLICAR UN ENFOQUE DE ECONOMÍA CIRCULAR PARA ALCANZAR UN DESARROLLO BAJO EN EMISIONES QUE NOS PERMITA MAYOR RESILIENCIA FRENTE AL CAMBIO CLIMÁTICO','REFORMA CONSTITUCIONAL QUE DISPONGA QUE LA ELABORACIÓN DE UNA NUEVA CONSTITUCIÓN DEBA HACERSE POR ASAMBLEA CONSTITUYENTE ELEGIDA POR VOTACIÓN POPULAR Y QUE EL NUEVO TEXTO CONSTITUCIONAL DEBA SER SOMETIDO A REFERÉNDUM Y APROBADO POR UNA MAYORÍA DE 70% DE VOTANTES.'),
(9,3, 'INCREMENTAR LA COBERTURA DE LOS PROGRAMAS SOCIALES QUE PRIORICEN EL CIERRE DE BRECHAS PENDIENTES DE LA POBLACIÓN EN SITUACION DE POBREZA Y POBREZA EXTREMA', 'REVISIÓN E INCREMENTO ANUAL DE LA REMUNERACIÓN MÍNIMA VITAL', 'PROMOVER LA CONSTRUCCIÓN DE PLANTAS DE TRATAMIENTO DE AGUAS RESIDUALES A NIVEL LOCAL.',
'REFORMAR LA POLICÍA NACIONAL DEL PERÚ, RESPETANDO SU INSTITUCIONALIDAD, MEDIANTE LA ESTRATEGIA DE ESTABLECIMIENTO DE POLICÍA COMUNITARIA: UNA POLICÍA EFICIENTE AL SERVICIO DE LA GENTE'),

/*propuestas partido morado*/
(10,1, '1. ATENCIÓN INTEGRAL A LA PRIMERA INFANCIA, CON GARANTÍA DE NUTRICIÓN. 2. PERTINENCIA Y CULMINACIÓN OPORTUNA DE EDUCACIÓN BÁSICA. 3. MAYOR ACCESO A UNA EDUCACIÓN SUPERIOR DE CALIDAD. 4. DESARROLLO PROFESIONAL DOCENTE. 5. PROMOCIÓN DE LA CIENCIA Y TECNOLOGÍA. 6. CULTURA FÍSICA, RECREACIÓN Y DEPORTE',
'1. ESTABILIDAD, PREDICTIBILIDAD Y PRUDENCIA EN EL MANEJO DE LA ECONOMÍA. 2. MEJORA DE LA RECAUDACIÓN TRIBUTARIA: REFORMA TRIBUTARIA INTEGRAL.','1. CONSERVACIÓN Y USO SOSTENIBLE DE RECURSOS NATURALES CON ENFOQUE EN ECONOMÍA CIRCULAR Y MITIGACIÓN DEL CAMBIO CLIMÁTICO. 2. GESTIÓN DE RESIDUOS SÓLIDOS. 3. GESTIÓN DE RIESGOS Y DESASTRES.',
'1. GARANTÍA DEL ACCESO A LA JUSTICIA CON EQUIDAD, CELERIDAD Y HONESTIDAD. 2. SEGUIMIENTO Y PROTECCIÓN ESPECIAL PARA PERSONAS EN SITUACIÓN VULNERABLE: FEMINICIDIO, VIOLENCIA FAMILIAR, SECUESTRO, TRATA DE PERSONAS, TRABAJO INFANTIL.'),
(10,2, '1. SISTEMA ÚNICO DE SALUD, CON FORTALECIMIENTO DEL PRIMER NIVEL. 2. SALUD COMUNITARIA CON ENFOQUE EN INFANCIA, ENFERMEDADES DE ALTO COSTO Y TERCERA EDAD. 3. PROGRAMAS DE APOYO A PERSONAS EN VULNERABILIDAD. 4. SALUD Y BENEFICIOS SOCIALES PARA TRABAJADORES. 5. VIGILANCIA DE CONDICIONES DIGNAS DE TRABA',
'1. TURISMO, HOTELERÍA Y GASTRONOMÍA. 2. ACTIVIDAD PESQUERA TRADICIONAL E INDUSTRIAL. 3. OFERTA DE PUESTOS DE TRABAJO FORMALES Y SOSTENIBLES. 4. AGRICULTURA Y GANADERÍA PARA GENERAR EMPLEO, SEGURIDAD ALIMENTARIA Y DESARROLLO RURAL. 5. INDUSTRIA FORESTAL SOSTENIBLE Y CULTURA DE GUARDABOSQUES EN LA SEL', '1. PLANIFICACIÓN TERRITORIAL: USO RACIONAL Y SOSTENIBLE DE NUESTRA GEOGRAFÍA Y NATURALEZA. 2. 
VIVIENDA DIGNA EN ENTORNOS ESTIMULANTES. (CIUDAD) (VIVIENDA) 3. SERVICIOS DE TRANSPORTE CON VISIÓN MULTIMODAL Y ALCANCE NACIONAL', '1. REFORMA Y REVISIÓN DEL SERVICIO CIVIL Y CARRERA PÚBLICA. 2. REFORMA DE LAS CONTRATACIONES DEL ESTADO: INTERVENCIÓN CONCURRENTE DE LA CONTRALORÍA, LICITACIONES Y OBRAS PÚBLICAS.'),
(10,3, '1. PROMOVER LA REIVINDICACIÓN Y VALORIZACIÓN DE LA DIVERSIDAD CULTURAL, ÉTNICA Y DE GRUPOS SOCIALES Y LUCHA CONTRA LA DISCRIMINACIÓN. 2. VIGILANCIA Y SANCIÓN DEL MALTRATO ANIMAL. 3. DESARROLLO Y FORTALECIMIENTO DE COMPETENCIAS CIUDADANAS PARA LA CONVIVENCIA ARMONIOSA.', '1. PROMOCIÓN DEL PRODUCTO PERUANO DE ALTA CALIDAD PARA EL MERCADO INTERNO Y EXTERNO. 2. ELIMINACIÓN DE BARRERAS Y TRÁMITES Y APOYO DE SUS DERECHOS CIUDADANOS DE LOS PERUANOS EN EL EXTERIOR.',
'1. CONECTIVIDAD E INFRAESTRUCTURA DIGITAL DE ALCANCE NACIONAL. 2. PLATAFORMA ÚNICA DIGITAL PARA INSTITUCIONES DEL GOBIERNO CENTRAL, REGIONAL Y LOCAL. 3. SERVICIOS DIGITALES DEL GOBIERNO HACIA EL CIUDADANO Y LAS EMPRESAS: CARPETA CIUDADANA DIGITAL (GRATUITA), EDUCACIÓN, MEDICINA.', '1. PREVENCIÓN DEL DELITO Y LUCHA CONTRA LA VIOLENCIA DOMÉSTICA, VIOLENCIA DE GÉNERO Y PERSONAS VULNERABLES. 2. MODERNIZACIÓN Y FORTALECIMIENTO DE LA PNP: RRHH, ESPECIALIZACIÓN,
INFRAESTRUCTURA, LOGÍSTICA Y TECNOLOGÍA. 3. PREVENCIÓN Y LUCHA CONTRA LA PRODUCCIÓN, DISTRIBUCIÓN Y CONSUMO DE DROGAS.'),

/*propuestas partido nacionalista peruano*/
(11,1, 'LA INSTAURACIÓN DE UNA SEGUNDA REPÚBLICA MEDIANTE LA CONVOCATORIA A UNA ASAMBLEA CONSTITUYENTE, QUE ORIENTE UN PROYECTO NACIONAL QUE CAMBIE Y DESARROLLE NUESTRA', 'LA POLÍTICA SOCIAL EN ESTE QUINQUENIO SE HA ABANDONADO Y DEJADO DE SER UNA PRIORIDAD, AFECTANDO A LOS MÁS POBRES PERMITIENDO',
'LA POLÍTICA SOCIAL EN ESTE QUINQUENIO SE HA ABANDONADO Y DEJADO DE SER UNA PRIORIDAD, AFECTANDO A LOS MÁS POBRES PERMITIENDO', 'LA POLÍTICA SOCIAL EN ESTE QUINQUENIO SE HA ABANDONADO Y DEJADO DE SER UNA PRIORIDAD, AFECTANDO A LOS MÁS POBRES PERMITIENDO LA POLÍTICA SOCIAL EN ESTE QUINQUENIO SE HA ABANDONADO Y DEJADO DE SER UNA PRIORIDAD, AFECTANDO A LOS MÁS POBRES PERMITIENDO'),

/*propuestas contigo peru*/

/*propuestas partido popular cristiano*/
(13,1, 'SE REQUIERE MEJORAR LAS CONDICIONES DE IFRAESTRUCTURA, EDUCATIVA, ESTABLECER MECANISMOS PARA REDUCIR LA DESERCIÓN ESCOLAR, POTENCIAR LA EDUCACIÓN PARA QUE LOS ALUMNOS PUEDAN COMPETIR, Y PROMOVER EL ACCESO A EDUCACIÓN DE CALIDAD PARA EL EDUCANDO RESPETANDO LAS DIFERENCIAS.',
'PROMOVER LA PARTICIPACIÓN DE LA EMPRESA PRIVADA PARA LAS OBREAS MEDIANTE OTROS SISTEMAS: OBRAS POR IMPUESTOS, ACUERDOS DE GOIERNO A BOGIERNO ENTRE OTRAS, PERMITIENDO LA EFICIENCIA EN LA EJECUCIÓN DE LAS OBRAS Y LA PRIORIZACIÓN DE LAS MISMAS','FORTALECER LA INTITUCIONALIDAD AMBIENTAL PARA QUE TENIENDO LAS ATRICUCIONES REQUERIDAD SE CONVIERTA REALMENTE EN UN ENTE ARTCULADOR DE LA PROBLEMATICA Y OBJETIVOS AMBIENTALES QUE TIENE LA NACIÓN',
'FORTALECIMIENTO INSTITUCIONAL E INTERACCIÓN DENTRO DEL SISTEMA, SELECCIÓN Y CAPACITACIÓN DE OPERADORES, INTEGRIDAD, TRANSPARENCIA Y ACCESO. RESPETAR Y GARANTIZAR LOS DDHH Y ATENDER LOS GRUPOS DE ESPECIAL PROTECCIÓN PROMOVIENDO LA IGUALDAD DE GENERO'),
(13,2, 'GENERAR ESTRATEGIAS MULTISECTORIALES PARA REDUCIR LA INFORMALIDAD PRIORIZANDO LA EMPLEABILIDAD JUVENIL CONSIDERANDO LAS NECESIDADES DE LOS MERCADOS PRODUCTIVOS Y AMPLIANDO LA PROTECCIÓN SOCIAL DE LA CIUDADANÍA DE MANERA QUE SE GENERE UNA ESTABILIDAD ECONOMICA Y SOCIAL.','FORTALECER EL IMPULSO EMPRESARIAL ENTENDIENDO QUE LOS RECURSOS NATURALES Y LA BIODIVERSIDAD DEL PERÚ, SON CAPITALES NATURALES QUE SE DEBEN APROVECHAR DE MANERA SUSTENTABLE Y SOSTENIDA.',
'ELIMINAR LA IMPUNIDAD Y ATENDER LOS FACTORES QUE CONFLUYEN PARA LA COMISIÓN DE LOS DELITOS COMUNES Y EL CRIMEN ORGANIZADO', null),
(13,3, 'SELECCIÓN Y CAPACITACIÓN DE OPERADORES DEL SISTEMA DE JUSTICIA', null, null, null),

/*propuestas peru libre*/
(14,1, 'SALUD PÚBLICA ORIENTADA A INTERESES DEL PUEBLO, CON SUFICIENTES RECURSOS ASIGNADOS DEL PRESUPUESTO PÚBLICO. IMPLEMENTACIÓN Y MODERNIZACIÓN DE LOS MEDIOS DE DIAGNÓSTICOS PARA CADA REGIÓN MEJORANDO LA CAPACIDAD Y CALIDAD DE ATENCIÓN EN LA SALUD PÚBLICA.',
'FIN AL HAMBRE, LA SEGURIDAD ALIMENTARIA, MEJOR NUTRICIÓN Y PROMOVER LA AGRICULTURA SOSTENIBLE. IMPLEMENTAR UNA POLÍTICA AGRARIA COMO SEGURIDAD NACIONAL. ESTE SECTOR TIENE UNA AGENDA ESPECIAL EN NUESTRO PROGRAMA, DESDE EL INCREMENTO DEL PRESUPUESTO, LA TECNIFICACIÓN, PROMOVER MERCADOS INTER. Y EXT.',
'LA DEFENSA Y CONSERVACIÓN DEL MEDIO AMBIENTE CONSTITUYE PARA EL SOCIALISMO UNA DE LAS COLUMNAS DONDE SE SOSTIENE, A DIFERENCIA DIAMETRALMENTE OPUESTA DEL NEOLIBERALISMO.', 'ELIMINAR LA INMUNIDAD POLÍTICA-.'),
(14,2, 'EDUCACIÓN DE CALIDAD INCLUSIVA Y EQUITATIVA, Y PROMOVER LAS OPORTUNIDADES DE APRENDIZAJE PERMANENTE PARA TODOS. LA ASIGNACIÓN PRESUPUESTAL DEBE INCREMENTARSE DE MANERA VALIENTE E HISTÓRICA MÍNIMAMENTE AL 10% DEL PBI. GARANTIZAR MEJOR INFRAESTRUCTURA, EQUIPAMIENTO, AUMENTO DE SUELDO PARA LOS MAESTROS',
'MODIFICAR LA ACTUAL SITUACIÓN EN QUE EL GOBIERNO CENTRAL EN SU POLÍTICA CENTRALISTA ASIGNA EL 70% DEL PRESUPUESTO NACIONAL Y EL 30% RESTANTE ENTRE LOS 25 GOBIERNOS REGIONALES Y LAS 4,385 MUNICIPALIDADES. EXISTE UNA RELACIÓN DIRECTAMENTE PROPORCIONAL ENTRE LA CONCENTRACIÓN ECONÓMICA Y LA CORRUPCIÓN.',
'LAS REGIONES DEBEN ELABORAR CON AUTONOMÍA REAL SU PROPIA ZEE, SIN INJERENCIA DEL GOBIERNO CENTRAL, DEMARCAR SUS ÁREAS PROTEGIDAS E INTANGIBLES, SUSÁREAS HÍDRICAS, AGRÍCOLAS, DE RESIDUOS SÓLIDOS, DE RECURSOS NATURALES EXPLOTABLES Y NO EXPLOTABLES, ETC. BAJO EL CONTROL CIUDADANO. PRESERVANDO EL M.AMB.',
'CREACIÓN DE UNA CONTRALORÍA ESPECIAL PARA EMPRESAS PRIVADAS.'),
(14,3, 'FOMENTAR UN CRECIMIENTO ECONÓMICO SOSTENIDO, INCLUSIVO Y SOSTENIBLE, EL EMPLEO PLENO Y PRODUCTIVO, Y EL TRABAJO DECENTE PARA TODOS.DEFENDEMOS EL DERECHO AL TRABAJO, EL DERECHO EN EL TRABAJO Y EL DERECHO DESPUÉS DEL TRABAJO. ASÍ COMO LA SEGURIDAD SOCIAL CON CARÁCTERUNIVERSAL, QUE LES UNA VIDA DIGNA.',
'PROHIBIR PRIVATIZAR EL AGUA. LA NUEVA CONSTITUCIÓN DEBE PROHIBIR DE MANERA TAXATIVA LA PRIVATIZACIÓN DEL AGUA, COMO LO REFRENDA LAS CONSTITUCIONES DE ECUADOR Y BOLIVIA. EN NUESTROS PAÍSES SE HAN EMPODERADO LAS JUNTAS DE AGUAS O DE RIEGO, HABIÉNDOLA PRIVATIZADO EN LA PRÁCTICA, PARA CONTROLARLOS.',
'ELIMINAR SUELDOS DORADOS DEL ESTADO, COMO EL DEL CONTRALOR DE LA REPÚBLICA, QUIÉN DEBIERA LIDERAR ESTA INICIATIVA, SIN EMBARGO, SU SUELDO DUPLICA AL DEL PRESIDENTE DE LA REPÚBLICA, DEBIENDO CORREGIRSE.', null),

/*propuestas peru patria segura*/
(15,1, 'REDUCIR LOS FACTORES DE RIESGO QUE GENERAN COMPORTAMIENTOS VIOLENTOS Y DELICTIVOS EN LOS QUE SON AFECTADOS, NIÑOS, JÓVENES, MUJERES Y PERSONAS DE LA TERCERA EDAD EN SITUACIÓN DE VULNERABILIDAD.', 'PASAR DE LA PRIMERA REVOLUCIÓN VERDE A LA SEGUNDA REVOLUCIÓN VERDE APLICAR LA ECONOMÍA CIRCULAR',
'DESARROLLO DE LA ECONOMÍA LOCAL, EN BASE A LA INTEGRACIÓN DE LAS INSTITUCIONES : ESTADO , EMPRESAS ACADÉMICAS, SOCIEDAD CIVIL.', 'PASAR DE LA ECONOMÍA GLOBALIZDADA A LA ECONOMÍA LOCAL, HACIENDO MÁS CON LO QUE TENEMOS, EN LAS LOCALIDADES Y REGIONES.'),

/*propuestas podemos peru*/
(16,1, '-REDUCIR ÍNDICES DE POBREZA Y POBREZA EXTREMA -ERRADICAR TODAS LAS FORMAS DE DISCRIMINACIÓN', 'RESCATE MACROECONÓMICO Y CRECIMIENTO SOSTENIDO', 'ASEGURAR LA PROVISIÓN DE INFRAESTRUCTURA PRODUCTIVA SUFICIENTE, ADECUADA Y DE CALIDAD', 'DESARROLLAR Y CONSOLIDAR LA GOBERNABILIDAD DEMOCRÁTICA Y UNA FUERTE INSTITUCIONALIDAD PÚBLICA'),
(16,2, 'GARANTIZAR EL DERECHO A LA PARTICIPACIÓN POLÍTICA Y LA CIUDADANÍA INTER-CULTURAL', 'DESARROLLAR UN SISTEMA DE INNOVACIÓN QUE POTENCIE LA ESTRUCTURA ECONÓMICA', 'TERRITORIO COHESIONADO Y ORGANIZADO EN CIUDADES SOSTENIBLES CON PROVISIÓN ASEGURADA DE INFRAESTRUCTURA DE CALIDAD', 'DESARROLLAR UNA GESTION PUBLICA EJECUTIVA ORIENTADA AL CIUDADANO EN LOS 3 NIVELES DE GOBIERNO'),
(16,3, 'GARANTIZAR EL ACCESO A SERVICIOS DE CALIDAD QUE PERMITAN EL DESARROLLO PLENO EN CONDICIONES EQUITATIVAS Y SOSTENIBLE.', 'TENER UNA ESTRUCTURA PRODUCTIVA DIVERSIFICADA Y PRO-EXPORTADORA QUE PARTICIPE EN CADENAS DE VALOR GLOBAL',
'APROVECHAMIENTO EFICIENTE, RESPONSABLE Y SOSTENIBLE DE LA DIVERSIDAD BIOLÓGICA, ASEGURANDO UNA CALIDAD MAMBIENTAL ADECUADA PARA EL DESARROLLO SOSTENIBLE DEL PAÍS.', 'GARANTIZAR EL ESTADO DE DERECHO Y LA SEGURIDAD CIUDADANA'),

/*propuestas renacimiento unido nacional*/
(17,1, 'ATENCIÓN DE SERVICIOS DE EDUCACIÓN DE CALIDAD DE CARÁCTER HUMANÍSTICO, CIENTÍFICO Y TECNOLÓGICO CON SUELDOS DIGNOS PARA LOS MAESTROS. BECAS DE GRADO Y POSGRADO PARA LA JUVENTUD ESTUDIOSA.', 'RECUPERACIÓN PROGRESIVA DEL PBI, MEDIANTE LA INCENTIVACIÓN A LA MAYOR INVERSIÓN, EMPLEO Y CONSUMO.',
'INSTRUIR A LA POBLACIÓN EN TALLERES, SEMINARIOS, CONFERENCIAS, FOLLETOS, EN LA COMPRENSIÓN DE LOS ALCANCES DE LA LEY DE DESCENTRALIZACIÓN Y EL EJECUTIVO COORDINARA CON LOS GOBIERNOS REGIONALES Y LOCALES LOS PROGRAMAS Y PROYECTOS QUE REALICEN EN LOS RESPECTIVOS TERRITORIOS.', 'ELECCIÓN E INSTALACIÓN DE UNA CONSTITUYENTE REDACTORA'),
(17,2, 'DESTINANDO EL 6% DEL PBI, COMO RECURSO ASIGNADO AL SECTOR EDUCACIÓN, AL 28 DE JULIO DEL 2030 (MEF)', 'APROVECHAR EL IMPULSO DE LA DEMANDA EXTERNA YA QUE DEBEMOS BENEFICIARNOS POR LA REANUDACIÓN DE ACTIVIDADES Y PAQUETES DE ESTÍMULO EN OTRAS ECONOMÍAS A NIVEL GLOBAL.',
'EL APROVISIONAMIENTO OPORTUNO DEL AGUA A PRECIOS ACCESIBLES PARA EL CONSUMO HUMANO, PARA EL AGRÍCOLA ES GRATUITO EN EL TIEMPO, SERÁ RESPONSABILIDAD DE NUESTRO GOBIERNO, SE COORDINARÁ LAS MEDIDAS PERTINENTES CON LOS GOBIERNOS REGIONALES Y LOCALES',
'PLANTEAR LA REFUNDACIÓN DE LA NACIÓN, EN BASE A LOS PRINCIPIOS Y VALORES DEL TAWANTINSUYU DEL (AMA SUA, AMA QILLA Y AMA LLULLA)'),
(17,3, 'ORIENTAR LA EDUCACIÓN PERUANA, SOBRE TODO LA EDUCACIÓN SUPERIOR, HACIA ÁREAS PRIORITARIAS DEL DESARROLLO NACIONAL, CON VALORES TAWANTINSUYANAS', 'MANTENER LA FORTALEZA MACROECONÓMICA DE PERÚ CONSEGUIDA EN LOS ÚLTIMOS AÑOS QUE HA PERMITIDO MANIOBRAR CON MEDIDAS FISCALES Y MONETARIAS Y PALEAR LOS EFECTOS DEL EN CAMPO DE LA ECONOMÍA Y SALUD COVID-19.',
'LA POBLACIÓN URBANA Y RURAL PARTICIPA EN LA FORMULACIÓN DEL PLAN CON ENFOQUE TERRITORIAL PARA EL DESARROLLO SOSTENIBLE Y DE GESTIÓN AMBIENTAL, EL USO EFICIENTE DEL SUELO, SUBSUELO, AGUA Y AIRE.',
'GENERAR LAS CONDICIONES PARA INSTAURAR UN ESTADO TAWANTINSUYANO BASADO EN EL SISTEMA CONFEDERATIVO QUE RECOJA LAS REALIDADES Y POTENCIALIDADES DE NUESTRA BIODIVERSIDAD Y EL ECOSISTEMA GEOGRÁFICO ANDINO.'),

/*propuestas renovacion popular*/
(18,1, '1.CREAR UNA CENTRAL CONTRA LA CORRUPCIÓN 2.RECUPERAR EL PRINCIPIO DE AUTORIDAD Y CONFIANZA EN LAS INSTITUCIONES 3.REFORZAR LAS ORGANIZACIONES POPULARES 4.LUCHAR PARA ERRADICAR LA POBREZA EXTREMA 5.DOTAR Y FORTALECER LAS POSTAS MÉDICAS 6.DERROTAR LA DELINCUENCIA COMÚN',
'GARANTIZAR MEDIDAS QUE PERMITAN UN CRECIMIENTO SOSTENIDO DEL PBI REDUCIR LA INFLACIÓN IMPULSAR LA INDUSTRIALIZACIÓN Y LA PRODUCCIÓN DE BIENES Y SERVICIOS. TRABAJAR EN LA GENERACIÓN DE VENTAJAS COMPETITIVAS EN NUESTRA ECONOMÍA. APOYAR LA CREACIÓN DEL BANCO DE PYMES DE CAPITAL PRIVADO.',
'CONTROLAR LAS EMISIONES DE GASES DE EFECTO INVERNADERO. REFORZAR LA INSTITUCIONALIDAD Y DAR FACULTADES DEL CONSEJO NACIONAL DEL AGUA PARA UN EFICIENTE MANEJO TÉCNICO DE LAS CUENCAS. AUMENTAR EL SERVICIO DE AGUA POTABLE EN TODO EL PAÍS. PROTEGER LOS BOSQUES CONTRA LA TALA INDISCRIMINADA.',
'ELIMINAR LAS BARRERAS BUROCRÁTICAS PROMOVER UN GOBIERNO AL SERVICIO DEL CIUDADANO REDUCIR EL NÚMERO DE MINISTERIOS EXISTENTES DESCENTRALIZAR LAS SEDES MINISTERIALES Y EL PROPIO PODER EJECUTIVO'),

/*propuestas union por el peru*/
(19,1, 'LOGRAR REDUCIR LA BRECHA DE CONECTIVIDAD DE INTERNET, MEJOR GESTION PARA EL MANTENIMIENTO Y EQUIPOS BIOMEDICOS DE HOSPITALES PARA EL COVID 19, REDUCIR LA BRECHA DE LOS SERVICIOS DE AGUA POTABLE, ALCANTARILLADO Y DESAGUE, CAMBIO DE LA CONSTITUCION DEL 93 Y PENA DE MUERTE A LOS CORRUPTOS',
'LA PROPIEDAD DEL SUB SUELO DEBE SER DEL DUEÑO DEL SUELO, REDUCIR LA BRECHA DE INFRAESTRUCTURA DE TRANSPORTE AÉREO, TERRESTRE, LACUSTRE Y FLUVIAL, PROGRAMA DE CAPACITACIÓN PARA LA MICRO Y PEQUEÑA EMPRESA CON INCENTIVOS ARANCELARIOS PARA LA IMPORTACIÓN DE TECNOLOGÍA.',
'APROBACIÓN DE ESTUDIOS DE IMPACTO AMBIENTAL EN PROYECTOS MINEROS, REDUCIR EL PARQUE AUTOMOTOR EN UN 10 % CADA AÑO., PARTICIPACION CIUDADANA EN LA GESTION AMBIENTAL.', 'REDUCCION DE MINISTERIOS PARA AGILIZAR LA GESTION PUBLICA, CREACION DEL NUEVO MINISTERIO DE LA FAMILIA FUSIONANDO EL MIDIS Y EL MIMP, MINISTERIO DE LA PRODUCCION INCORPORA AL MINISTERIO DE TURISMO.'),

/*propuestas victoria nacional*/
(20,1,'VINCULAREMOS LA FORMACIÓN TÉCNICA DESDE LOS 2 ÚLTIMOS AÑOS DE LA EDUCACIÓN SECUNDARIA, CON LA POSIBILIDAD DE ACCEDER CON FACILIDAD A UN EMPLEO TÉCNICO Y SEGUIR LOS ESTUDIOS TÉCNICOS ESPECIALIZADOS DE MANERA DUAL O DE REGRESAR A LA EDUCACIÓN CLÁSICA UNIVERSITARIA POR VALIDACIÓN DE LOS ESTUDIOS.',
'RECUPERAREMOS EL EQUILIBRIO FISCAL SINCERANDO LAS NECESIDADES DE ENDEUDAMIENTO Y GASTOS PÚBLICOS', 'GESTIONAREMOS LAS EMISIONES DE GASES DE EFECTO INVERNADERO (GEI).', 'IMPULSAREMOS UNA REFORMA CONSTITUCIONAL QUE CONTRIBUYA A REDUCIR DRÁSTICAMENTE LOS ACTOS DE CORRUPCIÓN SISTEMÁTICOS.'),
(20,2,'DESARROLLAREMOS UNA RED DESCENTRALIZADA DE SERVICIOS DE ATENCIÓN PRIMARIA, APLICANDO UN ENFOQUE DE INTERCULTURALIDAD Y PARTICIPACIÓN CIUDADANA QUE PERMITA CONTENER TEMPRANAMENTE LAS ENFERMEDADES EVITANDO RIESGOS DE COLAPSO DE LA ATENCIÓN HOSPITALARIA.',
'IMPULSAREMOS LA GENERACIÓN DE EMPLEOS PERMANENTES, DINAMIZANDO Y RENTABILIZANDO LOS NEGOCIOS MYPE, E IMPULSANDO EL CONSUMO Y LA INVERSIÓN.', 'ELEVAREMOS PROGRESIVAMENTE LA PARTICIPACIÓN DE LAS ENERGÍAS RENOVABLES NO CONVENCIONALES DE BAJO COSTO AMBIENTAL Y ECONÓMICO EN LA MATRIZ ENERGÉTICA.',
'LUCHAREMOS CONTRA LA IMPUNIDAD EN DELITOS DE CORRUPCIÓN PROPICIANDO UNA LABOR ARTICULADA ENTRE FISCALES, PROCURADORES, CONTRALORES E INTELIGENCIA FINANCIERA, CON EL SOPORTE DE HERRAMIENTAS DE INVESTIGACIÓN PENAL, PERICIA LEGAL, ADMINISTRATIVA Y FINANCIERA.'),
(20,3,'OPTIMIZAR LA LABOR DE INTELIGENCIA OPERATIVA MANTENIENDO ESTRECHA RELACIÓN CON SUS PARES A NIVEL NACIONAL E INTERNACIONAL.', 'RENTABILIZAR Y RECUPERAR CON RESILIENCIA LOS NEGOCIOS MYPE, IMPULSANDO EL DESARROLLO DE REDES Y CADENAS PRODUCTIVAS A TRAVÉS DE PLATAFORMAS QUE CONTRIBUYAN A SU FORMALIZACIÓN.',
'PROMOVEREMOS LA OPTIMIZACIÓN DE LOS SISTEMAS DE RIEGO Y LA GESTIÓN INTEGRADA DEL AGUA A NIVEL DE CUENCAS HIDROGRÁFICAS', 'IMPLEMENTAREMOS LA REFORMA DE LA CARRERA PÚBLICA. REFORMAREMOS Y OPTIMIZAREMOS LOS SISTEMAS DE PLANEAMIENTO, INVERSIÓN PÚBLICA Y ABASTECIMIENTO E IMPULSAREMOS LA DIGITALIZACIÓN DE PROCESOS Y TRÁMITES EN LA ADMINISTRACIÓN PÚBLICA.')


--------------- HOJA DE VIDA DEL CANDIDATO ---------------------------
-- HOJAS DE VIDA
insert into tb_hoja_vida_persona(cod_per, hoja_vida_pdf) values
/*presidentes*/
(3, '~/Pdf/Hojas Vida/10001088.pdf'),
(8, '~/Pdf/Hojas Vida/01211014.pdf'),
(13,'~/Pdf/Hojas Vida/17903382.pdf'),
(18,'~/Pdf/Hojas Vida/09155583.pdf'),
(23,'~/Pdf/Hojas Vida/19669215.pdf'),
(28,'~/Pdf/Hojas Vida/26605193.pdf'),
(29,'~/Pdf/Hojas Vida/40765768.pdf'),
(30,'~/Pdf/Hojas Vida/18010708.pdf'),
(31,'~/Pdf/Hojas Vida/09337130.pdf'),
(32,'~/Pdf/Hojas Vida/44123390.pdf'),
(33,'~/Pdf/Hojas Vida/06630665.pdf'),
(34,'~/Pdf/Hojas Vida/27427864.pdf'),
(35,'~/Pdf/Hojas Vida/08274605.pdf'),
(36,'~/Pdf/Hojas Vida/43863835.pdf'),
(37,'~/Pdf/Hojas Vida/19813153.pdf'),
(38,'~/Pdf/Hojas Vida/07845838.pdf'),
(39,'~/Pdf/Hojas Vida/08330968.pdf'),
(40,'~/Pdf/Hojas Vida/41265978.pdf'),
/*el resto del equipo*/
(4,  '~/Pdf/Hojas Vida/09537000.pdf'),
(5,  '~/Pdf/Hojas Vida/07831436.pdf'),
(6,  '~/Pdf/Hojas Vida/08232920.pdf'),
(7,  '~/Pdf/Hojas Vida/09991098.pdf'),

(9,  '~/Pdf/Hojas Vida/40804904.pdf'),
(10, '~/Pdf/Hojas Vida/08104229.pdf'),
(11, '~/Pdf/Hojas Vida/06310702.pdf'),
(12, '~/Pdf/Hojas Vida/44242860.pdf'),

(14, '~/Pdf/Hojas Vida/10308752.pdf'),
(15, '~/Pdf/Hojas Vida/08194883.pdf'),
(16, '~/Pdf/Hojas Vida/07827893.pdf'),
(17, '~/Pdf/Hojas Vida/18114960.pdf'),

(19, '~/Pdf/Hojas Vida/00478062.pdf'),
(20, '~/Pdf/Hojas Vida/07667076.pdf'),
(21, '~/Pdf/Hojas Vida/43781857.pdf'),
(22, '~/Pdf/Hojas Vida/10314044.pdf'),

(24, '~/Pdf/Hojas Vida/24965523.pdf'),
(25, '~/Pdf/Hojas Vida/09302945.pdf'),
(26, '~/Pdf/Hojas Vida/07787126.pdf'),
(27, '~/Pdf/Hojas Vida/47919213.pdf')
go

update tb_hoja_vida_persona set fecha_act = GETDATE()
go

-- EDUCACION BASICA HOJAS VIDA
insert into tb_edu_basica_hoja_vida (cod_hoja, primaria, secundaria)
values (1, 'SI', 'SI'), (2, 'SI', 'SI'), (3, 'SI', 'SI'), (4, 'SI', 'SI'), (5, 'SI', 'SI'),
(6, 'SI', 'SI'), (7, 'SI', 'SI'), (8, 'SI', 'SI'), (9, 'SI', 'SI'), (10, 'SI', 'SI'),
(11, 'SI', 'SI'), (12, 'SI', 'SI'), (13, 'SI', 'SI'),
(14, 'SI', 'SI'), (15, 'SI', 'SI'), (16, 'SI', 'SI'), (17, 'SI', 'SI'), (18, 'SI', 'SI')
go


-- ESTUDIOS TECNICOS HOJAS VIDA
insert into tb_est_tecnico_hoja_vida (cod_hoja, nro_item, cen_est_tec, car_tec, con_tec)
values (17, 1, 'COLEGIO DE ABOGADOS DE LIMA', 'CONCILIADOR EXTRAJUDICIAL', 'SI')
go
-- ESTUDIOS NO UNIVERSITARIOS HOJA VIDA
insert into tb_est_nouniversitario_hoja_vida(cod_hoja, nro_item, cen_est_nouni, car_nouni, con_nouni)
values (12, 1, 'IESPP OCTAVIO MATA CONTRERAS DE CUTERVO', 'PROFESOR DE EDUCACIÓN PRIMARIA', 'SI')
go

-- ESTUDIOS UNIVERSITARIOS HOJA VIDA
insert into tb_est_universitario_hoja_vida(cod_hoja, nro_item, cen_est_uni, car_uni, con_uni)
values (1, 1, 'BOSTON UNIVERSITY', 'ADMINISTRACION DE EMPRESAS', 'SI'),

(2, 1, 'UNIVERSIDAD CATÓLICA DE SANTA MARÍA', 'ABOGADO', 'SI'),
(2, 2, 'UNIVERSIDAD CATÓLICA DE SANTA MARÍA', 'BACHILLER EN DERECHO', 'SI'),

(3, 1, 'UNIVERSIDAD NACIONAL DE TRUJILLO', 'INGENIERO QUIMICO', 'SI'),
(3, 2, 'UNIVERSIDAD NACIONAL DE TRUJILLO', 'BACHILLER EN INGENIERIA QUIMICA', 'SI'),

(4, 1, 'UNIVERSITE DE GENEVE', 'DEMI LICENCE EN SCIENCES ECONOMIQUES', 'SI'),

(5, 1, 'UNIVERSIDAD INCA GARCILASO DE LA VEGA ASOCIACIÓN CIVIL', 'ABOGADO', 'SI'),
(5, 2, 'UNIVERSIDAD INCA GARCILASO DE LA VEGA ASOCIACIÓN CIVIL', 'BACHILLER EN DERECHO', 'SI'),

(6, 1, 'UNIVERSIDAD NACIONAL DE CAJAMARCA', 'BACHILLER EN SOCIOLOGIA', 'SI'),
(6, 2, 'MARCELINO CHAMPAGNAT', 'PEDAGOGIA', 'SI'),
(6, 3, 'UNIVERSIDAD PONTIFICA GREOGORIANA DE ROMA', 'LICENCIATURA', 'SI'),

(7, 1, 'DENIS DIDEROT - PARIS VII', 'LICENCIATURA DE PSICOLOGIA', 'SI'),

(8, 1, 'UNIVERSIDAD PRIVADA CÉSAR VALLEJO', 'ARQUITECTO', 'SI'),
(8, 2, 'UNIVERSIDAD PRIVADA CÉSAR VALLEJO', 'BACHILLER DE ARQUITECTURA', 'SI'),

(9, 1, 'UNIVERSIDAD CATÓLICA DEL PERÚ', 'BACHILLER EN ECONOMIA', 'SI'),
(9, 2, 'GEORGETOWN UNIVERSITY (EEUU)', 'MASTER EN POLITICA PUBLICAS', 'SI'),

(10, 1, 'ESCUELA MILITAR DE CHORRILLOS', 'OFICIAL DEL EJERCITO', 'SI'),

(11, 1, 'PONTIFICIA UNIVERSIDAD CATÓLICA DEL PERÚ', 'ABOGADO', 'SI'),

(12, 1, 'UNIVERSIDAD PRIVADA CÉSAR VALLEJO', 'BACHILLER EN EDUCACION', 'SI'), 

(13, 1, 'UNIVERSIDAD INCA GARCILAZO DE LA VEGA', 'CIENCIAS ADMINISTRATIVAS', 'NO'),

(14, 1, 'ESCUELA MILITAR DE CHORRILLOS', 'BACHILLER EN CIENCIAS MILITARES', 'SI'),

(15, 1, 'UNIVERSIDAD NACIONAL MAYOR DE SAN MARCOS', 'ABOGADO', 'SI'),

(16, 1, 'UNIVERSIDAD DE PIURA', 'INGENIERO INDUSTRIAL', 'SI'),

(18, 1, 'UNIVERSIDAD PERUANA DE CIENCIAS APLICADAS', 'ADMINISTRACION Y NEGOCIOS', 'NO')
go

-- ESTUDIOS POSTGRADO HOJA VIDA
insert into tb_est_postgrado_hoja_vida(cod_hoja, nro_item, cen_est_pos, esp_pos, con_pos, gra_pos)
values (1, 1, 'COLUMBIA UNIVERSITY', 'MAESTRÍA EN ADMINISTRACIÓN DE EMPRESAS', 'SI', 'MAESTRO'),

(2, 1, 'UNIVERSIDAD DE CHILE', 'GRADO MAESTRIA', 'SI', 'MAESTRO'),

(3, 1, 'UNIVERSIDAD COMPLUTENSE DE MADRID', 'TÍTULO DE DOCTOR POR LA UNIVERSIDAD COMPLUTENSE DE MADRID', 'SI', 'DOCTOR'),

(4, 1, 'INSTITUT UNIVERSITAIRE DES HAUTES ETUDES INTERNATIONALES', 'LINCENCE ECONOMIE ET DROIT INTERNATIONAL', 'SI', null),

(5, 1, 'UNIVERSIDAD NACIONAL JOSE FAUSTINO SANCHEZ CARRION', 'DERECHO CONSTITUCIONAL ADMINISTRATIVO', null, null),

(6, 1, 'PONTIFICA UNIVERSIDAD CATOLICA DEL PERU', 'MAESTRIA EN SOCIOLOGIA', 'SI', 'MAESTRO'),

(7, 1, 'SORBONA NUEVA - PARIS III', 'MASTER INVESTIGACION SOCIEDADES CONTEMPORANEAS', 'SI', 'MAESTRO'),

(9, 1, 'UNIVERSITY OF MARYLAND (EEUU)', 'PHD, POLÍTICAS PÚBLICAS', 'SI', 'DOCTOR'),

(10, 1, 'PONTIFICIA UNIVERSIDAD CATOLICA DEL PERU', null, 'SI', null),

(11, 1, 'PONTIFICIA UNIVERSIDAD CATÓLICA DEL PERÚ', 'MAGISTER EN DERECHO PENAL', 'SI', 'MAESTRO'),

(12, 1, 'UNIVERSIDAD PRIVADA CÉSAR VALLEJO', 'MAGISTER EN PSICOLOGIA EDUCATIVA', 'SI', 'MAESTRO'),

(14, 1, 'UNIVERSIDAD NACIONAL FEDERICO VILLAREAL', 'MAESTRIA', 'SI', null),

(15, 1, 'UNIVERSIDAD NACIONAL DEL CENTRO DEL PERÚ', 'MAGISTER EN ANTROPOLOGIA JURIDICA', 'SI', 'MAESTRO'),

(16, 1, 'UNIVERSIDAD DEL PACIFICO', 'MAGISTER EN ADMINISTRACION', 'SI', 'MAESTRO')

go

-- EXPERIENCIA LABORAL HOJA VIDA
insert into tb_trabajos_hoja_vida (cod_hoja, nro_tra, cen_tra , ocu_tra, per_tra)
values (1, 1, 'PARTIDO POLÍTICO FUERZA POPULAR', 'PRESIDENTA', '2013-HASTA LA ACTUALIDAD'),
(1, 2, 'OPORTUNIDADES INSTITUTO PARA EL DESARROLLO', 'PRESIDENTA', '2011-2013'),
(1, 3, 'CONGRESO DE LA REPUBLICA', 'CONGRESISTA REPUBLICA', '2006-2011'),

(2, 1, 'CONGRESO DE LA REPUBLICA', 'ASESOR PRINCIPAL', '2020-2020'),
(2, 2, 'UNIVERSIDAD NACIONAL DEL ALTIPLANO', 'PROFESOR PRINCIPAL', '2019-HASTA LA ACTUALIDAD'),

(3, 1, 'UNIVERSIDAD CESAR VALLEJO', 'ASESOR', '2019-HASTA LA ACTUALIDAD'),
(3, 2, 'UNIVERSIDAD CESAR VALLEJO', 'PRESIDENTE DEL DIRECTORIO', '1999-2019'),
(3, 3, 'UNIVERSIDAD CESAR VALLEJO', 'GERENTE GENERAL', '2005-2007'),
(3, 4, 'UNIVERSIDAD CESAR VALLEJO', 'GERENTE GENERAL', '1999-1999'),

(4,	1, 'INSTITUTO LIBERTAD Y DEMOCRACIA', 'PRESIDENTE', '1980-HASTA LA ACTUALIDAD'),

(5, 1, 'EDITORA E INMOBILIARIA DT EIRL', 'GERENTE GENERAL', '2009-HASTA LA ACTUALIDAD'),
(5, 2, 'SMRL MANUEL ANTONIO I', 'GERENTE GENERAL', '1996-2010'),

(6, 1, 'CONGRESO DE LA REPUBLICA', 'CONGRESISTA', '2016-2020'),

(7, 1, 'PACHAMAMA ALLIANCE PERU', 'CONSULTORA INDEPENDIENTE', '2020-2020'),
(7, 2, 'DEREHOS HUMANOS SIN FRONTERAS - OHSF', 'EVALUACION INSTITUCIONAL', '2020-2020'),
(7, 3, 'ASOCIACION NUESTRO SUR', 'DOCENTE SEMINARIO', '2019-2019'),
(7, 4, 'CENTRO PERUANO DE ESTUDIOS SOCIALES', 'INVESTIGACION PUEBLOS INDIGENAS', '2017-2017'),
(7, 5, 'ASOCIACION MOVIMIENTO NUEVO PERU', 'ADMINISTRADORA', '2019-2020'),

(8, 1, 'GRUPO YANASARA S.A.C.', 'APODERADO', '2020-HASTA LA ACTUALIDAD'),
(8, 2, 'CONGRESO DE LA REPUBLICA', 'CONGRESISTA', '2016-2019'),
(8 ,3, 'COINSA SRL', 'GERENTE (REPRESENTANTE LEGAL)', '1998-2020'),
(8, 4, 'DSV CONSTRUCTORES SAC', 'GERENTE (REPRESENTANTE LEGAL)', '2004-2011'),

(9, 1, 'INSTITUTO DE FORMACION Y DESARROLLO DEL TALENTO PERUANO', 'PRESIDENTE DEL CONSEJO DIRECTIVO', '2018-HASTA LA ACTUALIDAD'),
(9, 2, 'UNIVERSIDAD RUIZ DE MONTOYA', 'DOCENTE', '2019-2020'),
(9, 3, 'PONTIFICIA UNIVERSIDAD CATOLICA DEL PERU', 'DOCENTE', '2018-2019'),
(9, 4, 'YALE UNIVERSITY', 'MAURICE R. GREENBERG WORLD FELLOWS PROGRAM- THE 2018 WORLD FELLOWS', '2018-2018'),
(9, 5, 'DN CONSULTORES SOCIEDAD ANONIMA CERRADA','ESTUDIO: "ANALISIS COMPARATIVO DE POLITICAS DE GOBIERNO DIGITAL EN AMERICA LATINA"', '2017-2017'),

(10, 1, 'PARTIDO NACIONALISTA PERUANO', 'PRESIDENTE', '2016-HASTA LA ACTUALIDAD'),
(10, 2, 'DESPACHO PRESIDENCIAL DE LA REPUBLICA', 'PRESIDENTE DE LA REPUBLICA', '2011-2016'),

(11, 1, 'VERDE VISION PRODUCCIONES S.A.', 'PERIODISTA', '2017-HASTA LA ACTUALIDAD'),
(11, 2, 'PONTIFICIA UNIVERSIDAD CATOLICA DEL PERU', 'CATEDRATICO', '2008-2019'),
(11, 3, 'UNIVERSIDAD SAN MARTIN DE PORRES', 'CATEDRATICO', '2007-HASTA LA ACTUALIDAD'),
(11, 4, 'GOBIERNO REGIONAL CALLAO (VER IX. INFORMACION ADICIONAL)', 'LOCACION DE SERVICIOS', '2019-2020'),
(11, 5, 'CONGRESO DE LA REPUBLICA', 'CONGRESISTA DE LA REPUBLICA', '2011-2016'),

(12, 1, 'I.E. 104565, PUÑA, TACABAMBA, CHOTA', 'DOCENTE', '1995-HASTA LA ACTUALIDAD'),

(13, 1, 'INVERSIONES LORD & GOLDMAN SAC', 'GERENTE GENERAL', '2015-2020'),

(14, 1, 'CONGRESO DE LA REPUBLICA', 'CONGRESISTA DE LA REPUBLICA DEL PERÚ', '2020-HASTA LA ACTUALIDAD'),
(14, 2, 'MUNICIPALIDAD DE LOS OLIVOS', 'GERENTE DE SEGURIDAD CIUDADANA', '2019-2019'),
(14, 3, 'PCM', 'GESTIÓN DE RIESGO DE DESASTRES', '2013-2013'),
(14, 4, 'PCM', 'ALTO COMISIONADO EN LA MINERIA ILEGAL', '2013-2013'),
(14, 5, 'PCM', 'MINISTRO DEL INTERIOR', '2014-2015'),

(15, 1, 'NOTARIA DE HUANCAYO "CIRO GALVEZ"', 'NOTARIO', '1985-2020'),

(16, 1, 'UNIVERSIDAD NACIONAL DE INGENIERIA UNI', 'CATEDRATICO', '2017-2020'),
(16, 2, 'PERURAIL S.A.', 'PRESIDENTE DEL DIRECTORIO', '1999-HASTA LA ACTUALIDAD'),
(16, 3, 'PERU BELMOND HOTELS S.A.', 'DIRECTOR', '1999-HASTA LA ACTUALIDAD'),
(16, 4, 'FERROCARRIL TRASANDINO SA', 'DIRECTOR', '2000-HASTA LA ACTUALIDAD'),
(16, 5, 'CITIBANK NA LIMA', 'GERENTE DE BANCA CORPORATIVA Y DE DESARROLO', '1985-1989'),

(17, 1, 'CONGRESO DE LA REPÚBLICA', 'CONGRESISTA', '2020-HASTA LA ACTUALIDAD'),

(18, 1, 'MUNICIPALIDAD DE LA VICTORIA', 'ALCALDE DISTRITAL', '2019-2020'),
(18, 2, 'CLUB ALIANZA LIMA', 'REPRESENTANTE DE CREDITO LABORAL', '2012-2020'),
(18, 3, 'LOS M S.A.C.', 'GERENTE GENERAL', '2017-HASTA LA ACTUALIDAD'),
(18, 4, 'MUNICIPALIDAD DISTRITAL DE LA VICTORIA', 'REGIDOR DISTRITAL', '2011-2014')

go

-- PENALIDADES HOJA VIDA
insert into tb_ambito_penal_hoja_vida(cod_hoja, nro_amb_pen, del_amb_pen, fal_amb_pen, cod_mod_amb_pen, cum_amb_pen)
values (14, 1, 'DIFAMACIÓN AGRAVADA', '1 AÑO DE PENA PRIVATIVA DE LIBERTAD Y EL PAGO A UNA REPARACIÓN CIVIL', 3, 'PENA CUMPLIDA')
go

-- OTRAS PENALIDADES HOJA VIDA
insert into tb_otras_sentencias_hoja_vida(cod_hoja, nro_otro_sen, del_otro_sen, fal_otro_sen)
values (8, 1, 'FAMILIA / ALIMENTARIA', 'DISUELTO EL VINCULO MATRIMONIAL'),

(15, 1, 'LABORAL', 'SENTENCIA LABORAL PAGO INDEMNIZACION POR SUPUESTO DESPIDO ARBITRARIO - FECHA: 21/12/2009'),
(15, 2, 'LABORAL', 'PAGO INDEMNIZACION POR DESPIDO')
go


---------CARGOS Y TIPO VOTO--------
insert into tb_cargo (desc_cargo) values ('presidente'),
('primer vicepresidente'),('segundo vicepresidente'),
('congresista'), ('representante ante el parlamento'),
-- ESTOS 3 ULTIMOS SON PARA EL VOTO
('presidencial'),('congresal'),('parlamento andino')
go

-------------CANDIDATOS--------------
-- select*from tb_persona
-- select*from tb_partidopolitico
insert into tb_candidato (id_per, cod_par, nro_can, id_cargo, id_dep_lug)
values
	  /*FUERZA POPULAR*/
	  (3, 1, 0, 1, null), /*keiko - pres*/
	  (4, 1, 0, 2, null), /*luis fernando - 1ervice*/
	  (5, 1, 0, 3, null), /*carmen patricia - 2dovice*/
	  (5, 1, 2, 4, '15'), /*carmen patricia - congresista*/
	  (6, 1, 3, 4, '15'), /*carlos ernesto - congresista*/
	  (4, 1, 1, 5, null), /*luis fernando - parlamentario*/
	  (7, 1, 8, 5, null), /*patricia monica - parlamentario*/

	  /*ACCION POPULAR*/
	  (8, 2, 0, 1, null),  /*yonhy lescano - pres*/
	  (9, 2, 0, 2, null), /*gisela tipe - 1ervice*/
	  (10,2, 0, 3, null), /*luis alberto - 2dovice*/
	  (10,2, 25, 4, '15'), /*luis alberto - congresista*/
	  (9, 2, 1, 4, '05'), /*gisela tipe - congresista*/
	  (11,2, 9, 4, '15'), /*oswaldo martin - congresista*/
	  (12,2, 1, 5, null), /*leslye carol - parlamentario*/

	  /*ALIANZA PARA EL PROGRESO*/
	  (13,3, 0, 1, null), /*cesar acuña - pres*/
	  (14,3, 0, 2, null), /*maria del carmen - 1er vice*/
	  (15,3, 0, 3, null), /*luis carlos antonio - 2dovice*/
	  (16,3, 4, 4, '15'), /*daniel fernando bugatas - congresista*/
	  (17,3, 6, 5, null), /*tania rosalia - parlamentario*/

	  /*AVANZA PAIS*/
	  (18,4, 0, 1, null), /*hernando de soto - pres*/
	  (19,4, 0, 2, null), /*corinne isabelle - 1ervice*/
	  (20,4, 0, 3, null), /*jaime oswaldo - 2dovice*/
	  (19,4, 1, 4, '23'), /*corinne isabelle - congresista*/
	  (20,4, 8, 4, '15'), /*jaime oswaldo - congresista*/
	  (21,4, 9, 4, '15'), /*alessandra camila - congresista*/
	  (22,4, 1, 5, null), /*juancarlos ramirez - parlamento*/

	  /*DEMOCRACIA DIRECTA*/
	  (23,5, 0, 1, null), /*andres avelino - pres*/
	  (24,5, 0, 2, null), /*elena emperatriz - 1ervice*/
	  (25,5, 0, 3, null), /*javier felipe - 2dovice*/
	  (24,5, 1, 4, '08'), /*elena emperatriz - congresista*/
	  (25,5, 1, 4, '15'), /*javier felipe - congresista*/
	  (26,5, 2, 4, '15'), /*maria evelina - congresista*/
	  (27,5, 1, 5, null),  /*vladimir mateo - parlamento*/

	  /*FRENTE AMPLIO*/
	  (28,6,0, 1, null), /*marco antonio avelino - pres*/

	  /*JUNTOS POR EL PERU*/
	  (29,8,0, 1, null), /*veronica mendoza - pres*/

	  /*PARTIDO DEMOCRATICO SOMOS PERU*/
	  (30,9,0, 1, null), /*daniel enrique salaverry - pres*/

	  /*PARTIDO MORADO*/
	  (31,10,0, 1, null), /*julio guzman - pres*/
	  
	  /*PARTIDO NACIONALISTA PERUANO*/
	  (32,11,0, 1, null), /*ollanta moises - pres*/

	  /*PARTIDO POPULAR CRISTIANO*/
	  (33,13,0, 1, null), /*alberto beingolea - pres*/

	  /*PERU LIBRE*/
	  (34,14,0, 1, null), /*jose pedro castillo - pres*/

	  /*PERU PATRIA SEGURA*/
	  (35,15,0, 1, null), /*rafael gaston tadeo - pres*/

	  /*PODEMOS PERU*/
	  (36,16,0, 1, null), /*daniel urresti -pres*/

	  /*RENACIMIENTO UNIDO PERU*/
	  (37,17,0, 1, null), /*ciro alfredo - pres*/

	  /*RENOVACION POPULAR*/
	  (38,18,0, 1, null), /*rafael bernardo lopez - pres*/

	  /*UNION POR EL PERU*/
	  (39,19,0, 1, null), /*jose alejandro vega - pres*/

	  /*VICTORIA NACIONAL*/
	  (40,20,0, 1, null) /*forsyth - pres*/
go


------------ELECCION / VOTO-------------
insert into tb_eleccion (nro_eleccion,cod_per, fecha_voto) 
values (1, 1, '2021-04-11 12:03:45'),  /*VOTO DE PABLO*/
	   (2, 2, '2021-04-11 17:20:26')   /*VOTO DE MARIA*/
go


/*DETALLE VOTO PABLO*/
insert into tb_partpolitico_elecciones(nro_eleccion, id_cargo, id_part, nropart1, nropart2)
values (1, 6, 1, 0, 0),  /*FICHA PRESIDENCIAL*/
	   (1, 7, 1, 2, 3), /*FICHA CONGRESAL*/
	   (1, 8, 1, 1, 2)  /*FICHA PARLAMENTO ANDINO*/
update tb_persona set voto=1 where id_per=1
go

/*DETALLE VOTO MARIA ...*/
insert into tb_partpolitico_elecciones(nro_eleccion, id_cargo, id_part, nropart1, nropart2)
values (2, 6, 1, 0, 0),  /*FICHA PRESIDENCIAL*/
	   (2, 7, 1, 6, 2), /*FICHA CONGRESAL*/
	   (2, 8, 1, 5, 10)  /*FICHA PARLAMENTO ANDINO*/
update tb_persona set voto=1 where id_per=2
go


-- select*from tb_pais
-- select*from tb_departamento
-- select*from tb_provincia
-- select*from tb_distrito
-- select*from tb_estado_civil
-- select*from tb_persona

-- select*from tb_cargo
-- select*from tb_partidopolitico
-- select*from tb_candidato

-- select*from tb_eleccion
-- select*from tb_partpolitico_elecciones