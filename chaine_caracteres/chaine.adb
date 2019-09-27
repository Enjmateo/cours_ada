with ada.Text_IO, Ada.Integer_Text_IO;
with ada.Calendar;

use ada.Text_IO;

procedure Chaine is
   -- Sous-types & variables globales
   LMT : constant Integer := 100; -- Taille maximun du traitement
   Type Buffer is array (1..LMT) of Character;
   
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
   
   
   -- Procedure de recherche de mot
   procedure Fnd_Mot (Text : in String) is
      J : Integer := 0;
      Find : Boolean := False;
      Compteur : Integer := 0;
   begin
      for I in Text'Range loop
	 if Text(I) = ' ' then
	    
	    -- Localisation du ' ' suivant
	    J := 1;
	    Find := False;
	    while not Find loop
	       if Text(I+J) = ' ' then
		  Find := True;
		  Compteur := Compteur + 1;
	       else 
		  J := J+1;
	       end if;
	    end loop;
	    Put("Mot n°" & Integer'Image(Compteur) & " trouvé : ");
	    
	    for K in I..(I+J) loop
	       Put(Text(K));
	    end loop;
	    New_Line;
	 end if;
	 
      end loop;
      
   end Fnd_Mot;
   
   
begin
   Fnd_Mot(Lire_Entree);
end Chaine;
