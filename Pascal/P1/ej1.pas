program ej1;
const
	maximasVentas=50;
type
	rangoVentas=0..maximasVentas;
	rangoDia=0..31;
	rangoCodigo=1..15;
	rangoCantidad=0..99;
	
	venta=record
		dia:rangoDia;
		codigo:rangoCodigo;
		cantidad:rangoCantidad;
	end;
	
	vectorVentas=array[1..maximasVentas] of venta;

procedure leerRegistro(var reg:venta; dl:rangoVentas);
begin
	Randomize;
	if(dl<maximasVentas) then begin
		writeln('Dia: '); readln(reg.dia);
		if(reg.dia<>0) then begin
			writeln('Cantidad vendida: '); readln(reg.cantidad);
			reg.codigo:=random(15)+1;
		end;
		writeln('............');
	end;
end;

procedure leerVentas(var vec:vectorVentas; var dl:rangoVentas);
var
	regVenta:venta;
begin
	dl:=0;
	leerRegistro(regVenta,dl);
	while (dl<maximasVentas) and (regVenta.dia<>0) do begin
		dl:=dl+1;
		vec[dl]:=regVenta;
		leerRegistro(regVenta,dl);
	end;
end;

procedure imprimirVector(veVentas:vectorVentas; dLog:rangoVentas);
var
	i:rangoVentas;
begin
	for i:=1 to dLog do begin
		writeln('Dia: ', veVentas[i].dia);
		writeln('Codigo: ', veVentas[i].codigo);
		writeln('Cantidad vendida: ', veVentas[i].cantidad);
		writeln('-----------------');
	end;
end;

procedure ordenarVector(var v:vectorVentas; dl:rangoVentas);
var
	i,j,pos:rangoVentas;
	aux:venta;
begin
	for i:=1 to (dl-1) do begin
		pos:=i;
		for j:=i+1 to dl do
			if(v[j].codigo<v[pos].codigo) then pos:=j;
		
		aux:=v[pos];
		v[pos]:=v[i];
		v[i]:=aux;
	end;
end;

procedure eliminarVentas(var vector:vectorVentas; var dl:rangoVentas; n1:rangoCodigo; n2:rangoCodigo);
var
	pos,contador:integer;
begin
	contador:=0;
	pos:=1;
	while(pos<=maximasVentas) do begin
		if(vector[pos].codigo>n1) and (vector[pos].codigo<n2) then contador:=contador+1
		else begin
			if(contador>0) then vector[pos-contador]:=vector[pos];
		end;
		pos:=pos+1;
	end;
	dl:=dl-contador;
end;

procedure ventasCodigoPar(ventas:vectorVentas; var ventasPar:vectorVentas; dimL:rangoVentas; var dimLpar:rangoVentas; var totalVentas:integer);
var
	i:rangoVentas;
begin
	totalVentas:=0;
	dimLpar:=0;
	for i:=1 to dimL do begin
		if((ventas[i].codigo MOD 2) = 0) then begin
			dimLpar:=dimLpar+1;
			ventasPar[dimLpar]:=ventas[i];
		end;
		totalVentas:=totalVentas+ventas[i].cantidad;
	end;
end;

var
	ventas,ventasPar:vectorVentas;
	dimL, dimLpar:rangoVentas;
	num1,num2:rangoCodigo;
	totalVentas:integer;
begin
	//Cargar vector e imprimir
	leerVentas(ventas, dimL);
	imprimirVector(ventas,dimL);
	writeln('**************');
	//Ordenar vector por codigo de forma ascendente e imprimir
	ordenarVector(ventas, dimL);
	imprimirVector(ventas, dimL);
	writeln('**************');
	//Eliminar ventas en un rango de codigos
	writeln('Ingrese dos codigos para eliminar ventas: '); readln(num1); readln(num2);
	eliminarVentas(ventas, dimL, num1, num2);
	imprimirVector(ventas, dimL);
	writeln('**************');
	//Vector con ventas de codigo par y total de productos vendidos
	ventasCodigoPar(ventas, ventasPar, dimL, dimLpar, totalVentas);
	imprimirVector(ventasPar, dimLpar);
	writeln('- Total de ventas: ',totalVentas);
end.
	
