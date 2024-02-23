program ej3;
const
	cantMaterias=30;
type
	subrangoNotas=-1..10;
	//Arbol de alumnos. Alumnos con codigo y lista de notas
	ListaNotas=^nodoNotas;
	nodoNotas=record
		dato:subrangoNotas;
		sig:ListaNotas;
	end;
	alumnoTotal=record
		codigo:integer;
		notas:ListaNotas;
	end;
	arbolAlumnos=^nodoAlumnos;
	nodoAlumnos=record
		dato:alumnoTotal;
		HI:arbolAlumnos;
		HD:arbolAlumnos;
	end;
	{Registro materia con codigo y lista de finales. 
	Lista de finales con codigo de alumno y nota.
	Arbol de materias, para reducir tiempo de busqueda
	de materias al actualizar notas}
	alumnoYnota=record
		codigo:integer;
		nota:subrangoNotas;
	end;
	ListaFinales=^nodoFinales;
	nodoFinales=record
		dato:alumnoYnota;
		sig:ListaFinales;
	end;
	materia=record
		codigo:integer;
		finales:ListaFinales;
	end;
	arbolMaterias=^nodoMaterias;
	nodoMaterias=record
		dato:materia;
		HI:arbolMaterias;
		HD:arbolMaterias;
	end;
	
	//Registro para leer información
	finalRendido=record
		codAlumno:integer;
		codMateria:integer;
		nota:subrangoNotas;
	end;
	//Lista que almacena codigos de promedios para inciso b
	codigoYpromedio=record
		codigo:integer;
		promedio:real;
	end;
	listaCodyProm=^nodoCodyProm;
	nodoCodyProm=record
		dato:codigoYpromedio;
		sig:listaCodyProm;
	end;

//Procedimiento que lee los campos del registro de final
procedure leerFinalRendido(var finalRend:finalRendido);
begin
	writeln('Ingrese la nota del final'); readln(finalRend.nota);
	if(finalRend.nota <> -1)then
	begin
		writeln('Ingrese el codigo de alumno'); readln(finalRend.codAlumno);
		writeln('Ingrese codigo de materia'); readln(finalRend.codMateria);
	end;
	writeln('---------------------');
end;
//Agrega nodos al árbol de alumnos o los actualiza (agrega nota)
procedure agregarAlumno(var alumnos:arbolAlumnos;finalRend:finalRendido);
	//Agrega un nodo al principio de la lista
	procedure agregarNota(var lisNotas:ListaNotas; nota:subrangoNotas);
	var
		nuevo:ListaNotas;
	begin
		new(nuevo);
		nuevo^.dato:=nota;
		nuevo^.sig:=lisNotas;
		lisNotas:=nuevo;
	end;
begin
	if(alumnos=nil) then begin
		new(alumnos);
		alumnos^.dato.codigo:=finalRend.codAlumno;
		alumnos^.dato.notas:=nil;
		agregarNota(alumnos^.dato.notas,finalRend.nota);
		alumnos^.HI:=nil;
		alumnos^.HD:=nil;
	end
	else begin 
		if(finalRend.codAlumno=alumnos^.dato.codigo) then
			agregarNota(alumnos^.dato.notas,finalRend.nota)
		else if(finalRend.codAlumno<=alumnos^.dato.codigo) then
			agregarAlumno(alumnos^.HI, finalRend)
		else agregarAlumno(alumnos^.HD, finalRend);
	end;
end;
//Agrega nodos al árbol de alumnos o los actualiza (agrega final)
procedure agregarMateria(var materias:arbolMaterias; finalRend:finalRendido);
	//Agrega un nodo al principio de la lista
	procedure agregarFinalesRendidos(var lisFinales:ListaFinales; evFinal:finalRendido);
	var
		nuevo:ListaFinales;
	begin
		new(nuevo);
		nuevo^.dato.codigo:=evFinal.codAlumno;
		nuevo^.dato.nota:=evFinal.nota;
		nuevo^.sig:=lisFinales;
		lisFinales:=nuevo;
	end;
begin
	if(materias=nil) then begin
		new(materias);
		materias^.dato.codigo:=finalRend.codMateria;
		materias^.dato.finales:=nil;
		agregarFinalesRendidos(materias^.dato.finales, finalRend);
		materias^.HI:=nil;
		materias^.HD:=nil;
	end
	else begin
		if(finalRend.codMateria=materias^.dato.codigo) then
			agregarFinalesRendidos(materias^.dato.finales, finalRend)
		else if(finalRend.codMateria<=materias^.dato.codigo) then
			agregarMateria(materias^.HI, finalRend)
		else agregarMateria(materias^.HD, finalRend);
	end;
end;

//Carga la información al arbol alumnos y al arbol materias
procedure cargarAlumnosyMaterias(var alumnos:arbolAlumnos; var materias:arbolMaterias);
var
	finalRend:finalRendido;
begin
	leerFinalRendido(finalRend);
	if(finalRend.nota<>-1) then begin
		if(finalRend.nota>=4) then agregarAlumno(alumnos,finalRend);
		agregarMateria(materias,finalRend);
		cargarAlumnosyMaterias(alumnos,materias);
	end;
end;
//Imprime árbol de alumnos
procedure imprimirAlumnos(alumnos:arbolAlumnos);
	procedure printNotas(lisNotas:ListaNotas);
	begin
		if(lisNotas<>nil) then begin
			printNotas(lisNotas^.sig);
			writeln(lisNotas^.dato);
		end;
	end;
begin
	if(alumnos<>nil) then begin
		writeln('Alumno ',alumnos^.dato.codigo);
		writeln('Notas: ');
		printNotas(alumnos^.dato.notas);
		writeln('----------');
		imprimirAlumnos(alumnos^.HI);
		imprimirAlumnos(alumnos^.HD);
	end;
end;
//Imprime árbol de materias
procedure imprimirMaterias(materias:arbolMaterias);
	procedure printFinales(lisFinales:ListaFinales);
	begin
		if(lisFinales<>nil) then begin
			printFinales(lisFinales^.sig);
			writeln('Codigo alumno: ',lisFinales^.dato.codigo);
			writeln('Nota: ',lisFinales^.dato.nota);
			writeln;
		end;
	end;
begin
	if(materias<>nil) then begin
		writeln('Materia ',materias^.dato.codigo);
		printFinales(materias^.dato.finales);
		writeln('----------');
		imprimirMaterias(materias^.HI);
		imprimirMaterias(materias^.HD);
	end;
end;
//Retorna en una lista el codigo y promedio de alumnos con codigo mayor al ingresado
procedure retornarCodigosyPromedios(alumnos:arbolAlumnos; var aluInfo:listaCodyProm; codRef:integer);
	//Agrega en la lista el código y promedio
	procedure agregarCodigoyPromedio(var aluInfo:listaCodyProm; alumno:alumnoTotal);
		//Calcula el promedio de la lista de notas del alumno
		procedure calcularPromedio(lisNotas:ListaNotas; var sumaNotas:integer; var cantNotas:integer);
		begin
			if(lisNotas<>nil) then begin
				sumaNotas:=sumaNotas+lisNotas^.dato;
				cantNotas:=cantNotas+1;
				calcularPromedio(lisNotas^.sig,sumaNotas,cantNotas);
			end
		end;
	var
		nuevo:listaCodyProm;
		sumaNotas,cantNotas:integer;
	begin
		sumaNotas:=0;
		cantNotas:=0;
		calcularPromedio(alumno.notas,sumaNotas,cantNotas);
		
		new(nuevo);
		nuevo^.dato.codigo:=alumno.codigo;
		//Evita dividir por 0 si el alumno no tiene notas aprobadas
		if(cantNotas>0) then nuevo^.dato.promedio:=sumaNotas/cantNotas
		else nuevo^.dato.promedio:=-1;
		nuevo^.sig:=aluInfo;
		aluInfo:=nuevo;
	end;
begin
	if(alumnos<>nil) then begin
		if(alumnos^.dato.codigo>codRef) then begin
			agregarCodigoyPromedio(aluInfo,alumnos^.dato);
			retornarCodigosyPromedios(alumnos^.HI,aluInfo,codRef);
			retornarCodigosyPromedios(alumnos^.HD,aluInfo,codRef);
		end
		else retornarCodigosyPromedios(alumnos^.HD,aluInfo,codRef);
	end;
end;
//Imprimir codigo y promedio de alumno que cumple condición inciso B
procedure imprimirAluInfo(aluInfo:listaCodyProm);
begin
	if(aluInfo<>nil) then begin
		writeln('Codigo de alumno: ',aluInfo^.dato.codigo);
		writeln('Promedio de alumno: ',aluInfo^.dato.promedio:1:2);
		writeln;
		imprimirAluInfo(aluInfo^.sig);
	end;
end;
//Evalua en un rango de codigos si la cantidad de finales de los alumnos es igual al valor ingresado y suma un contador
procedure retornarCantAlumnosIncisoC(alumnos:arbolAlumnos;rangoMin,rangoMax:integer;cantFinalesRef:integer;var cantAlumnos:integer);
	//Recorre la lista de notas de un alumno contando su cantidad
	function contarFinales(lisNotas:ListaNotas):integer;
	begin
		if(lisNotas<>nil) then begin
			contarFinales:=contarFinales(lisNotas^.sig) + 1;
		end
		else contarFinales:=0;
	end;
begin
	if(alumnos<>nil) then begin
		if(alumnos^.dato.codigo>rangoMin) and (alumnos^.dato.codigo<rangoMax) then begin
			if(cantFinalesRef=contarFinales(alumnos^.dato.notas)) then cantAlumnos:=cantAlumnos+1;
			retornarCantAlumnosIncisoC(alumnos^.HI,rangoMin,rangoMax,cantFinalesRef,cantAlumnos);
			retornarCantAlumnosIncisoC(alumnos^.HD,rangoMin,rangoMax,cantFinalesRef,cantAlumnos);
		end
		else if(alumnos^.dato.codigo<=rangoMin) then
			retornarCantAlumnosIncisoC(alumnos^.HD,rangoMin,rangoMax,cantFinalesRef,cantAlumnos)
		else retornarCantAlumnosIncisoC(alumnos^.HI,rangoMin,rangoMax,cantFinalesRef,cantAlumnos);
	end;
end;

var
	alumnos:arbolAlumnos;
	materias:arbolMaterias;
	codigoReferencia,rangoMin,rangoMax,cantAlumnosIncisoC,cantFinalesRef:integer;
	aluInfo:listaCodyProm;
begin
	//Carga de árbol de alumnos y árbol de materias
	cargarAlumnosyMaterias(alumnos, materias);
	//Impresión de árboles de alumnos y materias
	imprimirAlumnos(alumnos);
	writeln;
	imprimirMaterias(materias);
	writeln;
	//Retornar codigos y promedios de alumnos en base a valor ingresado
	aluInfo:=nil;
	write('Ingrese un codigo de alumno: '); readln(codigoReferencia);
	retornarCodigosyPromedios(alumnos,aluInfo,codigoReferencia);
	imprimirAluInfo(aluInfo);
	if(aluInfo=nil) then writeln('No hay alumnos con codigo mayor al ingresado');
	writeln;
	//Retornar cuantos alumnos con cantidad de finales aprobados igual a valor ingresado en un rango de valores
	cantAlumnosIncisoC:=0;
	writeln('Ingrese codigo minimo del rango: '); readln(rangoMin);
	writeln('Ingrese codigo maximo del rango: '); readln(rangoMax);
	writeln('Ingrese la cantidad de finales a evaluar: '); readln(cantFinalesRef);
	retornarCantAlumnosIncisoC(alumnos, rangoMin, rangoMax, cantFinalesRef, cantAlumnosIncisoC);
	if(cantAlumnosIncisoC<>0) then writeln('La cantidad de alumnos que cumplen la condicion es de: ',cantAlumnosIncisoC)
	else writeln('Ningun alumno cumple la condicion');
end.
