with Ada.Text_Io; 
with Unchecked_Deallocation;

use Ada.Text_Io;

procedure Arbres is
   
   type Noeud;
   type Abr is access Noeud;
   type Noeud is record
      Info : Integer;
      Gauche : Abr;
      Droite : Abr;
   end record;
   
   procedure Free is new Unchecked_Deallocation(Noeud, Abr);
   
   --
   -- Exercice 1
   -- 
   
   -- Fonction d'appartenace en O(Hauteur(A))
   function Appartient(E : Integer; A : Abr) return Boolean is
   begin
      if A = null then
	 return False;
      elsif A.all.Info = E then
	 return True;
      else
	 if E > A.all.Info then
	    return Appartient(E, A.Droite);
	 else
	    return Appartient(E, A.Gauche);
	 end if;
      end if;
   end Appartient;
   
   -- Fonction de calcul de hauteur en O(Nb_Elements)
   function Hauteur(A : Abr) return Natural is
      HD, HG : Natural := 0;
   begin
      if A = null then
	 return 0;
      else
	 HD := Hauteur(A.Droite);
	 HG := Hauteur(A.Gauche);
	 if HD > HG then
	    return 1 + HD;
	 else 
	    return 1 + HG;
	 end if;
      end if;
   end Hauteur;
   
   -- Procédure d'affichage
   procedure Impression_Couchee(A : Abr; I : Integer := 0) is
   begin
      if A /= null then
	 Impression_Couchee(A.Droite, I + 1);
	 for J in 1..I loop
	    Put("----");
	 end loop;
	 Put_Line(Integer'Image(A.Info));
	 Impression_Couchee(A.Gauche, I + 1);
      end if;
   end Impression_Couchee;
   
   --
   -- Exercice 2
   --
   
   type Cellule;
   type Liste is access Cellule;
   type Cellule is record
      Info : Integer;
      Suiv : Liste;
   end record;
   
   -- Fonction de liste des éléments pairs --- NON IMPLEMENTE
   function Pairs(A : Abr) return Liste is
   begin
      if A = null then
	 return null;
      else
	 if A.Info mod 2 = 0 then
	    return new Cellule'(A.Info, Pairs(A.Gauche));
	 else
	    return Pairs(A.Gauche);
	 end if;
      end if;
   end Pairs;
	 
   
   A : Abr := new Noeud'(8, new Noeud'(3,new Noeud'(1,null,null),new Noeud'(6,null,null)),new Noeud'(12,new Noeud'(10,null,null),new Noeud'(15,null,null)));
begin
   Impression_Couchee(A);
end Arbres;
