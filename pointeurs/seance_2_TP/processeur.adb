with Ada.Text_IO;
with Ada.Integer_text_IO;
use Ada.Text_IO;

procedure Processeur is
   
   package Int renames Ada.Integer_Text_Io;
   
   --types
   type process is record
      Num : Integer; --PID
      Dur : Integer; --Quantum
   end record;
   
   type Tache;
   type Liste is access Tache;
   type Tache is record
      Info : Process;
      Suiv : Liste;
   end record;
   
   
   
   --------------------------
   --    TP4 : Séance 2    --
   --------------------------
   
      -- Procédure d'affichage d'une liste
   procedure Afficher (Lst2 : in Liste) is
      Aff : Boolean := True;
      Lst : Liste := Lst2;
   begin
      Put("[ ");
      
      if Lst = null then Aff := False; end if;
      
      while aff loop
	 if Lst.all.Suiv = null then
	    Aff := False;
	 end if;
	 Put("PID:" & Integer'Image(Lst.all.Info.Num) & ",Q=" & Integer'Image(Lst.all.Info.Dur) & "; ");
	 Lst := Lst.all.Suiv;
      end loop;
      Put_Line("]");
   end Afficher;
   
   -- Fonction de suppression d'élément 
   function Del_Tache (N : Integer; Lst2 : in Liste) return Liste is
      Lst : Liste := Lst2;
      Prec : Liste := Lst2;
   begin
      while Lst.all.Info.Num /= N loop
	 Lst := Lst.all.Suiv;
      end loop;
      while Prec.all.Suiv /= Lst loop
	 Prec := Prec.all.Suiv;
      end loop;
      if Prec.all.Suiv = Lst.all.Suiv then
	 Lst := null;
      else
	 Prec.all.Suiv := Lst.all.Suiv;
	 Lst := Lst.all.Suiv;
	 Put_Line("Tache n°" & Integer'Image(N) & " supprimée.");
      end if;
      return Lst;
   end Del_Tache;
   
   
   
   -- fonction d'initialisation de la machine (création des taches)
   function Init return Liste is
      Lst : Liste := null;
      P_Lst : Liste := null;
   begin
      Lst := new Tache'((1,5), null);
      P_Lst := Lst;
      for I in 2..5 loop
	 P_Lst.all.Suiv := new Tache'((I,(6-I)), null);
	 P_Lst := P_Lst.all.Suiv;
      end loop;
      P_Lst.all.Suiv := Lst;
      Afficher(Lst);
      return Lst;
   end Init;
   
   procedure Processeur(Lst : in out Liste) is
   begin
      while Lst /= null loop
	 Lst.all.Info.Dur := Lst.all.Info.Dur - 1;
	 Put_Line("La tâche n°" & Lst.all.Info.Num & " est passée dans le processeur pendant 1 quantum.");
	 if Lst.all.Info.Dur <= 0 then
	    Del_Tache(Lst.all.Info.Num, Lst);
	 end if;
      end loop;
   end Processeur;
   
   Lst : Liste := null;
begin
   Lst := Init;
end Processeur;
