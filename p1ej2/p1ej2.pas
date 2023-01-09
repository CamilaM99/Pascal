{2.- El administrador de un edificio de oficinas cuenta, en papel, con la información del pago de las expensas de dichas oficinas. 
Implementar un programa modularizado que:
a. Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina se ingresa el código de identificación, DNI del propietario y valor de la expensa.
*  La lectura finaliza cuando se ingresa el código de identificación -1, el cual no se procesa.
b. Ordene el vector, aplicando el método de inserción, por código de identificación de la oficina.
c. Ordene el vector aplicando el método de selección, por código de identificación de la oficina.}

program p1ej2;

const

dimf = 30; //300

type 

oficina = record 
	cod:integer;
	dni:integer;
	expensa:real;
end;

vector = array [1..dimf] of oficina;

procedure leerOficina (var o:oficina);
begin
	writeln('codigo');
	readln(o.cod);
	if (o.cod > -1) then begin
		o.dni:=random(100);
		writeln(o.dni);
		o.expensa:=random(100);
		writeln(o.expensa:3:2);
		writeln;
	end;	
end;

procedure generarVector (var v:vector; var diml:integer);
var o:oficina;
begin
	diml:=0;
	leerOficina(o);
	while (o.cod > -1) and (diml < dimf) do begin
		diml:=diml+1;
		v[diml]:=o;
		leerOficina(o);
	end;
end;

procedure ordenarSeleccion(var v:vector; diml:integer);
var i,j,p:integer; item:oficina;
begin
	for i:=1 to diml-1 do begin
		p:=i;
		for j:=i+1 to diml do 
			if (v[j].cod < v[p].cod) then 
				p:=j;
		item:=v[p];
		v[p]:=v[i];
		v[i]:=item;
	end;
end;

procedure ordenarInsercion(var v:vector; diml:integer);
var i,j:integer; actual:oficina;
begin
	for i:=2 to diml do begin
		actual:=v[i];
		j:=i-1;
			while (j > 0) and (v[j].cod > actual.cod) do begin
				v[j+1]:=v[j];
				j:=j-1;
			end;
		v[j+1]:=actual;
	end;
end;

procedure imprimir (v:vector; diml:integer);
var i:integer;
begin
	for i:= 1 to diml do begin
		writeln('codigo ', v[i].cod);
	end;
end;

var
 v:vector; diml:integer;
begin
	generarVector(v,diml);
	ordenarInsercion(v,diml);
	writeln;
	writeln('ordenado por insercion');
	imprimir(v,diml);
	ordenarSeleccion(v,diml);
	writeln;
	writeln('ordenado por seleccion');
	imprimir(v,diml);
end.
