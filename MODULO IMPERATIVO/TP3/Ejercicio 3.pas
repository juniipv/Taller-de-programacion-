{Implementar un programa que contenga:
a. Un módulo que lea información de los finales rendidos por los alumnos de la Facultad de
Informática y los almacene en una estructura de datos. La información que se lee es legajo,
código de materia, fecha y nota. La lectura de los alumnos finaliza con legajo 0. La estructura
generada debe ser eficiente para la búsqueda por número de legajo y para cada alumno deben
guardarse los finales que rindió en una lista.
}
program arboles2;
type
 rangonota= 1..10;
 rangodias= 1..31;
 rangomeses= 1..12;
 diaymes= record
  dia: rangodias;
  mes: rangomeses;
 end;
 info= record
  cod: integer;
  fecha: diaymes;
  nota:rangonota;
 end;
 lista= ^nodo;
 nodo= record
  dato: info;
  sig: lista;
 end;
 infocompl= record
  legajo: integer;
  lis: lista;
 end;
 arbol= ^nodo2;
 nodo2= record
  dato: infocompl;
  hi: arbol;
  hd: arbol;
 end;
 procedure leerinformacion (var inf: info; var leg: integer);
 begin
  leg:= random (11);
  if (leg <> 0) then begin
   inf.cod:= random (10);
   inf.fecha.dia:= random (12)+1;
   inf.fecha.mes:= random (31)+1;
   inf.nota:= random (10)+1;
  end;
 end;
 procedure insertaradelante (var l: lista; f:info);
 var
  aux: lista;
 begin
  new (aux);
  aux^.dato:= f;
  aux^.sig:= l;
  l:=aux;
 end;
 procedure agregar (var a: arbol;leg: integer; inf: info);
 var
  aux: arbol;
 begin
  if (a=nil) then begin
   new (aux);
   aux^.dato.legajo:= leg;
   aux^.dato.lis:= nil;
   insertaradelante (aux^.dato.lis, inf);
   aux^.hi:= nil;
   aux^.hd:= nil;
   a:=aux;
  end
  else begin
    if (a^.dato.legajo = leg) then 
     insertaradelante (a^.dato.lis, inf)
    else
     if (a^.dato.legajo > leg) then 
      agregar (a^.hi,leg, inf)
     else 
      agregar (a^.hd,leg,  inf);
  end;
 end;
 procedure generararbol (var a:arbol; leg: integer);
  var 
   i: info;
  begin 
   a:= nil;
   leerinformacion (i, leg);
   while (leg <> 0) do begin
    agregar (a, leg, i);
    leerinformacion (i, leg);
   end;
  end;
 procedure imprimirlista (lis:lista);
 begin 
  if (lis<>nil) then begin
   writeln ('Codigo de la materia: ',lis^.dato.cod);
   writeln ('Fecha del final:',lis^.dato.fecha.dia, '/', lis^.dato.fecha.mes);
   writeln ('Nota: ',lis^.dato.nota);
   imprimirlista (lis^.sig);
  end;
 end;
   
 procedure imprimirarbol (a:arbol);
 begin
  if (a <> nil) then begin
   imprimirarbol (a^.hi);
   writeln ('--------------------Legajo del estudiante: ', a^.dato.legajo,'--------------------------');
   writeln ('Informacion del final: ');
   imprimirlista (a^.dato.lis);
   imprimirarbol (a^.hd);   
  end;
 end;
{b. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con
legajo impar.}
 procedure legajosimpares (a:arbol; var cant: integer);
 begin
  if (a<>nil) then begin
   if (a^.dato.legajo mod 2 <> 0) then
    cant:= cant + 1;
   legajosimpares (a^.hi, cant);
   legajosimpares (a^.hd, cant);
  end;
 end;
{c. Un módulo que reciba la estructura generada en a. e informe, para cada alumno, su legajo y
su cantidad de finales aprobados (nota mayor o igual a 4).}
 function contarfinales (l:lista): integer;
 var
  contador: integer;
 begin
  contador:=0;
  while (l <> nil) do begin
   if (l^.dato.nota > 4) then 
    contador:= contador + 1;
   l:= l^.sig;
  end;
  contarfinales:= contador;
 end;
 procedure finalesaprobados (a:arbol);
 begin
  if (a<>nil) then begin
   writeln ('El legajo nro ', a^.dato.legajo,' tiene un total de ', contarfinales (a^.dato.lis), ' finales aprobados');   
   finalesaprobados (a^.hi);
   finalesaprobados (a^.hd);
  end;
 end;
{d. Un módulo que reciba la estructura generada en a. y un valor real. Este módulo debe
retornar los legajos y promedios de los alumnos cuyo promedio supera el valor ingresado.}
 function promedio (l:lista): real;
 var 
  suma, cant: integer;
 begin
  suma:= 0;
  cant:= 0;
  while (l<>nil) do begin 
   suma:= suma + l^.dato.nota;
   cant:= cant +1;
   l:=l^.sig;
  end; 
   if (cant > 0) then
    promedio:= suma / cant
   else
    promedio:= 0;
 end;
 procedure mayorquex (a:arbol; valor: real);
 begin
  if (a <> nil) then begin 
   mayorquex (a^.hi, valor);
   if (promedio(a^.dato.lis) > valor) then 
    writeln ('Legajo:' , a^.dato.legajo,' Promedio: ', promedio(a^.dato.lis):2:2 );
   mayorquex (a^.hd,valor);
  end;
 end;
VAR
 a: arbol;
 leg, cant: integer;
 num: real;
BEGIN
 leg:=-1;
 randomize;
 generararbol (a, leg);
 imprimirarbol (a);
 cant:=0;
 legajosimpares (a, cant);
 writeln ('La cantidad de alumnos con legajo impar es ', cant);
 writeln ('Ingrese un valor real');
 readln (num);
 mayorquex (a, num);
END.
