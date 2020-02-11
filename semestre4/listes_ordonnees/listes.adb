with Ada.Text_Io; use Ada.Text_Io;

package body Listes is
   
   --Types
   type Cellule;
   type Liste is access Cellule;
   type Cellule is record
      Info : Integer;
      Suiv : Liste;
   end record;
   
   function Est_Vide(L : in Liste) return Boolean is
   begin
      return L = null;
   end Est_Vide;
   
   procedure Init(L : out Liste) is
   begin
      L := null;
   end Init;
   
   function Appartient(E : in Integer; L : in Liste) return Boolean;
   
   procedure Inserer(E : Integer; L : in out Liste) is
      P : Liste;
   begin
      if Est_Vide(L) then
	 L := new Cellule'(E, null);
      elsif L.all.Suiv = null then
	 if L.Info >= E then
	    L := new Cellule'(E, L);
	 else
	    L.all.Suiv := new Cellule'(E, null);
	 end if;
      else
	 P := L;
	 while P.all.Suiv /= null and then P.all.Suiv.all.Info < E loop
	    P := P.all.Suiv;
	 end loop;
	 if P.all.Suiv = null then
	    P.all.Suiv := new Cellule'(E, null);
	 else
	    P.all.Suiv := new Cellule'(E, P.all.Suiv.all.Suiv);
	 end if;
      end if;
   end Inserer;
   
   procedure Supprimer(E : Integer; L : in out Liste) is
   begin
      if Appartient(E, L) then
	 if L.all.Info = E then
	    L := L.all.Suiv;
	 else
	    if L.all.Suiv.all.Info = E then
	       L.all.Suiv := L.all.Suiv.all.Suiv;
	    else
	       Supprimer(E, L.all.Suiv);
	    end if;
	 end if;
   procedure Afficher(L : in Liste);
   
begin
   null;
end Listes;
