program ej2;
const
	zonas=2;
	precioCorte=-1;
type
	rangoZonas=1..zonas;
	
	propiedad=record
		codigo:integer;
		tipo:string;
		precio:real;
	end;
	
	listaP=^nodoP;
	nodoP=record
		dato:propiedad;
		sig:listaP;
	end;
	
	listaCod=^nodoCod;
	nodoCod=record
		dato:integer;
		sig:listaCod;
	end;
	
	vectorPropiedades=array[1..zonas] of listaP;

procedure crearListas(var v:vectorPropiedades);
var
	h:rangoZonas;
begin
	for h:=1 to zonas do
		v[h]:=nil;
end;

procedure leerRegistro(var reg:propiedad; var preM2:real; var pZona:rangoZonas);
var
	metCuadrados:real;
begin
	writeln('Precio por m2: '); readln(preM2);
	if(preM2<>precioCorte) then begin
		writeln('Codigo: '); readln(reg.codigo);
		writeln('Zona: '); readln(pZona);
		writeln('Tipo: '); readln(reg.tipo);
		writeln('Metros cuadrados: '); readln(metCuadrados);
		reg.precio:=metCuadrados*preM2;
	end;
	writeln('-------------------------');
end;

procedure insertarOrdenado(var pri:listaP; elem:propiedad);
var
	nuevo, actual, anterior: listaP;
begin
	new(nuevo);
	nuevo^.dato:=elem;
	nuevo^.sig:=nil;
	if(pri=nil) then pri:=nuevo
	else begin
		actual:=pri;
		while((actual<>nil) and (actual^.dato.tipo<>nuevo^.dato.tipo)) do begin
			anterior:=actual;
			actual:=actual^.sig;
		end;
		
		if(actual=pri) then begin
			nuevo^.sig:=pri;
			pri:=nuevo;
		end
		else begin
			anterior^.sig:=nuevo;
			nuevo^.sig:=actual;
		end;
	end;
end;

procedure leerPropiedades(var vecProp:vectorPropiedades);
var
	regProp:propiedad;
	preciom2:real;
	zona:rangoZonas;
begin
	crearListas(vecProp);
	
	leerRegistro(regProp,preciom2,zona);
	while(preciom2<>precioCorte) do begin
		insertarOrdenado(vecProp[zona],regProp);
		leerRegistro(regProp,preciom2,zona);
	end;
end;

procedure agregarAdelante(var l:listaCod; dato:integer);
var
	nuevo:listaCod;
begin
	new(nuevo);
	nuevo^.dato:=dato;
	nuevo^.sig:=l;
	l:=nuevo;
end;

procedure retornarCodigoyTipo(var codigos:listaCod; prop:vectorPropiedades; zona:rangoZonas; tipo:string);
begin
	codigos:=nil;
	while(prop[zona]<>nil) do begin
		if(prop[zona]^.dato.tipo=tipo) then agregarAdelante(codigos, prop[zona]^.dato.codigo);
		prop[zona]:=prop[zona]^.sig;
	end;		
end;


var
	propiedades:vectorPropiedades;
	codigosPropiedades:listaCod;
	zona:rangoZonas;
	tipo:string;
begin
	leerPropiedades(propiedades);
	
	writeln('Ingrese zona: '); readln(zona);
	writeln('Ingrese tipo: '); readln(tipo);
	retornarCodigoyTipo(codigosPropiedades,propiedades,zona,tipo);
end.

//Si tipo de propiedad se considera un entero, la busqueda por tipo en el modulo
//retornarCodigoyTipo puede hacerse de forma mas eficiente
