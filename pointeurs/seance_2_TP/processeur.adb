with Ada.Text_IO;
with Ada.Integer_text_IO;
use Ada.Text_IO;

procedure Processeur is
   
   package Int renames Ada.Integer_Text_Io;
   
   --types
   type Cellule;
   type Liste is access Cellule;
   type Cellule is record
      Info : Integer;
      Suiv : Liste;
   end record;
   
begin
   null;
end Processeur;
