procedure sous_liste(L : in Liste; S : in out Liste) is
begin
	if L /= null then
		if critere(L.info) then
			S := new Cellule'(L.info, S);
		end if;	
		sous_liste(L.all.suiv, S);
	end if;
end sous_liste;
