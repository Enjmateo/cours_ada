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
   procedure Afficher (Liste : Liste) is
   begin
      null;
   end Afficher;
   
   
begin
   null;
end Pointeurs;
