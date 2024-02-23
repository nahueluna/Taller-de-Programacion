//Tickets de venta. Se lee codigo de venta y productos vendidos hasta codigo de venta -1
//De los productos vendidos se lee codigo y cantidad de unidades solicitadas hasta cantidad 0
//El ticket se compone del codigo de venta, detalle (codigo producto, cantidad, precio) de
//los vendidos (si no hay stock suficiente, se vende lo maximo), y monto total de venta
//Se dispone de tabla con precios y stocks de los 1000 productos

program ej3;
const
	productos=10;
type
	rangoProductos=1..productos;
	
	producto=record
		codigo:rangoProductos;
		cantidad:integer;
		precio:real;
	end;
	
	listaV=^nodoV;
	nodoV=record
		dato:producto;
		sig:listaV;
	end;
	
	ticket=record
		codigo:integer;
		ventas:listaV;
		total:real;
	end;
	
	listaT=^nodoT;
	nodoT=record
		dato:ticket;
		sig:listaT;
	end;
	
	tabla=record
		precio:real;
		stock:integer;
	end;
	
	vectorTabla=array[rangoProductos] of tabla;
	
procedure cargarTabla(var vecTabla:vectorTabla);
var
	i:rangoProductos;
begin
	for i:=1 to productos do begin
		vecTabla[i].precio:=i*2.74;
		vecTabla[i].stock:=i*15;
	end;
end;

procedure leerRegProducto(var regP:producto);
var
	tablaSupermercado:vectorTabla;
begin
	cargarTabla(tablaSupermercado);
	writeln('Codigo producto: '); readln(regP.codigo);
	writeln('Cantidad vendida: '); readln(regP.cantidad);
	if(regP.cantidad<>0) then begin
		if(regP.cantidad>tablaSupermercado[regP.codigo].stock) then 
			regP.cantidad:=tablaSupermercado[regP.codigo].stock;
		regP.precio:=tablaSupermercado[regP.codigo].precio;
	end;
end;

procedure agregarProducto(var listaVentas:listaV; elemento:producto);
var
	nuevo:listaV;
begin
	new(nuevo);
	nuevo^.dato:=elemento;
	nuevo^.sig:=listaVentas;
	listaVentas:=nuevo;
end;

procedure leerVentas(var ventas:listaV);
var
	regProducto:producto;
begin
	ventas:=nil;
	leerRegProducto(regProducto);
	while(regProducto.cantidad<>0) do begin
		writeln('....');
		agregarProducto(ventas, regProducto);
		leerRegProducto(regProducto);
	end;
	writeln('-----------');
end;

function calculoMontoTotal(lisV:listaV):real;
var
	sumaTotal:real;
begin
	sumaTotal:=0;
	while(lisV<>nil) do begin
		sumaTotal:=sumaTotal + (lisV^.dato.cantidad*lisV^.dato.precio);
		lisV:=lisV^.sig;
	end;
	calculoMontoTotal:=sumaTotal;
end;

procedure leerRegistro(var reg:ticket);
begin
	writeln('Codigo venta: '); readln(reg.codigo);
	if(reg.codigo<>-1) then begin
		leerVentas(reg.ventas);
		reg.total:=calculoMontoTotal(reg.ventas);
	end;
end;

procedure agregarAdelante(var lisT:listaT; elemento:ticket);
var
	nuevo:listaT;
begin
	new(nuevo);
	nuevo^.dato:=elemento;
	nuevo^.sig:=lisT;
	lisT:=nuevo;
end;

procedure leerTickets(var listaTickets:listaT);
var
	regTicket:ticket;
begin
	leerRegistro(regTicket);
	while(regTicket.codigo<>-1) do begin
		agregarAdelante(listaTickets, regTicket);
		leerRegistro(regTicket);
	end;
end;
	
function cantProdporVenta(lisProductos:listaV; codigo:rangoProductos):integer;
begin
	while((lisProductos<>nil) and (lisProductos^.dato.codigo<>codigo)) do begin
		lisProductos:=lisProductos^.sig;
	end;
	if((lisProductos<>nil) and (lisProductos^.dato.codigo=codigo)) then cantProdporVenta:=lisProductos^.dato.cantidad
	else cantProdporVenta:=0;
end;	

function cantidadProductoPorCodigo(lisTicketVenta:listaT; codigo:rangoProductos):integer;
var
	totalUnidades:integer;
begin
	totalUnidades:=0;
	while(lisTicketVenta<>nil) do begin
		totalUnidades:=totalUnidades + cantProdporVenta(lisTicketVenta^.dato.ventas, codigo);
		lisTicketVenta:=lisTicketVenta^.sig;
	end;
	cantidadProductoPorCodigo:=totalUnidades;
end;

procedure imprimirTickets(ticketsVenta:listaT);
begin
		while(ticketsVenta<>nil) do begin
		writeln('Venta: '); writeln(ticketsVenta^.dato.codigo);
		while(ticketsVenta^.dato.ventas<>nil) do begin
			writeln('Codigo: '); writeln(ticketsVenta^.dato.ventas^.dato.codigo);
			writeln('Cantidad: '); writeln(ticketsVenta^.dato.ventas^.dato.cantidad);
			writeln('Precio: '); writeln(ticketsVenta^.dato.ventas^.dato.precio:1:2);
			writeln('.......');
			ticketsVenta^.dato.ventas:=ticketsVenta^.dato.ventas^.sig;
		end;
		writeln('Total: '); writeln(ticketsVenta^.dato.total:1:2);
		writeln('--------------');
		ticketsVenta:=ticketsVenta^.sig;
	end;
end;
	
var
	ticketsVenta:listaT;
	codigoBuscado:rangoProductos;
begin
	ticketsVenta:=nil;
	leerTickets(ticketsVenta);
	writeln('Codigo buscado: '); readln(codigoBuscado);
	writeln('El codigo ',codigoBuscado,' se corresponde con ',cantidadProductoPorCodigo(ticketsVenta,codigoBuscado),' productos vendidos');
	imprimirTickets(ticketsVenta);
end.
