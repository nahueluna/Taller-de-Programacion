program ej3;
Type
	Lista = ^nodo;
	nodo = record
		dato:integer;
		sig:Lista;
	end;
procedure cargarEnteros(var enteros:Lista);
var
	nue:Lista;
	num:integer;
begin
	num:=Random(100);
	if(num <> 0)then
	begin
		cargarEnteros(enteros);
		new(nue);
		nue^.dato:=num;
		nue^.sig:=enteros;
		enteros:=nue;
	end
	else
		enteros:=nil;
end;

function calcularMinimo(enteros:Lista):integer;
	function min(x,y:integer):integer;
	begin
		if (x<y) then min:=x
		else min:=y;
	end;
begin
	if(enteros<>nil) then
		calcularMinimo:=min(enteros^.dato,calcularMinimo(enteros^.sig))
	else
		calcularMinimo:=9999;
end;

function calcularMaximo(enteros:Lista):integer;
	function max(x,y:integer):integer;
	begin
		if(x>y) then max:=x
		else max:=y;
	end;
begin
	if(enteros<>nil) then
		calcularMaximo:=max(enteros^.dato,calcularMaximo(enteros^.sig))
	else
		calcularMaximo:=-1;
end;

function buscarValor(enteros:Lista; valor:integer):boolean;
begin
	if(enteros<>nil) then begin
		if(enteros^.dato=valor) then buscarValor:=true
		else buscarValor:=buscarValor(enteros^.sig,valor);
	end
	else buscarValor:=false;
end;
var
	enteros:Lista;
	valor:integer;
begin
	Randomize;
	cargarEnteros(enteros);
	calcularMinimo(enteros);
	writeln('El valor minimo es: ', calcularMinimo(enteros));
	writeln;
	writeln('El valor maximo es: ', calcularMaximo(enteros));
	writeln;
	write('Ingrese un valor a buscar: '); readln(valor);
	if(buscarValor(enteros, valor)) then writeln('El valor se ha encontrado')
	else writeln('El valor no se ha encontrado');
	while(enteros <> nil)do
	begin
		writeln(enteros^.dato);
		enteros:=enteros^.sig;
	end;
end.
