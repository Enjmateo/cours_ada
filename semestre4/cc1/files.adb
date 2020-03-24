with Ada.Text_Io; use Ada.Text_Io;

--
-- GASC Mayeul - 2 MIC D
-- fait le 18/03/20
--


package body Files is
   
   procedure Clear(F : out File) is
   begin
      F.Deb := 1;
      -- Cette affectation n'est pas obligatoire mais
      -- simplifie la compréhension
      
      F.Nb := 0;
   end Clear;
   
   function Max_Size_Of(F: in File) return Positive is
   begin
      return F.Max_Size;
      -- retourne le parametre de F demandé
   end Max_Size_Of;
   
   function Is_Empty(F: in File) return Boolean is
   begin
      return F.Nb = 0;
      -- retourne TRUE si n = 0 i.e. la liste est vide
   end Is_Empty;
   
   function Size_Of(F : in File) return Natural is
   begin
      return F.Nb;
      -- retourne le parametre de F demandé
   end Size_Of;
   
   function Head_Of(F : in File) return Integer is
   begin
      return F.Tab(F.Deb);
      -- retourne le parametre de F demandé
   end Head_Of;
   
   procedure Insert(E : in Integer; F : in out File) is
   begin
      if F.Max_Size <= F.Nb then raise Full_Error; end if;
      -- On compare la taille maximale avec le nombre d'élément déjà présent
      -- S'il n'y a plus de place on leve un exception
      
      F.Tab(((F.Deb + F.Nb - 1) mod F.Max_Size) + 1) := E;
      -- On utilise la formule donnée danss le sujet et adaptée
      
      F.Nb := F.Nb + 1;
   end Insert;
   
   procedure Suppress_Head(F : in out File) is
   begin
      if F.Nb <= 0 then raise Empty_Error; end if;
      
      if F.Deb >= F.Tab'Last then  -- Cette condiation permet un bouclage
	 F.Deb := F.Tab'First;     -- du tableau sans problèmes:
	 F.Nb := F.Nb - 1;         -- Cas 1 (if) : on doit boucler
      else                         -- Cas 2 (else) : pas besoin
	 F.Deb := F.Deb + 1;
	 F.Nb := F.Nb - 1;
      end if;
   end Suppress_Head;
   
   
   -- Procédure d'affichage de file pour les tests unitaires
   -- Mise de côtée comme demandé
--   procedure Put(F : in File) is
--      -- affiche F a l'ecran 
--      -- displays F on the screen       
--      Pos : positive;    
--   begin      
--      New_Line;       
--      Put_Line(Integer'Image(F.Nb)&" elements :");       
--      Pos := F.Deb;       
--      for I in 0..F.Nb-1 loop           
--	 Pos := ((F.Deb+I-1) mod F.Max_Size) +1;           
--	 Put_line(Integer'image(Pos)&" :" & integer'image(F.tab(Pos)));       
--      end loop;
--      New_Line;   
--   end Put;  
   
end Files;
