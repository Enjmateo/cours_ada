with Ada.Text_Io; use Ada.Text_Io;
with Rationnels; use Rationnels;

procedure Test_Paquetages is
   function Cc(A,B: Integer) return Rationnel is
   begin
      return Constructeur(A,B);
   end Cc;
   
   procedure Af(I: Integer) is begin Put_Line(Integer'Image(I)); end Af;
   
   A,B,C,D : Rationnel;
begin
   A := Cc(1,2);
   B := Cc(3,6);
   C := Cc(3,9);
   D := Cc(4,9);
   
   Af(Numerateur(A));
   Af(Denominateur(C));
   Put_Line(To_String(A));
   Put_Line(To_String(C));
   Put_Line(To_String(A + C));
   Put_Line(To_String(A - C));
   Put_Line(To_String(A * C));
   Put_Line(To_String(A / C));
   
   if A >= C then
      Put_Line(To_String(A) & " >= " & To_String(C));
   end if;
   
   if A = B then
      A := Cc(2,0);
   end if;
end Test_Paquetages;
