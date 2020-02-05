package Rationnels is
   
   type Rationnel is private;
   
   function Constructeur(A, B : in Integer) return Rationnel;
   function Numerateur(A : in Rationnel) return Integer;
   function Denominateur(A : in Rationnel) return Integer;
   function "+"(A, B : in Rationnel) return Rationnel;
   function "-"(A, B : in Rationnel) return Rationnel;
   function "*"(A, B : in Rationnel) return Rationnel;
   function "/"(A, B : in Rationnel) return Rationnel;
   function To_String(A : in Rationnel) return String;
   
private
   type Rationnel is record
      Num : Integer;
      Den : Integer;
   end record;
end Rationnels;

   
