{
TURNO L (recursantes)

Se lee información de las compras realizadas por los clientes a un supermercado en el año 2024. 
De cada compra se lee el código de cliente, número de factura, número de mes y monto gastado. 
La lectura finaliza cuando se lee el cliente con código 0.

A) Realizar un módulo que lea la información de las compras y retorne un árbol de búsqueda ordenado por código de cliente. 
Para cada código de cliente, se debe almacenar un vector con el monto total gastado por dicho cliente en cada mes del año 2024

B) Realizar un módulo que reciba la estructura generada en a) y un código de cliente, y retorne el mes con mayor gasto de dicho cliente.

C) Realizar un módulo que reciba la estructura generada en a) y un número de mes, 
y retorne la cantidad de clientes que no gastaron nada en dicho mes.
}
program parcialSupermercado;
const
	dimf = 12;
type

	rangoMes = 1..dimf;
	
	vector = array [rangoMes] of real;
	
	compra = record
		codCliente: integer;
		numFactura: integer;
		mes: rangoMes;
		monto: real;
	end;
	
	arbol = ^nodoArbol;

	nodoArbol = record
		codCliente: integer;
		vec: vector;
		HI: arbol;
		HD: arbol;
	end;
	
procedure inicializarVector(var v: vector);
var
	i: integer;
begin
	for i := 1 to dimf do
		v[i] := 0;
end;
	
// --------------- CARGA DE DATOS ----------------- //
procedure leerCompra(var c: compra);
begin
	c.codCliente := random(10);
	write('Cod cliente: ', c.codCliente);
	if(c.codCliente <> 0)then
	begin
		c.numFactura := random(2000)+10000;
		c.mes := random(12)+1;
		write(' | mes : ', c.mes);
		c.monto := random(20000) / (random(10)+1);
		write(' | monto: ', c.monto:0:2);
		writeln;
	end;
end;

procedure agregarAlArbol(var a: arbol; c: compra);
begin
	if(a = nil)then
	begin
		new(a);
		a^.codCliente := c.codCliente;
		inicializarVector(a^.vec);
		a^.vec[c.mes] := c.monto;
		a^.HI := nil;
		a^.HD := nil;
	end
	else if(c.codCliente = a^.codCliente)then
		a^.vec[c.mes] := a^.vec[c.mes] + c.monto
	else if(c.codCliente < a^.codCliente)then
		agregarAlArbol(a^.HI, c)
	else
		agregarAlArbol(a^.HD, c)
end;

procedure cargarDatos(var a: arbol);
var
	c: compra;
begin
	leerCompra(c);
	while(c.codCliente <> 0)do
	begin
		agregarAlArbol(a, c);
		leerCompra(c);
	end;
end;

// ------------- IMPRESION -------------- //
procedure imprimirVector(v: vector);
var
	i: integer;
begin
	for i := 1 to dimf do		
		writeln('    mes ', i, ' - monto total: ', v[i]:0:2);
end;

procedure imprimirArbol(a: arbol);
begin
	if(a <> nil)then
	begin
		imprimirArbol(a^.HI);
		writeln('Cod de cliente: ', a^.codCliente);
		imprimirVector(a^.vec);
		writeln;
		imprimirArbol(a^.HD);
	end;
end;
		
// --------------- MODULO B ----------------- //
procedure actualizarMaximo(v: vector; var max: real; var mesMax: integer);
var
	i: integer;
begin
	for i := 1 to 12 do
		if(v[i] > max)then
		begin
			max := v[i];
			mesMax := i;
		end;
end;

procedure retornarMesMayor(a: arbol; cod: integer; var max: real; var mesMax: integer);
begin
	if(a <> nil)then 
	begin
		if(a^.codCliente = cod)then
			actualizarMaximo(a^.vec, max, mesMax)
		else if(a^.codCliente < cod)then
			retornarMesMayor(a^.HD, cod, max, mesMax)
		else
			retornarMesMayor(a^.HI, cod, max, mesMax)
	end;	
end;
	
// --------------- MODULO C ----------------- //

function cantClientesPorMes(a: arbol; mes: integer): integer;
begin
	if(a = nil)then
		cantClientesPorMes := 0
	else if(a^.vec[mes] = 0)then
			cantClientesPorMes := 1 + cantClientesPorMes(a^.HI, mes) + cantClientesPorMes(a^.HD, mes)
	else
		cantClientesPorMes := cantClientesPorMes(a^.HI, mes) + cantClientesPorMes(a^.HD, mes)
end;
	
var 
	a: arbol;
	cod: integer;
	max: real; 
	mesMax: integer;
	cantClientes, mes: integer;
begin
	a := nil;
	randomize;
	cargarDatos(a);
	writeln;
	writeln;
	//
	imprimirArbol(a);
	writeln;
	writeln;
	writeln('Ingrese un codigo de cliente');
	readln(cod);
	max := -1;
	retornarMesMayor(a, cod, max, mesMax);
	writeln;
	writeln('El mes con mayor gasto del clientes es el mes: ', mesMax);
	
	writeln;
	writeln;
	writeln('Ingrese un mes de cliente');
	readln(mes);
	cantClientes := cantClientesPorMes(a, mes);
	writeln;
	writeln('Cant de clientes que no gastaron ese mes: ', cantClientes);
end.
	
	
	
	
	
