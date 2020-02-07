package body Outils is
   function Pgcd(A, B : in Positive) return Positive is 
      P : Integer := 1;
   begin
      for I in 1..A loop
	 if A mod I = 0 and B mod I = 0 then
	    P := I;
	 end if;
      end loop;
      return P;
   end Pgcd;
   
   function Ppcm(A, B : in Positive) return Positive is 
   begin
      return (A * B)/Pgcd(A,B);
   end Ppcm;
   
begin
   null;
end Outils;
