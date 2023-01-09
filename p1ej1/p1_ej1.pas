{1.- Implementar un programa que procese la información de las ventas de productos de un comercio (como máximo 20). 
De cada venta se conoce código del producto (entre 1 y 15) y cantidad vendida (como máximo 99 unidades).  El ingreso de las ventas finaliza con el código 0 (no se procesa).
a. Almacenar la información de las ventas en un vector. El código debe generarse automáticamente (random) y la cantidad se debe leer. 
b. Mostrar el contenido del vector resultante.
c. Ordenar el vector de ventas por código.
d. Mostrar el contenido del vector resultante.
e. Eliminar del vector ordenado las ventas con código de producto entre dos valores que se ingresan como parámetros. 
f. Mostrar el contenido del vector resultante.
g. Generar una lista ordenada por código de producto de menor a mayor a partir del vector resultante del inciso e., sólo para los códigos pares.
h. Mostrar la lista resultante.}

program p1_ej1;
const

dimf = 20;

type 

rangoCod = 0..15;
rangoCant = 1..99;

venta = record
	cod:rangoCod;
	cant:rangoCant;
end;

vectorVenta = array [1..dimf] of venta;

lista = ^nodo;

nodo = record
	dato:venta;
	sig:lista;
end;


procedure leerVenta(var ven:venta);
begin
	ven.cod:=random(15);
	writeln('cod');
	writeln(ven.cod);
	if (ven.cod > 0) then begin
		writeln('cant');
		readln(ven.cant);
	end;
end;

procedure generarVectorVenta (var v:vectorVenta; var diml:integer);
var ven:venta;
begin
	diml:=0;
	leerVenta(ven);
	while (ven.cod > 0) and (diml < dimf) do begin
		diml:=diml+1;
		v[diml]:=ven;
		leerVenta(ven);
	end;
end;

procedure imprimir (v:vectorVenta; diml:integer);
var i:integer;
begin
	for i:=1 to diml do begin
		writeln('  pos ', i);
		writeln('     cod ', v[i].cod);
		writeln('     cant ', v[i].cant);
	end;
end;

procedure ordenarSeleccion(var v:vectorVenta; diml:integer);
var i,j,pos:integer; item:venta;
begin
	for i:=1 to diml-1 do begin
		pos:=i;
		for j:=i+1 to diml do 
			if (v[j].cod < v[pos].cod) then
				pos:=j;
		item := v[pos];
		v[pos]:=v[i];
		v[i]:=item;
	end;
end;

procedure borrarRango(var v:vectorVenta; var diml:integer; inf,sup:integer);
var i,ini,fin,cantBorrar:integer;
begin
	ini:=1;
	while (ini <= diml) and (v[ini].cod < inf) do
		ini:=ini+1;
	fin:=ini;
	while (fin <= diml) and (v[fin].cod <= sup) do 
		fin:=fin+1;
	cantBorrar:= fin - ini;
	if (cantBorrar > 0) then begin
		for i:=fin to diml do begin
			v[ini]:=v[i];
			ini:=ini+1;
		end;
	end;
	diml:=diml - cantBorrar;
end;


procedure insertarAtras(var l,ult:lista; v:venta);
var nue:lista;
begin
	if ((v.cod mod 2)=0) then begin
		new(nue);
		nue^.dato:=v;
		nue^.sig:=nil;
		if (l = nil) then 
			l:=nue
		else
			ult^.sig:=nue;
		ult:=nue;
	end;
end;

procedure generarLista(v:vectorVenta; diml:integer;var l:lista);
var i:integer; aux:lista;
begin
	for i:=1 to diml do 
		insertarAtras(l,aux,v[i]);
end;

procedure imprimirLista(l:lista);
begin
	while (l <> nil) do begin
		writeln('cod ', l^.dato.cod);
		writeln('cant ', l^.dato.cant);
		writeln;
		l:=l^.sig;
	end;
end;	

var v:vectorVenta; diml:integer; inf,sup:integer; l:lista;
begin
	l:=nil;
	generarVectorVenta(v,diml); //A
	writeln('--- vector de ventas desordenado ----');
	imprimir(v,diml); //B
	ordenarSeleccion(v,diml); //C
	writeln('---- vector de ventas ordenado por seleccion ----');
	imprimir(v,diml); //D
	writeln;
	writeln('ingrese el cod min para borrar');
	readln(inf);
	writeln('ingrese el cod max para borrar');
	readln(sup);
	borrarRango(v,diml,inf,sup);//E
	writeln;
	writeln('---- vector de ventas con valores eliminados ----');
	imprimir(v,diml); //F
	writeln;
	generarLista(v,diml,l); //G
	writeln('---- lista de ventas con cod pares ----');
	imprimirLista(l);//H
end.
