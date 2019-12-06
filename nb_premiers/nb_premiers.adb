with Ada.Text_Io;
use Ada.Text_Io;

with Ada.Numerics.Elementary_Functions;
use Ada.Numerics.Elementary_Functions;

procedure Nb_Premiers is
   
   -- Variables parametres
   subtype SIZE is Integer range 1..18;
   
   
   -- Fonction de test de nb premiers
   function Is_Prime(N : Long_Integer) return Boolean is
      Prime : Boolean := True;
   begin
      if N mod Long_Integer(2) = 0 then
	 Prime := False;
      else
	 for I in 2..(Long_Integer(Sqrt(Float(N)))/2) loop
	    if N mod Long_Integer(2*I-1) = 0 then 
	       Prime := False;
	       exit;
	    end if;
	 end loop;
      end if;
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
      --T_Min : constant Natural := 1; --Nombre de digits des nombres affichés
   begin
      Put_Line(Long_Integer'Image(N));
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
      N3 : Long_Integer := 0;
   begin
      if Is_Prime(N) then
	 Aff_Troncable(N);
	 if N < (Long_Integer'Last / 100) then
	    for I in 1..10 loop
	       N3 := 10;
	       for J in 1..(Mode(N) - 2) loop
		  N3 := N3 * 10;
	       end loop;	    
	       Troncable(N + Long_Integer(I)*N3);
	    end loop;
	 elsif N < (Long_Integer'Last / 11) then
	    for I in 1..8 loop
	       N3 := 10;
	       for J in 1..(Mode(N) - 2) loop
		  N3 := N3 * 10;
	       end loop;	    
	       Troncable(N + Long_Integer(I)*N3);
	    end loop;
	 end if;
      end if;
   end Troncable;
   
   
begin
   IP(Long_Integer'Last);
   for I in 1..9 loop
      null;
      --Troncable(Long_Integer(I));
   end loop;
end Nb_Premiers;
