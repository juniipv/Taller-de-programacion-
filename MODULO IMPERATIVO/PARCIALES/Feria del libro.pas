{La feria del libro necesita un sistema para obtener estadisticas sobre los libros presentados
* a) Implementar un modulo que lea inforacion de los libros. De cada libro se conoce: ISBN, codigo del autor
*  y codigo del genero (1:literario, 2: filosofia, 3: biologia, 4: arte, 5: computacion, 6: medicina, 7: ingenieria).
* La lectura finaliza con el valor 0 para el ISBN.
* i. Un arbol binario de bsuqueda ordenado por codigo de autor. Para cada codigo de autor debe almacenarse la cantidad de libros
* correspondientes al codigo)}
program parcial3;
type 
 rangogenero= 1..7;
 libro= record
  isbn: integer;
  codau: integer;
  codgenero: rangogenero; 
 end;
 
 reg2= record
  cant: integer;
  codautor: integer;
 end; 
 
 arbol= ^nodo;
 nodo= record
  dato: reg2;
  hi: arbol;
  hd: arbol;
 end;
 
 codycant= record
  codg: rangogenero;
  cantlg: integer;
 end;
 
 vector= array [rangogenero] of codycant;
 
 procedure leerlibro (var l:libro);
 begin 
  readln (l.isbn);
  if (l.isbn <> 0) then begin
   readln (l.codau);
   readln (l.codgenero);
  end;
 end;
 procedure agregar (var a: arbol; li:libro );
 begin
  if (a=nil) then begin
   new (a);
   a^.dato.codautor:= li.codau;
   a^.hi:= nil;
   a^.hd:= nil;
  end
  else begin 
   if (li.codau = a^.dato.codautor) then
    a^.dato.cant:= a^.dato.cant + 1 ///// si quiero cargar registro lo pongo aca;
   else 
    if (li.codau < a^.dato.codautor) then
     agregar (a^.hi, li)
    else
     agregar (a^.hd, li);
  end;
 end; 

   
{* ii. Un vector que almacene para cada genero, el codigo del genero y la cantidad de libros del genero.}
 procedure inicializarvector (var v: vector);
  var
   i: integer;
  begin
   for i:= 1 to 7 do begin
    v[i].codg:= i;
    v [i].cantlg:= 0 ;
   end;
  end;

 procedure cargararbolyvector (var a: arbol; var v:vector );
 var
  l: libro;
 begin
  leerlibro (l);
  while (l.isbn <> 0) do begin
   agregar (a, l);
   v [l.codgenero].cantlg :=  v [l.codgenero].cantlg + 1; /// se suma 1 al campo de cantidad del genero leido 
   leerlibro (l);
  end;
 end;  

{b) Implementar un modulo que reciba el vector generado en a) LO ORDENE por cantidad de libros de mayor a menor y retorne
 el nombre de genero con mayor cantidad de libros}
 procedure ordenarseleccion (var v:vector);
 var
  i,j, pos: integer;
  item: codycant;
 begin
  for i:= 1 to 6 do begin
    pos:= i;
    for j:= i + 1 to 7 do begin
      if v[j].cantlg < v [pos].cantlg then
       pos:= j;
    end;
    item:= v [pos];
    v [pos]:= v [i];
    v [i]:= item;
  end;
 end; 

{ c)Implementar un modulo que rciba el arbol generado en a) y dos codigos. El modulo debe retornar la cantidad total de libros 
* correspondientes a los codigos de autores entre los dos codigos ingresados (incluidos ambos)}

 function entredosvalores (a: arbol; cod1, cod2: integer ): integer;
 begin
  if (a = nil) then
   entredosvalores:= 0
  else begin
   if (a^.dato.codautor >= cod1) then
    if(a^.dato.codautor <= cod2) then
       entredosvalores:= entredosvalores (a^.hd, cod1, cod2) + entredosvalores (a^.hi, cod1, cod2) + a^.dato.cant
    else
      entredosvalores:= entredosvalores (a^.hi, cod1, cod2)  
   else
     entredosvalores:= entredosvalores (a^.hd, cod1, cod2);
   end
 end;
