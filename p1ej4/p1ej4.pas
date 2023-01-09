{4.- Una librería requiere el procesamiento de la información de sus productos. De cada producto se conoce el código del producto, código de rubro (del 1 al 8) y precio. 

Implementar un programa modularizado que:
a. Lea los datos de los productos y los almacene ordenados por código de producto y agrupados por rubro, en una estructura de datos adecuada.
*  El ingreso de los productos finaliza cuando se lee el precio 0.

b. Una vez almacenados, muestre los códigos de los productos pertenecientes a cada rubro.

c. Genere un vector (de a lo sumo 30 elementos) con los productos del rubro 3. Considerar que puede haber más o menos de 30 productos del rubro 3. 
* Si la cantidad de productos del rubro 3 es mayor a 30, almacenar los primeros 30 que están en la lista e ignore el resto. 

d. Ordene, por precio, los elementos del vector generado en b) utilizando alguno de los dos métodos vistos en la teoría. 

e. Muestre los precios del vector ordenado.
}


 program p1ej4;
 
 type 
 
rangoCod = 1..8;
 
producto = record 
	codProd: integer;
	codRubro: rangoCod;
	precio: real;
end;

lista = ^nodo;
nodo = record
	dato:producto;
	sig:lista;
end;



vectorLista = array [rangoCod] of lista;

vectorRubro3 = array [1..30] of producto;

procedure leerProducto (var p:producto);
begin
	writeln('precio');
	readln(p.precio);
	if (p.precio > 0) then begin
		writeln('cod producto');
		readln(p.codProd);
		writeln('cod rubro');
		readln(p.codRubro);
		writeln;
	end;
end;


procedure insertarOrdenado(var l:lista; p:producto);
var ant,act,nue:lista; 
begin
	new(nue);
	nue^.dato:=p;
	act:=l;
	ant:=l;
	while (act <> nil) and (act^.dato.codProd < p.codProd) do begin
		ant:=act;
		act:=act^.sig;
	end;
	if (ant = act) then 
		l:=nue
	else
		ant^.sig:=nue;
	nue^.sig:=act;
end;

procedure generarVectorDeListas(var v:vectorLista);
var p:producto;
begin
	leerProducto(p);
	while (p.precio > 0) do begin
		insertarOrdenado(v[p.codRubro],p);
		leerProducto(p);
	end;
end;

procedure imprimirVectorLista(v:vectorLista);
var i:integer;
begin
	for i:=1 to 8 do begin
		while (v[i] <> nil) do begin
			writeln('| cod Rubro ',v[i]^.dato.codRubro,' | cod Producto ',v[i]^.dato.codProd,' | precio ',v[i]^.dato.precio:3:1);
			v[i]:=v[i]^.sig;
		end;
	end;
end;

procedure generarVectorRubro3(var vr:vectorRubro3; v:vectorLista; var diml:integer);
begin
	diml:=0;
	while (v[3]<>nil)do begin
		diml:=diml+1;
		vr[diml]:=v[3]^.dato;
		v[3]:=v[3]^.sig;
	end;
end;

procedure imprimirVectorRubro(vr:vectorRubro3; diml:integer);
var i:integer;
begin
	for i:=1 to diml do begin
		writeln('rubro ', vr[i].codRubro,'| cod Producto ', vr[i].codProd,' | precio ', vr[i].precio:3:1);
	end;
end;


procedure ordenarVecRubro (var vr:vectorRubro3; diml:integer);
var i,j:integer;  actual:producto;
begin
	for i:=2 to diml do begin
		actual:=vr[i];
		j:=i-1;
			while (j > 0) and (vr[j].precio > actual.precio) do begin
				vr[j+1]:=vr[j];
				j:=j-1;
			end;
		vr[j+1]:=actual;
	end;
end;


var l:lista; v:vectorLista; vr:vectorRubro3; diml:integer;
begin
	generarVectorDeListas(v); //A
	writeln('---- vector lista ----');
	writeln;
	imprimirVectorLista(v); //B
	
	generarVectorRubro3(vr,v,diml);//C
	writeln('---- vector rubro 3 sin orden ----');
	imprimirVectorRubro(vr,diml); 
	
	ordenarVecRubro(vr,diml); //D
	writeln;
	writeln('---- vector rubro 3 ordenado por precio ----');
	imprimirVectorRubro(vr,diml); //E
end.
