program ej6;

procedure convertirBinario();
	procedure conversor(num:integer);
	begin
		if(num=1) then write(1)
		else begin
			conversor(num DIV 2);
			write(num MOD 2);
		end;
	end;
var
	num:integer;
begin
	write('Ingrese un numero: '); readln(num);
	if(num<>0) then begin 
		write('Su binario es: ');
		conversor(num);
		writeln;
		writeln;
		convertirBinario();
	end;
end;

begin
	convertirBinario();
end.
