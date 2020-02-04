with Ada.Text_Io;
with Ada.Integer_Text_IO;

use Ada.Integer_Text_IO;
use Ada.Text_IO;

procedure Labyrinthe is
   
   type Lab is array (Integer range <>, Integer range <>) of Character;
   
   procedure Aff(L : Lab) is
   begin
      for I in L'Range(1) loop
	 for J in L'Range(2) loop
	    Put(L(I,J));
	 end loop;
	 New_Line;
      end loop;
      New_Line(2);
   end Aff;
   
   procedure Trouver_Sortie(L : in out Lab; X : Integer; Y : Integer) is
   begin
      if L(X,Y) = 'H' then
	 raise STORAGE_ERROR;
      end if;
      
      if X = L'First or Y = L'First or X = L'Last or Y = L'Last then
	 null;
      else
	 if L(X+1,Y) = '.' then
	    Trouver_Sortie(L, X+1, Y);
	 elsif L(X,Y+1) = '.' then
	    Trouver_Sortie(L, X, Y+1);
	 elsif L(X-1,Y) = '.' then
	    Trouver_Sortie(L, X-1, Y);
	 elsif L(X,Y-1) = '.' then
	    Trouver_Sortie(L, X, Y-1);
	 end if;
      end if;
      L(X,Y) := '@';
      Put_Line("(" & Integer'Image(X) & "; " & Integer'Image(Y) & ")");
      Aff(L);
   end Trouver_Sortie;
   
   subtype Dim is Integer range 1..7;
   Mon_Lab  : Lab (Dim,  Dim):=  (('H','H','H','H','H','H','H'),
				     ('H','.','.','.','.','.','H'),
				     ('H','H','H','H','.','H','H'),
				     ('H','.','.','.','.','H','H'),
				     ('H','.','.','H','.','H','H'),
				     ('H','.','.','.','.','.','H'),
				     ('H','H','H','H','H','.','H'));
   Numero_Ligne_Depart,  Numero_Colonne_Depart  : Dim;
   Sortie_Trouvee  : boolean  := False;
begin
   Aff(Mon_Lab);
   put("Position  initiale : ");
   get(Numero_Ligne_Depart);  
   get(Numero_Colonne_Depart);
   Trouver_Sortie(Mon_Lab, Numero_Ligne_Depart, Numero_Colonne_Depart);
   
exception
   when STORAGE_ERROR => Put_Line("Le Labyrinthe n'a pas de sortie !");
end Labyrinthe;
