program ej4;
const
	df=10;
type
	vectorEnteros=array[1..df] of integer;
	

procedure cargarVector(var enteros:vectorEnteros; var dl:integer);
	procedure asignarEnteros(var enteros:vectorEnteros; var dl:integer);
	begin
		if(dl<df) then begin
			dl:=dl+1;
			enteros[dl]:=random(99)+1;
			asignarEnteros(enteros, dl);
		end;
	end;
begin
	dl:=0;
	asignarEnteros(enteros, dl);
end;

function calcularMaximo(enteros:vectorEnteros; dl:integer):integer;
	function max(x,y:integer):integer;
	begin
		if(x>y) then max:=x
		else max:=y;
	end;
begin
	if(dl>0) and (dl<=df) then calcularMaximo:=max(enteros[dl],calcularMaximo(enteros,dl-1))
	else calcularMaximo:=-1;
end;

function calcularSuma(enteros:vectorEnteros; dl:integer):integer;
begin
	if(dl>0) and (dl<=df) then calcularSuma:=enteros[dl]+calcularSuma(enteros, dl-1)
	else calcularSuma:=0;
end;

procedure imprimirVector(enteros:vectorEnteros; dl:integer);
	procedure imprimir(enteros:vectorEnteros; dl:integer; pos:integer);
	begin
		if(pos<dl) then begin
			pos:=pos+1;
			writeln(enteros[pos]);
			imprimir(enteros,dl,pos);
		end;
	end;
var
	pos:integer;
begin
	pos:=0;
	writeln('Vector:');
	imprimir(enteros, dl, pos);
end;

var
	enteros:vectorEnteros;
	dimL:integer;
begin
	Randomize;
	cargarVector(enteros, dimL);
	writeln('El valor maximo es: ',calcularMaximo(enteros,dimL));
	writeln('La suma de valores del vector es: ',calcularSuma(enteros,dimL));
	imprimirVector(enteros, dimL);
end.
