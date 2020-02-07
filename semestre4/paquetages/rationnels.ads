package Rationnels is
   
   type Rationnel is private;
   
   function Constructeur(D, B : in Integer) return Rationnel;
   function Numerateur(A : in Rationnel) return Integer;
   function Denominateur(A : in Rationnel) return Integer;
   function Inverse(A : in Rationnel) return Rationnel;
   function "="(A, B : in Rationnel) return Boolean;
   function "<="(A, B : in Rationnel) return Boolean;
   function ">="(A, B : in Rationnel) return Boolean;
   function "+"(A, B : in Rationnel) return Rationnel;
   function "-"(A, B : in Rationnel) return Rationnel;
   function "*"(A, B : in Rationnel) return Rationnel;
   function "/"(A, B : in Rationnel) return Rationnel;
   function To_String(A : in Rationnel) return String;
   
   Denominateur_Nul : exception;
   
private
   type Rationnel is record
      Num : Integer;
      Den : Integer;
   end record;
end Rationnels;

   
