program ej2;
type
	listaN=^nodoN;
	nodoN=record
		dato:integer;
		sig:listaN;
	end;

procedure leerNumeros(var numeros:listaN);
var
	num:integer;
	nuevo:listaN;
begin
	write('Ingrese un numero: '); readln(num);
	if(num<>0) then begin
		leerNumeros(numeros);
		new(nuevo);
		nuevo^.dato:=num;
		nuevo^.sig:=numeros;
		numeros:=nuevo
	end
	else numeros:=nil;
end;

procedure imprimirDigitos(numeros:listaN);
	procedure digitosNumero(valor:integer);
	var
		resto:integer;
	begin
		if(valor<>0) then begin	//valor=0 es el caso base
			resto:=valor MOD 10;
			digitosNumero(valor DIV 10);
			write(resto,' ');
		end;
	end;

begin
	if(numeros<>nil) then begin	//numeros=nil es el caso base
		writeln;
		digitosNumero(numeros^.dato);
		numeros:=numeros^.sig;
		imprimirDigitos(numeros);
	end;
end;

var
	numeros:listaN;
begin
	leerNumeros(numeros);
	writeln;
	imprimirDigitos(numeros);
end.
