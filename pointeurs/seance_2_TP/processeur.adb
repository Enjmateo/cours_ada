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
   
   Q : constant Natural := 1;
   
   --------------------------
   --    TP4 : Séance 2    --
   --------------------------
   
      -- Procédure d'affichage d'une liste
   procedure Afficher (Lst2 : in Liste) is
      Aff : Boolean := True;
      Lst : Liste := Lst2;
      Debut : Integer := 0;
   begin
      Put("    [ ");
      
      if Lst = null then Aff := False; end if;
      
      Debut := Lst.all.Info.Num;
      while aff loop
	 if Lst.all.Suiv.all.Info.Num = debut then
	    Aff := False;
	 end if;
	 Put("PID:" & Integer'Image(Lst.all.Info.Num) & ",Q=" & Integer'Image(Lst.all.Info.Dur) & "; ");
	 Lst := Lst.all.Suiv;
      end loop;
      Put_Line("]");
      New_Line;
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
	 Put_Line("Tache n°" & Integer'Image(N) & " supprimée.");
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
      Lst := new Tache'((1,3), new Tache'((2,5), new Tache'((3,2), new Tache'((4,3), null))));
      P_Lst := Lst;
      while P_Lst.all.suiv /= null loop
	 P_Lst := P_Lst.all.Suiv;
      end loop;
      P_Lst.all.Suiv := Lst;
      Afficher(Lst);
      return Lst;
   end Init;
   
   -- procedure de gestion des taches
   procedure Processeur(Lst : in out Liste) is
   begin
      while Lst /= null loop
	 Lst.all.Info.Dur := Lst.all.Info.Dur - Q;
	 Put_Line("La tâche n°" & Integer'Image(Lst.all.Info.Num) & " est passée dans le processeur pendant un quantum.");
	 
	 if Lst.all.Info.Dur <= 0 then
	    Put("Une tâche est terminée. ");
	    Lst := Del_Tache(Lst.all.Info.Num, Lst);
	    if Lst /= null then
	       Lst := Lst.all.Suiv;
	       --Afficher(Lst);
	    end if;
	 else
	    Lst := Lst.all.Suiv;
	    --Afficher(Lst);
	 end if;
      end loop;
      Put_Line("La liste des tâches est vide. Fin d'éxécution.");
   end Processeur;
   
   Lst : Liste := null;
begin
   Lst := Init;
   Processeur(Lst);
end Processeur;
