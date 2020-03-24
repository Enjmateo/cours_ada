with Ada.Text_Io; use Ada.Text_Io;

--
-- GASC Mayeul - 2 MIC D
-- fait le 18/03/20
--
-- Programme de test du packetage files :
   with Files; 
   use Files;
-- L'objectif est de tester l'ensemble des fonctionnalités
-- dans différentes situations.
-- L'ensemble des tests et leurs objectifs sont détaillés
-- au moment de l'execution.
--
-- Nb: La fonction put() n'est pas utilisée comme demandé 


procedure Test_Files is 
   
   -- Procédure d'affichage d'un test (similaire à afficher_test.adb utilisé en TP) 
   procedure Afficher_Test(Objet_du_Test, Attendu, Obtenu : in  String) is
   begin
      Put_Line(" --------------------");
      Put_Line("  " & Objet_du_Test);
      Put_Line("  Resultat attendu : " & Attendu);
      Put_Line("  Resultat obtenu  : " & Obtenu);
      Put_Line(" --------------------");
      New_Line;
   end Afficher_Test;
   
begin
   -- Tests sur les files vide
   declare
      F : File(10);
   begin
      New_Line;
      Put_Line("Test sur une file vide");
      Put_Line("On a initialisé une liste F de taille max. 10");
      Afficher_Test("F vide ?", "TRUE", Boolean'Image(Is_Empty(F)));
      Afficher_Test("Taille max. de F ?", "10", Integer'Image(Max_Size_Of(F)));
      Afficher_Test("Taille de F ?", "0", Integer'Image(Size_Of(F)));
   end;
   
   
   -- Tests d'utilisation d'une file
   declare
      F : File(5);
   begin
      New_Line;
      Put_Line("Test d'utilisation d'une file");
      Put_Line("On a initialisé une liste F de taille max. 5");
      Insert(1, F);
      Insert(3, F);
      Insert(2, F);
      
      Put_Line("On a inséré dans F : 1, 3 et 2 dans cet ordre");
      --Put("Test d'affichage : ");
      --Put(F);
      Afficher_Test("F vide ?", "FAlSE", Boolean'Image(Is_Empty(F)));
      Afficher_Test("Taille max. de F ?", "5", Integer'Image(Max_Size_Of(F)));
      Afficher_Test("Taille de F ?", "3", Integer'Image(Size_Of(F)));
      Afficher_Test("Tête de F  ?", "1", Integer'Image(Head_Of(F)));
      
      Put_Line("On supprime la tête actuelle, nouveaux tests");
      Suppress_Head(F);
      Afficher_Test("Taille de F ?", "2", Integer'Image(Size_Of(F)));
      Afficher_Test("Tête de F  ?", "3", Integer'Image(Head_Of(F)));
      
      Put_Line("On vide une file :");
      Clear(F);
      Afficher_Test("F vide ?", "TRUE", Boolean'Image(Is_Empty(F)));
      Afficher_Test("Taille de F ?", "0", Integer'Image(Size_Of(F)));
   end;
   
   
   -- Test du bouclage
   declare
      F : File(5);
   begin
      New_Line;
      Put_Line("Test de bouclage de la file");
      Put_Line("   On ajoute 3 éléments puis on les retires pour décaler le début");
      Insert(1, F);
      Insert(2, F);
      Insert(3, F);
      Insert(4, F);
      Put_Line("   Eléments ajoutées");
      Suppress_Head(F);
      Suppress_Head(F);
      Suppress_Head(F);
      Put_Line("   3 éléments supprimés");
      Put_Line("   On ajoute suffisement d'élément pour boucler");
      Insert(5, F);
      Insert(6, F);
      Put_Line("...fait. Ok pas d'erreur.");
      New_Line;
   end;
   
   
   -- Test des exceptions
   --   Is_empty
   declare
      F : File(2);
   begin
      Put_Line("Test de suppression d'une tête inexistante (file vide) : ");
      Suppress_Head(F);
      Put_Line("Echec"); -- Si l'exception est lévée, cette ligne n'est jamais atteinte.
   exception
      when Empty_Error => Put_Line("Exception lévée, test ok !"); New_Line;
   end;
   --   Full_Error
   declare
      F : File(2);
   begin
      Insert(1, F);
      Insert(3, F);
      Put_Line("Test d'ajout dans une file pleine ");
      PUt_Line("On créé F de taille 2, on ajoute 2 éléments");
      Put_Line("On ajoute dans un file pleine");
      Insert(1, F);
      Put_Line("Echec"); -- Si l'exception est lévée, cette ligne n'est jamais atteinte.
   exception
      when Full_Error => Put_Line("Exception lévée, test ok !"); New_Line;
   end;
   
   Put_Line("Fin des tests.");
   
end Test_Files;
      
