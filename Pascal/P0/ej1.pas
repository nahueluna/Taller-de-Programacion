program Ejercicio1;
Const
    matMax=36;
Type
    materias=0..matMax;

    ListaNotas = ^nodoN;
    nodoN = record
        dato:integer;
        sig:ListaNotas;
    end;

    alumno = record
        apellido:string;
        numero:integer;
        anioIngreso:integer;
        cantMaterias:materias;
        notas:ListaNotas;
    end;

    ListaAlumnos = ^nodoAlumno;
    nodoAlumno = record
        dato:alumno;
        sig:ListaAlumnos;
    end;
    
procedure agregarNota(var listaN:ListaNotas; nota:integer);
var
	nuevo:ListaNotas;
begin
	new(nuevo);
	nuevo^.dato:=nota;
	nuevo^.sig:=listaN;
	listaN:=nuevo;
end;

procedure cargarRegistro(var a:alumno);
var
	i:materias;
	nota:integer;
begin
	writeln('Apellido: '); readln(a.apellido);
	writeln('Numero: '); readln(a.numero);
	writeln('Ingreso: '); readln(a.anioIngreso);
	writeln('Materias: '); readln(a.cantMaterias);
	writeln('Notas: ');
	for i:=1 to a.cantMaterias do begin
		readln(nota);
		agregarNota(a.notas, nota);
	end;
end;

procedure agregarAdelanteAlumno(var alu:ListaAlumnos; elemento:alumno);
var
	nuevo:listaAlumnos;
begin
	new(nuevo);
	nuevo^.dato:=elemento;
	nuevo^.sig:=alu;
	alu:=nuevo;
end;

procedure leerAlumno(var alumnos:ListaAlumnos);
var
    datoAlu:alumno;
begin

    repeat
        datoAlu.notas:=nil;
        cargarRegistro(datoAlu);
        agregarAdelanteAlumno(alumnos, datoAlu);
    until(alumnos^.dato.numero=11111);
end;

procedure imprimirNotas(nota:ListaNotas);
begin
	writeln('Notas: ');
	while(nota<>nil) do begin
		writeln(nota^.dato);
		nota:=nota^.sig;
	end;
end;

procedure imprimirAlumnos(alum:ListaAlumnos);
begin
	while(alum<>nil) do begin
		writeln('---------------------');
		writeln(alum^.dato.apellido);
		writeln(alum^.dato.numero);
		writeln(alum^.dato.anioIngreso);
		writeln(alum^.dato.cantMaterias);
		imprimirNotas(alum^.dato.notas);
		alum:=alum^.sig;
	end;
end;

function calculoPromedio(cantMater:materias; lisNota:ListaNotas):real;
var
	sumaNota:integer;
begin
	sumaNota:=0;
	while(lisNota<>nil) do begin
		sumaNota:=sumaNota + lisNota^.dato;
		lisNota:=lisNota^.sig;
	end;
	calculoPromedio:=(sumaNota/cantMater);	//agregar un if(cantMater<>0) antes del proc.
end;

procedure incisoB(alum:ListaAlumnos);
begin
	while(alum<>nil) do begin
		if(alum^.dato.cantMaterias<>0) then
			writeln('El alumno ',alum^.dato.numero,' tiene promedio de ',calculoPromedio(alum^.dato.cantMaterias, alum^.dato.notas):1:2);
		alum:=alum^.sig;
	end;
end;

var
    alumnos:ListaAlumnos;

begin
    alumnos:=nil;
    leerAlumno(alumnos);
    incisoB(alumnos);
end.

//Debido a que las notas estan en una lista, no se deben hacer muchos cambios si no se conoce la cantidad
//de materias. Simplemente, en el módulo que suma las notas, debe tambien contar la cantidad de nodos (notas
//por materia) y luego calcular el promedio.
//Dado que no sabemos la cantidad de materias, se deberían ingresar las notas hasta cumplir determinada
//condición de corte.

//Para contabilizar los aplazos, se utilizaría la lista de notas. En vez de tener elementos de tipo entero,
//tendría elemento de tipo lista. Esta sublista contendría las notas. Por lo tanto, tendríamos la lista
//principal de alumnos, dentro una sublista1 con las notas por la materia (cada nodo corresponde a una materia)
//y dentro una sublista2 con todas las notas de dicha materia (con y sin aplazos).
//Dentro del módulo cargar registro tendría una variable local del tipo sublista2 y, en vez de leerla con un
//readln, llamaría un modulo que pregunte la nota (de la correspondiente materia) y la agregue en una lista
//hasta que se especifique una condición de corte. Luego, tal como antes, se agrega el puntero inicial de
//sublista2 a un nodo de sublista1 y se repite el proceso.
