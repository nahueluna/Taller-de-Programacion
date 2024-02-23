//Registro pelicula con codigo pelicula, codigo genero(1-8) y puntaje promedio.
//a)
//Vector df 8. Cada posicion tiene una lista con las peliculas del genero correspondiente (1-8)
//Los nodos se agregan al final (orden de llegada) hasta codigo -1.
//b)
//Vector df 8. Cada posicion tiene un registro con codigo pelicula y puntuacion mayor de 
//pelicula. Se debe recorrer el vector de a), en cada posicion, buscando el nodo con mayor
//puntuacion (maximo) y guardarlo en posicion correspondiente de este nuevo vector
//c)
//Ordenación de vector por puntaje (menor puntaje primero)
//d)
//Si el vector está ordenado, basta con imprimir la primer y ultima posicion del vector

program ej3;
const
	generos=4;
type
	rangoGeneros=1..generos;
	
	pelicula=record
		codigo:integer;
		genero:rangoGeneros;
		puntaje:real;
	end;
	
	listaP=^nodoP;
	nodoP=record
		dato:pelicula;
		sig:listaP;
	end;
	
	vectorTotalPeliculas=array[1..generos] of listaP;
	vectorPeliculaMaxPuntaje=array[1..generos] of pelicula;

procedure crearListas(var vec:vectorTotalPeliculas);
var
	i:rangoGeneros;
begin
	for i:=1 to generos do
		vec[i]:=nil;
end;

procedure leerRegistro(var reg:pelicula);
begin
	writeln('Codigo pelicula: '); readln(reg.codigo);
	if(reg.codigo<>-1) then begin
		writeln('Codigo genero: '); readln(reg.genero);
		writeln('Puntaje promedio: '); readln(reg.puntaje);
		if(reg.puntaje<1) or (reg.puntaje>10) then reg.puntaje:=-1;
	end;
	writeln('---------------');
end;

procedure agregarAtras(var pri:listaP; var ult:listaP; elemento:pelicula);
var
	nuevo:listaP;
begin
	new(nuevo);
	nuevo^.dato:=elemento;
	nuevo^.sig:=nil;
	if(pri=nil) then begin
		pri:=nuevo;
		ult:=nuevo;
	end
	else begin
		ult^.sig:=nuevo;
		ult:=nuevo;
	end;
end;

procedure leerPeliculas(var vecPelis:vectorTotalPeliculas);
var
	regPeli:pelicula;
	vecUltNodo:vectorTotalPeliculas;
begin
	crearListas(vecPelis);
	
	leerRegistro(regPeli);
	while(regPeli.codigo<>-1) do begin
		agregarAtras(vecPelis[regPeli.genero],vecUltNodo[regPeli.genero], regPeli);
		leerRegistro(regPeli);
	end;
end;
	
procedure imprimirPeliculas(vecPelis:vectorTotalPeliculas);
var
	h:integer;
begin
	h:=1;
	while(h<=generos) do begin
		while(vecPelis[h]<>nil) do begin 
			writeln('Codigo pelicula: ',vecPelis[h]^.dato.codigo);
			writeln('Genero pelicula: ',vecPelis[h]^.dato.genero);
			writeln('Puntaje pelicula: ',vecPelis[h]^.dato.puntaje:1:2);
			vecPelis[h]:=vecPelis[h]^.sig;
			writeln(' ');
		end;
		h:=h+1;
		writeln('==========');
	end;
end;

procedure buscarMaximoPuntaje(listaPeli:listaP; var maxPeli:pelicula);
begin
	maxPeli.codigo:=-1;
	maxPeli.puntaje:=-1;
	while(listaPeli<>nil) do begin
		if(listaPeli^.dato.puntaje>maxPeli.puntaje) then maxPeli:=listaPeli^.dato;
		listaPeli:=listaPeli^.sig;
	end;
end;

procedure generarVectorPuntajes(peliculas:vectorTotalPeliculas; var vecPeliMax:vectorPeliculaMaxPuntaje; var dl:rangoGeneros);
var
	i:rangoGeneros;
	maxPelicula:pelicula;
begin
	for i:=1 to generos do begin
		buscarMaximoPuntaje(peliculas[i], maxPelicula);//si no hay peliculas de un genero, maxPelicula retorna codigo pelicula -1
		vecPeliMax[i]:=maxPelicula;
	end;
	dl:=generos;
end;

procedure eliminarPuntajeInvalido(var vec:vectorPeliculaMaxPuntaje; var dLogica:rangoGeneros);
var
	h:rangoGeneros;
	contador:integer;
begin
	contador:=0;
	for h:=1 to generos do begin
		if(vec[h].puntaje=-1) or (vec[h].codigo=-1) then contador:=contador+1
		else if (contador>0) then vec[h-contador]:=vec[h];
	end;
	dLogica:=dLogica-contador;
end;

procedure ordenarVector(var v:vectorPeliculaMaxPuntaje; var dl:rangoGeneros);
var
	i,j:integer;	//para evitar warnings del compilador no se usa rangoGeneros
	actual:pelicula;
begin
	eliminarPuntajeInvalido(v,dl);
	for i:=2 to dl do begin
		actual:=v[i];
		j:=i-1;
		while(j>0) and (v[j].puntaje<actual.puntaje) do begin
			v[j+1]:=v[j];
			j:=j-1;
		end;
		v[j+1]:=actual;
	end;
end;

var
	peliculas:vectorTotalPeliculas;
	peliculasMaxPuntaje:vectorPeliculaMaxPuntaje;
	dimL:rangoGeneros;
begin
	leerPeliculas(peliculas);
	writeln('*******');
	imprimirPeliculas(peliculas);
	generarVectorPuntajes(peliculas, peliculasMaxPuntaje,dimL);
	ordenarVector(peliculasMaxPuntaje,dimL);
	if(dimL>0) then begin	//Para evitar imprimir si todas las peliculas tenian codigos de error
		writeln('Codigo de pelicula con mejor puntaje: ',peliculasMaxPuntaje[1].codigo);
		writeln('Codigo de pelicula con peor puntaje: ',peliculasMaxPuntaje[dimL].codigo);
	end;
end.
