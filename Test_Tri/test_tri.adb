with ada.Text_IO, Ada.Integer_Text_IO;
with ada.Calendar;

use ada.Text_IO;

procedure Test_Tri is
   
   -- Type tableau 
   type nbr is array (Integer range <>) of Integer;
   type P_procedure is access procedure (Tab : in out Nbr);
   
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
      end loop;
   end Tri_Bulle;
   
   -- Tri selection
   procedure Tri_Selection (Tab : in out Nbr) is
      VMin : Integer := Integer'last;
      Min : Integer := 0;
      Buffer : Integer;
   begin
      for J in Tab'Range loop
	 for I in ((Tab'First-J)+1)..Tab'last loop
	    if VMin > Tab(I) then
	       VMin := Tab(I);
	       Min := I;
	    end if;
	 end loop;
	 Buffer := Tab(Tab'First);
	 Tab(Tab'First) := VMin;
	 Tab(Min) := Buffer;
      end loop;
   end Tri_Selection;
   
   -- Test de la procédure tri
   procedure Test_Tri (F : P_Procedure) is
      test_tri1 : nbr(1..10) := (5,4,8,3,9,1,6,7,2,0);
      test_tri2 : nbr(1..10) := (5,4,8,6,9,1,6,7,7,0);
   begin
      F(test_tri2);
      F(test_tri1);
      for i in test_tri1'First..test_tri1'Last loop
         put(Integer'Image(test_tri1(i))& " ");
      end loop;
      Put_Line("");
      for i in test_tri2'First..test_tri2'Last loop
         put(Integer'Image(test_tri2(i))& " ");
      end loop;
      Put_Line("");
   end Test_tri;
   
   
   F1 : P_Procedure;
   F2 : P_Procedure;
begin
   F1 := Tri_Bulle'Access;
   F2 := Tri_Bulle'Access;
   Test_Tri(F1); Test_Tri(F2);
end Test_Tri;
