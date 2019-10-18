-- Compilation possible uniquement à l'INSA
with Tortue;
with Ada.Text_Io;
use Tortue;
use Ada.Text_Io;

procedure Koch is
   
   -- Procedure récursive pour tracer des courbes
   procedure Courbe (Finesse: Integer; Longueur : Integer) is
   begin
      if Finesse = 1 then
	 Avancer(Float(Longueur));
      else 
	 Courbe(Finesse - 1, Longueur / 4);
	 Tourner_Gauche (60.0);
	 Courbe(Finesse - 1, Longueur / 4);
	 Tourner_Droite(120.0);
	 Courbe(Finesse - 1, Longueur / 4);
	 Tourner_Gauche(60.0);
	 Courbe(Finesse - 1, Longueur / 4);
      end if;
   end Courbe;
   
   
   -- Procédure pour tracer un flocon
   procedure Flocon(Finesse: Integer; Longueur : Integer) is
   begin
      for I in 1..3 loop
	 Courbe(Finesse, Longueur);
	 Tourner_Droite(120.0);
      end loop;
   end Flocon;
   

   -- Initialisation de tortue
   procedure Init is
   begin
      Ouvrir_Fenetre;
      Lever_Crayon;
      Aller_A(300,400);
      Tourner_Droite(90.0);
      Baisser_Crayon;
   end Init;
   
   -- Procédure de test
   procedure Test_Koch is
      Pixel : Integer := 1000;
   begin
      Init;
      Flocon(4, pixel);
   end Test_Koch;
   
   
begin
   Test_Koch;
end Koch;
