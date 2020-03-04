with Ada.Text_Io, listes_ordonnees_entiers, Afficher_Test;
use  Ada.Text_Io, listes_ordonnees_entiers;

procedure Test_Listes_Ordonnees_Entiers is
begin
   -----------------------------------------------------------
   -- Test de création
   -----------------------------------------------------------
   Put_Line("Test après création");
   declare
      L : Une_Liste_Ordonnee_Entiers;
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
       L : Une_Liste_Ordonnee_Entiers;
   begin
      Put_Line("Liste créée, on ajout des éléments");
      Inserer(1,L);
      Inserer(-1,L);
      Inserer(3,L);
      Inserer(45,L);
      Inserer(2,L);
      Inserer(9,L);
      Put_Line("6 éléments ajoutés : [1, -1, 3, 45, 2, 9].");
      
      Put_Line("Test d'affichage: ");
      Put_Line(Liste_To_String(L)); New_Line;
      
      Afficher_Test("Est_Vide() ?", "FALSE", Boolean'Image(Est_Vide(L)));
      Afficher_Test("Cardinal() ?", "6", Integer'Image(Cardinal(L)));
      Afficher_Test("Appartient(2) ?", "TRUE", Boolean'Image(Appartient(2,L)));
   end;
   -----------------------------------------------------------
   
   
   -----------------------------------------------------------
   -- Test de manipulation
   -----------------------------------------------------------
   Put_Line("Test de manipulation");
   declare
      L : Une_Liste_Ordonnee_Entiers;
   begin
      Inserer(1,L); Inserer(-1,L);Inserer(3,L);Inserer(45,L);Inserer(2,L);Inserer(9,L);
      Put_Line("Liste créée, 6 éléments ajoutés : [1, -1, 3, 45, 2, 9].");
      Put_Line("Liste: ");
      Put_Line(Liste_To_String(L)); New_Line;
      Put_Line("On supprime 2:"); Supprimer(2,L);
      Afficher_Test("Cardinal() ?", "5", Integer'Image(Cardinal(L)));
      Afficher_Test("Appartient(2) ?", "FALSE", Boolean'Image(Appartient(2,L)));
   end;
   -----------------------------------------------------------
   
   
   -----------------------------------------------------------
   -- Test d'exceptions
   -----------------------------------------------------------
   declare
      L : Une_Liste_Ordonnee_Entiers;
   begin
      Inserer(1,L); Inserer(-1,L);Inserer(3,L);
      Put_Line("On supprime un élément inexistant : ");
      Supprimer(28, L);
   exception
      when Element_Non_Present => Put_Line("L'exception Element_Non_Present est correctement levée !");
   end;
   declare
      L : Une_Liste_Ordonnee_Entiers;
   begin
      Inserer(1,L); Inserer(-1,L);Inserer(3,L);
      Put_Line("On ajoute un élément déjà présent : ");
      Inserer(1, L);
   exception
      when Element_Deja_Present => Put_Line("L'exception Element_Deja_Present est correctement levée !");
   end;
   -----------------------------------------------------------
   
   
   -----------------------------------------------------------
   -- Test des fonctions auxiliaires
   -----------------------------------------------------------
   declare
       L, L2 : Une_Liste_Ordonnee_Entiers;
   begin
      Put_Line("On créé une liste L: ");
      Inserer(1,L); Inserer(-1,L);Inserer(3,L);
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
end Test_Listes_Ordonnees_Entiers;
