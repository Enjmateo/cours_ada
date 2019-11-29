with ada.Text_IO, Ada.Integer_Text_IO;
with Ada.Numerics.Discrete_Random;
with Ada.Command_Line;

use ada.Text_IO;
use Ada.Command_Line;

-- Lib C pour intefacer avec le system
with Interfaces.C; use Interfaces.C;

procedure Test_Tri is
   
   -- Variables globales
   TMP : constant Duration := 0.05;
   
   -- Type tableau 
   type nbr is array (Integer range <>) of Integer;
   type Grille is array (Integer range <>, Integer range <>) of character;
   subtype Double is Integer range 0..65535;
   
   -- Pointeurs
   type P_procedure is access procedure (Tab : in out Nbr);
   
   -- Package pour l'aléatoire
   package Aleatoire is new Ada.Numerics.Discrete_Random(Double);
   use Aleatoire;
   Hasard : Generator;
   
   -- Commandes systeme via C
   function System (Cmd : Interfaces.C.Char_Array) return Interfaces.C.int;
   pragma Import (C, System, "system");
   
   
   -- Procédure d'affichage d'un tableau de manière graphique
   procedure Aff (Tab : in  Nbr) is
      Hauteur : constant Integer := 60;
      Value : Integer := 0;
      G : Grille(Tab'First..Hauteur, Tab'range) := (others => (others => ' '));
      Max : Integer := 0;
      Err : Interfaces.C.int;
   begin
      Err := System("clear");
      -- Recherche du max
      for K in Tab'Range loop
	 if Value < Tab(K) then
	    Max := K;
	    Value := Tab(K);
	 end if;
      end loop; 
      Value := 0;
      -- Préparation affichage
      for I in Tab'Range loop
	 Value := ((Tab(I)*Hauteur)/(Tab(Max)+1));
	 for J in G'First(2)..Value loop
	    G(J,I) := '|';
	 end loop;
      end loop;
      --Affichage
      for H in G'Range(1) loop
	 for V in G'Range(2) loop
	    Put(G(G'Last-H+1,V) & "");
	 end loop;
	 New_Line;
      end loop;
      delay 0.05;
   end Aff;
   
   
   -- Procédure de tri d'un tableau (Tri bulle)
   procedure Tri_Bulle (Tab : in out Nbr) is
      K : Integer := 0; -- buffer
   begin
      for J in Tab'Range loop
	 for I in Tab'First..(Tab'Last - 1) loop
	    if Tab(I + 1)  < Tab(I) then
	       K := Tab(I + 1);
	       Tab(I + 1) := Tab(I);
	       Tab(I) := K;
	    end if;
	 end loop;
	 Aff(Tab);
	 delay TMP;
      end loop;
   end Tri_Bulle;
   
   
   -- Tri selection
   procedure Tri_Selection (Tab : in out Nbr) is
      VMin : Integer := Integer'last;
      Min : Integer := 0;
      Buffer : Integer;
   begin
      for J in Tab'Range loop
	 Vmin := Integer'Last;
	 for I in ((Tab'First+J-1))..Tab'last loop
	    if VMin > Tab(I) then
	       VMin := Tab(I);
	       Min := I;
	    end if;
	 end loop;
	 Buffer := Tab(Tab'First+J-1);
	 Tab(Tab'First+J-1) := Tab(Min);
	 Tab(Min) := Buffer;
	 Aff(Tab);
	 delay TMP;
      end loop;
   end Tri_Selection;
   
   
   -- Test de la procédure tri
   procedure Test_Tri (F : P_Procedure) is
      test_tri1 : nbr(1..150);
   begin
      Put_Line("------------------");
      for J in Test_Tri1'Range loop
	 Test_Tri1(J) := Random(Hasard);
      end loop;
      
      F(test_tri1);
   end Test_tri;
   
   
   F1 : P_Procedure;
   F2 : P_Procedure;
   Iteration : Integer := 0;
begin
   --Renitialisation du générateur
   Reset(Hasard);
   
   -- Présentation de l'algorithme
   Put_Line("Algorithme d'affichage d'algorithme de tri");
   Put_Line("Compatible avec les sytemes UNIX uniquement");
   Put_Line("Gasc Mayeul - 2019 - N'hésitez pas à reporter les bugs ;)");
   New_Line;
   Put_Line("Le nombre d'itération peut être donné en argument");
   
   delay 4.0;
   
   if Argument_Count = 1 then 
      Iteration := Integer'Value(Argument(1));
   else
      New_Line;
      Put("Nbr de boucles : ");
      Ada.Integer_Text_IO.Get(Iteration);
   end if;
   
   for I in 1..Iteration loop
      --Test des fonctions
      F1 := Tri_Bulle'Access;
      F2 := Tri_Selection'Access;
      Test_Tri(F1); 
      Test_Tri(F2);
   end loop;
end Test_Tri;
