with Ada.Text_Io; use Ada.Text_Io;
with Outils; use Outils;

package body Rationnels is
   
   function Simplify(A : Rationnel) return Rationnel is
      D : Integer := Pgcd(A.Num, A.Den);
   begin
      return (A.Num / D, A.Den / D);
   end Simplify;
   
   function Constructeur(A, B : in Integer) return Rationnel is
      C : Rationnel := (A,B);
   begin
      if B = 0 then
	 C := (1,1);
	 raise Denominateur_Nul;
      end if;
      return Simplify(C);
   exception
      when Denominateur_Nul => Put_Line("Tentative de division par zero !"); raise PROGRAM_ERROR;
   end Constructeur;
   
   function Numerateur(A : in Rationnel) return Integer is
   begin
      return A.Num;
   end Numerateur;
   
   function Denominateur(A : in Rationnel) return Integer is
   begin
      return A.Den;
   end Denominateur;
   
   --Opérations arithmétiques
   function "="(A, B : in Rationnel) return Boolean is
   begin
      return A.Num = B.Num and A.Den = B.Den;
   end "=";
   
   function "+"(A, B : in Rationnel) return Rationnel is
   begin
      return Simplify((A.Num * B.Den + A.Den * B.Num, A.Den * B.Den));
   end "+";
     
   function "-"(A, B : in Rationnel) return Rationnel is
   begin
      return A + ((-1)*B.Num, B.Den);
   end "-";
   
   function "*"(A, B : in Rationnel) return Rationnel is
   begin
      return (A.Num * B.Num, A.Den * B.Den);
   end "*";
   
   function "/"(A, B : in Rationnel) return Rationnel is
   begin
      return (A.Num * B.Den, A.Den * B.Num);
   end "/";
   function To_String(A : in Rationnel) return String is
   begin
      return (" " & Integer'Image(A.Num) & " / " & Integer'Image(A.Den) & " ");
   end To_String;
   
begin
   null;
end Rationnels;
