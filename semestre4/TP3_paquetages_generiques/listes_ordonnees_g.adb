with Ada.Unchecked_Deallocation;

package body Listes_Ordonnees_g is

   -------------------------------------------------------------------------
   function Est_Vide(L : in Une_Liste_Ordonnee_Entiers) return Boolean is
   begin
      return L.Debut = null;
   end Est_Vide;
   -------------------------------------------------------------------------

   -------------------------------------------------------------------------
   function Cardinal(L : in Une_Liste_Ordonnee_Entiers) return Integer is
   begin
      return L.Taille;
   end Cardinal;
   -------------------------------------------------------------------------

   -----------------------------------------------------------------------------
   -- Appartient classique sur une liste simplement chainee (type Lien) ordonnee

   function Appartient_Lien(E : Element; LL : in Lien) return Boolean is
      Resultat : boolean;
   begin
      if LL = null or else E < LL.all.info then
         Resultat := False;         -- element non trouve
      elsif LL.all.Info = E then
         Resultat := True;          -- element trouve en 1ere place
      else
         Resultat := Appartient_Lien(E, LL.all.Suiv);  -- on cherche plus loin
      end if;
      return Resultat;
   end Appartient_Lien;

   -- Appartient sur le type Une_Liste_Ordonnee_Entiers
   -- On reutilise la fonction classique Appartient_Lien sur L.debut
   function Appartient(E : in Element; L : in Une_Liste_Ordonnee_Entiers) return Boolean is
   begin
      return Appartient_Lien(E, L.Debut);
   end Appartient;
   -------------------------------------------------------------------------

   -------------------------------------------------------------------------
   -- Conversion en chaine de caracteres
   --
   -- sur le type Lien

   function Lien_To_String(LL : in Lien) return String is
   begin
      if LL = null then return "";
                   else return Element'image(LL.all.info) & Lien_To_String(LL.all.suiv);
      end if;
   end Lien_To_String;

   -- sur le type Une_Liste_Ordonnee_Entiers
   function Liste_To_String(L: in Une_Liste_Ordonnee_Entiers) return String is
   begin
      return Element'Image(L.Taille) & " elements : (" & Lien_To_String(L.Debut) & " )";
   end Liste_To_String;
   -------------------------------------------------------------------------

   -------------------------------------------------------------------------
   -- Insertion ORDONNEE et SANS DOUBLON
   
   procedure Inserer_Lien(E: in Element; L: in out Lien) is
   begin
      if L = null then
	 L := new Cellule'(E, null);
      elsif L.Info = E then raise Element_Deja_Present;
      elsif L.info > E then
	 L := new Cellule'(E, L);
      else
	 Inserer_Lien(E, L.Suiv);
      end if;

   -- On desire une version RECURSIVE
   -- La procedure doit LEVER L'EXCEPTION Element_Deja_Present en
   -- cas de tentative d'insertion d'un doublon
   end Inserer_Lien;



   -------------------------------------------------------------------------
   procedure Inserer(E: in Element; L: in out Une_Liste_Ordonnee_Entiers) is
   begin
      Inserer_Lien(E, L.Debut);
      L.Taille := L.Taille + 1;
   end Inserer;
   -------------------------------------------------------------------------


   -- Instanciation de Ada.Unchecked_Deallocation pour desallouer
   -- la memoire en cas de suppression des elements d'une liste
   -------------------------------------------------------------------------
   procedure Free is new Ada.Unchecked_Deallocation(Cellule, Lien);
   -------------------------------------------------------------------------
   procedure Supprimer_Lien(E : in Element; L: in out Lien) is
      Recup : Lien;
   begin
      if L = null or else E < L.All.Info then
         raise Element_Non_Present;
      elsif E = L.All.Info then
         Recup := L;           -- on repere la cellule a recycler
         L     := L.All.Suiv;  -- on modifie le debut de la liste
         Free(Recup);          -- on recupere la memoire
      else
         Supprimer_Lien(E, L.all.suiv);
      end if;
   end Supprimer_Lien;
   -------------------------------------------------------------------------
   procedure Supprimer(E: in Element; L: in out Une_Liste_Ordonnee_Entiers) is
   begin
      Supprimer_Lien(E, L.debut);
      L.Taille := L.Taille - 1;
   end Supprimer;
   -------------------------------------------------------------------------
   
   -------------------------------------------------------------------------
   -- Fonctions facultatives
   function Egal_Lien(L1, L2 : in Lien) return Boolean is
   begin
      if L1 = null and L2 = null then
	 return True;
      elsif (L1 = null or L2 = null) or (L1.Info /= L2.Info) then
	 return False;
      elsif L1.Info = L2.Info then
	 return Egal_Lien(L1.all.Suiv, L2.all.Suiv);
      else
	 return FALSE; -- Ligne de code jamais atteinte, mais supprime des messages d'erreurs à la compilation.
      end if;
   end Egal_Lien;
   
   function "="(L1, L2 : in Une_Liste_Ordonnee_Entiers) return Boolean is
   begin
      return Egal_Lien(L1.Debut, L2.Debut);
   end "=";
   
   procedure Copie_Lien(L1: in Lien; L2 : out Lien) is
      P1 : Lien := L1;
      P2 : Lien := null;
   begin
      L2 := P2;
      if L1 /= null then
	 P2 := new Cellule'(P1.all.Info, null);
	 L2 := P2;
	 P1 := P1.all.Suiv;
	 while P1 /= null loop
	    P2.all.Suiv := new Cellule'(P1.all.Info, null);
	    P2 := P2.all.Suiv;
	    P1 := P1.all.Suiv;
	 end loop;
      end if;
   end Copie_Lien;
   
   procedure Copie(L1 : in Une_Liste_Ordonnee_Entiers; L2 : out Une_Liste_Ordonnee_Entiers) is
   begin
      Copie_lien(L1.Debut, L2.Debut);
      L2.Taille := L1.Taille;
   end Copie;
   
end Listes_Ordonnees_g;
