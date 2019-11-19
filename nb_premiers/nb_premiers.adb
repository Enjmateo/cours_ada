with Ada.Text_Io;
use Ada.Text_Io;

with Ada.Numerics.Elementary_Functions;
use Ada.Numerics.Elementary_Functions;

procedure Nb_Premiers is
   
   
   -- Fonction de test de nb premiers
   function Is_Prime(N : Long_Integer) return Boolean is
      Prime : Boolean := True;
   begin
      for I in 2..Integer(Sqrt(Float(N))) loop
	 if (Float(Integer(N)/I)=Float(Integer(N))/Float(i)) then 
	    Prime := False;
	    exit;
	 end if;
      end loop;
      return prime;
   end Is_Prime;
   
   -- Affichage nombre premier
   procedure IP(N : Long_Integer) is
   begin
      if Is_Prime(N) then
	 Put_Line(Long_Integer'Image(N) & " premier");
      else
	 Put_Line(Long_Integer'Image(N) & " n'est pas premier");
      end if;
   end IP;
   
   -- Afficher les nb troncables d'une certaine taille
   procedure Aff_Troncable(N : Long_Integer) is
      Taille_Min : constant Natural := 1; --Nombre de digits des nombres affichés
   begin
      if (N-10**(Taille_Min-1))>0 then
	 Put_Line(Long_Integer'Image(N));
      end if;
   end Aff_Troncable;
   
   
   -- Puissance de 10
   function mode(M : Long_Integer) return Long_Integer is 
      I : Long_Integer := 0;
      N : Long_Integer := M;
   begin
      while N >= 0 loop
	 N := N - 10**(Integer(I));
	 I := I + 1;
      end loop;
      return I;
   end mode;
   
   -- Recherche de nombres premiers tromcables
   procedure Troncable(N : Long_Integer) is
      N2 : Long_Integer := 0;
   begin
      if Is_Prime(N) then
	 --Put_Line(Long_Integer'Image(N));
	 Aff_Troncable(N);
	 for I in 1..9 loop
	    N2 := N + Long_Integer(I*10**(Integer((Mode(N) - 1))));
	    if Is_Prime(N2) then
	       Troncable(N2);
	    end if;
	 end loop;
      end if;
   end Troncable;
   
   
   
begin
   --IP(37);
   for I in 0..9 loop
      Troncable(Long_Integer(I));
   end loop;
   --Put_Line(Integer'Image(Integer'Last));
end Nb_Premiers;
