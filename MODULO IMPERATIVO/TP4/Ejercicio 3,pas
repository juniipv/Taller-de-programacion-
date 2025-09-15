{ Implementar un programa modularizado para una librería. Implementar módulos para:
a. Almacenar los productos vendidos en una estructura eficiente para la búsqueda por
código de producto. De cada producto deben quedar almacenados su código, la
cantidad total de unidades vendidas y el monto total. De cada venta se lee código de
venta, código del producto vendido, cantidad de unidades vendidas y precio unitario. El
ingreso de las ventas finaliza cuando se lee el código de venta -1.}
program ejer3;
 type 
  producto= record
   cod: integer;
   totalvendido: integer;
   monto: real;
  end;
  arbol=^nodo;
  nodo= record
   dato: producto;
   hi:arbol;
   hd: arbol;
  end;
  venta= record
   cod: integer;
   codprod: integer;
   cant: integer;
   precio: real;
  end;
 procedure leerventa(var v: venta);
 begin
  v.cod:= random (12)-1;
  if (v.cod <> -1) then begin
   v.codprod:= random (10)+1;
   v.cant:= random (100)+1;
   v.precio:= random (1000)+1;
  end;  
 end;
 procedure agregar(var a:arbol; p:producto);
 var
  aux: arbol;
 begin
  if (a=nil) then begin
   new (aux);
   aux^.dato:= p; 
   aux^.hi:= nil;
   aux^.hd:= nil;
   a:= aux;
  end
  else
   if (p.cod  = a^.dato.cod) then begin
    a^.dato.totalvendido:= a^.dato.totalvendido + p.totalvendido;
    a^.dato.monto:= a^.dato.monto + p.monto;
   end 
   else
    if (p.cod < a^.dato.cod ) then
     agregar (a^.hi,p)
    else
     if (p.cod> a^.dato.cod) then
      agregar (a^.hd,p);
 end; 
 
 procedure generararbol (var a:arbol);
 var
  p: producto;
  v:venta;
 begin
  a:= nil;
   leerventa (v);
   while (v.cod <> -1) do begin
    p.cod:= v.codprod;
    p.totalvendido:= v.cant;
    p. monto:= v.precio * v.cant;
    agregar (a,p);
    leerventa (v); 
   end;
 end;
{b. Imprimir el contenido del árbol ordenado por código de producto.}
 procedure imprimir (a:arbol);
 begin 
  if (a <> nil) then begin
   imprimir (a^.hi);  
   writeln ('-------------CODIGO:',a^.dato.cod, '-----------------------');
   writeln ('Cantidad de productos vendidos: ', a^.dato.totalvendido);
   writeln ('Total vendido: ',a^.dato.monto:2:2);
  imprimir (a^.hd);
  end;
 end;
  {
  * 
c. Retornar el código de producto con mayor cantidad de unidades vendidas.}
 procedure maxunidadesvendidas (a:arbol; var max, codmax: integer);
 begin
  if (a<>nil) then begin
   if (a^.dato.totalvendido > max) then begin 
    max:= a^.dato.totalvendido;
    codmax:= a^.dato.cod;
   end; 
   maxunidadesvendidas (a^.hi, max, codmax);
   maxunidadesvendidas (a^.hd, max, codmax);
  end;
 end;  
{d. Retornar la cantidad de códigos que existen en el árbol que son menores que un valor
que se recibe como parámetro.}
 function menores (a:arbol; num: integer): integer;
  begin
   if (a = nil) then
    menores:= 0
   else 
    if (a^.dato.cod < num) then 
     menores:= menores (a^.hi,num) + menores(a^.hd,num) + 1
    else
     menores:= menores (a^.hi,num);
  end;
{e. Retornar el monto total entre todos los códigos de productos comprendidos entre dos
valores recibidos (sin incluir) como parámetros.}
  function montoentrevalores (a:arbol; num1, num2: integer): real;
  begin 
   if (a= nil) then
     montoentrevalores:= 0
   else
    if (a^.dato.cod>= num1) and (a^.dato.cod <= num2) then 
     montoentrevalores:= montoentrevalores (a^.hi, num1, num2) + montoentrevalores(a^.hd,num1, num2) + a^.dato.monto
    else
     if (a^.dato.cod < num1) then
      montoentrevalores:= montoentrevalores(a^.hd, num1,num2)
      else
       montoentrevalores:=montoentrevalores(a^.hi, num1, num2);
  end;
VAR
 a: arbol;
 max, codmax, num, num1, num2: integer;
BEGIN
 randomize;
 generararbol (a);
 imprimir (a);
 max:= -1;
 maxunidadesvendidas (a, max, codmax);
 writeln ('------------------------------------------------------------------------');
 writeln ('Ingrese un numero');
 readln (num);
 writeln ('La cantidad de codigos menores al numero ingresado es: ', menores(a, num));
 writeln ('Ingrese un numero: ');
 read (num1);
 writeln ('Ingrese otro numero: ');
 read (num2);
 writeln ('Monto total de la suma entre los codigos ingresados: ', montoentrevalores(a, num1, num2));
END.
