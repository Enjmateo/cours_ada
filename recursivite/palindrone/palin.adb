with Ada.Text_Io;
with Ada.Command_Line;

use Ada.Command_Line;
use Ada.Text_IO;

procedure Palin is
   
   function Is_Palin(W : String) return Boolean is
   begin
      if W'Length <= 1 then
	 return True;
      else 
	 if Character(W(W'First)) = Character(W(W'Last)) then
	    return Is_Palin(W(W'First + 1..W'Last - 1));
	 else
	    return False;
	 end if;
      end if;
   end Is_Palin;
   
   function Is_Palin_Ite(W : String) return Boolean is
      P : Boolean := True;
   begin
      for I in W'First..(W'Length / 2) loop
	 if (W(I..I)) /= (W(W'Last - I + 1..W'Last - I + 1
			   )) then
	    P := False;
	 end if;
      end loop;
      return P;
   end Is_Palin_Ite;
   
   
begin
   for I in 1..Argument_Count loop
      New_Line;
      Put_Line(Argument(I));
      if Is_Palin(Argument(I)) then
	 Put_Line("PALINDROME");
      else 
	 Put_Line("bin non en fait...");
      end if;
      
      if Is_Palin_ite(Argument(I)) then
	 Put_Line("PALINDROME");
      else 
	 Put_Line("bin non en fait...");
      end if;
   end loop;
end Palin;
