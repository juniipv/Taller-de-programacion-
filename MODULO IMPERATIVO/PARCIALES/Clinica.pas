{
Una clínica necesita un sistema para el procesamiento de las atenciones realizadas a los pacientes en julio de 2024.

a) Implementar un módulo que lea la información de las atenciones. 
De cada atención se lee: matrícula del médico, dni del paciente, día y diagnóstico (valor entre A y F
La lectura finaliza con el dni 0. Se sugiere utilizar el módulo leerAtencion(). 
El módulo deber retornar dos estructuras:
	i. Un árbol binario de búsqueda ordenado por matrícula del médico. 
		Para cada matrícula de médico debe almacenarse la cantidad de atenciones realizadas.
	ii. Un vector que almacene en cada posición el tipo del diagnóstico 
		y la lista de los DNI de pacientes atendidos con ese diagnóstico.

b) Implementar un módulo que reciba el árbol generado en a), una matrícula 
y retorne la cantidad total de atenciones realizadas por los médicos con matrícula superior a la matrícula ingresada.

c) Realizar un módulo recursivo que reciba el vector generado en a) y retorne el diagnóstico con mayor cantidad de pacientes atendidos.
}

program parcialClinicaM;

type
	
	atencion = record
        matricula: integer;
        dni: integer;
        dia: integer;
        diagnostico: char;
    end;
    
    regArbol = record
		matricula: integer;
		cant: integer;
	end;
	
	lista = ^nodoLista;
	
	nodoLista = record
		dato: integer;
		sig: lista
    end;
    
    arbol = ^nodoArbol;
    
    nodoArbol = record
		dato: regArbol;
		HI: arbol;
		HD: arbol;
	end;
	
	regVector = record
		diagnostico: char;
		l: lista;
	end;
	
	vector = array ['A'..'F'] of regVector;

procedure leerAtencion(var a : atencion);
var 
	v: array [1..6] of char = ('A', 'B', 'C', 'D', 'E', 'F');
begin
    a.dni := Random(50);
    if (a.dni <> 0) then begin
        a.matricula := Random(1000)+ 2000;
        a.dia := Random(31) + 1;
        a.diagnostico := v[Random(6) + 1];
    end;
end;

procedure agregarAlArbol(var a: arbol; at: atencion);
begin
	if(a = nil)then
	begin
		new(a);
		a^.dato.matricula := at.matricula;
		a^.dato.cant := 1;
		a^.HI := nil;
		a^.HD := nil;
	end
	else if(a^.dato.matricula = at.matricula)then
		a^.dato.cant := a^.dato.cant + 1
	else if(at.matricula < a^.dato.matricula)then
		agregarAlArbol(a^.HI, at)
	else
		agregarAlArbol(a^.HD, at)
end;

procedure inicializarVector(var v: vector);
var
	i: char;
begin
	for i := 'A' to 'F' do
	begin
		v[i].diagnostico := i;
		v[i].l := nil;
	end;
end;

procedure agregarAdelante(var l: lista; dni: integer);
var
	nuevo: lista;
begin
	new(nuevo);
	nuevo^.dato := dni;
	nuevo^.sig := l;
	l := nuevo;
end;

procedure agregarAlVector(var v: vector; at: atencion);
begin
	agregarAdelante(v[at.diagnostico].l, at.dni);
end;

procedure cargarDatos(var a: arbol; var v: vector);
var 
	at: atencion;
begin
	leerAtencion(at);
	while(at.dni <> 0)do
	begin
		agregarAlArbol(a, at);
		agregarAlVector(v, at);
		leerAtencion(at);
	end;
end;

procedure imprimirArbol(a: arbol);
begin
	if(a <> nil)then
	begin
		imprimirArbol(a^.HI);
		writeln('Matricula: ', a^.dato.matricula, ' | cant: ', a^.dato.cant);
		imprimirArbol(a^.HD);
	end;
end;

procedure imprimirLista(l: lista);
begin
	while(l <> nil)do
	begin
		writeln('     DNI: ', l^.dato);
		l := l^.sig;
	end;
end;

procedure imprimirVector(v: vector);
var
	i: char;
begin
	for i := 'A' to 'F' do
	begin
		writeln('Lista de diagnostico: ', i);
		imprimirLista(v[i].l);
	end;
end;

// MODULO B

function retornarCantidadAtenciones(a: arbol; m: integer): integer;
begin
	if(a = nil)then
		retornarCantidadAtenciones := 0
	else if (a^.dato.matricula > m)then
		retornarCantidadAtenciones := a^.dato.cant + retornarCantidadAtenciones(a^.HI, m) + retornarCantidadAtenciones(a^.HD, m)
	else
		retornarCantidadAtenciones := retornarCantidadAtenciones(a^.HD, m);
end;

//MODULO C
function contarLista(l: lista): integer;
begin
	if(l <> nil)then
		contarLista := 1 + contarLista(l^.sig)
	else
		contarLista := 0;
end;

procedure retornarMax(v: vector; var pos: integer; var max: integer; var maxD: char);
var
	cant: integer;
	v2: array [1..6] of char = ('A', 'B', 'C', 'D', 'E', 'F');
begin
	cant := 0;
	if(pos <= 6)then
	begin
		cant := contarLista(v[v2[pos]].l);
	
		if(cant > max)then
		begin
			max := cant;
			maxD := v2[pos];
		end;
			
		pos := pos + 1;
		retornarMax(v, pos, max, maxD);
	end; 
end;

var
	a: arbol;
	v: vector;
	cant: integer;
	matricula: integer;
	max: integer;
	pos: integer;
	maxDiagnostico: char;
begin
	randomize;
	a := nil;
	inicializarVector(v);
	cargarDatos(a, v);
	
	writeln('Arbol: ');
	imprimirArbol(a);
	writeln;
	writeln('Vector: ');
	imprimirVector(v);
	
	writeln;
	writeln('Ingrese una matricula: ');
	readln(matricula);
	cant := retornarCantidadAtenciones(a, matricula);
	writeln('Hay ', cant, ' atenciones realizadas para matriculas superiores a la ingresada');
		
	writeln;
	max := -1;
	pos := 1;
	retornarMax(v, pos, max, maxDiagnostico);
	writeln('El diagnostico con mayor cantidad de pacientes atendidos es el ', maxDiagnostico);
end.
