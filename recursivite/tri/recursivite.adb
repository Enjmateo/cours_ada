with Ada.Text_Io; 
with Ada.Integer_Text_IO;
use Ada.Text_IO;

procedure Recursivite is
   -- Types
   type Vector is array (Integer range <>) of Integer;
   
   -- Fonction dichotomique de recherche
   function Dichoto(V : Vector; Value : integer) return Integer is
      Middle : Integer := V'First + (((V'Last)-(V'First)) / 2);
      Find : Boolean := False;
   begin      
      --Etude des cas
      if (V'Length = 2 and V(V'First) /= Middle and V(V'Last) /= Middle) or Middle = 0 then
	 Middle := 0;
	 return Middle;
      end if;
      
      if Value > V(Middle) then
	 declare
	    V2 : Vector(Middle..V'Last) := V(Middle..V'Last);
	 begin
	    Middle := Dichoto(V2, Value);
	 end;
      elsif V(Middle) > Value then
	 declare
	    V2 : Vector(V'First..Middle) := V(V'First..Middle);
	 begin
	    Middle := Dichoto(V2, Value);
	 end;
      else
	 null;
      end if;
      return Middle;
   end Dichoto;
   
   --Procédure de test de Dichoto
   procedure Test_Dichoto(V : Vector; Value : Integer) is
   begin
      Put_Line(" Tableau saisie : ");
      for I in V'Range loop
	 Put(Integer'Image(V(I)) & "  ");
      end loop;
      New_Line;
      Put_Line("Valeur recherchée : " & Integer'Image(Value));
      if Dichoto(V, Value) /= 0 then
	 Put_Line("Valeur trouvée : " & Integer'Image(V(Dichoto(V, Value))));
      else 
	 Put_Line("La valeur n'existe pas dans le tableau");
      end if;
   end Test_Dichoto;
   
   -- Fonction factorielle récursive
   function Factorielle(N : Integer) return Integer is
      Resultat : Integer;
   begin
      if N = 0 then
	 Resultat := 1;
      else
	 Resultat := N* Factorielle(N-1);
      end if;
      return Resultat;
   end Factorielle;
   
   V1 : Vector(1..20) := (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20);
   V2 : Vector(1..20) := (11,29,30,46,56,64,71,89,98,107,110,123,133,145,150,168,171,189,193,210);
   N : Integer;
begin
   Test_Dichoto(V1, 16);
   Test_Dichoto(V2, 56);
   Test_Dichoto(V2, 31);
   
   Put("Factorielle de : ");
   Ada.Integer_Text_IO.Get(N);
   Put_Line(Integer'Image(Factorielle(N)));
end Recursivite;
