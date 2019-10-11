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
   
   -- Procédure d'affichage d'une liste
   procedure Afficher (Lst2 : in Liste) is
      Aff : Boolean := True;
      Lst : Liste := Lst2;
   begin
      while aff loop
	 if Lst.all.Suiv = null then
	    Aff := False;
	 end if;
	 
	 Put_Line(Integer'Image(Lst.all.Info));
	 Lst := Lst.all.Suiv;
      end loop;
   end Afficher;
   
   -- Procédure d'affichage en sens inverse d'une liste
   procedure Afficher_Inverse is
   begin
      null;
   end Afficher_Inverse;
   
   L : Liste := new Cellule'(1, new Cellule'(2, new Cellule'(3, null)));
begin
   Afficher(L);
end Pointeurs;
