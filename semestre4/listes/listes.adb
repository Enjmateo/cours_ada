with ada.text_io; use ada.text_io;

procedure listes is
   
   -- Création cellules et listes
   type Cell;
   type List is access Cell;
   type Cell is record
      Value : Integer;
      Next : List;
   end record;
   
   procedure Aff(L : in List) is
      P : List := L;
   begin
      while P /= null loop
	 Put(Integer'Image(P.Value) & " / ");
	 P := P.all.Next;
      end loop;
      New_Line;
   end Aff;
   
   function Identiques(L1, L2 : in List) return Boolean is
   begin
      if L1 = null and L2 = null then
	 return True;
      elsif L1 = null or L2 = null then
	 return False;
      else
	 if L1.Value = L2.Value then
	    return Identiques(L1.all.Next, L2.all.Next);
	 else 
	    return False;
	 end if;
      end if;
   end Identiques;
   
   procedure Test_Identiques(L1, L2 : in List) is
   begin
      if Identiques(L1, L2) then
	 Put_Line("Les listes sont identiques");
      else
	 Put_Line("Les listes sont différentes");
      end if;
   end Test_Identiques;
   
   procedure Filtrage(L: in List) is
      P, P2, Prec : List := L;
   begin
      while P /= null loop
	 P2 := L;
	 while P2 /= P and P2 /= null loop
	    if P2.all.Value = P.all.Value then
	       if P.all.Next /= null then
		  P := Prec;
		  Prec.all.Next := P.all.Next.all.Next;
	       else
		  P := Prec;
		  Prec.all.Next := null;
	       end if;
	    end if;
	    P2 := P2.all.Next;
	 end loop;
	 Prec := P;
	 P := P.all.Next;
      end loop;
   end Filtrage;
   
   
   L0 : List := null;
   L1 : List := null;
   L2 : List := new Cell'(1, new Cell'(2, new Cell'(3, new Cell'(2, null))));
   L3 : List := new Cell'(1, new Cell'(2, new Cell'(3, new Cell'(2, null))));
   L4 : List := new Cell'(1, new Cell'(2, new Cell'(3, new Cell'(4, new Cell'(1, new Cell'(2, new Cell'(3, new Cell'(4, null))))))));
begin
   --EXO 1
   Test_Identiques(L0, L1); --Identiques
   Test_Identiques(L2, L3); --Identiques
   Test_Identiques(L0, L2); --Différentes
   Test_Identiques(L2, L4); --Différentes
   
   --EXO 2
   Aff(L2);
   Filtrage(L2);
   Aff(L2);
   
   Aff(L4);
   Filtrage(L4);
   Aff(L4);
   
end listes;

