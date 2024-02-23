{Un supermercado requiere el procesamiento de sus productos. De cada producto se
conoce código, rubro (1..10), stock y precio unitario. Se pide:
a) Generar una estructura adecuada que permita agrupar los productos por rubro. A su
vez, para cada rubro, se requiere que la búsqueda de un producto por código sea lo
más eficiente posible. La lectura finaliza con el código de producto igual a -1.
b) Implementar un módulo que reciba la estructura generada en a), un rubro y un código
de producto y retorne si dicho código existe o no para ese rubro.
c) Implementar un módulo que reciba la estructura generada en a), y retorne, para cada
rubro, el código y stock del producto con mayor código.
d) Implementar un módulo que reciba la estructura generada en a), dos códigos y
retorne, para cada rubro, la cantidad de productos con códigos entre los dos valores
ingresados.}

//Registro producto con codigo, rubro(1-10), stock y precio unitario
//vector df 10 que agrupe por rubro los productos. Cada elemento del vector es un arbol (segun el rubro)
//ordenado por codigo de producto.

program Pr5_ej3;
const
	rubros=10;
type
	subrangoRubros=1..rubros;
	//Registro para datos del producto
	producto=record
		codigo:integer;
		rubro:subrangoRubros;
		stock:integer;
		precio:real;
	end;
	//Arbol de productos
	arbolProducto=^nodoProducto;
	nodoProducto=record
		dato:producto;
		hi:arbolProducto;
		hd:arbolProducto;
	end;
	//Vector que agrupa los árboles de productos por rubro del mismo
	vectorProductosPorRubro=array[1..rubros] of arbolProducto;
	//Codigo y stock para el producto con mayor codigo
	productoInfoMax=record
		codigo:integer;
		stock:integer;
	end;
	//Vector para guardar información de los productos con maximo codigo de cada rubro
	vectorProductosMaximos=array[1..rubros] of productoInfoMax;
	//Vector que almacena la cantidad de productos por rubro que se encuentran en un rango de codigos ingresado
	vectorCantidadProductos=array[1..rubros] of integer;
//Crea los arboles(asigna nil) de cada posicion del vector
procedure crearArbolesDeProductos(var vecProdPorRubro:vectorProductosPorRubro);
var
	i:subrangoRubros;
begin
	for i:=1 to rubros do
		vecProdPorRubro[i]:=nil;
end;
//Leo datos del producto
procedure leerProducto(var regProd:producto);
begin
	writeln('Codigo: '); readln(regProd.codigo);
	if(regProd.codigo<>-1) then begin
		writeln('Rubro: '); readln(regProd.rubro);
		writeln('Stock: '); readln(regProd.stock);
		writeln('Precio: '); readln(regProd.precio);
	end;
	writeln;
end;
//Agrego el producto leído al árbol, ordenado por código de producto
procedure agregarProductoAlArbol(var prodArbol:arbolProducto; prod:producto);
begin
	if(prodArbol=nil) then begin
		new(prodArbol);
		prodArbol^.dato:=prod;
		prodArbol^.hi:=nil;
		prodArbol^.hd:=nil;
	end
	else
		if(prod.codigo<=prodArbol^.dato.codigo) then agregarProductoAlArbol(prodArbol^.hi, prod)
		else agregarProductoAlArbol(prodArbol^.hd, prod);
end;
//Leo y cargo los productos en el árbol según el rubro
procedure cargarProductos(var productosPorRubro:vectorProductosPorRubro);
var
	regProd:producto;
begin
	leerProducto(regProd);
	while(regProd.codigo<>-1) do begin
		agregarProductoAlArbol(productosPorRubro[regProd.rubro], regProd);	//Envío el árbol correspondiente a la posicion del rubro leído
		leerProducto(regProd);
	end;
end;
{Busco si el codigo leido existe en el árbol del rubro leido. Uso una función dentro del procedimiento porque el inciso pide enviar el vector, no el árbol del rubro
Sino lo hacia directamente con la función}
procedure buscarCodigoPorRubro(vecProdPorRubro:vectorProductosPorRubro; rubroLeido:integer; codigoLeido:integer; var existeCodigo:boolean);
	function buscarCodigoEnArbol(arbolProd:arbolProducto; codigoLeido:integer):boolean;
	begin
		if(arbolProd = nil) then buscarCodigoEnArbol:=false
		else
			if(arbolProd^.dato.codigo = codigoLeido) then buscarCodigoEnArbol:=true
			else if(codigoLeido < arbolProd^.dato.codigo) then buscarCodigoEnArbol:=buscarCodigoEnArbol(arbolProd^.hi, codigoLeido)
			else buscarCodigoEnArbol:=buscarCodigoEnArbol(arbolProd^.hd, codigoLeido); 
	end; 
begin
	existeCodigo:=buscarCodigoEnArbol(vecProdPorRubro[rubroLeido], codigoLeido);
end;
//Recorro todo el vector de arboles con un for. Por cada uno, busco codigo máximo (hoja más a la derecha). Si el arbol está vacío el codigo máximo es -1
procedure codigoYstockProductosMaximos(vecProdPorRubro:vectorProductosPorRubro; var prodMaxCod:vectorProductosMaximos);
	procedure productoConMayorCodigo(arbolProd:arbolProducto; var prodMax:productoInfoMax);
	begin
		if(arbolProd = nil) then prodMax.codigo:=-1
		else
			if(arbolProd^.hd = nil) then begin
				prodMax.codigo:=arbolProd^.dato.codigo;
				prodMax.stock:=arbolProd^.dato.stock;
			end
			else productoConMayorCodigo(arbolProd^.hd, prodMax);
	end;
var
	j:subrangoRubros;
begin
	for j:=1 to rubros do
		productoConMayorCodigo(vecProdPorRubro[j],prodMaxCod[j]);
end;
{Busco los productos con codigo dentro de un rango ingresado, para cada rubro. Cuento la cantidad de productos que cumple dicha condición, en un vector que agrupa
por rubro}
procedure retornarCantidadProductosSegunCodigo(vecProdPorRubro:vectorProductosPorRubro; var vecCantProd:vectorCantidadProductos; codigoA,codigoB:integer);
	procedure contarCantidadProductos(arbolProd:arbolProducto; var cantProd:integer; codigoA,codigoB:integer);
	begin
		if(arbolProd<>nil) then begin
			if(arbolProd^.dato.codigo >= codigoA) and (arbolProd^.dato. codigo <= codigoB) then begin
				cantProd:=cantProd+1;	//Si se encuentra en el rango, sumo uno
				contarCantidadProductos(arbolProd^.hi, cantProd, codigoA, codigoB);
				contarCantidadProductos(arbolProd^.hd, cantProd, codigoA, codigoB);
			end
			else
				if(arbolProd^.dato.codigo < codigoA) then contarCantidadProductos(arbolProd^.hd, cantProd, codigoA, codigoB)
				else contarCantidadProductos(arbolProd^.hi, cantProd, codigoA, codigoB);
		
		end;
	end;
var
	h:subrangoRubros;
begin
	for h:=1 to rubros do begin	//Recorro todo el vector de arboles
		vecCantProd[h]:=0;	//Inicializo en 0 aca, para poder sumar cantidades. Si el arbol de un rubro está vacío, el vector en esa posición queda en 0
		{Verifico que el árbol del rubro no esté vacío y que el código mínimo ingresado no sea mayor al máximo 
		(ya que esto me haría recorrer muchos nodos del árbol buscando una condición que nunca se cumpliría)}
		if(vecProdPorRubro[h]<>nil) and (codigoA<=codigoB) then
			//Envío el arbol del rubro, el entero en la posicion correspondiente al rubro y los codigos
			contarCantidadProductos(vecProdPorRubro[h], vecCantProd[h], codigoA, codigoB);
	end;
end;

var
	productosPorRubro:vectorProductosPorRubro;
	productosMaximoCodigo:vectorProductosMaximos;
	cantidadProductosSegunCodigo:vectorCantidadProductos;
	rubroLeido,codigoLeido,codigoA,codigoB:integer;
	existeCodigo:boolean;
begin
	crearArbolesDeProductos(productosPorRubro);
	cargarProductos(productosPorRubro);
	writeln;
	
	write('Ingrese un rubro: '); readln(rubroLeido);
	write('Ingrese un codigo: '); readln(codigoLeido);
	buscarCodigoPorRubro(productosPorRubro, rubroLeido, codigoLeido, existeCodigo);
	
	codigoYstockProductosMaximos(productosPorRubro,productosMaximoCodigo);
	
	write('Ingrese el codigo minimo a buscar: '); readln(codigoA);
	write('Ingrese el codigo maximo a buscar: '); readln(codigoB);
	retornarCantidadProductosSegunCodigo(productosPorRubro, cantidadProductosSegunCodigo, codigoA, codigoB);
end.
