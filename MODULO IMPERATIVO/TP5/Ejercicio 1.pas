{El administrador de un edificio de oficinas tiene la información del pago de las expensas
de dichas oficinas. Implementar un programa con:
a) Un módulo que retorne un vector, sin orden, con a lo sumo las 300 oficinas que
administra. Se deben cargar, para cada oficina, el código de identificación, DNI del
propietario y valor de la expensa. La lectura finaliza cuando llega el código de
identificación 0.}

program ejer1;
 const 
  dimf= 300;
 type
  oficina= record
   cod: integer;
   dniprop: integer;
   expensa: real;
  end;
  vector = array [1..dimf] of oficina;
 procedure leeroficina (var o:oficina);
 begin
  readln (o.cod);
  if (o.cod <> 0) then begin
   readln (o.dniprop);
   readln (o.expensa);
  end;
 end;
 procedure cargarvector (var v: vector; var diml: integer);
 var
  o: oficina;
 begin
  leeroficina (o);
  while (diml< dimf) AND(o.cod <> 0) do begin
   diml:= diml + 1;
   v[diml]:= o;
   leeroficina (o);
  end;
 end;
{b) Un módulo que reciba el vector retornado en a) y retorne dicho vector ordenado por
código de identificación de la oficina. Ordenar el vector aplicando uno de los métodos
vistos en la cursada.}
 procedure ordenarseleccion (var v:vector; diml: integer);
 var 
  i,j,pos: integer;
  item: oficina;
 begin
  for i:= 1 to diml do begin 
   pos:= i;
   for j:= i + 1 to diml do 
    if (v[j].cod> v[pos].cod) then
     pos:= j;
   item:= v [pos];
   v [pos]:= v [i];
   v[i]:= item;
  end; 
 end;

{c) Un módulo que realice una búsqueda dicotómica. Este módulo debe recibir el vector
generado en b) y un código de identificación de oficina. En caso de encontrarlo, debe
retornar la posición del vector donde se encuentra y en caso contrario debe retornar 0.
Luego el programa debe informar el DNI del propietario o un cartel indicando que no
se encontró la oficina.}
 //procedure busquedadicotomica ();
  
{d) Un módulo recursivo que retorne el monto total acumulado de las expensas.}
 function montototal (v: vector; diml: integer): real; 
 begin
  if (diml > 0) then 
   montototal:= v[diml].expensa + montototal (v, diml-1)
  else
   montototal:= 0;
 end;
VAR
 v: vector;
 diml: integer;
Begin
 diml:= -1;
 cargarvector (v, diml);
 ordenarseleccion (v, diml); 
 //busquedadicotomica
 montototal (v, diml);
END.
