{
El administrador de un edificio de oficinas, cuenta en papel, con la información del pago
de las expensas de dichas oficinas. Implementar un programa con:
a) Un módulo que retorne un vector, sin orden, con a lo sumo las 300 oficinas que
administra. Se debe leer, para cada oficina, el código de identificación, DNI del
propietario y valor de la expensa. La lectura finaliza cuando llega el código de
identificación -1.
b) Un módulo que reciba el vector retornado en a) y retorne dicho vector ordenado por
código de identificación de la oficina. Ordenar el vector aplicando uno de los métodos
vistos en la cursada.
c) Un módulo que realice una búsqueda dicotómica. Este módulo debe recibir el vector
generado en b) y un código de identificación de oficina. En el caso de encontrarlo, debe
retornar la posición del vector donde se encuentra y en caso contrario debe retornar 0.
Luego el programa debe informar el DNI del propietario o un cartel indicando que no
se encontró la oficina.
d) Un módulo recursivo que retorne el monto total de las expensas.
}
Program Pr5_ej1;
Const
	dimF=300;
Type
	oficina = record
		codigo:integer;
		DNIprop:integer;
		valor:real;
	end;
	vectorOficinas = Array[1..dimF]of oficina;

procedure leerRegistro(var registro:oficina);
begin
	writeln('Ingrese un codigo de oficina');
	readln(registro.codigo);
	if(registro.codigo<>-1)then
	begin
		writeln('Ingrese el DNI del propietario');
		readln(registro.DNIprop);
		writeln('Ingrese valor de las expensas');
		readln(registro.valor);
	end;
	writeln;
end;

procedure cargarVector(var oficinas:vectorOficinas;var dimL:integer);
var
	registro:oficina;
begin
	leerRegistro(registro);
	while(dimL < dimF)and(registro.codigo <> -1)do
	begin
		dimL:=dimL+1;
		oficinas[dimL]:=registro;
		leerRegistro(registro);
	end;
end;

procedure ordenarVector(var oficinas:vectorOficinas;dimL:integer);
var
	i:integer;
	j:integer;
	actual:oficina;
begin
	for i:=2 to dimL do
	begin
		actual:=oficinas[i];
		j:=i-1;
		while(j > 0)and(oficinas[j].codigo > actual.codigo)do
		begin
			oficinas[j+1]:=oficinas[j];
			j:=j-1;
		end;
		oficinas[j+1]:=actual;
	end;
end;

function buscarVector(oficinas:vectorOficinas;dimL:integer;codigoID:integer):integer;
var
	ini,med,ult:integer;
begin
	ini:=1;
	ult:=dimL;
	med:=(ini + ult) DIV 2;
	while(ini<=ult) and (oficinas[med].codigo<>codigoID) do begin
		if(codigoID>oficinas[med].codigo) then ini:=med+1
		else ult:=med-1;
		med:=(ini + ult) DIV 2
	end;
	if(ini<=ult) and (codigoID = oficinas[med].codigo) then buscarVector:=med
	else buscarVector:=0;
end;

function calcularTotalExpensas(oficinas:vectorOficinas; dimL:integer):real;
begin
	if(dimL>=1) then
		calcularTotalExpensas:=oficinas[dimL].valor + calcularTotalExpensas(oficinas,dimL-1)
	else calcularTotalExpensas:=0;
end;

var
	oficinas:vectorOficinas;
	dimL,codigoID,posOficina:integer;
	totalExpensas:real;
begin
	dimL:=0;
	cargarVector(oficinas,dimL);
	ordenarVector(oficinas,dimL);
	
	writeln('Ingrese un codigo de oficina a buscar: ');
	readln(codigoID);
	posOficina:=buscarVector(oficinas,dimL,codigoID);
	if(posOficina<>0) then writeln('El DNI del propietario es: ',oficinas[posOficina].DNIprop)
	else writeln('No se encontro la oficina');
	
	totalExpensas:=calcularTotalExpensas(oficinas,dimL);
end.
