with ada.text_io; use ada.text_io;

procedure Listes_d is
   
   -- Création cellules et listes
   type Cell;
   type P_Cell is access Cell;
   type Cell is record
      Value : Integer;
      Next : P_Cell;
      Prev : P_Cell;
   end record;
   type List is record
      First : P_Cell;
      Last : P_Cell;
   end record;
   
   procedure Aff(L : in List) is
      P : P_Cell := L.First;
   begin
      while P /= L.Last loop
	 Put(Integer'Image(P.Value) & "  ");
	 P := P.all.Next;
      end loop;
      New_Line;
   end Aff;
   
   procedure Add_Beg(L : in out List) is
   begin
      null;
   end Add_Beg;
   
   procedure Add_End(L : in out List) is
   begin
      null;
   end Add_End;
   
   
begin
   null;
end Listes_d;
