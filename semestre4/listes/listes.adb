with ada.text_io; use ada.text_io;

procedure listes is
   
   -- Création cellules et listes
   type Cell;
   type List is access Cell;
   type Cell is record
      Value : Integer;
      Next : List;
   end record;
   
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
   
   
   L0 : List := null;
   L1 : List := null;
   L2 : List := new Cell'(1, new Cell'(2, new Cell'(3, null)));
   L3 : List := new Cell'(1, new Cell'(2, new Cell'(3, null)));
   L4 : List := new Cell'(1, new Cell'(2, new Cell'(3, new Cell'(4, null))));
begin
   Test_Identiques(L0, L1); --Identiques
   Test_Identiques(L2, L3); --Identiques
   Test_Identiques(L0, L2); --Différentes
   Test_Identiques(L2, L4); --Différentes
end listes;

