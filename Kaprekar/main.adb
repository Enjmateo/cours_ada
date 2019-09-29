with ada.Text_IO, Ada.Integer_Text_IO;
with ada.Calendar;

use ada.Text_IO;

procedure Main is
   
   -- Type & package
   subtype chiffre is Natural range 0..9;
   type nbr is array (Integer range <>) of Integer;
   package date renames ada.Calendar;
   
   
   -- Variables globales
   FND : constant Integer := 100; -- FIND
   WST : constant Integer := FND - 1;  -- WRITE START
   
   
   data_dect : nbr(1..FND);
   -- Ce tableau contient des nombres pour de la detection de boucle
   -- Le rang WST et FND sont des rangs de services
   
   
   -- Procédure de detection de boucle, utilise la base de données data_dect
   procedure detect_loop (int : in Integer) is
      debut_ecriture : Integer := data_dect(WST);
   begin
      for i in data_dect'First..(WST - 1) loop
         if int = data_dect(i) then
            data_dect(FND) := 1;
         end if;
      end loop;

      data_dect(debut_ecriture) := int;
      data_dect(WST) := data_dect(WST) + 1;

      if data_dect(WST) >= WST then
         raise Storage_Error;
      end if;

   end detect_loop;
   
   
   -- Tri par ordre croissant un tableau d'integer
   procedure tri (tab : in out nbr) is
      buffer : nbr(tab'Range);
      valeur : Integer := 0;
      pos : Integer := 0;
   begin
      for k in tab'Range loop
         valeur := 0;
         pos := tab'last;
         for i in tab'range loop
            if tab(i) >= valeur then
               pos := i;
               valeur := tab(i);
            end if;
         end loop;
         tab(pos):=0;
         buffer(k) := valeur;
      end loop;
      tab := buffer;
   end tri;
   
   
   -- Tri par ordre décroissant
   procedure tri_inverse (tab : in out nbr) is
      buffer : nbr(tab'Range);
   begin
      tri(tab);
      for i in tab'range loop
         buffer(i):=tab(tab'last-(i-1));
      end loop;
      tab:=buffer;
   end tri_inverse;

   -- Partie opérative de l'algo de Kaprekar (nombre en deux tableaux triés, affiche et retourne la différence des nombres
   function operation (nombre : integer; dimension : Integer) return Integer is
      ord_croiss : nbr(1..dimension);
      ord_droiss : nbr(1..dimension);
      nombre_croiss : Integer := 0;
      nombre_droiss : Integer := 0;
      nombre_stock : Integer := nombre;
   begin
      -- On met le nombre dans un tableau
      for k in 1..dimension loop
         ord_croiss(k) := (nombre_stock/10**(dimension-(k)));
         nombre_stock := nombre_stock - ord_croiss(k)*10**(dimension-k);
      end loop;

      --tri
      ord_droiss := ord_croiss;
      tri(ord_croiss);
      tri_inverse(ord_droiss);

      for j in 1..dimension loop
         nombre_droiss := nombre_droiss + ord_droiss(j) * (10**(dimension - (j)));
         nombre_croiss := nombre_croiss + ord_croiss(j) * 10**(dimension -(j));

      end loop;

      Put_Line("N1 = " & Integer'Image(nombre_croiss) & " N2 = " & Integer'Image(nombre_droiss) & " N1 - N2 = " & Integer'Image(nombre_croiss - nombre_droiss));

      return nombre_croiss - nombre_droiss;
   end operation;
   
   
   -- Permet de déterminer la taille d'un nombre
   function nb_digits (nombre : Integer) return Integer is
      dimension_nok : Boolean := true;
      dimension : Integer := 0;
      i : Integer := 0;
   begin
      while dimension_nok loop
         if (nombre / 10**i) <= 0 then
            dimension_nok := false;
            dimension := i;
         else
            i := i + 1;
         end if;
      end loop;

      if dimension = 0 then
         dimension := 1;
      end if;

      return dimension;
   end nb_digits;
   
   
   -- Procédure de coordination des fonctions de l'algorithme et de la detection de boucle 
   procedure kaprekar (nombre : in out Integer) is
      dimension_nok : Boolean := true;
      dimension : Integer := 0;
      i : Integer := 0;
      temp : Integer := nombre;
   begin
      nombre := temp + 1;

      while nombre /=temp loop
         dimension := nb_digits(temp);
         nombre := temp;
         temp := operation(temp, dimension);

         detect_loop(temp);
         if data_dect(FND) = 1 then
            Put_Line("Boucle dans l'algorthme");
            nombre := temp;
         end if;


         delay 0.2;
         Put_Line("--------------");
      end loop;


   end kaprekar;
   
   
   -- Procédure de test de la fonction tri
   -- cf ../../Test_tri pour d'autres algorithmes de tri
   procedure test_tri is
      test_tri1 : nbr(1..10) := (5,4,8,3,9,1,6,7,2,0);
      test_tri2 : nbr(1..10) := (5,4,8,6,9,1,6,7,7,0);
   begin
      tri(test_tri2);
      tri_inverse(test_tri1);

      for i in test_tri1'First..test_tri1'Last loop
         put(Integer'Image(test_tri1(i))& " ");
      end loop;
      Put_Line("");
      for i in test_tri2'First..test_tri2'Last loop
         put(Integer'Image(test_tri2(i))& " ");
      end loop;
      Put_Line("");
   end test_tri;
   

   nombre: Integer := 0;
begin
   -- Detection de boucle:
   data_dect(WST) := 1; --le premier rang écrit par défaut est le 1
   data_dect(FND) := 0; --aucune boucle n'est trouvé au début

   --Put_Line("Test du programme :");
   --test_tri;
   
   
   --
   Put("Algorithme de Kaprekar. Saisir un nombre : ");
   Ada.Integer_Text_IO.Get(nombre);

   kaprekar(nombre);

   Put_Line("ALGORITHME FINI");
   
   
   -- Exceptions
exception
   when Constraint_Error => Put_Line("Nombre donné non valide.");
   when Storage_Error => Put_Line("DATA_BASE_TOO_SHORT, data_dect(WST):"&Integer'Image(data_dect(WST)));
   when others => Put_line("Nombre non valide ou trop grand !");
end Main;
