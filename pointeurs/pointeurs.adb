with Ada.Text_IO;
use Ada.Text_IO;

procedure Pointeurs is
   
   --types
   type Cellule;
   type Liste is access Cellule;
   type Cellule is record
      Info : Integer;
      Suiv : Liste;
   end record;
   
   Ajout_Imp : exception;
   
   -----------------------------
   --    TD4 : pointeurs 1    --
   -----------------------------
   
   -- Procédure d'affichage d'une liste
   procedure Afficher (Lst2 : in Liste) is
      Aff : Boolean := True;
      Lst : Liste := Lst2;
   begin
      Put("[ ");
      
      if Lst = null then Aff := False; end if;
      
      while aff loop
	 if Lst.all.Suiv = null then
	    Aff := False;
	 end if;
	 Put(Integer'Image(Lst.all.Info) & " ;");
	 Lst := Lst.all.Suiv;
      end loop;
      Put_Line("]");
   end Afficher;
   
   
   -- Procédure d'affichage en sens inverse d'une liste
   procedure Afficher_Inverse is
   begin
      null;
   end Afficher_Inverse;
   
   
   -- Procédure qui compte le nb d'éléments d'une liste
   function Compte (Lst2 : in Liste) return Integer is
      Lst : Liste := Lst2;
      Compteur : Integer := 0;
   begin
      if Lst /= null then 
	 Compteur := 1;
	 while Lst.all.Suiv /= null loop
	    Compteur := Compteur +1;
	    Lst := Lst.all.Suiv;
	 end loop;
      end if;
      --Put_Line("Cette liste possède " & Integer'Image(Compteur) & " cellules");
      return Compteur;
   end Compte;
   
   
   --Procédure d'ajout d'élément en fin de liste de valeur V
   procedure Ajout_Cellule (Lst2 : in out Liste; V : integer) is
      Lst : Liste := Lst2;
   begin
      if Lst = null then
	 Lst2 := new Cellule'(V, null);
      else
	 while Lst.all.Suiv /= null loop
	    Lst := Lst.all.Suiv;
	 end loop;
	 Lst.all.Suiv := new Cellule'(V, null);
      end if;
      --Put_Line("Cellule ajoutée en fin de liste. Valeur : " & Integer'Image(V));
   end Ajout_Cellule;
   
   procedure AJ_Rec (Lst2 : in out Liste; V : Integer) is
   begin
      if Lst2 = null then
	 Lst2 := new Cellule'(V, null);
      else
	 AJ_Rec(Lst2.all.Suiv, V);
      end if;
   end AJ_Rec;
   
   
   -- Fonction de suppression d'un element n
   function Del_Elem (Lst : Liste; N : Integer) return Liste is
      Lst2 : Liste := Lst;
   begin
      if N <= 0 or N > Compte(Lst) then
	 raise Ajout_Imp;
      elsif N = 1 then
	 Lst2 := Lst.all.Suiv;
      else
	 for I in 2..N-1 loop
	    Lst2 := Lst2.all.Suiv;
	 end loop;
	 Lst2.all.suiv := Lst2.all.Suiv.all.Suiv;
	 Lst2 := Lst;
      end if;
      
      return Lst2;
   end Del_Elem;
      
   
   
   -- Procédure qui éclate la liste en une liste de nb pairs et une autre impaires
   function Trier_Liste(Lst : in out Liste) return Liste is
      Lst_Impaire : Liste := null;
      Lst_Buffer : Liste := Lst;
      I : Integer := 1;
      Nb_Enl : Integer := 0;
   begin
      while Lst_Buffer /= null loop
	 if (Float((Lst_Buffer.all.Info / 2)) = Float(Lst_buffer.all.Info)/2.0) then -- si info pair
	    null;
	 else
	    AJ_Rec(Lst_Impaire, Lst_Buffer.all.Info);
	    --Ajout_Cellule(Lst_Impaire, Lst_buffer.all.Info);
	    
	    Lst := Del_Elem(Lst, I - Nb_enl);
	    Nb_Enl := Nb_Enl + 1;
	 end if;
	 Lst_Buffer := Lst_Buffer.all.Suiv;
	 I := I + 1;
      end loop;
      return Lst_impaire;
   end Trier_Liste;
   
   
   
   -----------------------------
   --    TD5 : pointeurs 2    --
   -----------------------------
   
   -- Fonction copie - Version récursive
   function Copie(Lst : in Liste) return Liste is
   begin
      if Lst = null then
	return null;
      else 
	  return new Cellule'(Lst.all.Info, Copie(Lst.all.suiv));
      end if;
   end Copie;
   
   
   -- Procédure de concaténation avec destruction
   procedure Concatenation(L1, L2 : in out Liste) is
      L1buf : Liste := L1;
   begin
      while L1buf.all.suiv /= null loop
	 L1buf := L1buf.all.Suiv;
      end loop;
      L1buf.all.Suiv := L2;
      L2 := null;
   end Concatenation;
   
   
   -- Fonction de concaténation sans destruction
   function Concatenation_safe(L1, L2 : in Liste) return Liste is
      L1buf : Liste := null;
      L1bufaux : Liste := null;
   begin
      L1buf := Copie(L1);
      L1bufaux := L1buf;
      while L1bufaux.all.suiv /= null loop
	 L1bufaux := L1bufaux.all.Suiv;
      end loop;
      L1bufaux.all.Suiv := L2;
      return L1buf;
   end Concatenation_safe;
   
   
   -- Fonction de fusion
   function Fusion(L1, L2 : in Liste) return Liste is
      M1 : Liste := L1;
      M2 : Liste := L2;
      Fusion : Liste := null;
   begin
      while ((M1 /= null) and (M2 /= null)) loop
	 if (M1.all.Info <= M2.all.Info) then
	    Ajout_Cellule(Fusion, M1.all.Info);
	    M1 := M1.all.Suiv;
	 end if;
	 if (M1.all.Info > M2.all.Info) then
	    Ajout_Cellule(Fusion, M2.all.Info);
	    M2 := M2.all.Suiv;
	 end if;
      end loop;
      return Fusion;
   end Fusion;
   
   
   L : Liste := null;
   L2 : Liste := null;
   L3 : Liste := null;
begin
   -----------------------------
   --    TD4 : pointeurs 1    --
   -----------------------------
   for I in 1..10 loop
      Ajout_Cellule(L,I);
   end loop;
   --Ajout_Cellule(L,22);
   --Ajout_Cellule(L,41);
   --
   --Afficher(L);
   --New_Line;
   --Put_Line("Tri des nb pairs et impairs");
   --Afficher(Trier_Liste(L));
   --Afficher(L);
   
   -----------------------------
   --    TD5 : pointeurs 2    --
   -----------------------------
   -- Création des listes
   L2 := Copie(L);
   Ajout_Cellule(L, 22);
   Ajout_Cellule(L3, 3);
   Ajout_Cellule(L3, 5);
   Ajout_Cellule(L3, 7);
   Ajout_Cellule(L3, 9);
   
   Afficher(L);
   --Afficher(L2);
   Afficher(L3);
   --Afficher(Concatenation_safe(L, L2));
   --Afficher(L);
   --Afficher(L2);
   Afficher(Fusion(L,L3));
   
exception
   when Ajout_Imp => Put_Line("Tentative d'accès à une cellule inexistante");
end Pointeurs;
