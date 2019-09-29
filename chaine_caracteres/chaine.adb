with ada.Text_IO, Ada.Integer_Text_IO;
with ada.Calendar;

use ada.Text_IO;

procedure Chaine is
   -- Sous-types & variables globales
   LMT : constant Integer := 100; -- Taille maximun du traitement
   Type Buffer is array (1..LMT) of Character;
   type Position is record 
      Debut : Integer;
      Fin : Integer;
   end record;
   
   
   -- Lecture d'entrée console
   function Lire_Entree return String is
      Saisie : String (1..LMT);
      Last : Natural;
   begin
      Get_Line(Saisie, Last);
      declare
	 Phrase : String(Saisie'First..(Last+2));
      begin
	 Phrase(Phrase'First) := ' ';
	 Phrase(Phrase'Last) := ' ';
	 Phrase((Phrase'First+1)..(Phrase'Last-1)) := Saisie((Saisie'First)..Last);
	 return Phrase;
      end;
   end Lire_Entree;
   
   
   -- Extrait le premier mot d'un string
   function Extraire_Mot(Text : in out String; Trouve : out Boolean) return Position is
      I : Integer := 1;
      Pos : Position;
      Fin : Boolean := False;
   begin
      Trouve := True;
      
      while Text(I) = ' ' and not Fin loop
	 I := I + 1;
	 if I >= Text'Last then 
	    Trouve := False;
	    Fin := True;
	 end if;
      end loop;
      
      Pos.Debut := I;
      
      while not Fin loop
	 if Text(I) = ' ' then
	    Fin := True;
	 else
	    I := I + 1;
	 end if;
      end loop;
      
      Pos.Fin := I;
      
      for J in Text'First..I loop
	 Text(J) := ' ';
      end loop;

      return Pos;
   End Extraire_Mot;
   
   
   -- Procedure de recherche de mot
   procedure Fnd_Mot (Txt :  String) is
      Fini : Boolean := False;
      Compteur : Integer := 0;
      Pos : Position;
      Trouve : Boolean;
      Text : String(Txt'Range) := Txt; -- question de compatibilité
      
   begin
      while not Fini loop
	 Pos := Extraire_Mot(Text, Trouve);
	 
	 if not Trouve then
	    Fini := True;
	    Put_Line("Extraction terminée");
	 else 
	    Compteur := Compteur + 1;
	    Put("Mot n°" & Integer'Image(Compteur) & " trouvé : ");
	    for I in Pos.Debut..Pos.Fin loop
	       Put(Txt(I));
	       Text(I) := ' ';
	    end loop;
	    New_Line;
	 end if;
      end loop;
   end Fnd_Mot;
   
   
begin
   Fnd_Mot(Lire_Entree);
end Chaine;
