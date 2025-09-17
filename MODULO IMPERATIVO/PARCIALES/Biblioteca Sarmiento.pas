{La biblioteca sarmiento necesita un isstema para obtener estadisticas sobre los libros
* prestados. De cada prestamo se conoce el numero de prestamo, ISBN del libro y codigo de socio.
* La lectura finaliza con el codigo de socio 0 y todos los prestamos realizados a un mismo socio 
* se leen consecutivamente
* a) Implementar un modulo que lea informacion de los prestamos y genere:
*  I) Una estructura de datos eficiente para la busqueda por ISBN del libro.}
program parcial4; 
type
 prestamo= record
  isbn: integer;
  codsocio: integer;
 end; 
 
 arbol=^nodo;
 nodo= record
  dato: prestamo;
  hi: arbol;
  hd: arbol;
 end;

 reg2= record
  cod: integer;
  cantp: integer;
 end; 

 lista= ^nodo2;
 nodo2= record
  dato: reg2;
  sig: lista;
 end;

 procedure leerprestamo (var p:prestamo);
  begin
    readln (p.codsocio);
    if (p.isbn<> 0) then begin
     readln (p.isbn);
     readln (p.codsocio);
    end;
   end;

 procedure agregar (var a: arbol; p: prestamo);
 begin
  if (a= nil) then begin
   new (a);
   a^.dato:= p;
   a^.hi:= nil;
   a^.hd:= nil;
  end
  else begin 
   if (p.isbn <= a^.dato.isbn) then 
    agregar (a^.hi, p)
   else
    agregar (a^.hd, p);
  end;
 end;
 
{*  II) Una estructura donde se almacena codigos de socios junto a su cantidad de prestamos}
 procedure insertaradelante (var l:lista; cod, cant: integer);
 var
  aux: lista;
 begin 
  new (aux);
  aux^.dato.cod:= cod;
  aux^.dato.cantp:= cant;
  aux^.sig:= l;
  l:= aux; 
 end;
 
  procedure generararbolylista (var a:arbol; var l:lista);
  var
   p: prestamo;
   cant: integer; 
   codact: integer;
  begin
   leerprestamo (p);
   while (p.codsocio <>0) do begin
    cant:= 0;
    codact:= p.codsocio;
    while ((p.codsocio <> 0) AND (p.codsocio= codact) ) do begin
      agregar (a, p);
      cant:= cant + 1;
      leerprestamo (p);
   end;
    insertaradelante (l, codact, cant);
  end;  
 end; 

{ b) Implementar un modulo que reciba la estructura generada en a) y un ISBN y retorne la 
* cantidad de prestamos de ese ISBN}
 function cantprestamos (a:arbol; isbn: integer): integer;
 begin
  if (a = nil) then
   cantprestamos:= 0
  else begin
   if (isbn = a^.dato.isbn) then 
    cantprestamos:= cantprestamos (a^.hi, isbn) + cantprestamos (a^.hd, isbn)  + 1
   else
    cantprestamos:= cantprestamos (a^.hi, isbn) + cantprestamos (a^.hd, isbn);
  end;
 end;
{* c) Realizar un modulo RECURSIVO que reciba la estructura generada en a)ii y un valor X y
* retorne la cantidad de socios con cantidad de prestamos superior al valor X}
 function sociosmax (l: lista; x: integer): integer;
 begin
  if (l = nil) then
   sociosmax:= 0
  else
   if (x > l^.dato.cantp) then
    sociosmax:= sociosmax (l^.sig, x) + 1
   else
    sociosmax:= sociosmax (l^.sig, x);
 end;
