{Una agencia dedicada a la venta de autos ha organizado su stock y, dispone en papel de la
información de los autos en venta. Implementar un programa que:
a) Lea la información de los autos (patente, año de fabricación (2010..2018), marca y
modelo) y los almacene en dos estructuras de datos:
i. Una estructura eficiente para la búsqueda por patente.
ii. Una estructura eficiente para la búsqueda por marca. Para cada marca se deben
almacenar todos juntos los autos pertenecientes a ella.
b) Invoque a un módulo que reciba la estructura generado en a) i y una marca y retorne la
cantidad de autos de dicha marca que posee la agencia.
c) Invoque a un módulo que reciba la estructura generado en a) ii y una marca y retorne
la cantidad de autos de dicha marca que posee la agencia.
d) Invoque a un módulo que reciba el árbol generado en a) i y retorne una estructura con
la información de los autos agrupados por año de fabricación.
e) Invoque a un módulo que reciba el árbol generado en a) i y una patente y devuelva el
modelo del auto con dicha patente.
f) Invoque a un módulo que reciba el árbol generado en a) ii y una patente y devuelva el
modelo del auto con dicha patente.}

program Pr5_ej2;
const
	df=2018;
type
	subrangoFabricacion=2010..2018;
	
	auto=record
		patente:string;
		anioFabricacion:subrangoFabricacion;
		marca:string;
		modelo:string;
	end;
	
	arbolPorPatente=^nodoPorPatente;
	nodoPorPatente=record
		dato:auto;
		hi:arbolPorPatente;
		hd:arbolPorPatente;
	end;
	
	listaAutos=^nodoAutos;
	nodoAutos=record
		dato:auto;
		sig:listaAutos;
	end;
	arbolPorMarca=^nodoPorMarca;
	nodoPorMarca=record
		dato:listaAutos;
		hi:arbolPorMarca;
		hd:arbolPorMarca;
	end;
	
	vectorAutosPorFabricacion=array[subrangoFabricacion] of listaAutos;
	
procedure leerAuto(var regAuto:auto);
begin
	writeln('Patente: '); readln(regAuto.patente);
	if (regAuto.patente<>'zzz') then begin
		writeln('A;o de fabricacion: '); readln(regAuto.anioFabricacion);
		writeln('Marca: '); readln(regAuto.marca);
		writeln('Modelo '); readln(regAuto.modelo);
	end;
	writeln;
end;

procedure crearAutoPorPatente(var autosPorPatente:arbolPorPatente; vehiculo:auto);
begin
	if(autosPorPatente=nil) then begin
		new(autosPorPatente);
		autosPorPatente^.dato:=vehiculo;
		autosPorPatente^.hi:=nil;
		autosPorPatente^.hd:=nil;
	end
	else
		if(vehiculo.patente<=autosPorPatente^.dato.patente) then
			crearAutoPorPatente(autosPorPatente^.hi,vehiculo)
		else crearAutoPorPatente(autosPorPatente^.hd,vehiculo);
end;

procedure crearAutoPorMarca(var autosPorMarca:arbolPorMarca; vehiculo:auto; var nodoActual:arbolPorMarca);
begin
	if(autosPorMarca=nil) then begin
		new(autosPorMarca);
		autosPorMarca^.dato:=nil;
		autosPorMarca^.hi:=nil;
		autosPorMarca^.hd:=nil;
		nodoActual:=autosPorMarca;	//me guardo nodo actual, para agregar
	end
	else
		if(vehiculo.marca=autosPorMarca^.dato^.dato.marca) then nodoActual:=autosPorMarca	//me guardo nodo actual, para actualizar
		else if (vehiculo.marca<=autosPorMarca^.dato^.dato.marca) then 
			crearAutoPorMarca(autosPorMarca^.hi, vehiculo, nodoActual)
		else crearAutoPorMarca(autosPorMarca^.hd, vehiculo, nodoActual);
end;

procedure actualizarAutoPorMarca(nodoTomado:arbolPorMarca; vehiculo:auto);
var
	nuevo:listaAutos;
begin
	new(nuevo);
	nuevo^.dato:=vehiculo;
	nuevo^.sig:=nodoTomado^.dato;
	nodoTomado^.dato:=nuevo;
end;

procedure cargarArbolesAutos(var autosPorPatente:arbolPorPatente; var autosPorMarca:arbolPorMarca);
var
	regAuto:auto;
	nodoAutoPorMarca:arbolPorMarca;
begin
	leerAuto(regAuto);
	while(regAuto.patente<>'zzz') do begin
		crearAutoPorPatente(autosPorPatente,regAuto);	//Crea nodo con registro auto en arbol por patente
		crearAutoPorMarca(autosPorMarca,regAuto,nodoAutoPorMarca);	//Busca nodo por marca ya existente o lo crea y devuelve el nodo 
		actualizarAutoPorMarca(nodoAutoPorMarca, regAuto);	//Agrega el auto al nodo (ya sea una lista vacía o con elementos)
		leerAuto(regAuto);
	end;
end;

procedure imprimirAutosPorPatente(autosPorPatente:arbolPorPatente);
begin
	if(autosPorPatente<>nil) then begin
		writeln('Patente: ',autosPorPatente^.dato.patente);
		imprimirAutosPorPatente(autosPorPatente^.hi);
		imprimirAutosPorPatente(autosPorPatente^.hd);
	end;
end;

procedure imprimirAutosPorMarca(autosPorMarca:arbolPorMarca);
	procedure imprimirListaAutos(lisAutos:listaAutos);
	begin
		if(lisAutos<>nil) then begin
			imprimirListaAutos(lisAutos^.sig);
			writeln(lisAutos^.dato.patente);
		end;
	end;
begin
	if(autosPorMarca<>nil) then begin
		writeln('Marca: ',autosPorMarca^.dato^.dato.marca);
		imprimirListaAutos(autosPorMarca^.dato);
		writeln;
		imprimirAutosPorMarca(autosPorMarca^.hi);
		imprimirAutosPorMarca(autosPorMarca^.hd);
	end;
end;

procedure contarCantidadAutosParaMarcaA(autosPorPatente:arbolPorPatente; marcaLeida:string; var cantAutos:integer);
begin
	if(autosPorPatente<>nil) then begin
		if(autosPorPatente^.dato.marca=marcaLeida) then cantAutos:=cantAutos+1;
		contarCantidadAutosParaMarcaA(autosPorPatente^.hi, marcaLeida, cantAutos);
		contarCantidadAutosParaMarcaA(autosPorPatente^.hd, marcaLeida, cantAutos);
	end;
end;

procedure contarCantidadAutosParaMarcaB(autosPorMarca:arbolPorMarca; marcaLeida:string; var cantAutos:integer);
	procedure contarMarcasLista(lisMarcas:listaAutos; var cantAutos:integer);
	begin
		if(lisMarcas<>nil) then begin
			cantAutos:=cantAutos+1;
			contarMarcasLista(lisMarcas^.sig, cantAutos);
		end;
	end;
begin
	if(autosPorMarca<>nil) then begin
		if(marcaLeida=autosPorMarca^.dato^.dato.marca) then contarMarcasLista(autosPorMarca^.dato, cantAutos)
		else 
			if (marcaLeida<autosPorMarca^.dato^.dato.marca) then contarCantidadAutosParaMarcaB(autosPorMarca^.hi, marcaLeida, cantAutos)
			else contarCantidadAutosParaMarcaB(autosPorMarca^.hd, marcaLeida, cantAutos);
	end;
end;

procedure inicializarVectorAutos(var vecAutos:vectorAutosPorFabricacion);
var
	i:subrangoFabricacion;
begin
	for i:=2010 to df do
		vecAutos[i]:=nil;
end;

procedure agruparAutosPorAnioFabricacion(autosPorPatente:arbolPorPatente; var vecAutosPorFabricacion:vectorAutosPorFabricacion);
	procedure agregarAutoVector(var lisAuto:listaAutos; vehiculo:auto);
	var
		nuevo:listaAutos;
	begin
		new(nuevo);
		nuevo^.dato:=vehiculo;
		nuevo^.sig:=lisAuto;
		lisAuto:=nuevo;
	end;
begin
	if(autosPorPatente<>nil) then begin
		agregarAutoVector(vecAutosPorFabricacion[autosPorPatente^.dato.anioFabricacion], autosPorPatente^.dato);
		agruparAutosPorAnioFabricacion(autosPorPatente^.hi, vecAutosPorFabricacion);
		agruparAutosPorAnioFabricacion(autosPorPatente^.hd, vecAutosPorFabricacion);
		
	end;
end;

procedure imprimirVectorAutosPorFabricacion(autosPorFabricacion:vectorAutosPorFabricacion);
	procedure imprimirListaAutos(lisAutos:listaAutos);
	begin
		while(lisAutos<>nil) do begin
			writeln('Fabricacion: ',lisAutos^.dato.anioFabricacion);
			writeln('Patente: ',lisAutos^.dato.patente);
			lisAutos:=lisAutos^.sig;
		end;
	end;
var
	h:subrangoFabricacion;
begin
	for h:=2010 to df do begin
		if(autosPorFabricacion[h]<>nil) then begin
			imprimirListaAutos(autosPorFabricacion[h]);
			writeln;
		end;
	end;
end;

procedure retornarModeloAutoParaPatenteA(autosPorPatente:arbolPorPatente; patenteLeida:string; var modeloRetornado:string);
begin
	if(autosPorPatente<>nil) then begin
		if(patenteLeida=autosPorPatente^.dato.patente) then modeloRetornado:=autosPorPatente^.dato.modelo
		else
			if(patenteLeida<autosPorPatente^.dato.patente) then
				retornarModeloAutoParaPatenteA(autosPorPatente^.hi, patenteLeida, modeloRetornado)
			else retornarModeloAutoParaPatenteA(autosPorPatente^.hd, patenteLeida, modeloRetornado)
	end
	else modeloRetornado:='zzz';
end;

procedure retornarModeloAutoParaPatenteB(autosPorMarca:arbolPorMarca; patenteLeida:string; var modeloRetornado:string);
	procedure recorrerListaPorMarca(lisAutos:listaAutos; patenteLeida:string; var modeloRetornado:string; var continuar:boolean);
	begin
		while(lisAutos<>nil) and (continuar) do begin
			if(patenteLeida=lisAutos^.dato.patente) then begin
				modeloRetornado:=lisAutos^.dato.modelo;
				continuar:=false;
			end;
			lisAutos:=lisAutos^.sig;
		end;
	end;
	
	procedure recorrerArbolPorMarca(autosPorMarca:arbolPorMarca; patenteLeida:string; var modeloRetornado:string; var continuar:boolean);
	begin
		if(autosPorMarca<>nil) and (continuar) then begin
			recorrerListaPorMarca(autosPorMarca^.dato, patenteLeida, modeloRetornado, continuar);
			recorrerArbolPorMarca(autosPorMarca^.hi, patenteLeida, modeloRetornado, continuar);
			recorrerArbolPorMarca(autosPorMarca^.hd, patenteLeida, modeloRetornado, continuar);
		end;
	end;
var
	continuar:boolean;
begin
	continuar:=true;
	recorrerArbolPorMarca(autosPorMarca, patenteLeida, modeloRetornado, continuar);
	if(continuar) then modeloRetornado:='zzz';
end;

var
	autosPorPatente:arbolPorPatente;
	autosPorMarca:arbolPorMarca;
	cantAutoMarcaA, cantAutoMarcaB:integer;
	marcaLeida,patenteLeida,modeloRetornadoA,modeloRetornadoB:string;
	autosPorFabricacion:vectorAutosPorFabricacion;
begin
	autosPorPatente:=nil;
	autosPorMarca:=nil;
	cargarArbolesAutos(autosPorPatente,autosPorMarca);
	
	writeln;
	writeln;
	
	//imprimirAutosPorPatente(autosPorPatente);
	
	writeln;
	writeln;
	
	//imprimirAutosPorMarca(autosPorMarca);
	
	cantAutoMarcaA:=0;
	write('Ingrese una marca de auto: '); readln(marcaLeida);
	contarCantidadAutosParaMarcaA(autosPorPatente,marcaLeida,cantAutoMarcaA);
	//writeln('Cantidad de autos de la marca ',marcaLeida,': ',cantAutoMarcaA);
	
	cantAutoMarcaB:=0;
	contarCantidadAutosParaMarcaB(autosPorMarca,marcaLeida,cantAutoMarcaB);
	//writeln('Cantidad de autos de la marca ',marcaLeida,': ',cantAutoMarcaB);
	
	inicializarVectorAutos(autosPorFabricacion);
	agruparAutosPorAnioFabricacion(autosPorPatente, autosPorFabricacion);
	//imprimirVectorAutosPorFabricacion(autosPorFabricacion);
	
	write('Ingrese una patente de auto: '); readln(patenteLeida);
	retornarModeloAutoParaPatenteA(autosPorPatente, patenteLeida, modeloRetornadoA);
	{if(modeloRetornadoA <>'zzz') then writeln('El modelo correspondiente a la patente ',patenteLeida,' es: ',modeloRetornadoA)
	else writeln('No se ha encontrado la patente pedida');}
	
	retornarModeloAutoParaPatenteB(autosPorMarca, patenteLeida, modeloRetornadoB);
	{if(modeloRetornadoB <>'zzz') then writeln('El modelo correspondiente a la patente ',patenteLeida,' es: ',modeloRetornadoB)
	else writeln('No se ha encontrado la patente pedida');}
end.
