program ej5;
const
	df=10;
type
	vectorEnteros=array[1..df] of integer;
	
procedure cargarVector(var enteros:vectorEnteros; var dl:integer);
	procedure asignarNumeros(var enteros:vectorEnteros; var dl:integer);
	begin
		if(dl<df) then begin
			dl:=dl+1;
			enteros[dl]:=random(100)+1;
			asignarNumeros(enteros, dl);
		end;
	end;
begin
	dl:=0;
	asignarNumeros(enteros,dl);
end;

procedure ordenarVector(var enteros:vectorEnteros; dl:integer);
	procedure reasignacionSecundaria(var enteros:vectorEnteros; actual:integer; var j:integer);
	begin
		if(j>0) and (enteros[j]>actual) then begin
			enteros[j+1]:=enteros[j];
			j:=j-1;
			reasignacionSecundaria(enteros,actual,j);
		end;
	end;
	
	procedure reasignacionPrincipal(var enteros:vectorEnteros; dl:integer; i:integer);
	var
		j,actual:integer;
	begin
		if(i<=dl) then begin
			actual:=enteros[i];
			j:=i-1;
			reasignacionSecundaria(enteros,actual,j);	//bucle while j<0
			enteros[j+1]:=actual;
			ReasignacionPrincipal(enteros, dl, i+1);
		end;
	end;
var
	i:integer;
begin
	i:=2;
	reasignacionPrincipal(enteros, dl, i);	//bucle for i:=2
end;

procedure busquedaDicotomica(v:vectorEnteros; ini,fin:integer; dato:integer; var pos:integer);
	procedure bucleBusqueda(v:vectorEnteros; ini,fin:integer; dato:integer; var med:integer);
	begin
		med:=(ini+fin) DIV 2;
		if(ini<=fin) and (dato<>v[med]) then begin
			if(dato>v[med]) then ini:=med+1
			else fin:=med-1;
			bucleBusqueda(v,ini,fin,dato,med);
		end;
	end;
var
	med:integer;
begin
	bucleBusqueda(v,ini,fin,dato,med);
	if(ini<=fin) and (dato=v[med]) then pos:=med
	else pos:=-1;
end;

procedure imprimirVector(v:vectorEnteros; dl:integer);
	procedure imprimir(v:vectorEnteros;m:integer;dl:integer);
	begin
		if(m<dl) then begin
			m:=m+1;
			writeln(v[m]);
			imprimir(v,m,dl);
		end;
	end;
var
	m:integer;
begin
	m:=0;
	imprimir(v,m,dl);
end;

var
	enteros:vectorEnteros;
	dimL,valor,pos:integer;
begin
	Randomize;
	cargarVector(enteros, dimL);
	ordenarVector(enteros, dimL);
	write('Ingrese valor a buscar: '); readln(valor);
	busquedaDicotomica(enteros,1,dimL,valor,pos);
	writeln('Vector:');
	imprimirVector(enteros,dimL);
	writeln;
	if(pos<>-1) then writeln('El valor estaba en la posicion ',pos)
	else writeln('El valor no estaba en el vector');
	
end.
