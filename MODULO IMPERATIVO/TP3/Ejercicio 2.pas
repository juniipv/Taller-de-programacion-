{Escribir un programa que:
a. Implemente un módulo que genere aleatoriamente información de ventas de un comercio.
Para cada venta generar código de producto, fecha y cantidad de unidades vendidas. Finalizar
con el código de producto 0. Un producto puede estar en más de una venta. Se pide:

i. Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de
producto. Los códigos repetidos van a la derecha.
* 
ii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por
código de producto. Cada nodo del árbol debe contener el código de producto y la
cantidad total de unidades vendidas.
* 
iii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por
código de producto. Cada nodo del árbol debe contener el código de producto y la lista de
las ventas realizadas del producto.
Nota: El módulo debe retornar TRES árboles.}

program arboles1;
type
 rangofecha= 1..31;
 venta= record
  codprod: integer;
  fecha: rangofecha;
  vendido: integer;
 end; 
 arbol= ^nodo;
  nodo= record
   dato: venta;
   HI: arbol;
   HD: arbol;
  end;
 ventaprod= record
  codprod: integer;
  total:integer;
 end; 
 arbol2= ^nodo2;
  nodo2= record
   dato: ventaprod;
   HI: arbol2;
   HD: arbol2;
 end;
 
 
 datos= record
  fecha: integer;
  cant: integer;
 end; 
 lista= ^nodol;
 nodol= record
  dato: datos;
  sig:lista;
 end;
 venta2= record
  cod: integer;
  l: lista;
 end; 
 arbol3= ^nodo3;
 nodo3= record
  dato: venta2;
  HI: arbol3;
  HD: arbol3;
 end; 
 
 procedure generarventas (var v: venta);
 begin
  v.codprod:= random (11);
  if (v.codprod <> 0) then begin
   v.fecha:= random (30)+1;
   v.vendido:= random (5)+1; 
  end;
 end;
 procedure agregar (var a: arbol; v:venta);
  var 
   Aux: arbol;
  begin 
   if (a = nil) then begin
    new (aux);
    aux^.dato:= v;
    aux^.HI:= nil;
    aux^.HD:= nil;
    a:= aux;
   end
   else
    if (v.codprod = a^.dato.codprod) then
     agregar (a^.HD, v)
    else
    if (v.codprod < a^.dato.codprod) then 
     agregar (a^.HI, v)
    else
     agregar (a^.HD, v);
  end; 
 procedure agregar2 (var a2: arbol2; vp:ventaprod);
  Var
  Aux: arbol2;
 Begin
  if (a2= nil) then begin
    new (aux);
    aux^.dato:= vp;
    aux^.HI:= nil;
    aux^.HD:= nil;
    a2:= aux;
  end
  Else 
   if (vp.codprod = a2^.dato.codprod) then
    a2^.dato.total:= a2^.dato.total + vp.total 
   Else 
   If (vp.codprod< a2^.dato.codprod) then
    agregar2 (a2^.HI, vp)
   else
    agregar2 (a2^.HD, vp);
  End;
 procedure agregaradelante (var l:lista; fecha, cant: integer);
 var 
  aux: lista;
 begin
  new (aux);
  aux^.dato.fecha:= fecha;
  aux^.dato.cant:= cant;
  aux^.sig:= l;
  l:= aux;
 end;
 procedure agregar3 (var a3: arbol3; cod, fecha,cant: integer);
 var
  aux: arbol3;
 begin
  if (a3= nil) then begin
   new (aux);
   aux^.dato.cod:= cod;
   aux^.dato.l:= nil;
   agregaradelante (aux^.dato.l,fecha, cant);
   aux^.HI:= nil;
   aux^.HD:= nil; 
   a3:= aux;
  end
  else
   if (a3^.dato.cod= cod) then
    agregaradelante (a3^.dato.l,fecha, cant)
   else
    if (cod < a3^.dato.cod) then
     agregar3 (a3^.HI, cod, fecha, cant)
    else
     agregar3 (a3^.HD, cod, fecha, cant);
  end;
 procedure cargararboles (var a: arbol; var a2:arbol2; var a3:arbol3);
  var
   v: venta;
   vp: ventaprod; 
  begin 
   a:= nil;
   generarventas (v);
   while (v.codprod <> 0) do begin 
    agregar (a,v);
    vp.codprod:= v.codprod;
    vp.total:= v.vendido;
    agregar2 (a2, vp);
    agregar3 (a3,v.codprod, v.fecha, v.vendido);
    generarventas (v);
   end;
  end; 
    
 procedure imprimir1(a: arbol);
 begin 
  if (a <> nil) then begin
   imprimir1 (a^.HI);
   Writeln (' ---Codigo: ', a^.dato.codprod, ' --- fecha de compra: ', a^.dato.fecha, ' --- cantidad de productos vendidos: ', a^.dato.vendido);
   imprimir1 (a^.HD);   
  end;
 end;
 procedure imprimirarbol2(a2: arbol2);
 begin
 if (a2 <> nil) then begin
   imprimirarbol2 (a2^.HI);
   Writeln (' ---Codigo: ', a2^.dato.codprod);
   writeln ( '--- cantidad total de productos vendidos: ', a2^.dato.total);
   imprimirarbol2 (a2^.HD);   
  end;
 end;
 procedure imprimirlista (l:lista);
 begin
  if (l <> nil) then begin 
     writeln (' ---Fecha de la compra:', l^.dato.fecha);
     writeln ('---cantidad comprada: ', l^.dato.cant);
     imprimirlista (l^.sig);
  end;
 end;
 procedure imprimirarbol3 (a3:arbol3);
 begin
  if (a3 <> nil) then begin
   imprimirarbol3(a3^.HI);
   Writeln (' ---Codigo: ', a3^.dato.cod, '---Lista de compras:');
   imprimirlista(a3^.dato.l);
   imprimirarbol3 (a3^.HD);   
  end;
 end;
 { 
b. Implemente un módulo que reciba el árbol generado en i. y una fecha y retorne la cantidad
total de productos vendidos en la fecha recibida.}



 function vendidoporfecha(a:arbol; f: integer): integer; // b
 begin 
   if (a = nil) then
    vendidoporfecha := 0
   else begin
    if (a^.dato.fecha = f) then
      vendidoporfecha:= a^.dato.vendido + vendidoporfecha (a^.HI, f) + vendidoporfecha (a^.HD,f)
    else 
     vendidoporfecha:= vendidoporfecha (a^.HI,f) + vendidoporfecha (a^.HD,f);
   end;
  end;     
{c. Implemente un módulo que reciba el árbol generado en ii. y retorne el código de producto
con mayor cantidad total de unidades vendidas.}
 procedure codigomaximo (a2: arbol2; var codmax: integer; var maxprod: integer ); // c
 begin
  if (a2 <> nil) then begin
    if (a2^.dato.total > maxprod) then begin  
     codmax:= a2^.dato.codprod;  
     maxprod:= a2^.dato.total;
    end;
   codigomaximo (a2^.HI, codmax, maxprod);   
   codigomaximo (a2^.HD, codmax, maxprod);
  end;
 end;
 {d. Implemente un módulo que reciba el árbol generado en iii. y retorne el código de producto
con mayor cantidad de ventas.}
 function contarventas (l: lista): integer;
 begin
  if (l <> nil) then 
   contarventas:= 1 + contarventas (l^.sig)
  else
   contarventas:= 0;
 end;
 procedure ventasmaximas (a3: arbol3 ; var codmax: integer; var cantmax: integer); // d
 begin 
  if (a3 <> nil) then begin 
   if (contarventas(a3^.dato.l) > cantmax) then begin
    codmax:= a3^.dato.cod;
    cantmax:= contarventas(a3^.dato.l);
   end;
   ventasmaximas (a3^.HI, codmax, cantmax);   
   ventasmaximas(a3^.HD, codmax, cantmax);
  end;
 end;
VAR
 ar1: arbol;
 ar2: arbol2;
 ar3: arbol3;
 fecha: rangofecha;
 cant, cod: integer; 
BEGIN
 ar1:= nil;
 ar2:= nil;
 ar3:= nil;
 randomize;
 cargararboles (ar1, ar2, ar3);
 imprimir1 (ar1);
 imprimirarbol2 (ar2);
 imprimirarbol3 (ar3);
 writeln ('Ingrese una fecha');
 readln(fecha);
 writeln ('La cantidad de productos vendidos en la fecha ', fecha, ' es de ', vendidoporfecha (ar1, fecha));
 cant:= -1;
 codigomaximo(ar2, cod, cant);

 writeln ('El codigo del producto con mayor total de ventas es ', cod, ' con ', cant, ' ventas ');
 cant:= -1;
 ventasmaximas (ar3, cod, cant);
 writeln ('El codigo del producto con mayor cantidad de ventas es ', cod, ' con ', cant, ' ventas');
END.
