
use master

use Elecciones_2021
go

---------------------PROCEDIMIENTOS ALMACENADOS     Y     FUNCIONES---------------------

-- PROCEDIMIENTO: INGRESO VOTACION
create or alter procedure sp_ingreso_votacion_persona
	@dni  char(8),
	@fecnac date,
	@fecemi date
	as
	begin
		select p.id_per, p.dni_per, p.nom_per, p.apepat_per,
		p.apemat_per, p.fechanac_per, p.cod_dep_nac, p.foto_per, p.sexo_per, p.voto
		from tb_persona p
		where p.dni_per= @dni and p.fechanac_per= @fecnac and p.fechaemi_per= @fecemi
	end
go

exec sp_ingreso_votacion_persona '76023941','2001-02-17', '2018-04-27'
go

------------------PAGINA PRINCIPAL----------------------

-- PROCEDIMIENTO: CARGA LOS PARTIDOS
create or alter procedure sp_carga_partidos
	as
	begin
	   select pp.cod_Partido, isnull(pp.imagen_partido, '') imagen_partido, isnull(pp.nombre_partido, '') nombre_partido,
	   isnull(pp.pdf_partido,'') pdf_partido, isnull(pp.pag_partido, '') pag_partido
	   from tb_partidopolitico pp
	   order by pp.nombre_Partido asc
	end
go

exec sp_carga_partidos
go

update tb_persona set voto = 0 where id_per = 1

select * from tb_persona where id_per = 1
go


-- PROCEDIMIENTO: PARTIDO POR ID
create or alter procedure sp_carga_partidos_id
	@partido int
	as
	begin
	   select pp.cod_Partido, isnull(pp.imagen_partido, '') imagen_partido, isnull(pp.nombre_partido, '') nombre_partido,
	   isnull(pp.pdf_partido,'') pdf_partido, isnull(pp.pag_partido, '') pag_partido
	   from tb_partidopolitico pp
	   where pp.cod_Partido=@partido
	   order by pp.nombre_Partido asc
	end
go



exec sp_carga_partidos_id 12
go

/*
-- PROCEDIMIENTO: CANDIDATOS A LA PRESIDENCIA GENERAL (PRES, 1ERVICE, 2DOVICE)
create or alter procedure sp_candidatos_presidencia 
	as
	begin
		select pp.nombre_Partido, p.id_per, p.nom_per, p.apepat_per, p.apemat_per, car.desc_cargo from tb_candidato c 
		inner join tb_partidopolitico pp on c.cod_par = pp.cod_Partido
		inner join tb_persona p on c.id_per= p.id_per
		inner join tb_cargo car on c.id_cargo = car.id_Cargo
		where c.id_cargo in (1,2,3)
	end
go

exec sp_candidatos_presidencia
go*/

-- PROCEDIMIENTO: CANDIDATOS A LA PRESIDENCIA POR PARTIDO
create or alter procedure sp_candidatos_presidenciaxpartido
	@partido int
	as
	begin
		select pp.nombre_Partido, p.id_per, p.nom_per, p.apepat_per, p.apemat_per,p.foto_per, car.desc_cargo, p.dni_per
		from tb_candidato c 
		inner join tb_partidopolitico pp on c.cod_par = pp.cod_Partido
		inner join tb_persona p on c.id_per= p.id_per
		inner join tb_cargo car on c.id_cargo = car.id_Cargo
		where c.id_cargo in (1,2,3) and pp.cod_Partido = @partido
	end
go

exec sp_candidatos_presidenciaxpartido 1
go

-- PROCEDIMIENTO: LISTA DE DEPARTAMENTOS
create or alter procedure sp_departamentos
	as
	begin
	select d.id_dep, d.nom_dep from tb_departamento d
	end
go

exec sp_departamentos
go

-- PROCEDIMIENTO: CANDIDATOS AL CONGRESO POR PARTIDO
create or alter procedure sp_candidatos_congresoxpartido 
	@partido int,
	@lugar   varchar(2)
	as
	begin
		select pp.nombre_Partido, p.id_per,p.nom_per, p.apepat_per, p.apemat_per,p.foto_per, car.desc_cargo, c.nro_can, p.dni_per
		from tb_candidato c 
		inner join tb_partidopolitico pp on c.cod_par = pp.cod_Partido
		inner join tb_persona p on c.id_per= p.id_per
		inner join tb_cargo car on c.id_cargo = car.id_Cargo
		where c.id_cargo in (4) and pp.cod_Partido = @partido and c.id_dep_lug= @lugar
		order by nro_can asc
	end
go

exec sp_candidatos_congresoxpartido 1, '15'
go

-- PROCEDIMIENTO: CANDIDATOS PARLAMENTARIOS POR PARTIDO
create or alter procedure sp_candidatos_parlamentoxpartido 
	@partido int
	as
	begin
		select pp.nombre_Partido, p.id_per, p.nom_per, p.apepat_per, p.apemat_per, p.foto_per, car.desc_cargo, c.nro_can, p.dni_per
		from tb_candidato c 
		inner join tb_partidopolitico pp on c.cod_par = pp.cod_Partido
		inner join tb_persona p on c.id_per= p.id_per
		inner join tb_cargo car on c.id_cargo = car.id_Cargo
		where c.id_cargo in (5) and pp.cod_Partido = @partido
		order by nro_can asc
	end
go

exec sp_candidatos_parlamentoxpartido 1
go


-- PROCEDIMIENTO: CARGA PLAN DE GOBIERNO
create or alter procedure sp_carga_plan_gobierno_id
	@codpart int
	as
	begin
		select p.cod_par, isnull(p.nro_pro, 0) nro_pro, isnull(p.soc_pro, '') soc_pro, isnull(p.eco_pro, '') eco_pro,
		isnull(p.nat_pro, '') nat_pro, isnull(p.ins_pro, '') ins_pro
		from tb_plan_gobierno p where p.cod_par=@codpart
	end
go

exec sp_carga_plan_gobierno_id 1
go

-- PROCEDIMIENTO: INFORMACION CANDIDATO
create or alter procedure sp_informacion_candidato
	@idper int
	as
	begin
		declare @lugarcan varchar(255), @descargo varchar(255), @contador int
		-- HACEMOS EL CONTEO: DE SER SUPERIOR A UNO DEBEREMOS DE USAR LAS VARIABLES
		select @contador=count(*)  from tb_candidato where id_per=@idper
		if(@contador>1)
			begin
				-- OBTENER EL CARGO MAS FUERTE
				select top 1 @descargo = car.desc_cargo  
				from tb_candidato c inner join tb_cargo car on c.id_cargo= car.id_Cargo
				where id_per = @idper
				order by c.id_cargo asc

				-- OBTENER EL LUGAR DONDE SERA CONGRESISTA
				select top 1 @lugarcan = dep.nom_dep
				from tb_candidato c inner join tb_departamento dep
				on c.id_cargo= dep.id_dep
				where c.id_per = @idper
				order by c.id_cargo desc

				-- HACER EL QUERY Y REEMPLAZAR LOS VALORES POR LAS VARIABLES
				select top 1 pp.imagen_partido, p.nom_per, p.apepat_per, p.apemat_per,
				@descargo desc_cargo, p.dni_per,
				@lugarcan 'lugar_can',
				(case p.sexo_per when 'M' then 'masculino'
								 when 'F' then 'femenino'
				end) 'sexo_per',
				isnull(pai.nom_pai, '') nom_pai_nac,
				(case when p.cod_dep_nac is null then '' else dep.nom_dep end) as nom_dep_nac,
				(case when p.cod_pro_nac is null then '' else pro.nom_pro end) as nom_pro_nac,
				(case when p.cod_dist_nac is null then '' else dis.nom_dis end) as nom_dis_nac,

				(case when p.cod_dep_res is null then '' else depres.nom_dep end) as nom_dep_res,
				(case when p.cod_pro_res is null then '' else prores.nom_pro end) as nom_pro_res,
				(case when p.cod_dis_res is null then '' else disres.nom_dis end) as nom_dis_res,
				isnull(p.dir_res, '') dir_res,
				isnull(p.foto_per, '') foto_per,
				isnull(hv.hoja_vida_pdf, '') hoja_vida_pdf,
				p.fechanac_per,
				pp.nombre_Partido
				from tb_persona p
				inner join tb_candidato c1 on c1.id_per = p.id_per
				left join tb_departamento depcan on depcan.id_dep = c1.id_dep_lug
				inner join tb_cargo car on c1.id_cargo= car.id_Cargo
				inner join tb_partidopolitico pp on c1.cod_par= pp.cod_Partido
				left join tb_distrito dis on dis.id_dis = p.cod_dist_nac
				left join tb_provincia pro on pro.id_pro= p.cod_pro_nac
				left join tb_departamento dep on dep.id_dep = p.cod_dep_res
				left join tb_pais pai on p.cod_pai_res = pai.cod_pai
				left join tb_departamento depres on p.cod_dep_res=depres.id_dep
				left join tb_provincia prores on p.cod_pro_res = prores.id_pro
				left join tb_distrito disres on p.cod_dis_res = disres.id_dis
				left join tb_hoja_vida_persona hv on hv.cod_per= p.id_per 
				where c1.id_per= @idper
				order by c1.id_can asc
			end
		else
			begin
				select top 1 pp.imagen_partido, p.nom_per, p.apepat_per, p.apemat_per,
				car.desc_cargo,p.dni_per,
				(case when c1.id_dep_lug is null then ''
				else depcan.nom_dep
				end) 'lugar_can',
				(case p.sexo_per when 'M' then 'masculino'
								 when 'F' then 'femenino'
				end) 'sexo_per',
				isnull(pai.nom_pai, '') nom_pai_nac,
				(case when p.cod_dep_nac is null then '' else dep.nom_dep end) as nom_dep_nac,
				(case when p.cod_pro_nac is null then '' else pro.nom_pro end) as nom_pro_nac,
				(case when p.cod_dist_nac is null then '' else dis.nom_dis end) as nom_dis_nac,

				(case when p.cod_dep_res is null then '' else depres.nom_dep end) as nom_dep_res,
				(case when p.cod_pro_res is null then '' else prores.nom_pro end) as nom_pro_res,
				(case when p.cod_dis_res is null then '' else disres.nom_dis end) as nom_dis_res,
				isnull(p.dir_res, '') dir_res,
				isnull(p.foto_per, '') foto_per,
				isnull(hv.hoja_vida_pdf, '') hoja_vida_pdf,
				p.fechanac_per,
				pp.nombre_Partido
				from tb_persona p
				inner join tb_candidato c1 on c1.id_per = p.id_per
				left join tb_departamento depcan on depcan.id_dep = c1.id_dep_lug
				inner join tb_cargo car on c1.id_cargo= car.id_Cargo
				inner join tb_partidopolitico pp on c1.cod_par= pp.cod_Partido
				left join tb_distrito dis on dis.id_dis = p.cod_dist_nac
				left join tb_provincia pro on pro.id_pro= p.cod_pro_nac
				left join tb_departamento dep on dep.id_dep = p.cod_dep_res
				left join tb_pais pai on p.cod_pai_res = pai.cod_pai
				left join tb_departamento depres on p.cod_dep_res=depres.id_dep
				left join tb_provincia prores on p.cod_pro_res = prores.id_pro
				left join tb_distrito disres on p.cod_dis_res = disres.id_dis
				left join tb_hoja_vida_persona hv on hv.cod_per= p.id_per 
				where c1.id_per= @idper
			end
	end		
go

exec sp_informacion_candidato 5
go



---------------------------HOJA VIDA DEL CANDIDATO-------------------------

-- PROCEDIMIENTO: OBTENER HOJA VIDA DEL CANDIDATO
create or alter procedure sp_hojavida_edubasica
  @idper int
  as
  begin
  select isnull(hvp.cod_hoja, ''), isnull(ebhv.primaria, '') primaria, isnull(ebhv.secundaria, '') secundaria
  from  tb_edu_basica_hoja_vida ebhv
  right join tb_hoja_vida_persona hvp on hvp.cod_hoja= ebhv.cod_hoja
  where hvp.cod_per=@idper
  end
go

exec sp_hojavida_edubasica 5
go

-- PROCEDIMIENTO: OBTENER HOJA VIDA ESTUDIOS TECNICOS
create or alter procedure sp_hojavida_tecnicos
   @idper int
   as
   begin
    select hvp.cod_hoja, isnull(ethv.nro_item, 0) nro_item, isnull(ethv.cen_est_tec, '') cen_est_tec,
	isnull(ethv.car_tec, '') car_tec, isnull(ethv.con_tec, '') con_tec from  tb_est_tecnico_hoja_vida ethv
    right join tb_hoja_vida_persona hvp on hvp.cod_hoja= ethv.cod_hoja
	  where hvp.cod_per=@idper
   end
go

exec sp_hojavida_tecnicos 3
go

-- PROCEDIMIENTO: OBTENER HOJA VIDA ESTUDIOS NO UNIVERSITARIOS
create or alter procedure sp_hojavida_nouniversitarios
   @idper int
   as
   begin
    select hvp.cod_hoja, isnull(enhv.nro_item, 0) nro_item, isnull(enhv.cen_est_nouni, '') cen_est_nouni,
	isnull(enhv.car_nouni, '') car_nouni, isnull(enhv.con_nouni, '') con_nouni
	from  tb_est_nouniversitario_hoja_vida enhv
    right join tb_hoja_vida_persona hvp on hvp.cod_hoja= enhv.cod_hoja
	where hvp.cod_per=@idper
   end
go

exec sp_hojavida_nouniversitarios 3
go

-- PROCEDIMIENTO: OBTENER HOJA VIDA ESTUDIOS UNIVERSITARIOS
create or alter procedure sp_hojavida_universitarios
   @idper int
   as
   begin
    select hvp.cod_hoja, isnull(euhv.nro_item, 0) nro_item, isnull(euhv.cen_est_uni, '') cen_est_uni,
	isnull(euhv.car_uni, '') car_uni, isnull(euhv.con_uni, '') con_uni
	from  tb_est_universitario_hoja_vida euhv
    right join tb_hoja_vida_persona hvp on hvp.cod_hoja= euhv.cod_hoja
	where hvp.cod_per=@idper
   end
go

exec sp_hojavida_universitarios 3
go

-- PROCEDIMIENTO: OBTENER HOJA VIDA ESTUDIOS POSTGRADO
create or alter procedure sp_hojavida_postgrado
   @idper int
   as
   begin
    select hvp.cod_hoja, isnull(ephv.nro_item, 0) nro_item, isnull(ephv.cen_est_pos, '') cen_est_pos,
	isnull(ephv.esp_pos, '') esp_pos, isnull(ephv.con_pos, '') con_pos,
	isnull(ephv.gra_pos, '') gra_pos
	from  tb_est_postgrado_hoja_vida ephv
    right join tb_hoja_vida_persona hvp on hvp.cod_hoja= ephv.cod_hoja
	where hvp.cod_per=@idper
   end
go

exec sp_hojavida_postgrado 3
go

-----------------EXPERIENCIA LABORAL --------------------------
-- PROCEDIMIENTO: OBTENER TRABAJOS DEL CANDIDATO
create or alter procedure sp_hojavida_trabajos
   @idper int
   as
   begin
    select hvp.cod_hoja, isnull(t.nro_tra, 0) nro_tra, isnull(t.cen_tra, '') cen_tra,
	isnull(t.ocu_tra, '') ocu_tra, isnull(t.per_tra, '') per_tra
	from  tb_trabajos_hoja_vida t
    right join tb_hoja_vida_persona hvp on hvp.cod_hoja= t.cod_hoja
	where hvp.cod_per=@idper
   end
go

exec sp_hojavida_trabajos 3
go

---------------- RELACION PENAL ------------------------
-- PROCEDIMIENTO: OBTENER PENALIDADES
create or alter procedure sp_hojavida_ambitospenales
   @idper int
   as
   begin
    select hvp.cod_hoja, isnull(a.nro_amb_pen, 0) nro_amb_pen, isnull(a.del_amb_pen, '') del_amb_pen,
	isnull(a.fal_amb_pen, '') fal_amb_pen, isnull(ma.des_mod, '') des_mod, isnull(a.cum_amb_pen, '') cum_amb_pen
	from  tb_ambito_penal_hoja_vida a
    right join tb_hoja_vida_persona hvp on hvp.cod_hoja= a.cod_hoja
	inner join tb_modalidad_ambito_penal ma on ma.nro_mod= a.cod_mod_amb_pen
	where hvp.cod_per=@idper
   end
go

exec sp_hojavida_ambitospenales 3
go

-- PROCEDIMIENTO: OBTENER OTRAS PENALIDADES
create or alter procedure sp_hojavida_otraspenalidades
   @idper int
   as
   begin
    select hvp.cod_hoja, isnull(o.nro_otro_sen,'') nro_otro_sen, isnull(o.del_otro_sen, '') del_otro_sen, isnull(o.fal_otro_sen, '') fal_otro_sen
	from  tb_otras_sentencias_hoja_vida o
    right join tb_hoja_vida_persona hvp on hvp.cod_hoja= o.cod_hoja
	where hvp.cod_per=@idper
   end
go

exec sp_hojavida_otraspenalidades 3
go



------------------------------ COMPARAR --------------------------------
-- PROCEDIMIENTO: CARGA LOS HOJAS DE VIDA PRESIDENTE / PLANES DE GOBIERNO
create or alter procedure sp_carga_planesgobierno_hojasvidapresidente
	as
	begin
	   select pp.cod_Partido, pp.nombre_Partido
	   from tb_partidopolitico pp join tb_candidato c on pp.cod_Partido = c.cod_par
	   where c.id_cargo=1
	   order by pp.nombre_Partido asc
	end
go

exec sp_carga_planesgobierno_hojasvidapresidente
go

create or alter procedure sp_res_informacion_candidato
	@idper int
	as
	begin
		select top 1 pp.imagen_partido, p.nom_per, p.apepat_per, p.apemat_per,
				isnull(p.foto_per, '') foto_per, pp.nombre_Partido
				from tb_persona p
				inner join tb_candidato c1 on c1.id_per = p.id_per
				inner join tb_partidopolitico pp on c1.cod_par= pp.cod_Partido
				where c1.id_per= @idper
			end
go

exec sp_res_informacion_candidato 3
go

-- PROCEDIMIENTO: OBTENER HOJA VIDA PRESIDENTE MEDIANTE EL CODPARTIDO
create or alter procedure sp_obtener_presidente_partido
	@codpartido int
	as
	begin
	   select c.id_per
	   from tb_partidopolitico pp join tb_candidato c on pp.cod_Partido = c.cod_par
	   where c.id_cargo=1 and c.cod_par=@codpartido
	   order by c.cod_par asc
	end
go

exec sp_obtener_presidente_partido 4
go


------------------------------ VOTACION --------------------------------
-- PROCEDIMIENTO: OBTENER CONGRESISTAS DISPONIBLES POR DEPARTAMENTO SEGUN VOTANTE

create or alter procedure sp_candidatos_congresoxpartidoxlugarvotante 
	@lugarvotante varchar(2),
	@partido int
	as
	begin
		select pp.nombre_Partido, p.id_per,p.nom_per, p.apepat_per, p.apemat_per,p.foto_per, car.desc_cargo, c.nro_can
		from tb_candidato c 
		inner join tb_partidopolitico pp on c.cod_par = pp.cod_Partido
		inner join tb_persona p on c.id_per= p.id_per
		inner join tb_cargo car on c.id_cargo = car.id_Cargo
		where c.id_cargo in (4) and pp.cod_Partido = @partido and c.id_dep_lug= @lugarvotante
		order by nro_can asc
	end
go
------------------------------------------------ LIMA - ACCION POPULAR
exec sp_candidatos_congresoxpartidoxlugarvotante '15', 2
go

-- FUNCION: GENERADO PARA ELECCION
create or alter function fn_generaEleccion() returns int
as
	begin
		declare @obtener int
		select @obtener =  (max(e.nro_eleccion)+1) from tb_eleccion e
	return @obtener
	end
go

select dbo.fn_generaEleccion() as nroEleccionGenerado
go

-- PROCEDIMIENTO: CREAR VOTO
create or alter procedure sp_nuevo_eleccion
	@idelec int,
	@idper int
	as
	begin
		insert into tb_eleccion(nro_eleccion, cod_per, fecha_voto) values (@idelec, @idper, sysdatetime())
		update tb_persona  set voto=1 where id_per=@idper
	end
go

exec sp_nuevo_eleccion 3, 3  -- CREANDO VOTO DE KEIKO
go

-- PROCEDIMIENTO PARA FICHA PRESIDENTE
create or alter procedure sp_ficha_presidencial
	as
	begin
		select pp.cod_Partido, pp.imagen_partido, pp.nombre_Partido, p.nom_per, p.apepat_per, p.apemat_per, p.foto_per
		from tb_partidopolitico pp
		inner join tb_candidato c on c.cod_par = pp.cod_Partido
		inner join tb_persona p on p.id_per = c.id_per
		where c.id_cargo in (1)
	end
go

exec sp_ficha_presidencial
go

-- PROCEDIMIENTO REGISTRAR VOTO - FICHA PRESIDENTE
create or alter procedure sp_registra_voto_presidencial
	@eleccion  int,
	@codpar int
	as
	begin
		insert into tb_partpolitico_elecciones(nro_eleccion,id_cargo, id_part, nropart1, nropart2)
		values (@eleccion, 6, @codpar, 0, 0)
		update tb_candidato set cant_voto= cant_voto+1 where cod_par = @codpar and id_cargo = 1
	end
go

exec sp_registra_voto_presidencial 3, 1  --  VOTO KEIKO PRESIDENCIAL
go

-- PROCEDIMIENTO PARA FICHA PARTIDO CONGRESISTA
create or alter procedure sp_ficha_congresal
	@iddep varchar(2)
	as
	begin
		select distinct pp.cod_Partido, pp.imagen_partido, pp.nombre_Partido 
		from tb_partidopolitico pp
		inner join tb_candidato c on c.cod_par = pp.cod_Partido 
		where c.id_cargo in (4) and  c.id_dep_lug= @iddep
	end
go

exec sp_ficha_congresal '15'
go

-- PROCEDIMIENTO: OBTENER CONGRESISTAS POR PARTIDO POR DEPARTAMENTO AL QUE POSTULAN
create or alter procedure sp_nrocongresistas_partido_lugarpostulan
	@iddep varchar(2),
	@codpar int
	as
	begin
		select nro_can from tb_candidato
		where id_dep_lug = @iddep and cod_par = @codpar and id_cargo= 4
	end
go
exec sp_nrocongresistas_partido_lugarpostulan '15', 1
go


-- PROCEDIMIENTO REGISTRAR VOTO - FICHA CONGRESAL
create or alter procedure sp_registra_voto_congresal
	@eleccion  int,
	@iddep varchar(2),
	@codpar int,
	@nro1 int,
	@nro2 int
	as
	begin
		insert into tb_partpolitico_elecciones(nro_eleccion,id_cargo, id_part, nropart1, nropart2)
		values (@eleccion, 7, @codpar, @nro1, @nro2)
		update tb_candidato set cant_voto=cant_voto+1 where cod_par=@codpar and nro_can=@nro1 and id_dep_lug=@iddep and id_cargo=4
		update tb_candidato set cant_voto=cant_voto+1 where cod_par=@codpar and nro_can=@nro2 and id_dep_lug=@iddep and id_cargo=4
	end
go

use Elecciones_2021

exec sp_registra_voto_congresal 3, '15', 1, 2, 3 -- VOTO KEIKO - CONGRESAL
go

-- PROCEDIMIENTO: GENERA FICHA PARLAMENTO ANDINO
create or alter procedure sp_ficha_parlamental
	as
	begin
		select distinct pp.cod_Partido, pp.imagen_partido, pp.nombre_Partido 
		from tb_partidopolitico pp
		inner join tb_candidato c on c.cod_par = pp.cod_Partido 
		where c.id_cargo in (5)
	end
go

exec sp_ficha_parlamental
go

-- PROCEDIMIENTO: OBTENER NRO DE PARLAMENTARIOS POR PARTIDO
create or alter procedure sp_nroparlamentarios_partido
	@codpar int
	as
	begin
		select nro_can from tb_candidato
		where cod_par = @codpar and id_cargo=5
	end
go
exec  sp_nroparlamentarios_partido 1
go

-- PROCEDIMIENTO: REGISTRAR VOTO - FICHA PARLAMENTO ANDINO
create or alter procedure sp_registra_voto_parlamental
	@eleccion  int,
	@codpar int,
	@nro1 int,
	@nro2 int
	as
	begin
		insert into tb_partpolitico_elecciones(nro_eleccion,id_cargo, id_part, nropart1, nropart2)
		values (@eleccion, 8, @codpar, @nro1, @nro2)
		update tb_candidato set cant_voto=cant_voto+1 where cod_par=@codpar and nro_can=@nro1 and id_cargo=5
		update tb_candidato set cant_voto=cant_voto+1 where cod_par=@codpar and nro_can=@nro2 and id_cargo=5
	end
go

exec sp_registra_voto_parlamental 3, 1, 2, 4  -- VOTO KEIKO - CONGRESAL
go


-- FUNCION: DEVUELVE EN PORCENTAJE LOS VOTOS SEGUN TOTAL DE PRESIDENCIALES
create or alter function fn_total_votos_presidenciales() returns decimal
	as
	begin
		declare @total int = 0
		select @total= sum(cant_voto) from tb_candidato where id_cargo=1 
		return @total*1.00
	end
go

select dbo.fn_total_votos_presidenciales() as cantidadTotalVotosPresidencial
go

-- FUNCION: DEVUELVE EN PORCENTAJE LOS VOTOS SEGUN TOTAL DE CONGRESISTAS
create or alter function fn_total_votos_congresales() returns decimal
	as
	begin
		declare @total int = 0
		select @total= sum(cant_voto) from tb_candidato where id_cargo=4
		return @total*1.00
	end
go

select dbo.fn_total_votos_congresales() as cantidadTotalVotosCongresistas
go

-- FUNCION: DEVUELVE EN PORCENTAJE LOS VOTOS SEGUN TOTAL DE PARLAMENTARIOS
create or alter function fn_total_votos_parlamentales() returns decimal
	as
	begin
		declare @total int = 0
		select @total= sum(cant_voto) from tb_candidato where id_cargo=5
		return @total*1.00
	end
go

select dbo.fn_total_votos_parlamentales() as cantidadTotalVotosParlamentaristas
go

-- REPORTE: PARTIDOS PRESIDENCIAL MAYOR A MENOR VOTOS
create or alter procedure sp_resultados_votos_presidenciales
as
	begin
		select pp.imagen_partido, p.nom_per, p.apepat_per, p.apemat_per, c.cant_voto,
		concat(cast(round((c.cant_voto*100.00)/dbo.fn_total_votos_presidenciales(), 3) as float), '%') porcentaje from tb_candidato c
		inner join tb_persona p on c.id_per=p.id_per
		inner join tb_partidopolitico pp on c.cod_par = pp.cod_Partido
		where c.id_cargo=1
		order by c.cant_voto desc
	end
go

exec sp_resultados_votos_presidenciales
go
-- REPORTE: PARTIDOS CONGRESALES MAYOR A MENOR VOTOS
create or alter procedure sp_resultados_votos_congresales
as
	begin
		select pp.imagen_partido, p.nom_per, p.apepat_per, p.apemat_per, c.cant_voto, c.nro_can,
		concat(cast(round((c.cant_voto*100.00)/dbo.fn_total_votos_congresales(), 3) as float), '%') porcentaje from tb_candidato c
		inner join tb_persona p on c.id_per=p.id_per
		inner join tb_partidopolitico pp on c.cod_par = pp.cod_Partido
		where c.id_cargo=4
		order by c.cant_voto desc
	end
go

-- REPORTE: PARTIDOS PARLAMENTARIOS MAYOR A MENOR VOTOS
create or alter procedure sp_resultados_votos_parlamentales
as
	begin
		select pp.imagen_partido, p.nom_per, p.apepat_per, p.apemat_per, c.cant_voto, c.nro_can,
		concat(cast(round((c.cant_voto*100.00)/dbo.fn_total_votos_congresales(), 3) as float), '%') porcentaje from tb_candidato c
		inner join tb_persona p on c.id_per=p.id_per
		inner join tb_partidopolitico pp on c.cod_par = pp.cod_Partido
		where c.id_cargo=5
		order by c.cant_voto desc
	end
go

exec sp_resultados_votos_parlamentales
go

/*
use Elecciones_2021
exec sp_resultados_votos_congresales
select * from tb_partpolitico_elecciones
go

select * from tb_eleccion
update tb_persona set voto=0 where id_per = 1
select * from tb_partpolitico_elecciones
exec sp_Resultados_votos_congresales
exec sp_resultados_votos_parlamentarios
*/

exec sp_resultados_votos_parlamentales