with Ada.Text_Io, listes_ordonnees_g, Contacts, Ada.Unchecked_Deallocation;
use Contacts;

package Listes_Ordonnees_Contacts is
   package Listes_Contacts is new Listes_Ordonnees_G(Un_Contact,"<", Contact_To_string, Liberer_contact);
end Listes_Ordonnees_Contacts;
