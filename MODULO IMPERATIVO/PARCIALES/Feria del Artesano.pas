{La Feria del Artesano necesita un sistema para obtener estadísticas sobre las artesanías presentadas.

A) Implementar un módulo que lea la información de las artesanías. 
De cada artesanía se conoce: número de identificación de la artesanía, 
DNI del artesano y código del material base (1: madera, 2: yeso, 3: cerámica, 4: vidrio, 5: acero, 6: porcelana, 7: lana, 8: cartón). 
La lectura finaliza con el valor 0 para el DNI. El módulo debe retornar dos estructuras:

i. Un árbol binario de búsqueda ordenado por el DNI del artesano. 
Para cada DNI del artesano debe almacenarse la cantidad de artesanías correspondientes al DNI. 
ii. Un vector que almacene para cada material base, el código del material base y la cantidad de artesanías del material base.

b) Implementar un módulo que reciba el árbol generado en a) y un DNI. 
El módulo debe retornar la cantidad de artesanos con DNI menor al DNI ingresado. 

c) Implementar un módulo que reciba el vector generado en a), 
lo ordene por cantidad de artesanías de menor a mayor y retorne el nombre de material base con mayor cantidad de artesanías.
}

program feriaArtesano;

type 
	
	rangoCodigo = 1..8;

	artesania = record
		nro: integer;
		dni: integer;
		codigo: rangoCodigo;
	end;
	
	regVector = record
		codigo: integer;
		cant: integer;
	end;
	
	vector = array[rangoCodigo] of regVector;
	
	arbol = ^nodoArbol;
	
	nodoArbol = record
		dni: integer;
		cant: integer;
		HI: arbol;
		HD: arbol;
	end;
	
	
procedure inicializarVector(var v: vector);
var
	i: integer;
begin
	for i := 1 to 8 do
	begin
		v[i].codigo := i;
		v[i].cant := 0;
	end;
end;

procedure leerArtesania(var a: artesania);
begin
	a.dni := random(100);
	write('DNI: ', a.dni);
	if(a.dni <> 0)then
	begin
		a.nro := random(100)+2000;
		write(' | nro: ', a.nro);
		a.codigo := random(8)+1;
		write(' | codigo: ', a.codigo);
		writeln;
	end;
end;

procedure agregarAlArbol(var a: arbol; art: artesania);
begin
	if(a = nil)then
	begin
		new(a);
		a^.dni := art.dni;
		a^.cant := 1;
		a^.HI := nil;
		a^.HD := nil;
	end
	else if(a^.dni = art.dni)then
		a^.cant := a^.cant + 1
	else if(art.dni < a^.dni)then
		agregarAlArbol(a^.HI, art)
	else
		agregarAlArbol(a^.HD, art)
end;

procedure cargarDatos(var a: arbol; var v: vector);
var
	art: artesania;
begin
	leerArtesania(art);
	while(art.dni <> 0)do
	begin
		agregarAlArbol(a, art);
		v[art.codigo].cant := v[art.codigo].cant + 1;
		leerArtesania(art);
	end;
end;

procedure imprimirArbol(a: arbol);
begin
	if(a <> nil)then
	begin
		imprimirArbol(a^.HI);
		writeln('DNI: ', a^.dni, ' | cant: ', a^.cant);
		imprimirArbol(a^.HD);
	end;
end;

procedure imprimirVector(v: vector);
var
	i: integer;
begin
	for i := 1 to 8 do
		writeln('Codigo: ', v[i].codigo, ' | cant: ', v[i].cant);
end;

function retornarMenoresADNI(a:arbol; dni: integer): integer;
begin
	if(a = nil)then
		retornarMenoresADNI := 0
	else if(a^.dni < dni)then
		retornarMenoresADNI := 1 + retornarMenoresADNI(a^.HI, dni) + retornarMenoresADNI(a^.HD, dni)
	else
		retornarMenoresADNI := retornarMenoresADNI(a^.HI, dni) 
end;

//MODULO C
procedure ordenarVector(var v: vector; var max: string);
var
	pos, i, j: integer;
	item: regVector;
	
	v2: array[rangoCodigo] of String = ('madera', 'yeso', 'ceramica', 'vidrio', 'acero', 'porcelana', 'lana', 'carton');
begin
	for i := 1 to 7 do begin
		pos := i;
		for j := i+1 to 8 do
			if(v[pos].cant > v[j].cant)then
				pos := j;
			
		item := v[pos];
		v[pos] := v[i];
		v[i] := item;
	end;
	
	max := v2[v[8].codigo];
end;

var
	a: arbol;
	v: vector;
	dni, cantMenores: integer;
	max: string;
begin
	randomize;
	
	a := nil;
	inicializarVector(v);
	cargarDatos(a, v);
	writeln;
	writeln;
	imprimirArbol(a);
	writeln;
	imprimirVector(v);
	writeln;
	writeln;
	
	//MODULO B
	writeln('Ingrese un dni para retornar los dni menores a ese:');
	readln(dni);
	cantMenores := retornarMenoresADNI(a, dni);
	writeln('La cantidad de dni menores a ese es: ', cantMenores);
	
	//MODULO C
	
	writeln;
	writeln;
	ordenarVector(v, max);
	imprimirVector(v);
	writeln;
	writeln('El material con mayor cantidad de artesanias es: ', max);
end.
	
	
