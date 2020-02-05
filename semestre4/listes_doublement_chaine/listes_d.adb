with ada.text_io; use ada.text_io;

procedure Listes_d is
   
   -- Création cellules et listes
   type Cell;
   type P_Cell is access Cell;
   type Cell is record
      Value : Integer;
      Prev : P_Cell;
      Next : P_Cell;
   end record;
   type List is record
      First : P_Cell;
      Last : P_Cell;
   end record;
   
   --Exceptions
   Element_Inexistant : exception;
   
   procedure Aff(L : in List) is
      P : P_Cell := L.First;
   begin
      while P /= null loop
	 Put(Integer'Image(P.Value) & "  ");
	 P := P.all.Next;
      end loop;
      New_Line;
   end Aff;
   
   procedure Add_Beg(L : in out List; E : in integer) is
      Buffer : P_Cell := null;
   begin
      if L.First = null then
	 L.First := new Cell'(E, null, null);
	 L.Last := L.First;
      else
	 Buffer := L.First;
	 L.First := new Cell'(E, null, Buffer);
	 Buffer.all.Prev := L.First;
      end if;	 
   end Add_Beg;
   
   procedure Add_End(L : in out List; E : in integer) is
      Buffer : P_Cell := null;
   begin
      if L.First = null then
	 L.First := new Cell'(E, null, null);
	 L.Last := L.First;
      else
	 Buffer := L.Last;
	 L.Last := new Cell'(E, Buffer, null);
	 Buffer.all.Next := L.Last;
      end if;
   end Add_End;
   
   procedure Del_Beg(L : in out List) is
   begin
      if L.First /= L.Last then
	 L.First := L.First.all.Next;
	 L.First.Prev := null;
      elsif L.First /= null then
	 L.First := null;
	 L.Last := null;
      end if;
   end Del_Beg;
   
   procedure Del_End(L : in out List) is
   begin
      if L.First /= L.Last then
	 L.Last := L.Last.all.Prev;
	 L.Last.Next := null;
      elsif L.Last /= null then
	 L.First := null;
	 L.Last := null;
      end if;
   end Del_end;
   
   procedure Del_Elem(L : in out List; E : in Integer) is
      P, Prec : P_Cell := null;
      Find :  Boolean;
   begin
      if L.First = null then
	 raise Element_Inexistant;
      elsif L.First.Value = E then
	 Del_Beg(L);
      elsif L.Last.Value = E then
	 Del_End(L);
      else
	 Prec := L.first;
	 P := L.First.Next;
	 Find := False;
	 while P /= null and Find = False loop
	    if P.Value = E then
	       Prec.Next := Prec.next.Next;
	       P := Prec.Next;
	       P.Prev := Prec;
	       Find := True;
	    end if;
	    Prec := P;
	    P := P.Next;
	 end loop;
	 if Find = False then
	    raise Element_Inexistant;
	 end if;
      end if;
   exception
      when Element_Inexistant => Put_Line("Tentative de suppression d'un élément inexistant");
   end Del_Elem;

   L : List;
begin
   --EXO 3
   Add_Beg(L, 1);
   Add_Beg(L, 8);
   Add_Beg(L, 6);
   Add_Beg(L, 3);
   Add_End(L, 4);
   Aff(L);
   Del_Beg(L);
   Aff(L);
   Del_End(L);
   Aff(L);
   Add_End(L, 9);
   Aff(L);
   Del_Elem(L, 8);
   Aff(L);
   Del_Elem(L, 9);
   Aff(L);
   Del_Elem(L, 28);
   
   L := (null, null);
   Del_Elem(L, 1);
end Listes_d;
