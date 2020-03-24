--
-- GASC Mayeul - 2 MIC D
-- fait le 18/03/20
--

package Files is
   -- Type file de taille max Max_Size
   type File(Max_Size: Positive) is limited private;
   
   -- Les erreurs associées aux files
   Full_Error, Empty_Error : exception;
   
   
   --------------------------------------------------
   -- Listes des procédures et fonctions demandées --
   --------------------------------------------------
   
   procedure Clear(F : out File);
   -- Permet de nettoyer la file passée en argument
   
   function Max_Size_Of(F: in File) return Positive;
   -- Permet de connaitre la taille maximale d'une file
   
   function Is_Empty(F: in File) return Boolean;
   -- Retourne TRUE si la liste est vide
   
   function Size_Of(F : in File) return Natural;
   -- Retourne la taille actuelle de la file
   
   function Head_Of(F : in File) return Integer;
   -- Retourne l'élément en tête de file
   
   procedure Insert(E : in Integer; F : in out File);
   -- Insert l'élément E dans la file
   
   procedure Suppress_Head(F : in out File);
   -- Supprimer la tête de file
   
   --procedure Put(F : in File);
   -- procedure pour les tests unitaire
   
-- Partie privée
private
   type Tab_Elements is array (Natural range <>) of Integer;
   type File(Max_Size: Positive) is record
      Tab: Tab_Elements(1..Max_Size);
      Deb: Integer := 1;
      Nb: Natural := 0;
   end record;
end Files;
   
