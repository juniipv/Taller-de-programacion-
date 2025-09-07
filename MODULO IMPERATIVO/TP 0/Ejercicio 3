{Implemente un módulo CargarLista que cree una lista de enteros y le
agregue valores aleatorios entre el 100 y 150, hasta que se genere el
120.
b) Implemente un módulo ImprimirLista que reciba una lista generada en
a) e imprima todos los valores de la lista en el mismo orden que están
almacenados.
c) Implemente un módulo BuscarElemento que reciba la lista generada
en a) y un valor entero y retorne true si el valor se encuentra en la lista
y false en caso contrario.
d) Invocar desde el programa principal a los módulos implementados
para crear una lista, mostrar todos sus elementos y determinar si un
valor leído por teclado se encuentra o no en la lista.
   
}
program listas; 
 const 
 ;
 type
 lista= ^nodo;
 nodo= record
  dato: integer;
  sig: lista;
 end;
 procedure agregaradelante (var l:lista, num:integer);
  var
   aux: lista;
  begin
   new (num);
   aux^.dato:= num;
   aux^.sig:= l;
   l:= aux;
  end; 
 procedure Cargarlista (var l:lista );
  begin
    num:= random (150-100+1) - 100; 
    while (l <> 120) do begin
     agregaradelante (l, num);
     num:=andom (150-100+1) - 100;
    end;
   end; 
 procedure imprimirlista (l:lista);
  begin
   while (l<> nil) do begin 
    writeln ('El numero contenido en esta lista es:' l^.dato);
    l:=l^.sig;
   end;
  end;
 function buscarelemento (l:lista; valor: integer): boolean;
  var
   ok= boolean;
  begin
   ok:= false;
   while ((l<>nil) AND (ok= false)) do begin
    if (l^.dato = valor) then
     ok= true
    else
     ok= false
    l:= l^.sig;
   end;
   buscarelemento:= ok;
  end;
VAR
BEGIN
END.
