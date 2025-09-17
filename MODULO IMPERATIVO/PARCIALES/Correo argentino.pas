{El correo argentino necesita procesar los envios entregados durante el mes de julio de 2024.
* De cada envio se conoce el codigo del cliente, dia, codigo postal y peso el paquete.
* a) Implementar un modulo que lea envios, genere y retorne un arbol binario de busqueda ordenado 
* por codigo postal, donde para codigo postal se almacenen en una lista todos los envios (codigo de 
* cliente, dia y peso del paquete) correspondientes. La lectura finalia con el codigo de cliente 0. }
program parcial5;
type
 envio= record
  codcli: integer;
  dia: integer;
  codpos: integer;
  pesopaq: real;
 end;
 
 reg2= record
  codcli2: integer;
  dia2: integer;
  pesopaq2: real;
 end;
 
 lista=^nodo;
 nodo= record
  dato: reg2;
  sig: lista;
 end;
 
 reg3= record
  li: lista;
  codpos3: integer;
 end;
 
 arbol= ^nodo2;
 nodo2= record
  dato: reg3;
  hi: arbol;
  hd: arbol;
 end;

 
 procedure leerenvio (var e:envio);
 begin 
  readln (e.codcli);
  if (e.codcli <> 0) then begin
   readln (e.dia);
   readln (e.codpos);
   readln (e.pesopaq);
  end;
 end;
 
 procedure insertaradelante (var l: lista; e: envio);
 var
  aux: lista;
 begin
  new (aux);
  aux^.dato.codcli2:= e.codcli;
  aux^.dato.dia2:= e.dia;
  aux^.dato.pesopaq2:= e.pesopaq;
  aux^.sig:= l;
  l:=aux;
 end;
 
 procedure agregar (var a: arbol; e: envio);
 begin 
  if (a=nil) then begin
   new(a);
   a^.dato.codpos3:= e.codpos;
   a^.dato.li:= nil;
   insertaradelante (a^.dato.li, e);
   a^.hi:= nil;
   a^.hd:= nil;
  end
  else begin
   if (e.codpos = a^.dato.codpos3) then 
    insertaradelante (a^.dato.li, e)
   else
    if (e.codpos < a^.dato.codpos3) then
     agregar (a^.hi,e)
    else
     agregar (a^.hd,e);
  end;  
 end;
 
 procedure generararbol (var a:arbol);
 var 
  e: envio;
 begin
  leerenvio (e);
  while (e.codcli <> 0) do begin
   agregar (a, e);
   leerenvio (e);
  end;
 end; 
{* b) Implementar un modulo que reciba la estrucutra generada en a) y un codigo postal, y retorne todos 
* los envios de dicho codigo postal.}
 procedure envios (a:arbol; cod: integer; var l:lista);
 begin
  if (cod= a^.dato.codpos3) then 
   l:= a^.dato.li
  else begin 
   if (cod < a^.dato.codpos3) then 
     envios (a^.hi, cod, l)
   else
    envios (a^.hi, cod, l)
  end;
 end;
  
 
{c) Realizar un modulo RECURSIVO que reciba la estructura que retorna el inciso b) y retorne los dos
* codigos de cliente correspondientes al envio con mayor y menor peso}
 procedure mayorymenor (l: lista; max, min: real; maxcod, mincod: real);
 begin
  if (l<> nil) then
    if (max > l^.dato.pesopaq2) then begin
     max:= l^.dato.pesopaq2;
     maxcod:= l^.dato.codcli2;
    end;
    if (min < l^.dato.pesopaq2) then begin
     min:=l^.dato.pesopaq2;
     mincod:= l^.dato.codcli2;
    end;
    mayorymenor (l^.sig, max, min,maxcod, mincod);
  end;
