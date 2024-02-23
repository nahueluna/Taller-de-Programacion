{Una oficina requiere el procesamiento de los reclamos de las personas. De cada reclamo
se lee código, DNI de la persona, año y tipo de reclamo. La lectura finaliza con el código de
igual a -1. Se pide:
a) Un módulo que retorne estructura adecuada para la búsqueda por DNI. Para cada DNI
se deben tener almacenados cada reclamo y la cantidad total de reclamos que realizó.
b) Un módulo que reciba la estructura generada en a) y un DNI y retorne la cantidad de
reclamos efectuados por ese DNI.
c) Un módulo que reciba la estructura generada en a) y dos DNI y retorne la cantidad de
reclamos efectuados por todos los DNI comprendidos entre los dos DNI recibidos.
d) Un módulo que reciba la estructura generada en a) y un año y retorne los códigos de
los reclamos realizados en el año recibido.}

//registroA reclamo con codigo, dni, año, tipo reclamo (para lectura)
//RegistroB con codigo, anio y tipo reclamo (para almacenar)
//registroC con lista de reclamosB, dni y cantidad total de reclamos
//arbol con elementos tipo registroC, ordenado por dni

program ej4;
type
	//Registro para leer los reclamos. Luego se asignaran sus valores segun corresponda a los demas registros
	reclamoLectura=record
		codigo:integer;
		dni:integer;
		anio:integer;
		tipo:integer;
	end;
	//Registro con los datos de reclamo que serán almacenados en la lista
	reclamoAlmacenado=record
		codigo:integer;
		anio:integer;
		tipo:integer;
	end;
	//Lista para todos los reclamos de cada dni
	listaReclamos=^nodoReclamos;
	nodoReclamos=record
		dato:reclamoAlmacenado;
		sig:listaReclamos;
	end;
	//Registro con dni de la persona, la lista con todos sus reclamos y la cantidad de reclamos que hizo
	reclamosPersona=record
		dni:integer;
		reclamos:listaReclamos;
		cantidad:integer;
	end;
	//Arbol con reclamos de todas las personas, ordenado por DNI
	arbolReclamos=^nodoArbolReclamos;
	nodoArbolReclamos=record
		dato:reclamosPersona;
		hi:arbolReclamos;
		hd:arbolReclamos;
	end;
	//Lista con los codigos de reclamo para inciso d)
	listaCodigoReclamo=^nodoCodigoReclamo;
	nodoCodigoReclamo=record
		dato:integer;
		sig:listaCodigoReclamo;
	end;
//Leo registro de reclamo de lectura
procedure leerReclamo(var regReclamo:reclamoLectura);
begin
	writeln('Codigo: '); readln(regReclamo.codigo);
	if(regReclamo.codigo <> -1) then begin
		writeln('DNI: '); readln(regReclamo.dni);
		writeln('A;o: '); readln(regReclamo.anio);
		writeln('Tipo: '); readln(regReclamo.tipo);
	end;
	writeln;
end;
//Agrego el reclamo al árbol. Si no existe, creo el nodo y me lo guardo. Si ya existe, me guardo nodo actual para luego actualizar reclamos
procedure agregarArbolReclamos(var reclamos:arbolReclamos; var nodoTomado:arbolReclamos; regReclamo:reclamoLectura);
	procedure crearReclamo(nodoReclamo:arbolReclamos; regReclamo:reclamoLectura);
	begin
		nodoReclamo^.dato.dni:=regReclamo.dni;
		nodoReclamo^.dato.reclamos:=nil;
		nodoReclamo^.dato.cantidad:=0;
	end;
begin
	if(reclamos=nil) then begin
		new(reclamos);
		crearReclamo(reclamos, regReclamo);
		reclamos^.hi:=nil;
		reclamos^.hd:=nil;
		nodoTomado:=reclamos;
	end
	else
		if(regReclamo.dni = reclamos^.dato.dni) then nodoTomado:=reclamos
		else if(regReclamo.dni < reclamos^.dato.dni) then agregarArbolReclamos(reclamos^.hi, nodoTomado, regReclamo)
		else agregarArbolReclamos(reclamos^.hd, nodoTomado, regReclamo);
end;
//Agrego a la lista de reclamos el reclamo leído (ya sea que esté vacía o no) y sumo 1 la cantidad de reclamos
procedure actualizarReclamosPersona(nodoArbol:arbolReclamos; regReclamo:reclamoLectura);
	procedure armarReclamo(var reclamoGuardado:reclamoAlmacenado; datosReclamo:reclamoLectura);
	begin
		reclamoGuardado.codigo:= datosReclamo.codigo;
		reclamoGuardado.anio:= datosReclamo.anio;
		reclamoGuardado.tipo:= datosReclamo.tipo;
	end;
	
	procedure actualizarListaReclamos(var lisReclamos:listaReclamos; datosReclamo:reclamoLectura); 
	var
		nuevo:listaReclamos;
	begin
		new(nuevo);
		armarReclamo(nuevo^.dato, datosReclamo);
		nuevo^.sig:=lisReclamos;
		lisReclamos:=nuevo;
	end;
	
begin
	actualizarListaReclamos(nodoArbol^.dato.reclamos, regReclamo);
	nodoArbol^.dato.cantidad:= nodoArbol^.dato.cantidad + 1;
end;
//Cargo la información de todos los reclamos, ordenado por DNI
procedure cargarReclamos(var reclamos:arbolReclamos);
var
	regReclamo:reclamoLectura;
	nodoActualizar:arbolReclamos;
begin
	leerReclamo(regReclamo);
	while(regReclamo.codigo<>-1) do begin
		agregarArbolReclamos(reclamos, nodoActualizar, regReclamo);	//Hallo nodo donde debe ir la información
		actualizarReclamosPersona(nodoActualizar, regReclamo);	//Asigno la información al nodo correspondiente
		leerReclamo(regReclamo);
	end;
end;
//Devuelvo cantidad de reclamos de un determiando DNI. Lo busco en el árbol y asigno campo cantidad de reclamos. Si no existe el dni, cantidad es 0
function retornarCantidadReclamosDni(reclamos:arbolReclamos; dniLeido:integer):integer;
begin
	if(reclamos<>nil) then begin
		if(dniLeido = reclamos^.dato.dni) then retornarCantidadReclamosDni:= reclamos^.dato.cantidad
		else
			if(dniLeido < reclamos^.dato.dni) then 
				retornarCantidadReclamosDni:=retornarCantidadReclamosDni(reclamos^.hi, dniLeido)
			else retornarCantidadReclamosDni:= retornarCantidadReclamosDni(reclamos^.hd, dniLeido);
	end
	else retornarCantidadReclamosDni:=0;
end;	
//Recorro el arbol buscando DNI entre rangoA y rangoB de valores de DNI. En caso de coincidir el rango, sumo la cantidad de reclamos que tengo con las del actual nodo
procedure retornarCantidadReclamosRangoDni(reclamos:arbolReclamos; dniA,dniB:integer; var cantReclamosTotal:integer);
begin
	if(reclamos<>nil) then begin
		if(reclamos^.dato.dni >= dniA) and (reclamos^.dato.dni <= dniB) then begin
			cantReclamosTotal:= cantReclamosTotal + reclamos^.dato.cantidad;
			retornarCantidadReclamosRangoDni(reclamos^.hi, dniA, dniB, cantReclamosTotal);
			retornarCantidadReclamosRangoDni(reclamos^.hd, dniA, dniB, cantReclamosTotal);
		end
		else
			if(reclamos^.dato.dni < dniA) then 
				retornarCantidadReclamosRangoDni(reclamos^.hd, dniA, dniB, cantReclamosTotal)
			else retornarCantidadReclamosRangoDni(reclamos^.hi, dniA, dniB, cantReclamosTotal);
	end;
end;
{Recorro todo el árbol (no me sirve la ordenación del mismo) y, por cada nodo, recorro toda su lista de reclamos evaluando si el año coincide con el leido.
Si es asi, agrego ese codigo de reclamo a una lista de codigos de reclamo correspondiente al año leido}
procedure retornarCodigosReclamosPorAnio(reclamos:arbolReclamos; anioLeido:integer; var lisCodigos:listaCodigoReclamo);
	procedure agregarCodigoReclamo(var lisCodigos:listaCodigoReclamo; codigo:integer);
	var
		nuevo:listaCodigoReclamo;
	begin
		new(nuevo);
		nuevo^.dato:=codigo;
		nuevo^.sig:=lisCodigos;
		lisCodigos:=nuevo;
	end;
	
	procedure evaluarAnioReclamos(lisReclamos:listaReclamos; anioLeido:integer; var lisCodigos:listaCodigoReclamo);
	begin
		while(lisReclamos<>nil) do begin
			if(lisReclamos^.dato.anio = anioLeido) then agregarCodigoReclamo(lisCodigos, lisReclamos^.dato.codigo);
			lisReclamos:=lisReclamos^.sig;
		end;
	end;

begin
	if(reclamos<>nil) then begin
		evaluarAnioReclamos(reclamos^.dato.reclamos, anioLeido, lisCodigos);
		retornarCodigosReclamosPorAnio(reclamos^.hi, anioLeido, lisCodigos);
		retornarCodigosReclamosPorAnio(reclamos^.hd, anioLeido, lisCodigos);
	end;
end;

var
	reclamos:arbolReclamos;
	dniLeido, cantReclamosDniA, cantReclamosDniB, dniA, dniB, anioLeido:integer;
	codigosReclamosPorAnio:listaCodigoReclamo;
begin
	reclamos:=nil;
	cargarReclamos(reclamos);

	write('Ingrese un DNI: '); readln(dniLeido);
	cantReclamosDniA:=retornarCantidadReclamosDni(reclamos, dniLeido);	//Reclamos del DNI leido

	cantReclamosDniB:=0;
	write('Ingrese el DNI minimo: '); readln(dniA);
	write('Ingrese el DNI maximo: '); readln(dniB);
	retornarCantidadReclamosRangoDni(reclamos, dniA, dniB, cantReclamosDniB);	//Reclamos de todos los DNIs entre el rango de valores
	
	codigosReclamosPorAnio:=nil;
	write('Ingrese un a;o: '); readln(anioLeido);
	retornarCodigosReclamosPorAnio(reclamos, anioLeido, codigosReclamosPorAnio);	//Codigos de aquellos reclamos pertenecientes al año leído
end.
