-- with Liste_Generique;
with Participant, Partie;
with Ada.Text_IO, Ada.Integer_Text_Io;
use Ada.Text_IO;
use Ada.Integer_Text_Io;
use Participant;

package body Partie is

	procedure Joue_Partie(E : in out Etat; J : in Joueur) is
		C : Coup;
		fin : Boolean;   -- si fin == true alors la partie peut prendre fin (c'est à dire si E correspond à un état gagnant ou d'une partie 'nulle'
		player : Joueur;
	begin
		player := J;
		fin := false;
		while not fin loop   --tant que la partie n'est pas finie faire...
			Affiche_Jeu(E);  -- on affiche la 'grille' du jeux
			if player = Joueur1 then  -- si c'est au joueur 1 de jouer alors...
				C := Coup_Joueur1(E);  -- on demande quel coup il souhaite faire
				Put(Nom_Joueur1 & " joue : ");
				Affiche_Coup(C);
			else                               -- pareil si c'est au joueur 2 de jouer
				C := Coup_Joueur2(E);
				Put(Nom_Joueur2 & " joue : ");
				Affiche_Coup(C);
			end if;
			E := Etat_Suivant(E, C);    -- on actualise alors l'état du jeux qui prend en compte le coup du joueur
			if Est_Gagnant(E, player) = true then   -- on regarde si ce coup amène à un état gagnant
				fin := true;      -- si c'est le cas la partie peut prendre fin
				Affiche_Jeu(E);
				if player = Joueur1 then
					Put_Line("Félicitations "&Nom_Joueur1&": vous avez gagné la partie !");
				else
					Put_Line("Félicitations "&Nom_Joueur2&": vous avez gagné la partie !");
				end if;
			else if Est_Nul(E) then   -- de même si le coup amène à un match 'nulle'
				fin := true;
				Affiche_Jeu(E);
				Put_Line("La partie se termine sur un match nul !");
			end if;
			end if;
			player := Adversaire(player);   -- sinon on recommence avec l'autre joueur
		end loop;
	end Joue_Partie;


end Partie;
