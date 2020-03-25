with Ada.Text_Io; use Ada.Text_Io;
with Ada.IO_Exceptions;
with Contacts; use Contacts;
with Afficher_Test;
with Listes_Ordonnees_Contacts; use Listes_Ordonnees_Contacts;

procedure Tester_Liste_Contacts is  
   
   Fichier : File_Type;
   Chaine : String(1..70);
   Len : Integer := 0;
   L : Une_Liste_Ordonnee;
begin
   
   -----------------------------------------------------------
   -- Utilisation d'annuaires
   -----------------------------------------------------------
   
   -- Entourloupe pour avoir un nom de fichier contraint, saisi par l'utilisateur et de bonne taille
   Put_Line("Lecture d'un fichier de contact, veillez saisir le nom du fichier : ");
   Get_Line(Chaine, Len);
   declare
      Nom_Fichier : String(Chaine'First..Len) := Chaine(Chaine'First..Len);
   begin
      open(Fichier, in_File, Nom_Fichier);
      
      
      -- WORK IN PROGRESS
      
   
   -----------------------------------------------------------
   -- Test de création
   -----------------------------------------------------------
   Put_Line("Test après création");
   declare
      L : Une_Liste_Ordonnee;
   begin
      Afficher_Test("Est_Vide() ?", "TRUE", Boolean'Image(Est_Vide(L)));
      Afficher_Test("Cardinal() ?", "0", Integer'Image(Cardinal(L)));
      
      Put_Line("Test d'affichage: ");
      Put_Line(Liste_To_String(L)); New_Line;
   end;
   -----------------------------------------------------------
   
   
   -----------------------------------------------------------
   -- Test d'ajout d'éléments
   -----------------------------------------------------------
   Put_Line("Test après ajout d'éléments");
   declare
      L : Une_Liste_Ordonnee;
      C1 : Un_Contact := Initialiser_Contact("Charles", "Chang", "Beziers", "ORL", "0703888032");
      C2 : Un_Contact := Initialiser_Contact("Martha", "Bibbs", "Beauvais", "Psychiatre", "0616751216");
      C3 : Un_Contact := Initialiser_Contact("Jerry", "Joosten", "Albi", "Pharmacien", "0724258260");
      C4 : Un_Contact := Initialiser_Contact("Elijah", "Taylor", "Caen", "Orthodontiste", "0770222606");
   begin
      Put_Line("Liste créée, on ajout des éléments");
      Inserer(C1,L);
      Inserer(C2,L);
      Inserer(C3,L);
      Inserer(C4,L);
      Put_Line("4 éléments ajoutés");
      
      Put_Line("Test d'affichage: ");
      Put_Line(Liste_To_String(L)); New_Line;
      
      Afficher_Test("Est_Vide() ?", "FALSE", Boolean'Image(Est_Vide(L)));
      Afficher_Test("Cardinal() ?", "4", Integer'Image(Cardinal(L)));
      Afficher_Test("Appartient(C2) ?", "TRUE", Boolean'Image(Appartient(C2,L)));
   end;
   -----------------------------------------------------------
   
   
   -----------------------------------------------------------
   -- Test de manipulation
   -----------------------------------------------------------
   Put_Line("Test de manipulation");
   declare
      L : Une_Liste_Ordonnee;
      C1 : Un_Contact := Initialiser_Contact("Charles", "Chang", "Beziers", "ORL", "0703888032");
      C2 : Un_Contact := Initialiser_Contact("Martha", "Bibbs", "Beauvais", "Psychiatre", "0616751216");
      C3 : Un_Contact := Initialiser_Contact("Jerry", "Joosten", "Albi", "Pharmacien", "0724258260");
      C4 : Un_Contact := Initialiser_Contact("Elijah", "Taylor", "Caen", "Orthodontiste", "0770222606");
   begin
      Put_Line("Liste créée, on ajout des éléments");
      Inserer(C1,L);
      Inserer(C2,L);
      Inserer(C3,L);
      Inserer(C4,L);
      Put_Line("Liste créée, 4 éléments ajoutés");
      Put_Line("Liste: ");
      Put_Line("On supprime C2:"); Supprimer(C2,L);
      Afficher_Test("Cardinal() ?", "3", Integer'Image(Cardinal(L)));
      Afficher_Test("Appartient(C2) ?", "FALSE", Boolean'Image(Appartient(C2,L)));
   end;
   -----------------------------------------------------------
   
   
   -----------------------------------------------------------
   -- Test d'exceptions
   -----------------------------------------------------------
   declare
      L : Une_Liste_Ordonnee;
      C1 : Un_Contact := Initialiser_Contact("Charles", "Chang", "Beziers", "ORL", "0703888032");
      C2 : Un_Contact := Initialiser_Contact("Martha", "Bibbs", "Beauvais", "Psychiatre", "0616751216");
      C3 : Un_Contact := Initialiser_Contact("Jerry", "Joosten", "Albi", "Pharmacien", "0724258260");
      C4 : Un_Contact := Initialiser_Contact("Elijah", "Taylor", "Caen", "Orthodontiste", "0770222606");
   begin
      Put_Line("Liste créée, on ajout des éléments");
      Inserer(C1,L);
      Inserer(C2,L);
      Inserer(C3,L);
      Put_Line("On supprime un élément inexistant : ");
      Supprimer(C4, L);
   exception
      when Element_Non_Present => Put_Line("L'exception Element_Non_Present est correctement levée !");
   end;
   declare
      L : Une_Liste_Ordonnee;
      C1 : Un_Contact := Initialiser_Contact("Charles", "Chang", "Beziers", "ORL", "0703888032");
      C2 : Un_Contact := Initialiser_Contact("Martha", "Bibbs", "Beauvais", "Psychiatre", "0616751216");
      C3 : Un_Contact := Initialiser_Contact("Jerry", "Joosten", "Albi", "Pharmacien", "0724258260");
      C4 : Un_Contact := Initialiser_Contact("Elijah", "Taylor", "Caen", "Orthodontiste", "0770222606");
   begin
      Put_Line("Liste créée, on ajout des éléments");
      Inserer(C1,L);
      Inserer(C2,L);
      Put_Line("On ajoute un élément déjà présent : ");
      Inserer(C2, L);
   exception
      when Element_Deja_Present => Put_Line("L'exception Element_Deja_Present est correctement levée !");
   end;
   -----------------------------------------------------------
   
   
   -----------------------------------------------------------
   -- Test des fonctions auxiliaires
   -----------------------------------------------------------
   declare
       L, L2 : Une_Liste_Ordonnee;
       C1 : Un_Contact := Initialiser_Contact("Charles", "Chang", "Beziers", "ORL", "0703888032");
       C2 : Un_Contact := Initialiser_Contact("Martha", "Bibbs", "Beauvais", "Psychiatre", "0616751216");
       C3 : Un_Contact := Initialiser_Contact("Jerry", "Joosten", "Albi", "Pharmacien", "0724258260");
       C4 : Un_Contact := Initialiser_Contact("Elijah", "Taylor", "Caen", "Orthodontiste", "0770222606");
   begin
      New_Line;
      Put_Line("Test des fonctions auxilaires (=)");
      Put_Line("Liste créée, on ajout des éléments");
      Inserer(C1,L);
      Inserer(C2,L);
      Inserer(C3,L);
      Inserer(C4,L);
      Put_Line(Liste_To_String(L)); New_Line;
      Put_Line("On en créé une copie L2: ");
      Copie(L, L2);
      Put_Line(Liste_To_String(L2)); New_Line;
      
      Put_Line("On vérifie qu'elles sont égales:");
      Afficher_Test("=(L,L2) ?", "TRUE", Boolean'Image(L=L2));
   end;
   -----------------------------------------------------------
   
   New_Line;
   Put_Line("Fin des tests.");
   exception
      when ADA.IO_EXCEPTIONS.NAME_ERROR => Put_Line("Fichier invalide.");
   end;
end Tester_Liste_Contacts;
