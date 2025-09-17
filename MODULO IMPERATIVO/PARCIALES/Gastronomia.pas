{
TURNO P (recursantes)

Una empresa de gastronomía desea procesar las entregas de comida realizadas a sus clientes durante el año 2024.

A)Implementar un módulo que lea las entregas de comidas. De cada compra se lee código de comida, código de cliente 
* y categoría de la entrega(“Full”, ”Super”, “Media”, “Normal”, “Básica”). La lectura finaliza con el código de cliente 0. 
Se deben retornar 2 estructuras de datos:

i. Un árbol binario de búsqueda ordenado por código de comida. Para cada código de comida debe almacenarse la cantidad de entregas 
realizadas a ese código entre todos los clientes.
ii. Un vector que almacene en cada posición el nombre de la categoría y la cantidad de entregas realizadas para esa categoría.

B) Implementar un módulo que reciba el árbol generado en a) y un código de comida. 
El módulo debe retornar la cantidad de entregas realizadas al código de comida ingresado.

c) Implementar un módulo que reciba el vector generado en a), lo ordene por cantidad de entregas de menor a mayor 
y retorne la categoría con mayor cantidad de entregas.
}


program gastronomia;

type
	
	compra = record
		cod_comida: integer; 
		cod_cliente: integer;
		categoria: string;
	end;
	
	regArbol = record
		cod_comida: integer;
		cantidad: integer;
	end;
	
	arbol = ^nodoArbol;
	
	nodoArbol = record
		dato: regArbol;
		HI: arbol;
		HD: arbol;
	end;
	
	regVector = record
		categoria: string;
		cantidad: integer;
	end;
	
	vector = array [1..5] of regVector;
	
// ----------------------- CARGA DE DATOS ---------------------- //	

procedure leerCompra(var c: compra);
var
	v: array [1..5] of string = ('Full', 'Super', 'Media', 'Normal', 'Basica');
begin
	c.cod_cliente := random(100);
	if(c.cod_cliente <> 0)then
	begin
		c.cod_comida := random(50) + 1000;
		c.categoria := v[random(5)+1];
	end;
end;

procedure inicializarVector(var v: vector);
var 
	i: integer;
	v2: array [1..5] of string = ('Full', 'Super', 'Media', 'Normal', 'Basica');
begin
	for i := 1 to 5 do
	begin
		v[i].categoria := v2[i];
		v[i].cantidad := 0;
	end;
end;

procedure cargarArbol(var a: arbol; c: compra);
begin
	if(a = nil)then
	begin
		new(a);
		a^.dato.cod_comida := c.cod_comida;
		a^.dato.cantidad := 1;
		a^.HI := nil;
		a^.HD := nil;
	end
	else if(c.cod_comida = a^.dato.cod_comida)then
		a^.dato.cantidad := a^.dato.cantidad + 1
	else if(c.cod_comida < a^.dato.cod_comida)then
		cargarArbol(a^.HI, c)
	else
		cargarArbol(a^.HD, c);
end;

procedure cargarDatos(var a: arbol; var v: vector);
var
	c: compra;
	pos: integer;
begin
	leerCompra(c);
	while(c.cod_cliente <> 0)do
	begin
		pos := 1;
		cargarArbol(a, c);
		while(v[pos].categoria <> c.categoria)do
			pos := pos + 1;
		v[pos].cantidad := v[pos].cantidad + 1;
		leerCompra(c);
	end;
end;

procedure imprimirArbol(a: arbol);
begin
	if(a <> nil)then
	begin
		imprimirArbol(a^.HI);
		writeln('Cod de comida: ', a^.dato.cod_comida, ' | cant: ', a^.dato.cantidad);
		imprimirArbol(a^.HD);
	end;
end;

procedure imprimirVector(v: vector);
var
	i: integer;
begin
	for i := 1 to 5 do 
		writeln('Categoria: ', v[i].categoria, ' | cantidad: ', v[i].cantidad);
end;

// ----------------- MODULO B --------------- 
function retornarCant(a: arbol; cod: integer): integeR;
begin
	if(a = nil)then
		retornarCant := 0
	else if(a^.dato.cod_comida = cod)then
		retornarCant := a^.dato.cantidad
	else if(cod < a^.dato.cod_comida)then
		retornarCant := retornarCant(a^.HI, cod)
	else
		retornarCant := retornarCant(a^.HD, cod)
end;

procedure ordenarVector(var v: vector; var max: string);
var
	pos, i, j: integer;
	item: regVector;
begin
	for i := 1 to 4 do begin
		pos := i;
		for j := i+1 to 5 do
			if(v[pos].cantidad > v[j].cantidad)then
				pos := j;
				
		item := v[pos];
		v[pos] := v[i];
		v[i] := item;
	end;

	max := v[5].categoria;
end;

var
	a: arbol;
	v: vector;
	cant: integer;
	cod: integer;
	max: string;
begin
	randomize;
	a := nil;
	inicializarVector (v);
	
	cargarDatos (a, v);
	writeln('arbol:');
	imprimirArbol(a);
	writeln;
	writeln('vector:');
	imprimirVector(v); 
	
	writeln;
	writeln('Ingrese un codigo de comida para buscar cantidad: ');
	readln(cod);
	cant := retornarCant(a, cod);
	writeln;
	writeln('El codigo ingresado tiene ', cant, ' compras');
	
	writeln;
	ordenarVector(v, max);
	imprimirVector(v);
	writeln;
	writeln('La categoria con mayor cantidad de compras es ', max);
end.






