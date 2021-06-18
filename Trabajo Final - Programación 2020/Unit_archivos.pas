unit Unit_archivos;
{$codepage utf8}
INTERFACE
uses crt;
type
t_provincia = record
		Nombre:string[25];
		cp:string[25];
		telefono:string[25];
		end;


t_persona = record
		nombre:string[20];
		Dni:longint;
		calle:string[20];
		{DOMICILIO}
		numero_calle:integer;
		piso:integer;
		ciudad:string[20];
		provincia:integer;
		Telefono:QWord;
		email:string[30];
		nacimiento:string[20];
		estado:boolean;
		end;

t_estadistica = record
	id:longint;
	dni:longint;
	codigo_provincia:integer;
	estado:integer;
	forma_contagio:integer;
	estado_2:integer;
	edad:integer;
	end;

t_archivo_provincia = file of t_provincia;
t_archivo_contagiados = file of t_persona;
t_archivo_estadistica = file of t_estadistica;

t_vector_datos_provincia = array [1..23] of string;

{-------------ARCHIVOS/ PROCEDIMIENTOS PARA PROVINCIAS-------------}
procedure crear_abrir_prov(var archivo:t_archivo_provincia);
procedure cerrar_prov(var archivo:t_archivo_provincia);
procedure guardar_prov(var archivo:t_archivo_provincia; reg:t_provincia);
procedure mostrar_registro_provincia(var reg:t_provincia);
procedure mostrar_archivo_provincia(var arch:t_archivo_provincia);
procedure clave_provincias(var claves_prov:t_vector_datos_provincia);
procedure Numero_tel_prov(var vec_numero:t_vector_datos_provincia);

{-------------ARCHIVOS PARA CONTAGIADOS-------------}
procedure CrearAbrir_archivo_per(var archivo:t_archivo_contagiados);
procedure cerrar_per(var archivo:t_archivo_contagiados);
procedure cargar_per_reg(var archivo:t_archivo_contagiados; var archivo2:t_archivo_provincia; var arch3:t_archivo_estadistica; var pos:longint);
procedure guardar_per(var archivo:t_archivo_contagiados; reg:t_persona);
procedure mostrar_registro_persona(var reg:t_persona; var reg2:t_provincia; var reg3:t_estadistica);
procedure mostrar_archivo_contagiados(var arch:t_archivo_contagiados; var arch2:t_archivo_provincia);

{-------------ARCHIVOS PARA ESTADISTICAS-------------}
procedure abrir_crear_estadistica(var arch:t_archivo_estadistica);
procedure cerrar_estadistica(var arch:t_archivo_estadistica);
procedure guardar_estadistia(var arch:t_archivo_estadistica; reg:t_estadistica);
procedure mostrar_registro_estadistica(var reg:t_estadistica);
procedure mostrar_archivo_estadistica(var arch:t_archivo_estadistica);




{--------------PROCEDIMIENTOS-----------------------------------------------}
procedure verificacion_de_estado(pos:longint; var v:integer; var arch:t_archivo_contagiados);
procedure dar_de_alta_persona(var arch:t_archivo_contagiados; pos:longint);
procedure busqueda_binaria(var arch:t_archivo_contagiados; buscado:longint; var pos:longint);
procedure ordenar_archivo(var arch:t_archivo_contagiados);
procedure ordenar_archivo_nombre(var arch:t_archivo_contagiados);
procedure obtener_fecha(fecha_ingresada:string; var e:integer);


IMPLEMENTATION 
{-------------ARCHIVOS PARA ESTADISTICAS-------------}

procedure abrir_crear_estadistica(var arch:t_archivo_estadistica);
begin
assign(arch,'ARCHIVO_ESTADISTICA');
{$i-}
reset(arch);
{$i+}
	if IOresult<>0 then
		rewrite(arch);
end;

procedure cerrar_estadistica(var arch:t_archivo_estadistica);
begin
close(arch);
end;

procedure guardar_estadistia(var arch:t_archivo_estadistica; reg:t_estadistica);
begin
	seek(arch,filesize(arch));
	write(arch,reg);
end;

procedure mostrar_registro_estadistica(var reg:t_estadistica);
begin
	with reg do
	begin
	writeln('ID: ',id);
	writeln('DNI: ',dni);
	writeln('Codigo provincia',codigo_provincia);
	if forma_contagio=1 then
			writeln('~Forma de contagio: DIRECTO.')
			else
				if forma_contagio=2 then
					writeln('~Forma de contagio: COMUNITARIO.')
					else
						if forma_contagio=2 then
							writeln('~Forma de contagio: DESCONOCIDO.');
	end;
end;

procedure mostrar_archivo_estadistica(var arch:t_archivo_estadistica);
var reg:t_estadistica;
begin
	reset(arch);
		while not (EOF(arch)) do
		begin
		read(arch,reg);
		mostrar_registro_estadistica(reg);
		end;
end;

{-------------ARCHIVOS PARA PROVINCIAS-------------}

procedure clave_provincias(var claves_prov:t_vector_datos_provincia);
begin
	claves_prov[1]:='Buenos Aires';
	claves_prov[2]:='Catamarca';
	claves_prov[3]:='Chaco';
	claves_prov[4]:='Chubut';
	claves_prov[5]:='Córdoba';
	claves_prov[6]:='Corrientes';
	claves_prov[7]:='Entre ríos';
	claves_prov[8]:='Formosa';
	claves_prov[9]:='Jujuy';
	claves_prov[10]:='La Pampa';
	claves_prov[11]:='La Rioja';
	claves_prov[12]:='Mendoza';
	claves_prov[13]:='Misiones';
	claves_prov[14]:='Neuquén';
	claves_prov[15]:='Río Negro';
	claves_prov[16]:='Salta';
	claves_prov[17]:='San Juan';
	claves_prov[18]:='San Luis';
	claves_prov[19]:='Santa Cruz';
	claves_prov[20]:='Santa Fe';
	claves_prov[21]:='Santiago del Estero';
	claves_prov[22]:='Tierra del Fuego';
	claves_prov[23]:='Tucumán';
end;


procedure Numero_tel_prov(var vec_numero:t_vector_datos_provincia);
begin
	vec_numero[1]:='148';
	vec_numero[2]:='383-4238872';
	vec_numero[3]:='0800-444-0829';
	vec_numero[4]:='107';
	vec_numero[5]:='107';
	vec_numero[6]:='107';
	vec_numero[7]:='0800-555-6549';
	vec_numero[8]:='107';
	vec_numero[9]:='0800-888-4767';
	vec_numero[10]:='2954-619130 / 2954-604986 ';
	vec_numero[11]:='911';
	vec_numero[12]:='0800-800-26843';
	vec_numero[13]:='107';
	vec_numero[14]:='0-800-333-1002';
	vec_numero[15]:='911';
	vec_numero[16]:='911 / 136';
	vec_numero[17]:='107';
	vec_numero[18]:='107';
	vec_numero[19]:='107';
	vec_numero[20]:='0800-555-6549';
	vec_numero[21]:='385-5237077​';
	vec_numero[22]:='911';
	vec_numero[23]:='381-3899025';
end;
procedure cerrar_prov(var archivo:t_archivo_provincia);
begin
	close(archivo);
end;

procedure crear_abrir_prov(var archivo:t_archivo_provincia);
begin
	assign(archivo,'ARCHIVO_PROVINCIA.DAT');  
    {$i-}
	reset(archivo);
    {$i+}
	if IOresult<>0then
		rewrite(archivo);
end;


procedure guardar_prov(var archivo:t_archivo_provincia; reg:t_provincia);
begin
	seek(archivo,filesize(archivo));
	write(archivo,reg);
end;

procedure mostrar_registro_provincia(var reg:t_provincia);
begin
	with reg do
	begin
		writeln('~Provincia');
		writeln(nombre);
		writeln('~Cp');
		writeln(cp);
		writeln('~Numero');
		writeln(telefono);
	end;
end;

procedure mostrar_archivo_provincia(var arch:t_archivo_provincia);
var reg:t_provincia;
begin
	reset(arch);
		while not(EOF(arch)) do
		begin
		read(arch,reg);
		mostrar_registro_provincia(reg)
		end;
end;
{----------------ARCHIVOS PARA CONTAGIADOS-------------------------}

procedure CrearAbrir_archivo_per(var archivo:t_archivo_contagiados);
begin
ASSIGN(archivo,'ARCHIVO_PERSONA.DAT');
{$i-}
reset(archivo); 
{$i+}
if IOresult<>0 then
	rewrite(archivo);
end;

procedure cerrar_per(var archivo:t_archivo_contagiados);
begin
	close(archivo);
end;


procedure guardar_per(var archivo:t_archivo_contagiados; reg:t_persona);
begin
	seek(archivo,filesize(archivo));
	write(archivo,reg)
end;

procedure mostrar_registro_persona(var reg:t_persona; var reg2:t_provincia; var reg3:t_estadistica);
begin

if reg.estado=true then
begin

	with reg do
	begin
		writeln('~Nombre: ',nombre);
		writeln('~DNI: ',Dni);
		writeln('~Calle: ',calle);
		writeln('~Numero de calle: ', numero_calle);
		writeln('~Piso: ',piso);
		writeln('~Calle: ',calle);
		writeln('~Ciudad: ', ciudad);
		with reg2 do
		begin
		writeln('~Provincia: ',nombre);
		end;
		writeln('~Telefono contacto: ',telefono);
		writeln('~Email: ',email);
		writeln('~Nacimiento: ',nacimiento);
		with reg3 do
		begin
		if forma_contagio=1 then
			writeln('~Forma de contagio: DIRECTO.')
			else
				if forma_contagio=2 then
					writeln('~Forma de contagio: COMUNITARIO.')
					else
						if forma_contagio=2 then
							writeln('~Forma de contagio: DESCONOCIDO.');
		if estado_2=1 then
			writeln('~Estado de Paciente: FALLECIDO ')
			else
				if estado_2=2 then
					writeln('~Estado de Paciente: RECUPERADO ')
					else
						if estado_2=3 then
							writeln('~Estado de Paciente: ACTIVO');
		end;
	end;
end;
writeln();
end;
procedure verificacion_de_estado(pos:longint; var v:integer; var arch:t_archivo_contagiados);
var reg:t_persona;
begin
seek(arch,pos);
read(arch,reg);
	if reg.estado=false then
		inc(v);
end;

procedure dar_de_alta_persona(var arch:t_archivo_contagiados; pos:longint);
var reg:t_persona;
	dar_alta:string;
begin
	seek(arch,pos);
	read(arch,reg);
	with reg do
	begin
	writeln('~DESEA DAR DE ALTA A LA PERSONA? si/no');
	readln(dar_alta);
		if (dar_alta='si') then
		begin
			reg.estado:=true;
			writeln('Con éxito Se ha dado de alta al usuario')
		end
		else
			writeln('Operación cancelada');
seek(arch,pos);
write(arch,reg);	
	end;	
end;

procedure ordenar_archivo(var arch:t_archivo_contagiados);
var reg1,reg2:t_persona;
	lim,i,j:integer;
begin
lim:=filesize(arch)-1;
	for i:=1 to lim-1 do
	begin
		for j:=0 to lim-1 do
		begin
		seek(arch,j);
		read(arch,reg1);
		seek(arch,j+1);
		read(arch,reg2);
			if reg1.Dni > reg2.Dni then
				begin
				seek(arch,j+1);
				write(arch,reg1);
				seek(arch,j);
				write(arch,reg2);
				end;
		end;
	end;	
end;

procedure ordenar_archivo_nombre(var arch:t_archivo_contagiados);
var reg1,reg2:t_persona;
	lim,i,j:integer;
begin
lim:=filesize(arch)-1;
	for i:=1 to lim-1 do
	begin
		for j:=0 to lim-1 do
		begin
		seek(arch,j);
		read(arch,reg1);
		seek(arch,j+1);
		read(arch,reg2);
			if reg1.nombre > reg2.nombre then
				begin
				seek(arch,j+1);
				write(arch,reg1);
				seek(arch,j);
				write(arch,reg2);
				end;
		end;
	end;	
end;
procedure busqueda_binaria(var arch:t_archivo_contagiados; buscado:longint; var pos:longint);
var reg:t_persona;
	pri,ult,med:longint;
begin
pri:=0;
ult:=filesize(arch)-1;
pos:=-1;
	while (pos=-1) and (pri<=ult) do
	begin
	med:=(pri+ult) div 2;
	seek(arch,med);
	read(arch,reg);
		if reg.Dni=buscado then
			pos:=med
			else
				if reg.Dni > buscado then
					ult:=med-1
					else
						pri:=med+1;
	end;
end;

procedure obtener_fecha(fecha_ingresada:string; var e:integer);
var a:string;
	b:integer;
begin
e:=0;
	a:=copy(fecha_ingresada,7,10);
	val(a,b);
	e:=2020-b;
end;
procedure cargar_per_reg(var archivo:t_archivo_contagiados; var archivo2:t_archivo_provincia; var arch3:t_archivo_estadistica; var pos:longint);
var i,verifica:integer;
	reg:t_persona;
	reg2:t_provincia;
	reg3:t_estadistica;
	cargar:string[4];
	vector_codigo:t_vector_datos_provincia;
	vector_telefono:t_vector_datos_provincia;
	edad_obtenida:integer;
begin
pos:=-1;
	with reg do
	begin
	writeln('-DESEA CARGAR UNA PERSONA A LA BASE DE DATOS? si/no');
	readln(cargar);
	lowercase(cargar);
	while ((cargar='si') and (pos=-1)) do
	begin
	verifica:=0;
	writeln('~Ingrese DNI:');
	readln(Dni);
	busqueda_binaria(archivo,Dni,pos);
	if pos>-1 then
		begin
		writeln('-Esta persona ya esta en la base de datos');
		verificacion_de_estado(pos,verifica,archivo);
			if verifica>0 then
			begin
				writeln('Esta persona esta dada de baja');
				dar_de_alta_persona(archivo,pos);
			end;
		readkey;
		clrscr;
		end;
	if pos = -1 then
	begin
	writeln('~Ingrese Nombre y Apellido');
	readln(nombre);
	writeln('~DOMICILIO:');
		writeln('-Ingrese calle');
		readln(calle);
		writeln('-Ingrese Numero de domicilio: ');
		readln(numero_calle);
		writeln('-Ingrese piso:');
		readln(piso);
		writeln('-Ingrese ciudad:');
		readln(ciudad);
		writeln('-Ingrese Clave provincia:');
		writeln('1- Buenos Aires');
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
		readln(provincia);
			with reg2 do
			begin
				clave_provincias(vector_codigo);
				Numero_tel_prov(vector_telefono);
				for i:=1 to 23 do
				begin
					if (provincia=i) then
					begin
						Nombre:=vector_codigo[i];
						telefono:=vector_telefono[i];
					end;
				end;
				guardar_prov(archivo2,reg2);
			end;
		
	writeln('~Ingrese numero de contacto');
	readln(Telefono);
	writeln('Ingrese Email');
	readln(email);
	writeln('Ingrese fecha de nacimiento');
	readln(nacimiento);
	obtener_fecha(nacimiento,edad_obtenida);
	estado:=true;
	guardar_per(archivo,reg);
	with reg3 do
	begin
	writeln('Ingrese forma de contagio:');
		writeln('1- Contagio directo.');
		writeln('2- Contagio comunitario.');
		writeln('3- Contagio desconocido.');
	readln(forma_contagio); 
	writeln('~Estado del paciente: ');
		writeln('-Fallecido: ');
		writeln('-Recuperado: ');
		writeln('-Activo: ');
	readln(estado_2);
		dni:=Dni;
		codigo_provincia:=provincia;
		id:=filesize(arch3);
		edad:=edad_obtenida;
	guardar_estadistia(arch3,reg3);
	end;
	writeln('-DESEA SEGUIR CARGANDO UNA PERSONA A LA BASE  DE DATOS? si/no');
	readln(cargar);
	clrscr;
	end
		else
			begin
			cargar:='';
			readkey;
			end;
	end;
	end;
end;


procedure mostrar_archivo_contagiados(var arch:t_archivo_contagiados; var arch2:t_archivo_provincia);
var reg:t_persona;
	reg2:t_provincia;
	reg3:t_estadistica;
	cont:longint;
begin
cont:=0;
	reset(arch);
	reset(arch2);
	
		while not(EOF(arch)) do
		begin
		inc(cont);
		writeln('PERSONA N° ',cont);
		read(arch,reg);
		read(arch2,reg2);
		mostrar_registro_persona(reg,reg2,reg3);
		readkey;
		end;
end;

end.
