with Ada.Text_Io;
with Ada.Numerics.Discrete_Random;
with Ada.Command_Line;

use Ada.Command_Line;
use Ada.Text_Io;

procedure Monty_Hall is 
   
   subtype Ternary is Integer range 1..3;
   
   package Random_bool is new Ada.Numerics.Discrete_Random(Boolean);
   package Random_Ternary is new Ada.Numerics.Discrete_Random(Ternary);
   
   package RB renames Random_Bool;
   package RT renames Random_Ternary;
   
   HasardRB : RB.Generator;
   HasardRT : RT.Generator;
   
   
   type Door is record
      Name : String;
      Is_Open : Boolean;
      Hide_Goat : Boolean;
   end record;
   
   type List_D is array (Integer range <>) of Door;
   
   type Strat is (C,N,R); -- Change / Not_Change / Random
   
   --Initialisation des portes
   procedure Set_Door (A,B,C : out Door) is
      T : Ternary;
   begin
      A := ("A",False, False);
      B := ("B",False, False);
      C := ("C",False, False);
      
      T := RT.Random(HasardRT);
      case T is
	 when 1 => A.Hide_Goat := True;
	 when 2 => B.Hide_Goat := True;
	 when 3 => C.Hide_Goat := True;
      end case;
   end Set_Door;
   
   -- Le présentateur désigne une porte dans la liste
   function Presentateur(L : in List_D(1..2)) return Integer is
      I : Integer;
   begin
      if List_D(1).Hide_Goat and List_D(2).Hide_Goat then
	 I := RB.Random(HasardRB);
      elsif List_D(1).Hide_Goat and not List_D(2).Hide_Goat then
	 I := 1;
      else
	 I := 2;
      end if;
      return I;
   end Presentateur;
   
   
   --Joue 1 jeu, retourne vrai si le joueur gagne
   function Game (S : in Strat) return Boolean is
      A, B, C, M : Door; -- M buffer
      Choice_T1 : Door;
      L1 : List_D(1..3) := (A,B,C);
      L2 : List-D(1..2); 
   begin
      Set_Door(A,B,C);
      
      -- Tour 1 et liste des porte restantes
      case RT.Random(HasardRT) is
	 when 1 => Choice_T1 := A; L2 := (B,C); M := A;
	 when 2 => Choice_T1 := B; L2 := (A,C); M := B;
	 when 3 => Choice_T1 := C; L2 := (A,B); M := C;
      end case;
      --Fin Tour 1
      
      -- Action Présentateur
      L2(Presentateur(L2)).IS_Open := True;
      L1 := ((M) & L2);
      
      for J in L1'Range loop
	 if L1(J).IS_Open then
	    Put_Line("Porte " & L1(J).Name & " ouverte" );
	 elsif 
	    
	 end if;
      end loop;
      --##
      --## ALGORITHME NON FINI
      --##
      --##
      return A.Hide_Goat;
   end Game;
   
   
begin
   RB.Reset(HasardRB);
   RT.Reset(HasardRT);
   
   if Game then
      Put("OK");
   end if;
end Monty_Hall;
