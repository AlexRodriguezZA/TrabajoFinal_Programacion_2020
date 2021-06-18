unit Unit_Procedimientos_pricipal;
{$codepage utf8}

INTERFACE
uses crt,Unit_archivos;

procedure buscar_dar_de_baja(var buscado:longint);
procedure dar_de_baja_persona(var arch:t_archivo_contagiados; pos:longint);
procedure inicializarper(var reg:t_persona);
procedure inicializarProv(var reg:t_provincia);
procedure inicializarEstadistica(var reg:t_estadistica);
procedure buscar_consultado(var n:longint);
procedure menu_de_campos_aModificar(var op:integer);
procedure modificacion_de_campos(op:integer; pos:longint; var arch:t_archivo_contagiados;var arch3:t_archivo_estadistica;var arch2:t_archivo_provincia);
procedure mostrar_consulta_de_usario(var arch:t_archivo_contagiados; var arch2:t_archivo_provincia; var arch3:t_archivo_estadistica; pos:longint);
procedure menu_listado_provicias(var a:integer);
procedure mostrar_usuario_por_provincia(var arch:t_archivo_contagiados; var arch2:t_archivo_provincia;var arch3:t_archivo_estadistica; a:integer);
procedure analis_estadisticas_por_estados_de_pacientes_nacional(var arch3:t_archivo_estadistica; var cont1,cont2,cont3:longint);
procedure MOSTRAR_analis_estadisticas_por_estados_de_pacientes_nacional(var arch3:t_archivo_estadistica; cont1,cont2,cont3:longint);
procedure analis_estadisticas_por_estados_de_pacientes_provincial(var arch3:t_archivo_estadistica; var cont1,cont2,cont3:longint; a:integer);
procedure MOSTRAR_analis_estadisticas_por_estados_de_pacientes_provincial(var arch3:t_archivo_estadistica; cont1,cont2,cont3:longint);
procedure analis_estadisticas_por_forma_contagio_de_pacientes_nacional(var arch3:t_archivo_estadistica; var cont1,cont2,cont3:longint);
procedure MOSTRAR_analis_estadisticas_por_forma_contagio_de_pacientes_nacional(var arch3:t_archivo_estadistica; cont1,cont2,cont3:longint);
procedure analis_estadisticas_por_forma_contagio_de_pacientes_provincial(var arch3:t_archivo_estadistica; var cont1,cont2,cont3:longint; a:integer);
procedure MOSTRAR_analis_estadisticas_por_forma_contagio_de_pacientes_provincial(var arch3:t_archivo_estadistica; cont1,cont2,cont3:longint);
procedure analis_estadisticas_por_rango_etario_de_pacientes_nacional(var arch3:t_archivo_estadistica; var cont1,cont2,cont3:longint);
procedure MOSTRAR_analis_estadisticas_por_rango_etario_de_pacientes_nacional(var arch3:t_archivo_estadistica; cont1,cont2,cont3:longint);
procedure analis_estadisticas_por_rango_etario_de_pacientes_provincial(var arch3:t_archivo_estadistica; cont1,cont2,cont3:longint; a:integer);
procedure MOSTRAR_analis_estadisticas_por_rango_etario_de_pacientes_provincial(var arch3:t_archivo_estadistica; cont1,cont2,cont3:longint);










IMPLEMENTATION
procedure buscar_dar_de_baja(var buscado:longint);
begin
	writeln('~Ingrese el DNI a buscar');
	readln(buscado);
end; 

procedure dar_de_baja_persona(var arch:t_archivo_contagiados; pos:longint);
var reg:t_persona;
	dar_baja:string;
begin
	seek(arch,pos);
	read(arch,reg);
	with reg do
	begin
	writeln('~DESEA DAR DE BAJA A LA PERSONA? si/no');
	readln(dar_baja);
		if (dar_baja='si') then
		begin
			reg.estado:=false;
			writeln('Con éxito Se ha dado de baja al usuario')
		end
		else
			writeln('Operación cancelada');
seek(arch,pos);
write(arch,reg);	
	end;	
end;


procedure buscar_consultado(var n:longint);
begin
n:=0;
	writeln('Ingrese el DNI de la persona que quiere consultar');
	readln(n);
end;



procedure inicializarper(var reg:t_persona);
begin
     with reg do
     begin
     Dni:=0;
     nombre:='';
     calle:='';
     numero_calle:=0;
     piso:=0;
     ciudad:='';
     provincia:=0;
     Telefono:=0;
     email:='';
     nacimiento:='';
     end;
end;

procedure inicializarProv(var reg:t_provincia);
begin
	with reg do
	begin
	Nombre:='';
	cp:='';
	telefono:='';
	end;
end;

procedure inicializarEstadistica(var reg:t_estadistica);
begin
	with reg do
	begin
	dni:=0;
	codigo_provincia:=0;
	estado_2:=0;
	forma_contagio:=0;
	end;
end;


procedure menu_de_campos_aModificar(var op:integer);
begin
op:=0;
	writeln('~¿Que desea modificar?');
	writeln('1- DNI');
	writeln('2- Nombre');
	writeln('3- Nacimiento');
	writeln('4- Ciudad ');
	writeln('5- Provincia');
	writeln('6- Telefono');
	writeln('7- Forma de contagio');
	writeln('8- Estado');
	readln(op);
end;

procedure modificacion_de_campos(op:integer; pos:longint; var arch:t_archivo_contagiados; var arch3:t_archivo_estadistica;var arch2:t_archivo_provincia );
var	reg:t_persona;
	reg2:t_provincia;
	reg3:t_estadistica;
begin
seek(arch,pos);
read(arch,reg);
seek(arch2,pos);
read(arch2,reg2);
seek(arch3,pos);
read(arch3,reg3);

	case op of
	1:begin
		writeln('~Ingrese el nuevo DNI');
		readln(reg.Dni);
		end;
	2:begin
		writeln('~Ingrese el nuevo nombre:');
		readln(reg.nombre);	
		end;
	3:begin
		writeln('~Ingrese la nueva fecha de nacimiento:');
		readln(reg.nacimiento);
		end;
	4:begin
		writeln('~Ingrese nueva ciudad');
		readln(reg.ciudad);
		end;

	5:begin
		writeln('~Ingrese nuevo Telefono');
		readln(reg.Telefono);
		end;
	6:begin
		writeln('Ingrese Nueva forma de contagio');
		writeln('1- Contagio directo.');
		writeln('2- Contagio comunitario.');
		writeln('3- Contagio desconocido.');
		readln(reg3.forma_contagio);
		end;
	7:begin
		writeln('Ingrese nueva nuevo estado del paciente');
		writeln('-Fallecido: ');
		writeln('-Recuperado: ');
		writeln('-Activo: ');
		readln(reg3.estado_2);
		end;
	end;
seek(arch3,pos);
write(arch3,reg3);
seek(arch,pos);		
write(arch,reg);
seek(arch2,pos);;		
write(arch2,reg2);
end;


procedure mostrar_consulta_de_usario(var arch:t_archivo_contagiados; var arch2:t_archivo_provincia;var arch3:t_archivo_estadistica; pos:longint);
var reg:t_persona;
	reg2:t_provincia;
	reg3:t_estadistica;
begin
seek(arch,pos);
read(arch,reg);
	with reg do
	begin
	writeln('Nombre: ',nombre);
	writeln('DNI: ',Dni);
	writeln('Nacimiento :', nacimiento);
	writeln('Ciudad: ',ciudad);
	seek(arch2,pos);
	read(arch2,reg2);
	with reg2 do
	begin
	writeln('Provincia: ',Nombre);
	writeln('Tel-contacto por covid-19: ',telefono);
	end;
	writeln('Telefono: ',Telefono);
	seek(arch3,pos);
	read(arch3,reg3);
	with reg3 do
	begin
	if forma_contagio=1 then
		writeln('Forma de contagio: DIRECTO')
		else
			if forma_contagio=2 then
				writeln('Forma de contagio: COMUNITARIO')
				else
					if forma_contagio=3 then
						writeln('Forma de contagio: DESCONOCIDO');
	if estado_2=1 then
		writeln('Estado: FALLECIDO')
		else
			if estado_2=2 then
				writeln('Estado: RECUPERADO')
				else
					if estado_2=3 then
						writeln('Estado: ACTIVO');
	end;		
	end;
end;

procedure menu_listado_provicias(var a:integer);
begin
a:=0;
		writeln('1-Buenos Aires');
		writeln('2- Catamarca');
		writeln('3- Chaco');
		writeln('4- Chubut');
		writeln('5- Córdoba');
		writeln('6- Corrientes');
		writeln('7- Entre Ríos');
		writeln('8- Formosa');
		writeln('9- Jujuy');
		writeln('10- La Pampa');
		writeln('11- La Rioja');
		writeln('12- Mendoza');
		writeln('13- Misiones');
		writeln('14- Neuquén');
		writeln('15- Río Negro');
		writeln('16- Salta');
		writeln('17- San Juan');
		writeln('18- San Luis');
		writeln('19- Santa Cruz');
		writeln('20- Santa Fe');
		writeln('21- Santiago del Estero');
		writeln('22- Tierra del Fuego');
		writeln('23- Tucumán');
		readln(a);
end;
procedure mostrar_usuario_por_provincia(var arch:t_archivo_contagiados; var arch2:t_archivo_provincia; var arch3:t_archivo_estadistica; a:integer);
var reg:t_persona;
	reg2:t_provincia;
	reg3:t_estadistica;
	cont:longint;
begin
cont:=0;
reset(arch);
reset(arch2);
reset(arch3);
while (not(EOF(arch)) and not(EOF(arch2))) do
begin
read(arch,reg);
read(arch2,reg2);
read(arch3,reg3);
	if ((a=reg.provincia) and (reg.estado=true)) then
		begin
		mostrar_registro_persona(reg,reg2,reg3);
		inc(cont); {Para registrar si se encuentran personas en cada provincia}
		end;
end;
if cont=0 then
	writeln('-No hay personas cargadas de esa provincia!!');

end;

procedure analis_estadisticas_por_estados_de_pacientes_nacional(var arch3:t_archivo_estadistica; var cont1,cont2,cont3:longint);
var reg3:t_estadistica;
begin
cont1:=0;
cont2:=0;
cont3:=0;
reset(arch3);
while not(EOF(arch3)) do
begin
read(arch3,reg3);
	if reg3.estado_2=1 then
		inc(cont1)
		else
			if reg3.estado_2=2 then
				inc(cont2)
				else
					if reg3.estado_2=3 then
						inc(cont3)
end;
end;

procedure MOSTRAR_analis_estadisticas_por_estados_de_pacientes_nacional(var arch3:t_archivo_estadistica; cont1,cont2,cont3:longint);
begin
	writeln('Personas Fallecidas --> ',cont1);
	writeln('Personas Recuperadas --> ',cont2);
	writeln('Personas activas --> ',cont3);
	writeln('>>PRESS ENTER<<');
	readkey;
	clrscr;
end;

procedure analis_estadisticas_por_estados_de_pacientes_provincial(var arch3:t_archivo_estadistica; var cont1,cont2,cont3:longint; a:integer);
var reg3:t_estadistica;
begin
cont1:=0;
cont2:=0;
cont3:=0;
reset(arch3);
	while not(EOF(arch3)) do
	begin
	read(arch3,reg3);
		if a=reg3.codigo_provincia then
		begin
			if reg3.estado_2=1 then
				inc(cont1)
					else
						if reg3.estado_2=2 then
							inc(cont2)
							else
								if reg3.estado_2=3 then
									inc(cont3)
		end;
	end;
end;

procedure MOSTRAR_analis_estadisticas_por_estados_de_pacientes_provincial(var arch3:t_archivo_estadistica; cont1,cont2,cont3:longint);
begin
	writeln('Personas Fallecidas --> ',cont1);
	writeln('Personas Recuperadas --> ',cont2);
	writeln('Personas activas --> ',cont3);
	writeln('>>PRESS ENTER<<');
	readkey;
	clrscr;
end;

procedure analis_estadisticas_por_forma_contagio_de_pacientes_nacional(var arch3:t_archivo_estadistica; var cont1,cont2,cont3:longint);
var reg3:t_estadistica;
begin
cont1:=0;
cont2:=0;
cont3:=0;
reset(arch3);
while not(EOF(arch3)) do
begin
read(arch3,reg3);
	if reg3.forma_contagio=1 then
		inc(cont1)
		else
			if reg3.forma_contagio=2 then
				inc(cont2)
				else
					if reg3.forma_contagio=3 then
						inc(cont3)
end;

end;
procedure MOSTRAR_analis_estadisticas_por_forma_contagio_de_pacientes_nacional(var arch3:t_archivo_estadistica; cont1,cont2,cont3:longint);
begin
	writeln('Forma de contagio directo --> ',cont1);
	writeln('Forma de contagio comunitario --> ',cont2);
	writeln('Forma de contagio desconocido --> ',cont3);
	writeln('>>PRESS ENTER<<');
	readkey;
	clrscr;
end;

procedure analis_estadisticas_por_forma_contagio_de_pacientes_provincial(var arch3:t_archivo_estadistica; var cont1,cont2,cont3:longint; a:integer);
var reg3:t_estadistica;
begin
cont1:=0;
cont2:=0;
cont3:=0;
reset(arch3);
	while not(EOF(arch3)) do
	begin
	read(arch3,reg3);
		if a=reg3.codigo_provincia then
		begin
			if reg3.forma_contagio=1 then
				inc(cont1)
					else
						if reg3.forma_contagio=2 then
							inc(cont2)
							else
								if reg3.forma_contagio=3 then
									inc(cont3)
		end;
	end;
end;

procedure MOSTRAR_analis_estadisticas_por_forma_contagio_de_pacientes_provincial(var arch3:t_archivo_estadistica; cont1,cont2,cont3:longint);
begin
	writeln('Forma de contagio directo --> ',cont1);
	writeln('Forma de contagio comunitario --> ',cont2);
	writeln('Forma de contagio desconocido --> ',cont3);
	writeln('>>PRESS ENTER<<');
	readkey;
	clrscr;
end;

procedure analis_estadisticas_por_rango_etario_de_pacientes_nacional(var arch3:t_archivo_estadistica; var cont1,cont2,cont3:longint);
var reg3:t_estadistica;
begin
cont1:=0;
cont2:=0;
cont3:=0;
reset(arch3);
while not(EOF(arch3)) do
begin
read(arch3,reg3);
	if reg3.edad<18 then
		inc(cont1)
		else
			if ((reg3.edad>=18) and (reg3.edad<=49)) then
				inc(cont2)
				else
					if (reg3.edad>50) then
						inc(cont3);

end;
end;
procedure MOSTRAR_analis_estadisticas_por_rango_etario_de_pacientes_nacional(var arch3:t_archivo_estadistica; cont1,cont2,cont3:longint);
begin
	writeln('Personas menores a 18 años --> ',cont1);
	writeln('Personas mayores a 18 años y menores a 50 años --> ',cont2);
	writeln('Personas mayores a 49 años --> ',cont3);
	writeln('>>PRESS ENTER<<');
	readkey;
	clrscr;
end;

procedure analis_estadisticas_por_rango_etario_de_pacientes_provincial(var arch3:t_archivo_estadistica; cont1,cont2,cont3:longint; a:integer);
var reg3:t_estadistica;
begin
cont1:=0;
cont2:=0;
cont3:=0;
reset(arch3);
	while not(EOF(arch3)) do
	begin
	read(arch3,reg3);
		if a=reg3.codigo_provincia then
		begin
		if reg3.edad<18 then
		inc(cont1)
		else
			if ((reg3.edad>=18) and (reg3.edad<=49)) then
				inc(cont2)
				else
					if (reg3.edad>50) then
						inc(cont3);
		end;
	end;
end;

procedure MOSTRAR_analis_estadisticas_por_rango_etario_de_pacientes_provincial(var arch3:t_archivo_estadistica; cont1,cont2,cont3:longint);
begin
	writeln('Personas menores a 18 años --> ',cont1);
	writeln('Personas mayores a 18 años y menores a 50 años --> ',cont2);
	writeln('Personas mayores a 49 años --> ',cont3);
	writeln('>>PRESS ENTER<<');
	readkey;
	clrscr;
end;
begin
end.



