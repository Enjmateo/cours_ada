with Ada.Text_Io;
use Ada.Text_IO;

procedure Somme is
   
   -- Type
   type Tab is array(Integer range <>) of Float;
   
   function Add(T : Tab) return Float is
   begin
      if T'Length <= 1 then
	 return T(T'Last);
      else
	 return T(T'First) + Add(T(T'First + 1.. T'Last));
      end if;
   end Add;
   
   T : Tab := (1.0, 1.5, 4.3);
begin
   Put_Line(Float'Image(Add(T)));
end Somme;
