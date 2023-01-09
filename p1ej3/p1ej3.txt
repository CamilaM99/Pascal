{3.- Netflix ha publicado la lista de películas que estarán disponibles durante el mes de diciembre de 2022. De cada película se conoce:
 código de película, código de género (1: acción, 2: aventura, 3: drama, 4: suspenso, 5: comedia, 6: bélica, 7: documental y 8: terror) y puntaje promedio otorgado por las críticas. 
Implementar un programa modularizado que:
a. Lea los datos de películas y los almacene por orden de llegada y agrupados por código de género, en una estructura de datos adecuada. La lectura finaliza cuando se lee el código de la película -1. 
b. Una vez almacenada la información, genere un vector que guarde, para cada género, el código de película con mayor puntaje obtenido entre todas las críticas.
c. Ordene los elementos del vector generado en b) por puntaje utilizando alguno de los dos métodos vistos en la teoría. 
d. Luego de ordenar el vector, muestre el código de película con mayor puntaje y el código de película con menor puntaje.
}


program p1ej3;

type 
rangoGenero = 1..8;

pelicula = record 
	codPeli:integer;
	codGen:rangoGenero;
	puntaje:real;
end;

lista = ^nodo;

nodo = record
	dato:pelicula;
	sig:lista;
end;


vector = array [rangoGenero] of lista;
vectorMaxCod = array [rangoGenero] of pelicula;

//para que sea mas rapido
{
procedure leerPelicula(var p:pelicula);
begin
	writeln('codigo pelicula');
	readln(p.codPeli);
	if (p.codPeli > -1) then begin
		writeln('codigo genero');	
		p.codGen := random(8)+1;
		writeln(p.codGen);
		writeln('puntaje');
		p.puntaje := random (10);
		writeln(p.puntaje:2:2);
		writeln;
	end;
end;
}


procedure leerPelicula(var p:pelicula);
begin
	writeln('codigo pelicula');
	readln(p.codPeli);
	if (p.codPeli > -1) then begin
		writeln('codigo genero');	
		readln(p.codGen);
		writeln('puntaje');
		readln(p.puntaje);
		writeln;
	end;
end;


procedure insertarAtras(var l,ult:lista; p:pelicula);
var nue:lista;
begin
	new(nue);
	nue^.dato:=p;
	nue^.sig:=nil;
	if (l = nil) then
		l:=nue
	else
		ult^.sig:=nue;
	ult:=nue;
end;


procedure generarLista(var v:vector);
var p:pelicula; ult:vector;
begin
	leerPelicula(p);
	while (p.codPeli > -1) do begin
		insertarAtras(v[p.codGen],ult[p.codGen],p);
		leerPelicula(p);
	end;
end;


procedure imprimirVecLista(v:vector);
var i:integer;
begin
	writeln;
	for i:=1 to 8 do begin
		while (v[i] <> nil) do begin
			writeln('pos ',i);
			writeln('cod genero ',v[i]^.dato.codGen);
			writeln('cod pelicula ',v[i]^.dato.codPeli);
			writeln('puntaje ',v[i]^.dato.puntaje:2:2);
			writeln;
			v[i]:=v[i]^.sig;
		end;
	end;
end;


procedure maximo(var max:pelicula; l:lista);
begin
	max.puntaje:=-1;
	while (l <> nil) do begin
		if (l^.dato.puntaje > max.puntaje) then 
			max:=l^.dato;
		l:=l^.sig;
	end;
end;


procedure generarVector2(var v2:vectorMaxCod; v:vector);
var i:integer;
begin
	for i:=1 to 8 do begin
		maximo(v2[i],v[i]);
	end;
end;


procedure imprimir (v2:vectorMaxCod);
var i:integer;
begin
	for i:=1 to 8 do begin
		writeln('del genero numero ',i,' el cod de pelicula con mayor puntaje es ', v2[i].codPeli,', puntaje ', v2[i].puntaje:2:2);
	end;
end;


procedure ordenar(var v2:vectorMaxCod);
var i,j:integer; actual:pelicula;
begin
	for i:=2 to 8 do begin
		actual:=v2[i];
		j:=i-1;
		while (j > 0) and (v2[j].puntaje > actual.puntaje) do begin
			v2[j+1]:=v2[j];
			j:=j-1;
		end;
		v2[j+1]:=actual;
	end;
end;

procedure imprimirOrdenado (var v2:vectorMaxCod);
var i:integer;
begin
	for i:=1 to 8 do begin
		writeln('pos ', i,' | puntaje ', v2[i].puntaje:2:2,' | cod Peli ',v2[i].codPeli,' | cod genero ',v2[i].codGen);
	end;
end;
var
l:lista; v:vector; v2:vectorMaxCod;   
begin
	l:=nil;
	generarLista(v); //A
	writeln('----- vector de listas -----');
	imprimirVecLista(v);
	generarVector2(v2,v);//B
	writeln;
	writeln('----- vector de codigos de pelicula -----');
	imprimir(v2);
	ordenar(v2); //C
	writeln('----- vector de codigos de pelicula ordenado por puntaje -----');
	imprimirOrdenado(v2);
	writeln;
	writeln('el codigo de pelicula con mayor puntaje es ', v2[8].codPeli,' con el puntaje ', v2[8].puntaje); //D
	writeln('el codigo de pelicula con menor puntaje es ', v2[1].codPeli,' con el puntaje ', v2[1].puntaje); //D
end.
