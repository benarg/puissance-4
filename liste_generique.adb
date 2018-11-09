with Ada.Text_Io; use Ada.Text_Io;
with Ada.Unchecked_Deallocation;

package body liste_generique is

	procedure Libere is new Ada.Unchecked_Deallocation (Cellule, Liste);
	procedure LibereIterateur is new Ada.Unchecked_Deallocation(Iterateur_Interne, Iterateur);




	procedure Affiche_Liste (L : in Liste) is
		It : Iterateur;
	begin
		It := Creer_Iterateur(L);
		While A_Suivant(It) loop
			Put(Element_Courant(It));
			Suivant(It);
		end loop;
		Put(Element_Courant(It));
		New_Line;
	end Affiche_Liste;

	procedure Insere_Tete (V : in Element; L : in out Liste) is
	begin
		L := new Cellule'(V, L);
	end Insere_Tete;


	procedure Libere_Liste(L : in out Liste) is
		Tmp : Liste;
	begin
		while L /= null loop
			Tmp := L;
			L := L.Suiv;
			Libere(Tmp);
		end loop;
	end Libere_Liste;



	function Creer_Liste return Liste is
	begin
		return null;
	end Creer_Liste;

	function Creer_Iterateur (L : Liste) return Iterateur is
		It : Iterateur;
		c : Cellule;
	begin
		c.Val := L.Val;
		c.Suiv := L.Suiv;
		It := new Iterateur_Interne'(Cell => c);
		return It;
	end Creer_Iterateur;

	procedure Libere_Iterateur(It : in out Iterateur) is
	begin
		LibereIterateur(It);
	end Libere_Iterateur;


	procedure Suivant(It : in out Iterateur) is
	begin
		It.Cell := Cellule'(Val => It.Cell.Suiv.Val, Suiv => It.Cell.Suiv.Suiv);
	end Suivant;


	function Element_Courant(It : Iterateur) return Element is
	begin
		return It.Cell.Val;
	end Element_Courant;

	function A_Suivant(It : Iterateur) return Boolean is
	begin
			if It.Cell.Suiv /= null then
				return true;
			else
				return false;
			end if;
	end A_Suivant;

end Liste_Generique;
