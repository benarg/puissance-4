with Ada.Text_IO;
with Ada.Integer_Text_IO;
with Puissance4;
with Participant;
with Partie;
 with Liste_Generique;
 with Moteur_Jeu;

use Ada.Text_IO;
use Ada.Integer_Text_IO;
use Participant;

procedure Main2Joueurs is

   package MyPuissance4 is new Puissance4(4,3,3);

	package MyOrdinateur is new Moteur_Jeu(MyPuissance4.Etat,
				  MyPuissance4.Coup,
				  MyPuissance4.Jouer,
				  MyPuissance4.Est_Gagnant,
				  MyPuissance4.Est_Nul,
				  MyPuissance4.Affiche_Coup,
				  MyPuissance4.Liste_Coups,
				  MyPuissance4.Coups_Possibles,
				  MyPuissance4.Eval,
				  MyPuissance4.Joue,
				  4,
				  Joueur2);

  package MyOrdinateur1 is new Moteur_Jeu(MyPuissance4.Etat,
          MyPuissance4.Coup,
          MyPuissance4.Jouer,
          MyPuissance4.Est_Gagnant,
          MyPuissance4.Est_Nul,
          MyPuissance4.Affiche_Coup,
          MyPuissance4.Liste_Coups,
          MyPuissance4.Coups_Possibles,
          MyPuissance4.Eval,
          MyPuissance4.Joue,
          4,
          Joueur2);


    package MyOrdinateur2 is new Moteur_Jeu(MyPuissance4.Etat,
				  MyPuissance4.Coup,
				  MyPuissance4.Jouer,
				  MyPuissance4.Est_Gagnant,
				  MyPuissance4.Est_Nul,
				  MyPuissance4.Affiche_Coup,
				  MyPuissance4.Liste_Coups,
				  MyPuissance4.Coups_Possibles,
				  MyPuissance4.Eval,
				  MyPuissance4.Joue,
				  6,
				  Joueur2);

   -- definition d'une partie entre un humain en Joueur 1 et un humain en Joueur 2
   package MyPartieHvsH is new Partie(MyPuissance4.Etat,
				  MyPuissance4.Coup,
				  "Pierre",
				  "Paul",
				  MyPuissance4.Jouer,
				  MyPuissance4.Est_Gagnant,
				  MyPuissance4.Est_Nul,
				  MyPuissance4.Afficher,
				  MyPuissance4.Affiche_Coup,
				  MyPuissance4.Demande_Coup_Joueur1,
				  MyPuissance4.Demande_Coup_Joueur2);

   package MyPartieHvsOrdi is new Partie(MyPuissance4.Etat,
				  MyPuissance4.Coup,
				  "Humain",
				  "Ordinateur",
				  MyPuissance4.Jouer,
				  MyPuissance4.Est_Gagnant,
				  MyPuissance4.Est_Nul,
				  MyPuissance4.Afficher,
				  MyPuissance4.Affiche_Coup,
				  MyPuissance4.Demande_Coup_Joueur1,
				  MyOrdinateur.Choix_Coup);


   package MyPartieOrdivsOrdi is new Partie(MyPuissance4.Etat,
				  MyPuissance4.Coup,
				  "Ordinateur 1",
				  "Ordinateur 2",
				  MyPuissance4.Jouer,
				  MyPuissance4.Est_Gagnant,
				  MyPuissance4.Est_Nul,
				  MyPuissance4.Afficher,
				  MyPuissance4.Affiche_Coup,
				  MyOrdinateur1.Choix_Coup,
				  MyOrdinateur2.Choix_Coup);



   -- use MyPartie;

   P: MyPuissance4.Etat;

	Partie : Natural;

begin
   Put_Line("Puissance 4");
   Put_Line("");
   Put_Line("Joueur 1 : X");
   Put_Line("Joueur 2 : O");

   P := MyPuissance4.Initialiser;

	New_Line;
	Put_Line("Tapez 0 pour une partie Humain VS Humain");
	Put_Line("Tapez 1 pour une partie Humain VS Ordinateur");
	Put_Line("Tapez 2 pour une partie Ordinateur VS Ordinateur");
	get(Partie);

	if Partie = 0 then
		MyPartieHvsH.Joue_Partie(P, Joueur1);
	end if;
	if Partie = 1 then
		MyPartieHvsOrdi.Joue_Partie(P, Joueur1);
	end if;
	if Partie = 2 then
	MyPartieOrdivsOrdi.Joue_Partie(P, Joueur1);
	end if;
end Main2Joueurs;
