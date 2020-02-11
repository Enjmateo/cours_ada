with Ada.Text_Io; use Ada.Text_Io;
with Ada.Unchecked_Deallocation;

package body Listes is
   
   --Types
   type Cellule;
   type Liste is access Cellule;
   type Cellule is record
      Info : Integer;
      Suiv : Liste;
   end record;

   --Free
   procedure Free is new Ada.Unchecked_Deallocation(Integer, Liste) ; 
   
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
      buffer : Liste;
   begin
      if Appartient(E, L) then
	 if L.all.Info = E then
	    buffer := L;
	    free(L);
	    L := buffer.all.Suiv;
	    free(buffer);	
	 else
	    if L.all.Suiv.all.Info = E then
	       buffer := L.all.suiv;
	       free(L.all.suiv);
	       L.all.Suiv := buffer.all.Suiv;
	       free(buffer);
	    else
	       Supprimer(E, L.all.Suiv);
	    end if;
	 end if;
      end if;
   end Supprimer;
   
   procedure Afficher(L : in Liste);
   
begin
   null;
end Listes;
