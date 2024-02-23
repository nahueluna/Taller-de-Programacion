program Practica1_ej2;
Const
	dimF=300;
Type
	oficina = record
		codigo:integer;
		dniPropietario:integer;
		valorExpensa:real;
	end;
	vector = Array[1..dimF] of oficina;

procedure leer(var o:oficina);
begin
	writeln('Ingrese codigo de oficina');
	readln(o.codigo);
	if(o.codigo<>-1)then
	begin
		writeln('Ingrese dni del propietario');
		readln(o.dniPropietario);
		writeln('Ingrese el valor de la expensa');
		readln(o.valorExpensa);
	end;
end;

procedure cargarOficinas(var oficinas:vector;var dimL:integer);
var
	o:oficina;
begin
	dimL:=0;
	leer(o);
	while(dimL<dimF)and(o.codigo <> -1)do
	begin
		dimL:=dimL+1;
		oficinas[dimL]:=o;
		leer(o);
	end;
end;

procedure ordenarInsercion(var ofi:vector; dL:integer);
var
	i,j:integer;
	actual:oficina;
begin
	for i:=2 to dL do begin
		actual:=ofi[i];
		j:=i-1;
		while(j>0) and (ofi[j].codigo>actual.codigo) do begin
			ofi[j+1]:=ofi[j];
			j:=j-1;
		end;
		ofi[j+1]:=actual;
	end;
end; 

procedure imprimirVectorOficinas(oficinas:vector;dimL:integer);
var
	i:integer;
begin
	for i:=1 to dimL do
	begin
		writeln(oficinas[i].codigo);
	end;
end;

procedure ordenarSeleccion(var oficinas:vector; dl:integer);
var
	i,j,pos:integer;
	aux:oficina;
begin
	for i:=1 to (dl-1) do begin
		pos:=i;
		for j:=i+1 to dl do begin
			if(oficinas[j].codigo<oficinas[pos].codigo) then pos:=j;
		end;
		
		aux:=oficinas[pos];
		oficinas[pos]:=oficinas[i];
		oficinas[i]:=aux;
	end;
end;

var
	oficinas:vector;
	dimL:integer;
begin
	cargarOficinas(oficinas,dimL);
	ordenarInsercion(oficinas,dimL);
	ordenarSeleccion(oficinas, dimL);
end.
