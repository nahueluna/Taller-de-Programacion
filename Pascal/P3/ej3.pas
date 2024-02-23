{
a)
Registro alumno con legajo, dni, año ingreso y listaFinales.
ListaFinales con elementos registro "final" con codigo y nota.
Registro alumno dato de cada nodo de un arbol.
Se detiene carga de la lista cuando se lee codigo -1 y detiene carga de arbol con
legajo 0
}
program ej3;
type
	subrangoNota=1..10;
	//Registro de finales
	evFinal=record
		codigo:integer;
		nota:subrangoNota;
	end;
	//Lista de finales
	listaF=^nodoF;
	nodoF=record
		dato:evFinal;
		sig:listaF;
	end;
	//Registro de alumno
	alumno=record
		legajo:integer;
		dni:integer;
		anioIngreso:integer;
		finales:listaF;
	end;
	//Arbol con alumnos
	arbolAlu=^nodoAlu;
	nodoAlu=record
		dato:alumno;
		hi:arbolAlu;
		hd:arbolAlu;
	end;
	//Registro con DNI y año de ingreso de alumno
	alumInfo=record
		dni:integer;
		ingreso:integer;
	end;
	//Lista de DNIs y años de ingreso de alumnos
	listaAI=^nodoAI;
	nodoAI=record
		dato:alumInfo;
		sig:listaAI;
	end;
	//Registro con legajo y promedio de alumno
	alumPromedio=record
		legajo:integer;
		promedio:real;
	end;
	//Lista de legajos y promedios de alumnos
	listaAP=^nodoAP;
	nodoAP=record
		dato:alumPromedio;
		sig:listaAP;
	end;

//Lee la información de los finales y los agrega a una lista, según el orden leído
procedure leerFinales(var lisFinales:listaF);
	//Lee los dos campos del registro
	procedure leerRegFinal(var regFi:evFinal);
	begin
		write('Codigo final: '); readln(regFi.codigo);
		if(regFi.codigo<>-1) then begin
			write('Nota final: '); readln(regFi.nota);
		end;
		writeln;
	end;
var
	regFinal:evFinal;
	nuevo:listaF;
begin
	leerRegFinal(regFinal);
	if(regFinal.codigo<>-1) then begin
		leerFinales(lisFinales);
		new(nuevo);
		nuevo^.dato:=regFinal;
		nuevo^.sig:=lisFinales;
		lisFinales:=nuevo;
	end
	else lisFinales:=nil;
end;
//Leer datos de alumno
procedure leerRegistro(var reg:alumno);
begin
	write('Legajo: '); readln(reg.legajo);
	if(reg.legajo<>0) then begin
		write('DNI: '); readln(reg.dni);
		write('Ingreso: '); readln(reg.anioIngreso);
		leerFinales(reg.finales);
	end;
	writeln;
	writeln('------------------');
end;
//Agrega nodos al árbol, ordenado por legajo
procedure agregarNodoArbol(var arbolAlum:arbolAlu; elemento:alumno);
begin
	if(arbolAlum=nil) then begin
		new(arbolAlum);
		arbolAlum^.dato:=elemento;
		arbolAlum^.hi:=nil;
		arbolAlum^.hi:=nil;
	end
	else
		if(elemento.legajo<=arbolAlum^.dato.legajo) then
			agregarNodoArbol(arbolAlum^.hi, elemento)
		else agregarNodoArbol(arbolAlum^.hd, elemento);
end;
//Proceso para leer alumnos y cargar el árbol
procedure leerAlumnos(var alumnos:arbolAlu);
var
	regAlu:alumno;
begin
	leerRegistro(regAlu);
	if(regAlu.legajo<>0) then begin
		agregarNodoArbol(alumnos,regAlu);
		leerAlumnos(alumnos);
	end;
end;
//Proceso para imprimir datos de alumnos con pre orden
procedure imprimirAlumnos(alumnos:arbolAlu);
	procedure imprimir(alu:alumno);
		procedure imprimirFinales(lisF:listaF);
		begin
			if(lisF<>nil) then begin
				writeln;
				writeln('Codigo final: ',lisF^.dato.codigo);
				writeln('Nota final: ',lisF^.dato.nota);
				imprimirFinales(lisF^.sig);
			end;
		end;
	begin
		writeln('Alumno: ');
		writeln('Legajo: ',alu.legajo);
		writeln('DNI: ',alu.dni);
		writeln('Ingreso: ',alu.anioIngreso);
		imprimirFinales(alu.finales);
		writeln('..............');
	end;
begin
	if(alumnos<>nil) then begin
		imprimir(alumnos^.dato);
		imprimirAlumnos(alumnos^.hi);
		imprimirAlumnos(alumnos^.hd);
	end;
end;
//Busca los legajos menores a "valor" y agrega info del alumno a una lista
procedure retornarInfoAlumnos(alumnos:arbolAlu; valor:integer; var lisInfoAlu:listaAI);
	//Agrega el elemento a la lista
	procedure agregarLista(var lis:listaAI; alu:alumno);
	var
		nuevo:listaAI;
	begin
		new(nuevo);
		nuevo^.dato.dni:=alu.dni;
		nuevo^.dato.ingreso:=alu.anioIngreso;
		nuevo^.sig:=lis;
		lis:=nuevo;
	end;
begin
	if(alumnos<>nil) then begin
		if(alumnos^.dato.legajo<valor) then begin
		{Si es menor ingresa, lo agrega y va a su izquierda. Cuando salga, debe
		verificar su derecha}
			agregarLista(lisInfoAlu,alumnos^.dato);
			retornarInfoAlumnos(alumnos^.hi,valor,lisInfoAlu);
			retornarInfoAlumnos(alumnos^.hd,valor,lisInfoAlu);
		end
		{Si el legajo es mayor igual al valor, solo se deben buscar legajos menores
		asi que va a la izquierda}
		else retornarInfoAlumnos(alumnos^.hi,valor,lisInfoAlu);
	end;
end;

function buscarMayorLegajo(alumnos:arbolAlu):integer;
begin
	if(alumnos<>nil) then begin	//verifico que el arbol no este vacío
	//Si el siguiente por la derecha existe, debo ir a ese, pues sé que es mayor
		if(alumnos^.hd<>nil) then buscarMayorLegajo:=buscarMayorLegajo(alumnos^.hd)
		//Sino, el nodo donde estoy ahora es el mayor
		else buscarMayorLegajo:=alumnos^.dato.legajo;
	end
	//Codigo de error si el arbol está vacío
	else buscarMayorLegajo:=-1;
end;
//Recorre todo el árbol buscando el DNI más grande
procedure buscarMayorDNI(alumnos:arbolAlu; var maxDNI:integer);
	function max(x,y:integer):integer;
	begin
		if(x>y) then max:=x
		else max:=y;
	end;
begin
	if(alumnos<>nil) then begin
		buscarMayorDNI(alumnos^.hi,maxDNI);
		maxDNI:=max(maxDNI,alumnos^.dato.dni);
		buscarMayorDNI(alumnos^.hd,maxDNI);
	end;
end;
//Recorro todo el arbol verificando si los legajos son impares(si es asi, sumo 1)
//¿Se podría hacer con función? --> problema cuando se alcanza un nil
procedure buscarLegajosImpares(alumnos:arbolAlu; var cantLegImpar:integer);
	function legajoImpar(legajo:integer):boolean;
	begin
		legajoImpar:=((legajo MOD 2)<>0);
	end;
begin
	if(alumnos<>nil) then begin
		buscarLegajosImpares(alumnos^.hi,cantLegImpar);
		if(legajoImpar(alumnos^.dato.legajo)) then cantLegImpar:=cantLegImpar+1;
		buscarLegajosImpares(alumnos^.hd,cantLegImpar);
	end;
end;

//Calcula el promedio recorriendo lista finales
procedure calcularPromedio(finales:listaF; var sumaNotas:integer; var cantNotas:integer);
begin
	if(finales<>nil) then begin
		calcularPromedio(finales^.sig,sumaNotas,cantNotas);
		sumaNotas:=sumaNotas + finales^.dato.nota;
		cantNotas:=cantNotas+1;
	end
	else begin
		sumaNotas:=0;
		cantNotas:=0;
	end;
end;

//Busca el alumno con mayor promedio en todo el arbol y lo retorna en aluMax
procedure buscarAlumnoMayorPromedio(alumnos:arbolAlu; var aluMax:alumPromedio);
	//Busca el promedio maximo dentro de un alumno y compara con aluMax
	procedure promedioMaximo(alu:alumno; var maxPromAlu:alumPromedio);
	var
		promedio:real;
		sumaNotas,cantNotas:integer;
	begin
		calcularPromedio(alu.finales,sumaNotas,cantNotas);
		if(cantNotas>0) then begin
			promedio:=sumaNotas/cantNotas;	//evita dividir por 0
			//Si promedio calculado es mayor, asigna legajo y promedio en aluMax
			if(promedio>maxPromAlu.promedio) then begin
				maxPromAlu.legajo:=alu.legajo;
				maxPromAlu.promedio:=promedio;
			end;
		end;
	end;
begin
	//Recorre todo el arbol. Manda a analizar el dato de alumno de un nodo en cada pasada
	if(alumnos<>nil) then begin
		buscarAlumnoMayorPromedio(alumnos^.hi, aluMax);
		promedioMaximo(alumnos^.dato,aluMax);
		buscarAlumnoMayorPromedio(alumnos^.hd, aluMax);
	end;
end;
//Carga una lista con el legajo y promedio de los alumnos que superan el promedio ingresado
procedure retornarDatosPromedioAlumno(alumnos:arbolAlu; promedioRef:integer; var datosAlu:listaAP);
	//Compara el promedio referencia con el del alumno (calculado)
	procedure compararPromedio(alu:alumno; promedioRef:integer; var datosAlu:listaAP);
		//Agrega el legajo y promedio al registro del nodo en la lista
		procedure agregarNodo(var lisDatosAlu:listaAP; legajo:integer; prom:real);
		var
			nuevo:listaAP;
		begin
			new(nuevo);
			nuevo^.dato.legajo:=legajo;
			nuevo^.dato.promedio:=prom;
			nuevo^.sig:=lisDatosAlu;
			lisDatosAlu:=nuevo;
		end;
	var
		sumaNotas,cantNotas:integer;
		prom:real;
	begin
		calcularPromedio(alu.finales, sumaNotas, cantNotas);
		if(cantNotas>0) then begin 
			prom:=sumaNotas/cantNotas;
			if(prom>promedioRef) then agregarNodo(datosAlu,alu.legajo,prom);
		end;
	end;
begin
	if (alumnos<>nil) then begin
		retornarDatosPromedioAlumno(alumnos^.hi, promedioRef, datosAlu);
		compararPromedio(alumnos^.dato, promedioRef, datosAlu);
		retornarDatosPromedioAlumno(alumnos^.hd, promedioRef, datosAlu);
	end;
end;

procedure imprimirInfoAlumnos(infoAlumnos:listaAI);
begin
	if(infoAlumnos<>nil) then begin
		imprimirInfoAlumnos(infoAlumnos^.sig);
		writeln('Alumno: ');
		writeln('DNI: ',infoALumnos^.dato.dni);
		writeln('Ingreso: ',infoAlumnos^.dato.ingreso);
		writeln('*****************');
	end;
end;

procedure imprimirPromAlumnos(promAlumnos:listaAP);
begin
	if(promAlumnos<>nil) then begin
		imprimirPromAlumnos(promAlumnos^.sig);
		writeln('Alumno: ');
		writeln('Legajo: ',promAlumnos^.dato.legajo);
		writeln('Promedio: ',promAlumnos^.dato.promedio:1:2);
		writeln('*****************');
	end;
end;

var
	alumnos:arbolAlu;
	valorLegajo, maxDNI,cantLegajoImpar,valorPromedio:integer;
	infoAlumnos:listaAI;
	promAlumnos:listaAP;
	aluMaxPromedio:alumPromedio;
begin
	//Cargar arbol de alumnos
	alumnos:=nil;
	leerAlumnos(alumnos);
	//Retornar DNI y año ingreso de alumnos con legajo menor a "valor"
	infoAlumnos:=nil;
	write('Ingrese un valor de legajo: '); readln(valorLegajo);
	retornarInfoAlumnos(alumnos,valorLegajo,infoAlumnos);
	imprimirInfoAlumnos(infoAlumnos);
	writeln;
	//Retornar legajo mas grande
	writeln('El legajo mas grande es: ',buscarMayorLegajo(alumnos));
	writeln;
	//Retornar DNI mas grande
	maxDNI:=-1;
	buscarMayorDNI(alumnos,maxDNI);
	writeln('El DNI mas grande es: ',maxDNI);
	writeln;
	//Retornar cantidad de alumnos con legajo impar
	cantLegajoImpar:=0;
	buscarLegajosImpares(alumnos,cantLegajoImpar);
	writeln('La cantidad de alumnos con legajo impar es de: ',cantLegajoImpar);
	writeln;
	//Retornar legajo y promedio de alumno con mayor promedio
	aluMaxPromedio.promedio:=-1;
	buscarAlumnoMayorPromedio(alumnos,aluMaxPromedio);
	writeln('Alumno con mayor promedio: ');
	writeln('Legajo: ',aluMaxPromedio.legajo);
	writeln('Promedio: ',aluMaxPromedio.promedio:1:2);
	writeln;
	//Retornar legajos y promedios de alumno mayores a un valor ingresado
	promAlumnos:=nil;
	write('Ingrese un valor de promedio: '); readln(valorPromedio);
	retornarDatosPromedioAlumno(alumnos,valorPromedio,promAlumnos);
	imprimirPromAlumnos(promAlumnos);
end.
