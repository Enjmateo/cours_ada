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
   
   
   function Appartient(E: in Integer; L: in List) return Boolean is P: List := L; begin
      if P = null then return False;
      elsif P.Value = E then return True;
      else return Appartient(E, P.all.Next);
      end if;
   end Appartient;
      
   procedure Filtrage(L: in List) is
      P, Prec : List := L;
      B : List := null;
   begin
      if P /= null then         --Si la liste n'est pas vide, on crée P et Prec t/q Prec prècède P
	 B := new Cell'(P.Value, null); --On stocke les valeurs déjà rencontrées dans une liste
	 P := P.Next; 
      end if;
      
      while P /= null loop
	 if Appartient(P.Value, B) then --Si on a déjà rencontré la valeur
	    Prec.Next := P.Next;        --On supprime la cellule
	    P := P.Next;
	 else                           --Sinon
	    B := new Cell'(P.Value, B); --On ajoute la valeur comme connue
	    P := P.Next;                --On passe au suivant
	    Prec := Prec.Next;
	 end if;
      end loop;
   end Filtrage;
   
   
   L0 : List := null;
   L1 : List := null;
   L2 : List := new Cell'(1, new Cell'(2, new Cell'(3, new Cell'(2, null))));
   L3 : List := new Cell'(1, new Cell'(2, new Cell'(3, new Cell'(2, null))));
   L4 : List := new Cell'(1, new Cell'(2, new Cell'(3, new Cell'(4, new Cell'(1, new Cell'(2, new Cell'(3, new Cell'(4, null))))))));
   L5 : List := new Cell'(1, new Cell'(1, new Cell'(1, new Cell'(2, new Cell'(1, new Cell'(3, new Cell'(3, null)))))));
   
begin
   -- Test appartient
   if Appartient(2, L5) then Put_Line("Test 1 ok"); end if;
   if Appartient(1, L5) then Put_Line("Test 2 ok"); end if;
   if Appartient(8, L5) then Put_Line("Test 3 failed"); end if;
   
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
   
   -- Test autre
   New_Line;
   Aff(L5);
   Filtrage(L5);
   Aff(L5);
   
end listes;

