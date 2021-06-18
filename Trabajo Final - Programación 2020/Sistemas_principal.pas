program Sistemas_principal;
{$codepage utf8}
uses crt,Unit_archivos,Unit_Procedimientos_pricipal;
var
	op,op2,menu_listado: Integer;  //opciones del menú   
	archivo_personas:t_archivo_contagiados;
	archivo_provicias:t_archivo_provincia;
	archivo_estadisticas:t_archivo_estadistica;
	registro_personas:t_persona;
	registro_provincias:t_provincia;
	registro_estadistica:t_estadistica;
	dni_consultado:longint;
	posicion,pos,cont1,cont2,cont3,cont_prov1,cont_prov2,cont_prov3,cont_forma1,cont_rango1,cont_rango2,cont_rango3,cont_forma2,cont_forma3,cont_prov_forma1,cont_prov_forma2,cont_prov_forma3:longint;
	op_modificar_1,menu_provincias,op_estadisticas,op_esta_estado,op_menu_prov,op_esta_form,op_rango_etario:integer;

BEGIN
repeat
dni_consultado:=0;
textcolor(yellow);
writeln('~~~~~~~~~~~~~~~~~~~~~MENÚ~~~~~~~~~~~~~~~~~~~');
textcolor(green);
writeln('~1 - ABMC');
textcolor(cyan);
writeln('~2 - Estadisticas');
textcolor(blue);

writeln('~3 - Listado');
textcolor(red);

writeln('~4 - Salir');
readln(op);
clrscr;
textcolor(white);
case op of
1 :	begin   //sub menu pacientes
	repeat
	op2:=0;
	dni_consultado:=0;
	inicializarEstadistica(registro_estadistica);
	inicializarProv(registro_provincias);
    inicializarper(registro_personas);
    writeln('~~~~~~~~~~~~~~~~~~~~~ABMC~~~~~~~~~~~~~~~~~~~');
	textcolor(red);
	writeln('~1 - Alta ');
	writeln('~2 - Baja');
	writeln('~3 - Modificar');
	writeln('~4 - Consultar');
	writeln('~5 - Volver al menú pricipal');
	readln(op2);
	
	clrscr;
	textcolor(white);
		if op2=1 then
		begin
			writeln('~~~~~~~~~~~~~~~~~~~~~DAR DE ALTA~~~~~~~~~~~~~~~~~~');
			crear_abrir_prov(archivo_provicias);
			CrearAbrir_archivo_per(archivo_personas);
			abrir_crear_estadistica(archivo_estadisticas);
			ordenar_archivo(archivo_personas);
			cargar_per_reg(archivo_personas,archivo_provicias,archivo_estadisticas,pos);
			readkey;
			cerrar_per(archivo_personas);
			cerrar_prov(archivo_provicias);
			cerrar_estadistica(archivo_estadisticas);
			clrscr;
		end
		else
			if op2=2 then
			begin
			abrir_crear_estadistica(archivo_estadisticas);
			crear_abrir_prov(archivo_provicias);
			CrearAbrir_archivo_per(archivo_personas);
			writeln('~~~~~~~~~~~~~~~~~~~~~DAR DE BAJA~~~~~~~~~~~~~~~~~~~');
			if (filesize(archivo_personas)=0) then	
				begin
					writeln('No hay datos cargados');
				cerrar_per(archivo_personas);
				end
				else
				begin
				ordenar_archivo(archivo_personas);
				buscar_dar_de_baja(dni_consultado);
				busqueda_binaria(archivo_personas,dni_consultado,posicion);
					if posicion<>-1 then
						begin
						dar_de_baja_persona(archivo_personas,posicion);
						end
					else
						writeln('No se ha encotrado la persona!');
				cerrar_per(archivo_personas);
				cerrar_prov(archivo_provicias);
				cerrar_estadistica(archivo_estadisticas);
				end;
			end
			else
				if op2=3 then
					begin
					abrir_crear_estadistica(archivo_estadisticas);
					crear_abrir_prov(archivo_provicias);
					CrearAbrir_archivo_per(archivo_personas);
					writeln('~~~~~~~~~~~~~~~~~~~~~MODIFICACIONES DE DATOS~~~~~~~~~~~~~~~~~~~');
					if (filesize(archivo_personas)=0) then	
						begin
							writeln('No hay datos cargados');
							cerrar_per(archivo_personas);

						end
						else
						begin
						ordenar_archivo(archivo_personas);
						writeln('-Ingrese Dni a buscar: ');
						readln(dni_consultado);
						busqueda_binaria(archivo_personas,dni_consultado,posicion);
						if posicion>-1 then
							begin
								menu_de_campos_aModificar(op_modificar_1);
								modificacion_de_campos(op_modificar_1,posicion,archivo_personas,archivo_estadisticas,archivo_provicias);
							end
						else
							writeln('!No se ha encotrado la persona!');
						cerrar_per(archivo_personas);
						cerrar_prov(archivo_provicias);
						cerrar_estadistica(archivo_estadisticas);
						end;
					end
				else
						if op2=4 then
						begin
							writeln('~~~~~~~~~~~~~~~~~~~~~CONSULTAS~~~~~~~~~~~~~~~~~~');
							crear_abrir_prov(archivo_provicias);
							abrir_crear_estadistica(archivo_estadisticas);
							CrearAbrir_archivo_per(archivo_personas);
							if (filesize(archivo_personas)=0) then	
							begin
							writeln('-No hay datos cargados');
							cerrar_per(archivo_personas)
							end
								else
									begin
										ordenar_archivo(archivo_personas);
										writeln('~Ingrese Dni a buscar: ');
										readln(dni_consultado);
										busqueda_binaria(archivo_personas,dni_consultado,posicion);
										if posicion>-1 then
											mostrar_consulta_de_usario(archivo_personas,archivo_provicias,archivo_estadisticas,posicion)
										else
											writeln('No se ha encotrado la persona!');
							cerrar_per(archivo_personas);
							cerrar_prov(archivo_provicias);
							cerrar_estadistica(archivo_estadisticas);
							end;
						end
						else
							if op2=5 then
			
		else
			writeln('¡OPCIÓN INCORRECTA!');
		readkey;
		clrscr;
	until op2 = 5;
	clrscr;
	end;
2:	begin //Estadisticas
	
		CrearAbrir_archivo_per(archivo_personas);
		abrir_crear_estadistica(archivo_estadisticas);

		if (filesize(archivo_personas)=0) then	
		begin
			writeln('No hay datos cargados');

		end
			else
				begin
				repeat
				cont1:=0;
				cont2:=0;
				cont3:=0;
				op_estadisticas:=0;
					writeln('~ESTADISTICAS');
					writeln('1- Estadisticas por rango etario.');
					writeln('2- Estadisticas de estados de pacientes.');
					writeln('3- Estadisticas por forma de contagio.');
					writeln('4- Volver al menú principal');
					readln(op_estadisticas);
						
						if op_estadisticas=1 then
						begin
						op_rango_etario:=0;
						writeln('RANGO ETARIO DE LOS PACIENTES');
						writeln('1- NIvel nacional');
						writeln('2- nivel provincial');
						readln(op_rango_etario);
							if op_rango_etario=1 then
							begin
								analis_estadisticas_por_rango_etario_de_pacientes_nacional(archivo_estadisticas,cont_rango1,cont_rango2,cont_rango3);
								MOSTRAR_analis_estadisticas_por_rango_etario_de_pacientes_nacional(archivo_estadisticas,cont_rango1,cont_rango2,cont_rango3);
								end
								else 
									if op_rango_etario=2 then
										begin
										menu_listado_provicias(op_menu_prov);
										analis_estadisticas_por_rango_etario_de_pacientes_provincial(archivo_estadisticas,cont_rango1,cont_rango2,cont_rango3,op_menu_prov);
										MOSTRAR_analis_estadisticas_por_rango_etario_de_pacientes_provincial(archivo_estadisticas,cont_rango1,cont_rango2,cont_rango3);
										end;
						end
							else
								if op_estadisticas=2 then
									begin
									op_esta_estado:=0;
										writeln('ESTADOS DE LOS PACIENTES');
										writeln('1- NIvel nacional');
										writeln('2- Nivel provincial');
										readln(op_esta_estado);
										if op_esta_estado=1 then
										begin
										analis_estadisticas_por_estados_de_pacientes_nacional(archivo_estadisticas,cont1,cont2,cont3);
										MOSTRAR_analis_estadisticas_por_estados_de_pacientes_nacional(archivo_estadisticas,cont1,cont2,cont3);
										end
										else
											if op_esta_estado=2 then
											begin
											menu_listado_provicias(op_menu_prov);
											analis_estadisticas_por_estados_de_pacientes_provincial(archivo_estadisticas,cont_prov1,cont_prov2,cont_prov3,op_menu_prov);
											MOSTRAR_analis_estadisticas_por_estados_de_pacientes_provincial(archivo_estadisticas,cont_prov1,cont_prov2,cont_prov3);
											
											end;

									end
									else
										if op_estadisticas=3 then
										begin
										op_esta_form:=0;
											writeln('FORMA DE CONTAGIO DE LOS PACIENTES');
											writeln('1- NIvel nacional');
											writeln('2- nivel provincial');
											readln(op_esta_form);
												if op_esta_form=1 then
												begin
												analis_estadisticas_por_forma_contagio_de_pacientes_nacional(archivo_estadisticas,cont_forma1,cont_forma2,cont_forma3);
												MOSTRAR_analis_estadisticas_por_forma_contagio_de_pacientes_nacional(archivo_estadisticas,cont_forma1,cont_forma2,cont_forma3);
												end
												else 
													if op_esta_form=2 then
													begin
													menu_listado_provicias(op_menu_prov);
													analis_estadisticas_por_forma_contagio_de_pacientes_provincial(archivo_estadisticas,cont_prov_forma1,cont_prov_forma2,cont_prov_forma3,op_menu_prov);
													MOSTRAR_analis_estadisticas_por_forma_contagio_de_pacientes_provincial(archivo_estadisticas,cont_prov_forma1,cont_prov_forma2,cont_prov_forma3);
													end;

										end;
				until op_estadisticas=4;
				
				end;
		cerrar_per(archivo_personas);
		cerrar_estadistica(archivo_estadisticas);

		readkey;
		clrscr;
	end;
3:	begin //listado
	abrir_crear_estadistica(archivo_estadisticas);
	CrearAbrir_archivo_per(archivo_personas);
	crear_abrir_prov(archivo_provicias);
	if (filesize(archivo_personas)=0) then	
		begin
			writeln('No hay datos cargados');
			
		end
		else
			begin
			repeat
			menu_listado:=0;
				writeln('~LISTADOS DE CONTAGIADOS');
				writeln('1- Nivel Nacional');
				writeln('2- Nivel provincial');
				writeln('3- Volver al menú pricipal');

				readln(menu_listado);
				clrscr;
				if menu_listado=1 then
				begin
				
				writeln('~~~~~~~~~~~~~~LISTADO A NIVEL NACIONAL~~~~~~~~~~~~~~');
				ordenar_archivo_nombre(archivo_personas);
				mostrar_archivo_contagiados(archivo_personas,archivo_provicias);
				readkey;
				clrscr;
				end
				else
					if menu_listado=2 then
					begin
					writeln('~~~~~~~~~~~~~~LISTADO A NIVEL PROVINCIAL~~~~~~~~~~~~~~');
					writeln('~Ingrese el N° de la provincia que desee ver el listado.');
					menu_provincias:=0;
					menu_listado_provicias(menu_provincias);
					mostrar_usuario_por_provincia(archivo_personas,archivo_provicias,archivo_estadisticas,menu_provincias);
					writeln('>>Press ENTER para volver al menú<<');
					readkey;
					clrscr;
					end
					else
						if menu_listado=3 then
							readkey;
			until menu_listado=3;
			end;
		cerrar_per(archivo_personas);
		cerrar_prov(archivo_provicias);
		cerrar_estadistica(archivo_estadisticas);
		clrscr;
	end;
4:	begin
		writeln('A salido del programa!');
	end
else
	writeln('¡OPCIÓN INCORRECTA!');
end;

until op=4;
readkey;
END.

