{Una empresa de alquiler de autos desea procesar la informacion de sus alquileres.
a) implementar un modulo que lea la informacion de los alquileres y retorne un vector
*  que agrupe los alquileres de acuerdo a la cantidad de dias de alquiler. Para cada 
* cantidad de dias, los alquileres deben almacenarse en un arbol binario de busqueda 
* ordenado por numero de chasis del auto.
* De cada alquiler se lee: dni del cliente, numero de chasis y cantidad de dias 
* (de 1 a 7). La lectura finaliza con el numero de chasis 0}
program parcial1;
 type
  alquiler = record
   dni: integer;
   chasis: integer;
   dias: 1..7;
  end;
  arbol= ^nodo;
  nodo= record
   dato: alquiler;
   hi: arbol;
   hd: arbol
  end;
 vector= array [1..7] of arbol;
 procedure leeralquiler (var a: alquiler);
 begin
  readln (a.chasis);
  if (a.chasis <> 0) then begin
   readln (a.dni);
   readln (a.dias)
  end;
 end;
 procedure agregar (var a: arbol; al: alquiler);
 begin
  if (a = nil) then begin
   new (a);
   a^.dato:= al;
   a^.hi:= nil;
   a^.hd:= nil
  end
  else 
   if (al.chasis <= a^.dato.chasis) then 
    agregar (a^.hi, al)
   else
    agregar (a^.hd, al);
 end;

 procedure inicializarvector(var v:vector);
 var
  i: integer;
 begin
  for i:= 1 to 7 do
   v [i]:= nil;
 end;
 

 procedure cargarvector (var v:vector);
 var
  al:alquiler;
 begin
  leeralquiler (al);
  while (al.chasis <>0)do begin
   agregar (v [al.dias], al);// se inserta en el dia que se ingreso o genero
   leeralquiler (al);
  end;   
 end;
 {b) Implementar un modulo que reciba la estructura generada en a) y un dni D. Este 
* modulo debe retornar la cantidad de alquileres realizados por el DNI D}

 function alquilerespordni (a:arbol; d: integer): integer;
 begin
  if (a= nil) then
   alquilerespordni:= 0
  else
   if ( a^.dato.dni = d) then
    alquilerespordni:= 1 + alquilerespordni(a^.hi,d) + alquilerespordni(a^.hd,d)
   else
    alquilerespordni:= alquilerespordni(a^.hi,d) + alquilerespordni (a^.hd,d);
 end;
 function contarpordni(v: vector; d: integer): integer;
 var 
  i: integer;
  cant: integer;
 begin 
  cant:= 0;
  for i:= 1 to 7 do 
   cant:= cant + alquilerespordni (v [i], d);
 contarpordni:= cant;
 end;
 
{ c) Implementar un modulo que reciba la estructura generada en a), un dia D y dos numeros 
* de chasis N1 y N2. Este modulo debe retornar la cantidad de alquileres realizados en el
* dia D, para los chasis entre N1 y N2 (ambos incluidos)}
 function entredosvalores (a: arbol; N1, N2: integer): integer;// no es necesario pasar D ya que ya lo hago en contarvector
 begin 
  if (a = nil) then
   entredosvalores:=0
  else
     if (a^.dato.chasis >= N1 ) then begin 
      if (a^.dato.chasis <= N2) then
       entredosvalores:= 1 + entredosvalores(a^.hi, N1, N2) + entredosvalores (a^.hd,N1 , N2)
      else
       entredosvalores:= entredosvalores (a^.hi, N1, N2); // en caso de que N2 sea mayor a lo contenido en el arbol
     end
     else
      entredosvalores:= entredosvalores (a^.hd, N1, N2); // en casi de que N1 sea menor a lo que se encuentra en el arbol 
 end; 
 
 function contarvector (v: vector; D, N1, N2: integer): integer;
 begin 
  contarvector:= entredosvalores (v [D], N1, N2); // si hago for, recorreria toda la estructura en vano
 end;
VAR
 v: vector; 
 d, dia, n1, n2: integer;
BEGIN 
///tengo que arreglar el programa principal jnskjcsdh
 inicializarvector (v);
 cargarvector (v);
 writeln ('Ingrese un numero: ',d);
 readln (d);
 contarpordni (v, d);
 writeln (' Ingrese un dia: ', dia);
 readln (dia);
 writeln ('Ingrese un nro de chasis: ', n1);
 readln (n1);
 writeln ('Ingrese otro nro de chasis',n2);
 readln (n2);
 contarvector (v, dia, n1, n2);
END.
