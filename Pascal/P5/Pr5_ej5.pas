{Una oficina requiere el procesamiento de los reclamos de las personas. De cada reclamo
se lee código, DNI de la persona, año y tipo de reclamo. La lectura finaliza con el código de
igual a -1. Se pide:
a) Un módulo que retorne estructura adecuada para la búsqueda por DNI. Para cada DNI
se deben tener almacenados cada reclamo y la cantidad total de reclamos que realizó.

Realizar el punto a) del ejercicio anterior, pero sabiendo que todos los reclamos de un
mismo DNI se leen de forma consecutiva (no significa que vengan ordenados los DNI).}

program Pr5_ej5;
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
//Leo los datos del reclamo y asigno al registro de lectura
procedure leerReclamo(var regReclamo:reclamoLectura);
begin
	writeln('Codigo: '); readln(regReclamo.codigo);
	if(regReclamo.codigo<>-1) then begin
		writeln('DNI: '); readln(regReclamo.dni);
		writeln('A;o: '); readln(regReclamo.anio);
		writeln('Tipo: '); readln(regReclamo.tipo);
	end;
	writeln;
end;
//Creo e inicializado los datos del nodo donde iré cargando los reclamos, en el corte de control
procedure crearNodoActual(var nodoArbol:arbolReclamos; dni:integer);
begin
	new(nodoArbol);
	nodoArbol^.dato.dni:=dni;
	nodoArbol^.dato.reclamos:=nil;
	nodoArbol^.dato.cantidad:=0;
	nodoArbol^.hi:=nil;
	nodoArbol^.hd:=nil;
end;
//Cada reclamo leído es agregado al nodo actual del corte de control. Se agregan reclamos a la lista y actualiza cantidad de reclamos
procedure agregarReclamosNodoActual(var reclamoIndividuo:reclamosPersona; regReclamo:reclamoLectura);
	procedure actualizarListaReclamos(lisReclamos:listaReclamos; datosReclamo:reclamoLectura);
	var
		nuevo:listaReclamos;
	begin
		new(nuevo);
		nuevo^.dato.codigo:= datosReclamo.codigo;
		nuevo^.dato.anio:= datosReclamo.anio;
		nuevo^.dato.tipo:= datosReclamo.tipo;
		nuevo^.sig:=lisReclamos;
		lisReclamos:=nuevo;
	end;
begin
	actualizarListaReclamos(reclamoIndividuo.reclamos, regReclamo);
	reclamoIndividuo.cantidad:= reclamoIndividuo.cantidad + 1;
end;
//Agrego el nodo con todos los reclamos de un dni al arbol, una vez que termino el corte de control (lei dni distinto)
procedure agregarArbolReclamos(var reclamos:arbolReclamos; nodoParaAgregar:arbolReclamos);
begin
	if(reclamos=nil) then begin
		reclamos:=nodoParaAgregar;
	end
	else
		{Jamas seran iguales ya que se ingresan todos los reclamos de un dni y luego se agregan juntos, 
		asi que ningun dni agregado coincidira con el que se agregará}
		if(nodoParaAgregar^.dato.dni < reclamos^.dato.dni) then agregarArbolReclamos(reclamos^.hi, nodoParaAgregar)
		else agregarArbolReclamos(reclamos^.hd, nodoParaAgregar);
end;
//Cargo todos los reclamos 
procedure cargarReclamos(var reclamos:arbolReclamos);
var
	regReclamo:reclamoLectura;
	dniActual:integer;
	nodoActual:arbolReclamos;
begin
	leerReclamo(regReclamo);
	while(regReclamo.codigo<>-1) do begin
		dniActual:=regReclamo.dni;	//Me guardo el DNI leido para el corte de control
		crearNodoActual(nodoActual,regReclamo.dni);
		while(regReclamo.codigo<>-1) and (regReclamo.dni = dniActual) do begin	//Mientras el DNI sea el mismo, agrego los reclamos de este
			agregarReclamosNodoActual(nodoActual^.dato, regReclamo);
			leerReclamo(regReclamo);
		end;
		agregarArbolReclamos(reclamos, nodoActual);	//Al cambiar de DNI, agrego el nodo generado con todos los reclamos del anterior DNI
	end;
end;
	
procedure imprimirArbol(reclamos:arbolReclamos);
	procedure imprimirReclamos(reclamoPers:reclamosPersona);
	begin
		writeln('DNI: ',reclamoPers.dni);
		writeln('Cantidad reclamos: ',reclamoPers.cantidad);
		writeln;
		while(reclamoPers.reclamos<>nil) do begin
			writeln('Codigo reclamo: ',reclamoPers.reclamos^.dato.codigo);
			reclamoPers.reclamos:=reclamoPers.reclamos^.sig;
		end;
		writeln('----------');
	end;
begin
	if(reclamos<>nil) then begin
		imprimirReclamos(reclamos^.dato);
		imprimirArbol(reclamos^.hi);
		imprimirArbol(reclamos^.hd);
	end;
end;
	
var
	reclamos:arbolReclamos;
begin
	reclamos:=nil;
	cargarReclamos(reclamos);
	writeln;
	writeln;
	
	imprimirArbol(reclamos);
end.
