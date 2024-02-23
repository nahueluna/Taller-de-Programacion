{	Una biblioteca nos ha encargado procesar la información de los préstamos realizados
durante el año 2021. De cada préstamo se conoce el ISBN del libro, el número de socio, día
y mes del préstamo y cantidad de días prestados. Implementar un programa con:
a. Un módulo que lea préstamos y retorne 2 estructuras de datos con la información de
los préstamos. La lectura de los préstamos finaliza con ISBN -1. Las estructuras deben
ser eficientes para buscar por ISBN.
i. En una estructura cada préstamo debe estar en un nodo.
ii. En otra estructura, cada nodo debe contener todos los préstamos realizados al ISBN.
(prestar atención sobre los datos que se almacenan).
b. Un módulo recursivo que reciba la estructura generada en i. y retorne el ISBN más
grande.
c. Un módulo recursivo que reciba la estructura generada en ii. y retorne el ISBN más
pequeño.
d. Un módulo recursivo que reciba la estructura generada en i. y un número de socio. El
módulo debe retornar la cantidad de préstamos realizados a dicho socio.
e. Un módulo recursivo que reciba la estructura generada en ii. y un número de socio. El
módulo debe retornar la cantidad de préstamos realizados a dicho socio.
f. Un módulo que reciba la estructura generada en i. y retorne una nueva estructura
ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
que se prestó.
g. Un módulo que reciba la estructura generada en ii. y retorne una nueva estructura
ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
que se prestó.
h. Un módulo recursivo que reciba la estructura generada en h. y muestre su contenido.
i. Un módulo recursivo que reciba la estructura generada en i. y dos valores de ISBN. El
módulo debe retornar la cantidad total de préstamos realizados a los ISBN
comprendidos entre los dos valores recibidos (incluidos).
j. Un módulo recursivo que reciba la estructura generada en ii. y dos valores de ISBN. El
módulo debe retornar la cantidad total de préstamos realizados a los ISBN
comprendidos entre los dos valores recibidos (incluidos).}
program Practica4_ej2;
Type
	subrangoDia=1..31;
	subrangoMes=1..12;
	prestamo = record
		ISBN:integer;
		numSocio:integer;
		dia:subrangoDia;
		mes:subrangoMes;
		cantDias:integer;
	end;
	ArbolA=^nodoA;
	nodoA = record
		dato:prestamo;
		HI:ArbolA;
		HD:ArbolA;
	end;
	Lista=^nodo;
	nodo = record
		dato:prestamo;
		sig:Lista;
	end;
	ArbolB=^nodoB;
	nodoB = record
		dato:Lista;
		HI:ArbolB;
		HD:ArbolB;
	end;
	libro = record
		ISBN:integer;
		cantVecesPrestado:integer;
	end;
	ArbolC=^nodoC;
	nodoC = record
		dato:libro;
		HI:ArbolC;
		HD:ArbolC;
	end;
//agrega un nodo al arbol de registros
procedure agregarNodoA(var prestamosA:ArbolA;registro:prestamo);
begin
	if(prestamosA = nil)then
	begin
		new(prestamosA);
		prestamosA^.dato:=registro;
		prestamosA^.HI:=nil;
		prestamosA^.HD:=nil;
	end
	else
		if(registro.ISBN <= prestamosA^.dato.ISBN)then
			agregarNodoA(prestamosA^.HI,registro)
		else
			agregarNodoA(prestamosA^.HD,registro);
end;
//debido a que no pide que este ordenada la lista, agrego adelante el nuevo nodo de la lista
procedure agregarAdelante(var L:Lista;registro:prestamo);
var
	nue:Lista;
begin
	new(nue);
	nue^.dato:=registro;
	nue^.sig:=L;
	L:=nue;
end;
//agrega un nodo a una lista del arbol
procedure agregarNodoB(var prestamosB:ArbolB;registro:prestamo);
begin
	if(prestamosB = nil)then
	begin
		new(prestamosB);
		prestamosB^.dato:=nil;//la primera vez el puntero será NIL, sin esto se pasaria basura a la lista
		agregarAdelante(prestamosB^.dato,registro);
		prestamosB^.HI:=nil;
		prestamosB^.HD:=nil;
	end
	else
		if(registro.ISBN = prestamosB^.dato^.dato.ISBN)then
			agregarAdelante(prestamosB^.dato,registro)
		else
			if(registro.ISBN < prestamosB^.dato^.dato.ISBN)then
				agregarNodoB(prestamosB^.HI,registro)
			else
				agregarNodoB(prestamosB^.HD,registro);
end;
//ingreso por teclado de los campos del registro prestamo
procedure leer(var registro:prestamo);
begin
	writeln('Ingrese el ISBN del libro');
	readln(registro.ISBN);
	if(registro.ISBN <> -1)then
	begin
		writeln('Ingrese numero de socio');
		readln(registro.numSocio);
		writeln('Ingrese dia');
		readln(registro.dia);
		writeln('Ingrese mes');
		readln(registro.mes);
		writeln('Ingrese cantidad de dias del Prestamo');
		readln(registro.cantDias);
	end;
end;
//carga ambos arboles
procedure cargarArbol(var prestamosA:ArbolA;var prestamosB:ArbolB);
var
	registro:prestamo;
begin
	leer(registro);
	if(registro.ISBN <> -1)then
	begin
		agregarNodoA(prestamosA,registro);
		writeln('caso 1');
		agregarNodoB(prestamosB,registro);
		writeln('caso 2');
		cargarArbol(prestamosA,prestamosB);
	end;
end;
//imprime registro tipo prestamo
procedure imprimirRegistro(registro:prestamo);
begin
	writeln('ISBN: ',registro.ISBN);
	writeln('Numero de socio: ',registro.numSocio);
	writeln('Dia: ',registro.dia);
	writeln('Mes: ',registro.mes);
	writeln('Cantidad de dias de prestamo: ',registro.cantDias);	
end;
//recorre el arbol de registros para imprimirlos
procedure recorrerArbolA(prestamos:ArbolA);
begin
	if(prestamos<>nil)then
	begin
		imprimirRegistro(prestamos^.dato);
		recorrerArbolA(prestamos^.HI);
		recorrerArbolA(prestamos^.HD);
	end;
end;
//recorre la lista para poder imprimirla
procedure recorrerLista(L:Lista);
begin
	if(L<>nil)then
	begin
		imprimirRegistro(L^.dato);
		writeln('dato',L^.dato.ISBN);
		recorrerLista(L^.sig);
	end;
end;
//Recorre el arbol de listas 
procedure recorrerArbolB(prestamos:ArbolB);
begin
	if(prestamos<>nil)then
	begin
		recorrerLista(prestamos^.dato);
		recorrerArbolB(prestamos^.HI);
		recorrerArbolB(prestamos^.HD);
	end;
end;
//recorre el arbol e informa el ISBN mas grande
function maximo(prestamosA:ArbolA):integer;
begin
	if(prestamosA^.HD = nil)then
		maximo:=prestamosA^.dato.ISBN
	else
		maximo:=maximo(prestamosA^.HD);
end;
//recorre el arbol e informa el ISBN mas chico
function minimo(prestamosB:ArbolB):integer;
begin
	if(prestamosB^.HI = nil)then
		minimo:=prestamosB^.dato^.dato.ISBN
	else
		minimo:=minimo(prestamosB^.HI);
end;
//retorna la cantidad de prestamos de un socio en particular
procedure prestamoSocioA(prestamosA:ArbolA;numSocio:integer;var cantPrestamos:integer);
begin
	//igual que en un informar, ya que no se encuentra ordenado por numero de socio
	if(prestamosA <> nil)then
	begin
		if(numSocio = prestamosA^.dato.numSocio)then
			cantPrestamos:=cantPrestamos+1;
		prestamoSocioA(prestamosA^.HI,numSocio,cantPrestamos);
		prestamoSocioA(prestamosA^.HD,numSocio,cantPrestamos)
	end;
end;
//suma las cantidades de prestamos de un socio en una lista
procedure sumarCantPrestamos(L:Lista;numSocio:integer;var cantPrestamos:integer);
begin
	if(L<>nil)then
	begin
		if(numSocio = L^.dato.numSocio)then
			cantPrestamos:=cantPrestamos+1;
		sumarCantPrestamos(L^.sig,numSocio,cantPrestamos);
	end;
end;
//retorna la cantidad de prestamos de un socio en particular, recorriendo el arbol de listas
procedure prestamoSocioB(prestamosB:ArbolB;numSocio:integer;var cantPrestamos:integer);
begin
	if(prestamosB <> nil)then
	begin
		sumarCantPrestamos(prestamosB^.dato,numSocio,cantPrestamos);
		prestamoSocioB(prestamosB^.HI,numSocio,cantPrestamos);
		prestamoSocioB(prestamosB^.HD,numSocio,cantPrestamos)
	end;
end;
//va agregando o actualizando registros en el arbol de cantida de prestamos por libro
procedure agregarOActualizarNodoA(var librosA:ArbolC;ISBN:integer);
begin
	
	if(librosA = nil)then
	begin
		new(librosA);
		librosA^.dato.ISBN:=ISBN;
		librosA^.dato.cantVecesPrestado:=1;
		librosA^.HI:=nil;
		librosA^.HD:=nil;
	end
	else
		if(librosA^.dato.ISBN = ISBN)then
			librosA^.dato.cantVecesPrestado:=librosA^.dato.cantVecesPrestado+1
		else
			if(ISBN < librosA^.dato.ISBN)then
				agregarOActualizarNodoA(librosA^.HI,ISBN)
			else
				agregarOActualizarNodoA(librosA^.HD,ISBN);
end;
//recorre el arbol de registros y actualiza o agrega nodos al arbol de cantidad de prestamos por libro
procedure cargarArbolA(prestamosA:ArbolA;var librosA:ArbolC);
begin
	if(prestamosA <> nil)then
	begin
		agregarOActualizarNodoA(librosA,prestamosA^.dato.ISBN);
		cargarArbolA(prestamosA^.HI,librosA);
		cargarArbolA(prestamosA^.HD,librosA);
	end;
end;
//imprime un registro de cantidad de prestamos de un libro
procedure imprimirLibro(registro:libro);
begin
	writeln('El ISBN del libro es: ',registro.ISBN);
	writeln('La cantidad de veces que se presto el libro fueron: ',registro.cantVecesPrestado);
end;
//imprime el arbol cantidad de prestamos por libro
procedure imprimirLibros(libros:ArbolC);
begin
	if(libros<>nil)then
	begin
		imprimirLibro(libros^.dato);
		imprimirLibros(libros^.HI);
		imprimirLibros(libros^.HD);
	end;
end;
//recorre la lista sumando los prestamos para agregar o actuaizar un nodo en un nuevo arbol
procedure agregarOActualizarNodoB(var librosB:ArbolC;ISBN:integer;cantPrestamos:integer);
begin
	if(librosB = nil)then
	begin
		new(librosB);
		librosB^.dato.ISBN:=ISBN;
		librosB^.dato.cantVecesPrestado:=cantPrestamos;
		librosB^.HI:=nil;
		librosB^.HD:=nil;
	end
	else
		if(ISBN <= librosB^.dato.ISBN)then
			agregarOActualizarNodoA(librosB^.HI,ISBN)
		else
			agregarOActualizarNodoA(librosB^.HD,ISBN);
end;
//suma la cantidad de veces que se presto un libro
function sumarPrestamosLibro(L:Lista):integer;
begin
	if(L=nil)then
		sumarPrestamosLibro:=0
	else
		sumarPrestamosLibro:=1+sumarPrestamosLibro(L^.sig);
end;
//recorre el arbol de listas de prestamos de libros a socios
procedure cargarArbolB(prestamosB:ArbolB;var librosB:ArbolC);
var
	cantPrestamos:integer;
begin
	if(prestamosB <> nil)then
	begin
		cantPrestamos:=sumarPrestamosLibro(prestamosB^.dato);
		agregarOActualizarNodoB(librosB,prestamosB^.dato^.dato.ISBN,cantPrestamos);
		cargarArbolB(prestamosB^.HI,librosB);
		cargarArbolB(prestamosB^.HD,librosB);
	end;
end;
//retorna la cantidad total de prestamos para un rango de libros ordenados por ISBN
procedure cantTotalPrestamosPorRango(prestamosA:ArbolA;rangoA:integer;rangoB:integer;var cantTotal:integer);
begin
	if(prestamosA <> nil)then
	begin
		if(rangoA <= prestamosA^.dato.ISBN)and(prestamosA^.dato.ISBN <= rangoB)then
		begin
			cantTotal:=cantTotal+1;
			cantTotalPrestamosPorRango(prestamosA^.HI,rangoA,rangoB,cantTotal);
			cantTotalPrestamosPorRango(prestamosA^.HD,rangoA,rangoB,cantTotal);
		end
		else
			if(prestamosA^.dato.ISBN < rangoA)then
				cantTotalPrestamosPorRango(prestamosA^.HD,rangoA,rangoB,cantTotal)
			else
				cantTotalPrestamosPorRango(prestamosA^.HI,rangoA,rangoB,cantTotal);
	end;
end;
//retorna la cantidad total de prestamos en un rango de libros pasando un arbol de listas
procedure cantTotalPrestamosPorRangoB(prestamosB:ArbolB;rangoA:integer;rangoB:integer;var cantTotal:integer);
	function sumaOcurrenciasLista(lisPrestamos:Lista):integer;
	begin
		if(lisPrestamos<>nil) then 
			sumaOcurrenciasLista:=sumaOcurrenciasLista(lisPrestamos^.sig) + 1
		else sumaOcurrenciasLista:=0;
	end;
begin
	if(prestamosB <> nil)then
	begin
		if(rangoA <= prestamosB^.dato^.dato.ISBN)and(prestamosB^.dato^.dato.ISBN <= rangoB)then
		begin
			cantTotal:=cantTotal+sumaOcurrenciasLista(prestamosB^.dato);
			cantTotalPrestamosPorRangoB(prestamosB^.HI,rangoA,rangoB,cantTotal);
			cantTotalPrestamosPorRangoB(prestamosB^.HD,rangoA,rangoB,cantTotal);
		end
		else
			if(prestamosB^.dato^.dato.ISBN < rangoA)then
				cantTotalPrestamosPorRangoB(prestamosB^.HD,rangoA,rangoB,cantTotal)
			else
				cantTotalPrestamosPorRangoB(prestamosB^.HI,rangoA,rangoB,cantTotal);
	end;
end;
var
	prestamosA:ArbolA;
	prestamosB:ArbolB;
	min:integer;
	max:integer;
	numSocio:integer;
	cantPrestamos:integer;
	librosA:ArbolC;
	librosB:ArbolC;
	rangoA:integer;
	rangoB:integer;
	cantTotal:integer;
begin
	cargarArbol(prestamosA,prestamosB);
	writeln('---------------------');
	if(prestamosA<>nil)then
	begin
		max:=maximo(prestamosA);
		writeln('Numero de ISBN mas grande: ',max);
	end;
	writeln('---------------------');
	if(prestamosB<>nil)then
	begin
		min:=minimo(prestamosB);
		writeln('Numero de ISBN mas chico: ',min);
	end;
	writeln('---------------------');
	writeln('Ingrese el numero de socio a buscar');
	readln(numSocio);
	cantPrestamos:=0;
	prestamoSocioA(prestamosA,numSocio,cantPrestamos);
	writeln('La cantidad de veces que el socio pidio un libro prestado fueron ', cantPrestamos);
	writeln('---------------------');
	writeln('Ingrese el numero de socio a buscar');
	readln(numSocio);
	cantPrestamos:=0;
	prestamoSocioB(prestamosB,numSocio,cantPrestamos);
	writeln('La cantidad de veces que el socio pidio un libro prestado fueron ', cantPrestamos);
	writeln('---------------------');
	writeln('Prestamos:',prestamosA^.dato.ISBN);
	cargarArbolA(prestamosA,librosA);
	cargarArbolB(prestamosB,librosB);
	//writeln('Libros:',librosA^.dato.ISBN);
	writeln('---------------------');
	//recorrerArbolA(prestamosA);
	writeln('---------------------');
	//recorrerArbolB(prestamosB);
	writeln('---------------------');
	imprimirLibros(librosA);
	writeln('---------------------');
	imprimirLibros(librosB);
	writeln('---------------------');
	writeln('Ingrese el primer rango de ISBN');
	readln(rangoA);
	writeln('Ingrese el segundo rango de ISBN');
	readln(rangoB);
	cantTotal:=0;
	cantTotalPrestamosPorRango(prestamosA,rangoA,rangoB,cantTotal);
	if(cantTotal<>0)then
		writeln('La cantidad de prestamos en ese rango es de ',cantTotal)
	else
		writeln('No se encontraron libros en ese rango');
	writeln('---------------------');
	cantTotal:=0;
	cantTotalPrestamosPorRangoB(prestamosB,rangoA,rangoB,cantTotal);
	if(cantTotal<>0)then
		writeln('La cantidad de prestamos en ese rango es de ',cantTotal)
	else
		writeln('No se encontraron libros en ese rango');
end.
