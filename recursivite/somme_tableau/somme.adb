with Ada.Text_Io;
use Ada.Text_IO;

procedure Somme is
   
   -- Type
   type Tab is array(Integer range <>) of Float;
   
   function Add(T : Tab; I : Integer) return Float is
   begin
      if I = T'Last then
	 return T(I);
      else
	 return T(I) + Add(T, I + 1);
      end if;
   end Add;
   
   T : Tab := (1.0, 1.5, 4.3);
begin
   Put_Line(Float'Image(Add(T, T'First)));
end Somme;
