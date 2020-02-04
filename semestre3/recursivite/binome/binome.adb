with Ada.Text_Io;
with Ada.Command_Line; 

use Ada.Command_Line;
use Ada.Text_Io;

procedure Binome is
   
   -- Fonction de calcul de coef. binomiaux
   function C(P : Integer; N : Integer) return Integer is
      Coef : Integer := 1;
   begin
      if P = 0 or N = P then
	 Coef := 1;
      else
	 Coef := C(P-1, N-1) + C(P, N-1);
      end if;
      return Coef;
   end C;
   
   -- Procédure de test de C
   procedure Test_C(N : Integer) is
   begin
      for P in 0..N loop
	 Put(Integer'Image(C(P,N)) & " ");
      end loop;
   end Test_C;
      
   
begin
   Test_C(Integer'Value((Argument(1))));
exception
   when CONSTRAINT_ERROR => Put_Line("1 argument attendu : valeur de N. Exemple : ./binome 7.");
end Binome;
