with Ada.Text_Io, Piles_Entiers, Afficher_Test;
use  Ada.Text_Io, Piles_Entiers;

procedure Post_Fixee is
   
   type Tab is array (Character range 'A'..'Z') of Integer;
   
   Symbole_Inconnu : exception;
   Manque_Operande : exception;
   Manque_Operateur : exception;
   
   procedure Lire_Entree(E : in out String; T : in out Tab) is 
      Len : Integer := 0;
   begin
      Get_Line(E, len);
      for I in Len+1..E'Last loop
	 E(I) := ' ';
      end loop;
      
      for J in 1..Len loop
	 case E(J) is
	    when 'A'..'Z' => 
	       Put("Quelle est la valeur de " & Character'Image(E(J)) & " ?");
	       T(E(J)) := Integer'Value(Get_line);
	    when others => null;
	 end case;
      end loop;
      
   end Lire_Entree;
   
   procedure Chk(P : in out Pile) is
   begin
      if Hauteur(P) < 2 then 
	 raise Manque_Operande;
      end if;
   end Chk;
   
   
   procedure Somme(P : in out Pile) is
      A,B : Integer;
   begin
      Chk(P);
      A := Sommet(P);
      Depiler(P);
      B := Sommet(P);
      Depiler(P);
      Empiler(A+B, P);
   end Somme;
   
   procedure Souss(P : in out Pile) is
      A,B : Integer;
   begin
      Chk(P);
      A := Sommet(P);
      Depiler(P);
      B := Sommet(P);
      Depiler(P);
      Empiler(B-A, P);
   end Souss;

   procedure Mult(P : in out Pile) is
      A,B : Integer;
   begin
      Chk(P);
      A := Sommet(P);
      Depiler(P);
      B := Sommet(P);
      Depiler(P);
      Empiler(A*B, P);
   end Mult;
   
   procedure Div(P : in out Pile) is 
      A,B : Integer;
   begin
      Chk(P);
      A := Sommet(P);
      Depiler(P);
      B := Sommet(P);
      Depiler(P);
      Empiler(B/A, P);
   end Div;
   
   function Eval_Exp_PostFixee(E : String; T : Tab) return Integer is
      P : Pile;
   begin
      Init(P);
      Put_Line(E);
      for I in E'First..E'Last loop
	 case E(I) is
	    when 'A'..'Z' => Empiler(T(E(I)), P);
	    when '+' => Somme(P);
	    when '-' => Souss(P);
	    when '*' => Mult(P);
	    when '/' => Div(P);
	    when ' ' => null;
	    when others => raise Symbole_Inconnu;
	 end case;
      end loop;
      
      if Hauteur(P) /= 1 then
	 raise Manque_Operateur;
      end if;
      
      return Sommet(P);
   end Eval_Exp_PostFixee;
   
   procedure display is
      E : String(1..20);
      Len : Integer := 0;
      T : Tab;
   begin
      for I in T'Range loop
	 T(I) := Len;
	 Len := Len + 1;
	 --Put_Line(I & " : " & Integer'Image(T(I)));
      end loop;
      
      Put_Line("Saisir l'expression : ");
      Lire_Entree(E, T);
      
      Put_Line(Integer'Image(Eval_Exp_PostFixee(E, T)));
      
   exception
      when Symbole_Inconnu => Put_Line("Un des caractères saisis est non valide."); Display;
      when Manque_Operande => Put_Line("Le nombre d'opérandes n'est pas valide."); Display;
      when Manque_Operateur => Put_Line("Le nombre d'opérateurs n'est pas valide."); Display;
   end Display;
   
   
begin
   <<Entry0>>
   Put_Line("Programme d'interprétation de chaine de calcul postfixee : "); 
   Display;
end Post_Fixee;
