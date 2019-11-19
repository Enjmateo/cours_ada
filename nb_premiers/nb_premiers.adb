with Ada.Text_Io;
use Ada.Text_Io;

with Ada.Numerics.Elementary_Functions;
use Ada.Numerics.Elementary_Functions;

procedure Nb_Premiers is
   
   --Fonction pour limiter le nombre de digits, faux si trop grand
   --function digit(N : Long_Integer) return Boolean is
   --   Taille_Min : constant Natural := 19;
   --   N3 : Long_Integer := 0;
   --   N4 : Integer := 0;
   --begin
   --   N3 := 10;
   --   N4 := Integer(Mode(N));
   --   for J in 1..N4 loop
   --     N3 := N3 * 10;
   --   end loop;
   --   return (N-N3)>0 ;
   --end digit;

      
   
   -- Fonction de test de nb premiers
   function Is_Prime(N : Long_Integer) return Boolean is
      Prime : Boolean := True;
   begin
      for I in 2..Long_Integer(Sqrt(Float(N))) loop
	 if N mod Long_Integer(I) = 0 then 
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
	 --IP(N);
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
      N3 : Long_Integer := 0;
   begin
      if Is_Prime(N) then
	 --Put_Line(Long_Integer'Image(N));
	 Aff_Troncable(N);
	 for I in 1..9 loop
	    N3 := 10;
	    for J in 1..(Mode(N) - 2) loop
	       N3 := N3 * 10;
	    end loop;	    
	    N2 := N + Long_Integer(I)*N3;
	    Troncable(N2);
	 end loop;
      end if;
   end Troncable;
   
   
   
begin
   --IP(67629137);
   --Troncable(7629137);
   for I in 1..9 loop
      Troncable(Long_Integer(I));
      null;
   end loop;
   Put_Line(Integer'Image(Integer'Last));
end Nb_Premiers;
