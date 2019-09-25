with ada.Text_IO, Ada.Integer_Text_IO;
with ada.Calendar;

use ada.Text_IO;

procedure Test_Tri is
   
   -- Type tableau 
   type nbr is array (Integer range <>) of Integer;
   type Pf is access function-- cd openc
   
   -- Procédure de tri d'un tableau
   procedure tri (Tab : in out Nbr) is
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
      end loop;
   end tri;
   
   -- Test de la procédure tri
   procedure Test_Tri  is
      test_tri1 : nbr(1..10) := (5,4,8,3,9,1,6,7,2,0);
      test_tri2 : nbr(1..10) := (5,4,8,6,9,1,6,7,7,0);
   begin
      tri(test_tri2);
      tri(test_tri1);

      for i in test_tri1'First..test_tri1'Last loop
         put(Integer'Image(test_tri1(i))& " ");
      end loop;
      Put_Line("");
      for i in test_tri2'First..test_tri2'Last loop
         put(Integer'Image(test_tri2(i))& " ");
      end loop;
      Put_Line("");
   end test_tri;
   
   
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
   
   -- Main
   N : Integer;
begin
   -- test_Tri;
   
   Ada.Integer_Text_IO.Get(N);
   Put_Line(Integer'Image(Factorielle(N)));
end Test_Tri;
