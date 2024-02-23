program ej1;
const
	df=10;
type
	rangoDf=0..df;
	vectorCaracteres=array[1..df] of char;
	
	listaC=^nodoC;
	nodoC=record
		dato:char;
		sig:listaC;
	end;

procedure cargarVector(var vecChar:vectorCaracteres; var dl:rangoDf);
	procedure leerCaracteres(var vecChar:vectorCaracteres; var dl:rangoDf);
	var
		caracter:char;
	begin
		if(dl<df) then begin
			write('Ingrese un caracter: '); readln(caracter);
			if(caracter<>'.') then begin
				dl:=dl+1;
				vecChar[dl]:=caracter;
				leerCaracteres(vecChar,dl);
			end;
		end;
	end;
begin
	dl:=0;	//Inicializo antes de la recursión para que el valor no se pise
	leerCaracteres(vecChar,dl);
end;
	
procedure imprimirCaracteres(caracteres:vectorCaracteres; dl:rangoDf);
var
	i:rangoDf;
begin
	for i:=1 to dl do
		write(caracteres[i],' ');
end;
	
procedure imprimirCaracteres2(caracteres:vectorCaracteres; dl:rangoDf);
	procedure imprimirRecursivo(caracteres:vectorCaracteres; dl:rangoDf; var pos:rangoDf);
	begin
		if(pos<dl) then begin
			pos:=pos+1;
			write(caracteres[pos],' ');
			imprimirRecursivo(caracteres, dl, pos);
		end;
	end;
var
	pos:rangoDf;
begin
	pos:=0;
	imprimirRecursivo(caracteres, dl, pos);
end;

function contarCaracteres():integer;
var
	caracter:char;
begin
	write('Ingrese un caracter: '); readln(caracter);
	if(caracter<>'.') then contarCaracteres:= contarCaracteres() + 1
	else contarCaracteres:=0;
end;

procedure cargarLista(var lis:listaC);
var
	nuevo:listaC;
	caracter:char;
begin
	write('Ingrese un caracter: '); readln(caracter);
	if(caracter<>'.') then begin
		cargarLista(lis);	//Guarda en el orden que fueron leidos
		new(nuevo);
		nuevo^.dato:=caracter;
		nuevo^.sig:=lis;
		lis:=nuevo;
	end
	else lis:=nil;	//Debido al orden, el . se guarda primero, por lo que en la última recursión se inicializa en nil la lista
end;

procedure imprimirLista(lis:listaC);
begin
	if(lis<>nil) then begin
		write(lis^.dato,' ');
		lis:=lis^.sig;
		imprimirLista(lis);
	end;
end;

procedure imprimirListaInverso(lis:listaC);
	procedure imprimir(lis:listaC);
	begin
		if(lis^.sig<>nil) then begin
			lis:=lis^.sig;
			imprimir(lis);
			write(lis^.dato,' ');
		end;
	end;
begin
	if(lis<>nil) then begin
		imprimir(lis);
		write(lis^.dato);
	end;
end;
var
	caracteres:vectorCaracteres;
	dimL:rangoDf;
	listaCaracteres:listaC;
	contadorChar:integer;
begin
	//Leer caracteres y cargar vector
	cargarVector(caracteres, dimL);
	writeln;
	//Imprimir de forma iterativa
	imprimirCaracteres(caracteres,dimL);
	writeln;
	//Imprimir de forma recursiva
	imprimirCaracteres2(caracteres,dimL);
	writeln;
	//Informar cantidad caracteres leidos
	contadorChar:=contarCaracteres;
	write('Se han leido ', contadorChar,' caracteres');
	writeln;
	//Leer caracteres y cargar lista
	cargarLista(listaCaracteres);
	writeln;
	//Imprimir lista en el orden almacenado
	imprimirLista(listaCaracteres);
	writeln;
	//Imprimir lista en orden inverso al almacenado
	imprimirListaInverso(listaCaracteres);
end.
