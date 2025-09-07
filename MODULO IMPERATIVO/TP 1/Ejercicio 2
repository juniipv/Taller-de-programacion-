{2.- El administrador de un edificio de oficinas cuenta, en papel, con la información del pago de
las expensas de dichas oficinas.b
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina
se ingresa el código de identificación, DNI del propietario y valor de la expensa. La lectura
finaliza cuando se ingresa el código de identificación -1, el cual no se procesa.
b. Ordene el vector, aplicando el método de inserción, por código de identificación de la
oficina.
c. Ordene el vector aplicando el método de selección, por código de identificación de la oficina}

program oficinas;
 const
  dimf=300;
 type
  oficina = record
   cod: integer;
   dni: integer;
   expensa: real;
  end;
  vecof= array[1..dimf] of oficina;
  procedure leeroficina (var o:oficina);
   begin
    writeln ('Ingrese el codigo de identificacion:');
    readln(o.cod);
    if (o.cod <> -1) then begin
     writeln('Ingrese el DNI del propietario:');
     readln(o.dni);
     writeln('Ingrese el valor de la expensa:');
     readln (o.expensa);
    end;
   end;
  procedure generarvector (var v:vecof; VAR diml: integer);
  var
   o: oficina;
  begin
   diml:=0;
   leeroficina (o);
   while ((o.cod <> -1) AND (diml < dimf)) do begin
    diml:= diml + 1;
    v [diml]:= o;
    leeroficina(o);
   end;
  end; 
  procedure insercion (var v: vecof ;diml: integer);
   var
    i, j: integer;
    actual: oficina; 
  begin 
   for i:= 2 to diml do begin
    actual:= v[i];
    j:= i - 1;
    while ((j > 0)AND(v[j].cod> actual.cod)) do begin
     v[j + 1]:= v[j];
     j:= j- 1;
    end;
    v [j+1]:= actual;
   end;
  end;
  procedure seleccion (var v: vecof; diml:integer);
   var
    i, j, pos: integer;
    item: oficina;
   begin
    for i:= 1 to (diml - 1) do begin
     pos:= i;
     for j:= i +1 to diml do
      if (v[j].cod < v[pos].cod) then
       pos:= j;
     item:= v [pos];
     v [pos]:= v[i];
     v [i]:= item;
    end; 
   end;
VAR
 vec:vecof;
 diml: integer;
BEGIN
 generarvector (vec, diml);
 seleccion (vec, diml);
 insercion (vec, diml);
END.
