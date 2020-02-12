-- Auteurs : P. E.
-- Version du 30/01/2019

with Ada.Text_Io, Piles_Entiers, Afficher_Test;
use  Ada.Text_Io, Piles_Entiers;

procedure Tests_Piles_Entiers is
begin
   ---------------------------------------------------------
   -- 1. Tests apres la declaration et acces a une pile vide
   ---------------------------------------------------------
   Put_Line("Test 1 : apres Declaration d'une pile P");
   declare
      P : Pile;
   begin
      Afficher_Test("Est_Vide(P)  ?", "TRUE", Boolean'Image(Est_Vide(P)));
      Afficher_Test("Hauteur(P)   ?", "0   ", Integer'Image(Hauteur(P)));
      Afficher_Test("To_String(P) ?", "    ", To_String(P));
   end;
   New_Line;
   Put_Line("Test 2: Tentative d'acces au sommet d'une pile vide");
   declare
      P  : Pile;
      Nb : Integer;
   begin
      Nb := Sommet(P);
      Afficher_Test("Sommet(P)  ?", "levee exception", Integer'Image(Nb));
      Put_Line("bizarre ... l'exception n'a pas ete levee ... ");
   exception
      when Pile_Vide =>
      Put_Line("ok, l'exception Pile_Vide a ete levee !!");
   end;

	---------------------
	-- 2. Tests d'empiler
	---------------------
   declare
      P : Pile;
   begin
      New_Line;
      Put_Line("Test 3 : Empiler 10 entiers ");
      for I in 2..12 loop
	 Empiler(I, P);
      end loop;
      Put_Line(To_String(P));
   end;

	--------------------------------
	-- 3. Tests de Depiler et Sommet
	--------------------------------
   declare
      P  : Pile;
      Nb : Integer;
   begin
      -- Empiler 10 elements
      Init(P);
      for I in 1..10 loop
	 Empiler(I, P);
      end loop;
      New_Line;
      Put_Line("Test 4: Affichage du sommet et depilement pendant 10 fois ...");

      -- Verifier que la pile est bien vide apres 10 appels a Depiler
      for J in 1..10 loop
	 Depiler(P);
      end loop;
      if Est_Vide(P) then
	 Put_Line("La pile est vide");
      else
	 Put_Line("TEST 4 FAUTIF");
	 --raise PROGRAM_ERROR;
      end if;
      New_Line;
      Put_Line("Test 5: Tentative de depilement d'une pile vide ...");
      Init(P);
      Depiler(P);
      end;

	-----------------------------------
	-- 4. Test sur l'egalite de 2 piles
	-----------------------------------
   Put_Line("Test 6 : Initialisation de 2 piles P1 et P2, et comparaison, ajout de 10 elements et comparaison");
   declare
      P1, P2 : Pile;
   begin
      null;
      -- P1 et P2 viennent d'etre declarees, elles sont donc vides
      -- Verifier qu'elles sont identiques (P1=P2)
      New_Line;
      Put_Line("Test 6 : Deux piles vides sont-elles identiques ?");
      if P1 = P2 then
	 Put_Line("Elles sont identiques");
      end if;
      New_Line;
      Put_line("On empile desormais 10 entiers 1..10 sur les 2 piles");
      for I in 2..11 loop
	 Empiler(I, P1);
	 Empiler(I, P2);
	 Put_Line("On empile sur P1 et P2 : " & Integer'Image(I));
      end loop;
      New_Line;
      Put_Line("Test 7 : Deux piles contenant 1..10 sont-elles identiques ?");
      if P1 = P2 then
	 Put_Line("Identiques");
      end if;
   end;
end Tests_Piles_Entiers;
