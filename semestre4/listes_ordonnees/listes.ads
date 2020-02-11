package Listes is
   type Liste is limited private;
   
   function Est_Vide(L : in Liste) return Boolean;
   procedure Init(L : in out Liste);
   function Appartient(E : in Integer; L : in Liste) return Boolean;
   procedure Inserer(E : Integer; L : in out Liste);
   procedure Supprimer(E : Integer; L : in out Liste);
   procedure Afficher(L : in Liste);
   
private
   type Cellule;
   type Liste is access Cellule;
   type Cellule is record
      Info : Integer;
      Suiv : Liste;
   end record;
end Listes;
