{3.- Implementar un programa que invoque a los siguientes módulos.
a. Un módulo recursivo que retorne un vector de 20 números enteros “random” mayores a 300
y menores a 1550 (incluidos ambos).
b. Un módulo que reciba el vector generado en a) y lo retorne ordenado. (Utilizar lo realizado
en la práctica anterior)
c. Un módulo que realice una búsqueda dicotómica en el vector, utilizando el siguiente
encabezado:
Procedure busquedaDicotomica (v: vector; ini,fin: indice; dato:integer; var pos: indice);
Nota: El parámetro “pos” debe retornar la posición del dato o -1 si el dato no se encuentra
en el vector.}
program ejer3;
 const
  dimf= 20;
 type 
  numeros= array [1..dimf] of integer; 
 procedure cargarvectorrecursivo (var v: numeros; var diml: integer);
  begin
   if (diml< dimf) then begin
    diml:= diml + 1;
    v [diml]:= random (1550-300+1)+300;
    cargarvectorrecursivo (v, diml);
   end;
  end;
 procedure retornarvectorrecursivo (v:numeros; diml: integer); 
  begin 
   if (diml > 0) then begin
    writeln ('El numero que se encuentra en la posicion ', diml, 'es ', v[diml]);
    retornarvectorrecursivo (v, diml-1);
   end;
  end;
 procedure ordenarvector (var v: numeros; diml: integer);
   var
    i, j, pos: integer;
    item: integer;
   begin
    for i:= 1 to (diml - 1) do begin
     pos:= i;
     for j:= i +1 to diml do
      if (v[j] < v[pos]) then
       pos:= j;
     item:= v [pos];
     v [pos]:= v[i];
     v [i]:= item;
    end; 
   end;
 procedure busquedadicotomicarecursiva (v: numeros; ini, fin: integer; buscado: integer; var pos: integer);
  var
   medio: integer;
  begin
   if (ini > fin) then 
    pos:= -1
   else begin 
    medio:=  (ini + fin) div 2;
     if (buscado = V [medio]) then
      pos:= medio
     else begin
      if (buscado < v [medio]) then
       busquedadicotomicarecursiva (v, ini, fin - 1, buscado, pos)
      else
       busquedadicotomicarecursiva (v, ini + 1, fin, buscado, pos); 
     end; 
   end; 
  end; 
 function encontro (pos: integer):boolean;
 begin
  if (pos = -1) then 
   encontro:= false
  else; 
  encontro:= true;
 end;  
VAR
 num: numeros;
 ini, fin, buscado, pos, diml: integer;
BEGIN 
 ini:= 0;
 diml:= 0;
 cargarvectorrecursivo (num, diml);
 fin:= diml;
 retornarvectorrecursivo (num, diml);
 ordenarvector(num, diml);
 retornarvectorrecursivo (num, diml);
 buscado:= 4;
 busquedadicotomicarecursiva (num, ini,fin, buscado, pos);
 if (encontro(pos)) then 
  writeln ('Se ha encontrado el numero buscado');
END.     
 
      
 

