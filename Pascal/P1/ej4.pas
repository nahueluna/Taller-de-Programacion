//Registro producto con codigo producto, codigo rubro (1 a 8) y precio.
//a)
//Vector df 8. Cada posicion es una lista que almacena los productos con insertar ordenado.
//Se detiene cuando precio leido es 0. Puede no haber productos para un rubro (lista en nil)
//b)
//Imprimir todos los codigos de cada producto(nodo) por cada posicion del vector
//c)
//Vector df 30. Cada posicion es un registro producto. Recorrer el vector de a) en posicion 3
//con while y dos condiciones: hasta lista=nil o indice=30
//d)
//Algoritmo de ordenacion por precio en el vector de c). Se debe usar diml
//e)
//Imprimir vector de d)
//f)
//Recorro vector de d) sumando valores y divido resultado por diml

program ej4;
const
	rubros=4;
	elementosRubro3=30;
	rubroEvaluado=3;
type
	rangoRubros=1..rubros;
	rangoElementosRubro3=0..elementosRubro3;
	
	producto=record
		codigo:integer;
		rubro:rangoRubros;
		precio:real;
	end;
	
	listaP=^nodoP;
	nodoP=record
		dato:producto;
		sig:listaP;
	end;
	
	vectorProductos=array[1..rubros] of listaP;
	vectorRubro3=array[1..elementosRubro3] of producto;

procedure crearListas(var v:vectorProductos);
var
	i:rangoRubros;
begin
	for i:=1 to rubros do
		v[i]:=nil;
end;
	
procedure leerRegistro(var reg:producto);
begin
	writeln('Precio: '); readln(reg.precio);
	if(reg.precio<>0) then begin
		writeln('Codigo producto: '); readln(reg.codigo);
		writeln('Codigo rubro: '); readln(reg.rubro);
	end;
	writeln('--------------');
end;

procedure insertarOrdenado(var pri:listaP; elemento:producto);
var
	nuevo, actual, anterior:listaP;
begin
	new(nuevo);
	nuevo^.dato:=elemento;
	nuevo^.sig:=nil;
	if(pri=nil) then pri:=nuevo
	else begin
		actual:=pri;
		while(actual<>nil) and (actual^.dato.codigo<nuevo^.dato.codigo) do begin
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

procedure leerProductos(var vecProd:vectorProductos);
var
	regProd:producto;
begin
	crearListas(vecProd);
	leerRegistro(regProd);
	while(regProd.precio<>0) do begin
		insertarOrdenado(vecProd[regProd.rubro],regProd);
		leerRegistro(regProd);
	end;
end;

procedure imprimirLista(lis:listaP);
begin
	while(lis<>nil) do begin
		writeln('Codigo producto: ',lis^.dato.codigo);
		lis:=lis^.sig;
	end;
end;

procedure imprimirCodigosProductos(vecProduc:vectorProductos);
var
	h:rangoRubros;
begin
	for h:=1 to rubros do begin
		if(vecProduc[h]<>nil) then imprimirLista(vecProduc[h]);
		writeln(' ');
	end;
end;

procedure generarVectorRubro3(var vecRubro3:vectorRubro3; var dl:rangoElementosRubro3; listaRubro:listaP);
begin
	dl:=0;
	while(dl<elementosRubro3) and (listaRubro<>nil) do begin
		dl:=dl+1;
		vecRubro3[dl]:=listaRubro^.dato;
		listaRubro:=listaRubro^.sig;
	end;
end;

procedure ordenarVectorRubro3(var vecRubro3:vectorRubro3; var dl:rangoElementosRubro3);
var
	i,j:rangoElementosRubro3;
	actual:producto;
begin
	for i:=2 to dl do begin
		actual:=vecRubro3[i];
		j:=i-1;
		while(j>0) and (vecRubro3[j].precio>actual.precio) do begin
			vecRubro3[j+1]:=vecRubro3[j];
			j:=j-1;
		end;
		vecRubro3[j+1]:=actual;
	end;
end;

procedure imprimirVectorRubro3(vecRubro3:vectorRubro3; dl:rangoElementosRubro3);
var
	k:rangoElementosRubro3;
begin
	for k:=1 to dl do
		writeln('Precio: ',vecRubro3[k].precio:1:2);
	writeln(' ');
end;

function calcularPromedioPrecios(vecRubro3:vectorRubro3; dl:rangoElementosRubro3):real;
var
	m:rangoElementosRubro3;
	sumaPrecio:real;
begin
	sumaPrecio:=0;
	for m:=1 to dl do
		sumaPrecio:=sumaPrecio + vecRubro3[m].precio;
	calcularPromedioPrecios:=sumaPrecio/dl;	//opera con reales y subrango, es correcto?
end;

var
	productos:vectorProductos;
	productosRubro3:vectorRubro3;
	dimL:rangoElementosRubro3;
begin
	leerProductos(productos);
	imprimirCodigosProductos(productos);
	generarVectorRubro3(productosRubro3, dimL, productos[rubroEvaluado]);
	ordenarVectorRubro3(productosRubro3, dimL);
	writeln('********');
	imprimirVectorRubro3(productosRubro3, dimL);
	writeln('El promedio de precios es de: $',calcularPromedioPrecios(productosRubro3, dimL):1:2);
end.
