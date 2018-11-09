with Liste_Generique;
with Participant;
with Ada.Text_IO;
use Participant;

-- Retourne la liste des coups possibles pour J a partir de l ’ etat J-1


generic
	largeur : Natural;
	hauteur : Natural;
	nbrPionsAlignes : Natural;

package Puissance4 is



	coupImpossible : Exception;

	type Etat is private;


	-- un coup est défini comme un entier naturel désignant la colonne dans laquelle le joueur veux placer son "pion"
	subtype Coup is Natural range 1..largeur;

	type Maillon is record
		possibilite : Coup;
		val : Integer;
	end record;

	-- function créant un état correspondant à l'état initial de la partie
	function Initialiser return Etat;

	function Jouer(E : Etat; C : Coup) return Etat;
	function Est_Gagnant(E : Etat; J : Joueur) return Boolean;
	function Est_Nul(E : Etat) return Boolean;
	procedure Afficher(E : Etat);
	procedure Affiche_Coup(C : in Coup);
	--procedure Affiche_Maillon(M : in Maillon);
	function Demande_Coup_Joueur1(E : Etat) return Coup;
	function Demande_Coup_Joueur2(E : Etat) return Coup;
	function Eval(E : Etat; J : Joueur) return Integer;
	function Sont_Alignes(E : Etat; c : Character; nombre : Integer) return Integer;
	package Liste_Coups is new Liste_Generique(Coup,Affiche_Coup);
	function Coups_Possibles ( E : etat ; J : Joueur) return Liste_Coups.Liste;
	--function Est_final(E : Etat) return Boolean;  --retourne true si E est final
	function Joue(E : Etat; J : Joueur) return Boolean;

private

	type tabEtats is array(1 .. hauteur, 1 .. largeur) of Character;
	type tabNbPionsCol is array(1..largeur) of Integer;

	-- structure définissant un état
	type Etat is record
		tab : tabEtats;  -- tableaux 2D de caractéres (un pion est un caractère 'X' ou 'O'), définissant la "grille" du puissance 4 (pas de pion = ' ')
		nbrCroix : Integer; -- nombre de pions joués par le joueur correspondant aux 'X'
		nbrRond : Integer;  --  même chose pour 'O'
		tabCol : tabNbPionsCol; -- tableaux permettant d'accéder aux nombres de coups joués dans les différentes colonnes
	end record;


end Puissance4;
