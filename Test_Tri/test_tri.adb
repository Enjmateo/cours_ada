with ada.Text_IO, Ada.Integer_Text_IO;
with Ada.Numerics.Discrete_Random;
with ada.Calendar;

use ada.Text_IO;

procedure Test_Tri is
   
   -- Variables globales
   TMP : constant Duration := 0.1;
   
   -- Type tableau 
   type nbr is array (Integer range <>) of Integer;
   type Grille is array (Integer range <>, Integer range <>) of character;
   subtype Double is Integer range 0..65535;
   type P_procedure is access procedure (Tab : in out Nbr);
   
   
   -- Package pour l'aléatoire
   package Aleatoire is new Ada.Numerics.Discrete_Random(Double);
   use Aleatoire;
   Hasard : Generator;
   
   
   -- Procédure d'affichage d'un tableau de manière graphique
   procedure Aff (Tab : in  Nbr) is
      Hauteur : constant Integer := Tab'Last;
      Value : Integer := 0;
      G : Grille(Tab'Range, 1..Hauteur) := (others => (others => ' '));
      Max : Integer := 0;
   begin
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
	 Value := ((Tab(I)*Tab'Last)/(Tab(Max)+1));
	 for J in G'First(2)..Value loop
	    G(J,I) := '#';
	 end loop;
      end loop;
      --Affichage
      for H in G'Range(1) loop
	 for V in G'Range(2) loop
	    Put(G(G'Last-H+1,V) & " ");
	 end loop;
	 New_Line;
      end loop;
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
	 delay TMP;
	 Aff(Tab);
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
	 delay TMP;
	 Aff(Tab);
	 
      end loop;
   end Tri_Selection;
   
   
   -- Test de la procédure tri
   procedure Test_Tri (F : P_Procedure) is
      test_tri1 : nbr(1..40);
   begin
      Put_Line("------------------");
      for J in Test_Tri1'Range loop
	 Test_Tri1(J) := Random(Hasard);
      end loop;
      
      F(test_tri1);
   end Test_tri;
   
   
   F1 : P_Procedure;
   F2 : P_Procedure;
begin
   --Renitialisation du générateur
   Reset(Hasard);
   
   --Test des fonctions
   F1 := Tri_Bulle'Access;
   F2 := Tri_Selection'Access;
   Test_Tri(F1); 
   Test_Tri(F2);
end Test_Tri;
