{Una biblioteca necesita un sistema para procesar la informacion de los libros. De cada libro se conoce:
ISBN, año de edicion, codigo del autor y codigo de genero (1 a 15).
a) Implementar un modulo que lea la informacion de los libros y retorne una estructura de datos eficiente
 para la busqueda por codigo de autor que contenga codigo de autor y una lista de todos sus libros. La
 lectura finaliza al ingresar el valor 0 para un ISBN.}
program parcial2; 
type 
 rangogenero= 1..15;
 vecgenero= array [rangogenero] of integer;
 libro= record
  isbn: integer;
  anio: integer;
  cod: integer;
  codgenero: rangogenero;
 end;
  reg2= record
   isbn2: integer;
   anio2:integer;
   codgenero2: rangogenero;
  end;
  
  lista=^nodo;
  nodo= record
   dato:reg2; 
   sig: lista;
  end; 
  
  reg3= record
   codautor: integer;
   l:lista;
  end;
  
  arbol= ^nodo2;
  nodo2= record
   dato: reg3;
   hi: arbol;
   hd: arbol;
  end;
  
  reg4= record
   codau: integer;  
   cantlibros: integer; 
  end;
  lista2= ^nodo3;
  nodo3= record
   dato: reg4;
   sig:lista2;
  end; 
  
 procedure leerlibro (var li: libro);
 begin
  readln (li.isbn);
   if (li.isbn <> 0) then begin 
   readln (li.anio);
   readln (li.cod);
   readln (li.codgenero);
  end;
 end;
 procedure insertaradelante ( var l:lista; li:libro);
 var
  aux: lista;
 begin
  new (aux);
  aux^.dato.isbn2:= li.isbn;
  aux^.dato.anio2:= li.anio;
  aux^.dato.codgenero2:= li.codgenero;
  aux^.sig:= l;
  l:= aux;
 end;
 procedure agregar (var a:arbol; l:libro);
 begin
  if (a=nil) then begin
   new (a);
   a^.dato.codautor:= l.cod;
   a^.dato.l:= nil;
   insertaradelante (a^.dato.l, l);
   a^.hi:= nil;
   a^.hd:= nil;
  end 
  else begin
   if (l.cod = a^.dato.codautor) then 
    insertaradelante (a^.dato.l, l)
   else
    if (l.cod < a^.dato.codautor) then 
     agregar (a^.hi, l)
    else
     agregar (a^.hd, l);
  end;
 end; 
 procedure cargararbol (var a:arbol);
 var
  l: libro;
 begin
  leerlibro(l);     
  while (l.isbn <> 0) do begin
   agregar (a, l);
   leerlibro (l);
  end;
 end;
 procedure imprimirlista (l:lista);
 procedure imprimirarbol (a: arbol); 
{b) Realizar un modulo que reciba la estructura generada en el inciso a) y un codigo. El modulo debe retornar
 una lista con codigo de autor y su cantidad de libros, para cada autor con codigo superior al ingresado}
 function contarlibros (l:lista): integer;
 var
  cant: integer;
 begin
  cant:= 0;
  while (l<> nil) do begin 
   cant:= cant + 1;
   l:= l^.sig;
  end;
  contarlibros:= cant;
 end;
 procedure insertaradelante2 (var l2: lista2; cod, cant: integer );
 var 
  aux: lista2;
 begin
  new (aux);
  aux^.dato.codau:= cod;
  aux^.dato.cantlibros:= cant;
  aux^.sig:= l2;
  l2:= aux;
 end; 
 
 procedure crearlistanueva (a: arbol; cod: integer;  var l2: lista2 );
 var
  cant: integer;
 begin
  cant:= 0;
  if (a <> nil) then begin  
   if (cod < a^.dato.codautor) then begin 
    crearlistanueva (a^.hi, cod, l2); // pasa por hijo izquierdo
    cant:= contarlibros (a^.dato.l);// cant de libros de cod actual 
    insertaradelante2 (l2, a^.dato.codautor , cant); //  inserta en l2
    crearlistanueva (a^.hd, cod, l2);// recorrer subarbol derecho
   end
   else
    crearlistanueva (a^.hd, cod,l2);// si no cumple se busca en el derecho
  end;
 end;
 procedure inicisob (a: arbol; l2: lista2);
  var
   cod: integer;
  begin
   l2:= nil;
   writeln ('Ingrese un codigo de autor: ');
   readln (cod);
   crearlistanueva (a, cod, l2);
  end; 
 procedure Imprimirlista2 (l2: lista2);
 begin
  writeln ('LISTA DE LIBROS CON CODIGO SUPERIOR AL INGRESADO');
  while (l2 <> nil) do begin
   writeln ('Codigo de autor: ', l2^.dato.codau );
   writeln ('Cantidad de libros: ', l2^.dato.cantlibros);
   l2:= l2^.sig;
  end;
 end; 
{c) Realizar un modulo recursivo que reciba la estructura generada en el inciso b) y retorne cantidad y codigo 
 de autor con mayor cantidad de libros} 
 procedure cantycodmayor (l2: lista2; var cantmax: integer; var codmax: integer);
  begin 
   if (l2 <> nil) then begin
    if (l2^.dato.cantlibros > cantmax) then begin 
     cantmax:= l2^.dato.cantlibros;
     codmax:= l2^.dato.codau;
    end;  
    cantycodmayor (l2^.sig, cantmax, codmax);
   end;
  end; 
VAR 

BEGIN
