*{2.- Escribir un programa que:
a. Implemente un módulo recursivo que genere y retorne una lista de números enteros
“random” en el rango 100-200. Finalizar con el número 100.
b. Un módulo recursivo que reciba la lista generada en a) e imprima los valores de la lista en el
mismo orden que están almacenados.
c. Implemente un módulo recursivo que reciba la lista generada en a) e imprima los valores de
la lista en orden inverso al que están almacenados.
d. Implemente un módulo recursivo que reciba la lista generada en a) y devuelva el mínimo
valor de la lista.
e. Implemente un módulo recursivo que reciba la lista generada en a) y un valor y devuelva
verdadero si dicho valor se encuentra en la lista o falso en caso contrario.}*

program ejer2;
 type
  lista= ^nodo;
  nodo= record
   dato: integer;
   sig: lista;
  end;
 procedure agregaradelante (var l:lista; num:integer);
 var
  aux: lista;
 begin
  new (aux);
  aux^.dato:= num;
  aux^.sig:= l;
  l:= aux;
 end;
  procedure cargarlistarecursiva (var l:lista);
   begin
    agregaradelante(l,100);
    agregaradelante(l,120);
    agregaradelante(l,130);
    agregaradelante(l,140);
   end; 
{ procedure cargarlistarecursiva (var l:lista);
  var
   num: integer;
  begin
   num:= random (200-100+1)+100;
   if (num <> 100)then begin;
    agregaradelante (l, num);
    cargarlistarecursiva(l);
   end;
  end;
 procedure imprimirlista (l:lista);
 begin
  while (l <> nil) do begin 
   writeln (l^.dato);
   l:=L^.sig; 
  end;
 end;}
 procedure imprimirlistarecursivainversa (l:lista);
  begin
   if (l <> nil) then begin
    writeln ('El numero generado es:',l^.dato);
    imprimirlistarecursivainversa (l^.sig);
   end;
  end;
 procedure imprimirlistarecursiva (l:lista);
  begin
   if (l <> nil) then begin
    imprimirlistarecursiva(l^.sig);
    writeln ('El numero generado es:',l^.dato);
   end;
  end;
 function minimorecursivo (l:lista; min: integer): integer;
  begin
   if (l= nil) then 
    minimorecursivo:= min
   else begin
     if(l^.dato < min ) then begin
       min:= l^.dato;
     end;
   minimorecursivo:= minimorecursivo (l^.sig, min);
    end;
  end; 
 function maximorecursivo (l:lista; max: integer): integer;
  begin
   if (l= nil) then 
    maximorecursivo:= max
   else begin
    if (l^.dato > max) then begin
     max:= l^.dato;
    end;
   maximorecursivo:= maximorecursivo (l^.sig, max); 
   end;
  end; 

VAR
 l: lista;
 min, max: integer;
BEGIN
 l:= nil;
 min:= 999;
 max:= -999; 
 cargarlistarecursiva (l);
 imprimirlistarecursiva(l);
 imprimirlistarecursivainversa(l);
 writeln ('El minimo valor de la lista es: ', minimorecursivo(l, min));
 writeln ('El maximo valor de la lsta es: ',  maximorecursivo(l,max));
END.
