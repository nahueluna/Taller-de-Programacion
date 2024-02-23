program ej1;
type
	socio=record
		numero:integer;
		nombre:string;
		edad:integer;
	end;
	
	arbolS=^nodoS;
	nodoS=record
		dato:socio;
		hi:arbolS;
		hd:arbolS;
	end;
	
procedure leerSocios(var sociosArbol:arbolS);
	procedure leerRegistro(var reg:socio);
	begin
		write('Numero socio: '); readln(reg.numero);
		if(reg.numero<>0) then begin
			write('Nombre: '); readln(reg.nombre);
			write('Edad: '); readln(reg.edad);
		end;
		writeln;
	end;
	
	procedure agregarSocio(var arbol:arbolS; elemento:socio);
	begin
		if(arbol=nil) then begin
			new(arbol);
			arbol^.dato:=elemento;
			arbol^.hi:=nil;
			arbol^.hd:=nil;
		end
		else
			if(elemento.numero<=arbol^.dato.numero) then agregarSocio(arbol^.hi,elemento)
			else agregarSocio(arbol^.hd,elemento);
	end;

var
	regSocio:socio;
begin
	leerRegistro(regSocio);
	if(regSocio.numero<>0) then begin
		agregarSocio(sociosArbol,regSocio);
		leerSocios(sociosArbol);
	end;
end;

procedure imprimirArbol(socios:arbolS);	//imprime pre orden (orden que se ingresó desde izq)
begin
	if(socios<>nil) then begin
		writeln('- ',socios^.dato.numero);
		imprimirArbol(socios^.hi);
		imprimirArbol(socios^.hd);
	end;
end;

function buscarNumeroSocioMayor(socios:arbolS):integer;
	function max(x,y:integer):integer;
	begin
		if(x>y) then max:=x
		else max:=y;
	end;
	
begin
	if(socios<>nil) then 
		buscarNumeroSocioMayor:=max(socios^.dato.numero,buscarNumeroSocioMayor(socios^.hd))
	else buscarNumeroSocioMayor:=-1;
end;

procedure datosSocioNumeroChico(socios:arbolS);	//Se puede mejorar para que no guarde un minimo en cada pasada?
	procedure buscarSocioMinimo(arbol:arbolS; var min:socio);
	begin
		if(arbol^.hi<>nil) buscarSocioMinimo(arbol^.hi,min);
		else min:=arbol^.dato;
	end;

var
	minSocio:socio;
begin
	minSocio.numero:=9999;
	minSocio.nombre:='';
	minSocio.edad:=-1;
	if (socios<>nil) then BuscarSocioMinimo(socios,minSocio);
	writeln('Socio con menor numero: ');
	writeln('Nombre: ',minSocio.nombre);
	writeln('Edad: ',minSocio.edad);
	writeln('Numero: ',minSocio.numero);
end;

var
	socios:arbolS;
begin
	//Cargar arbol
	socios:=nil;
	leerSocios(socios);
	//Imprimir arbol
	imprimirArbol(socios);
	writeln;
	//Calcular numero de socio maximo
	writeln('El numero de socio mayor es: ',buscarNumeroSocioMayor(socios));
	writeln;
	//Datos de socio con numero mas chico
	datosSocioNumeroChico(socios);
end.
