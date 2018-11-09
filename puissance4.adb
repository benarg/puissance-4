with Liste_Generique;
with Participant;
with Ada.Text_IO, Ada.Integer_Text_Io;
use Ada.Text_IO;
use Ada.Integer_Text_Io;
use Participant;


package body Puissance4 is



	-- initilisae l'etat correspondant à l'etat du puissance4 lorsque l'on commence une partie (tableau vide).
	function Initialiser return Etat is
		tab : tabEtats;
		tabP : tabNbPionsCol;
		E : Etat;
	begin
		for i in 1..largeur loop
			for j in 1..hauteur loop
				tab(j,i) := ' ';
			end loop;
			tabP(i) := 0;
		end loop;
		E := (tab => tab, nbrCroix => 0, nbrRond => 0, tabCol => tabP);
		return E;
	end Initialiser;

	function Joue(E : Etat ; J : Joueur) return Boolean is
	begin
		if E.nbrCroix > E.nbrRond and then J = Joueur2 then
			return true;
		end if;
		if E.nbrRond = E.nbrCroix and then J = Joueur1 then
			return true;
		end if;
		return false;
	end Joue;


	function Jouer(E : Etat; C : Coup) return Etat is
		i : Integer;
		ESuiv : Etat;
	begin
		ESuiv := E;
		if ESuiv.tabCol(C) /= hauteur then
			i := ESuiv.tabCol(C) + 1;
			if ESUiv.nbrCroix > ESuiv.nbrRond then
				ESuiv.tab(i, C) := 'O';
				ESuiv.nbrRond := ESuiv.nbrRond + 1;
			else
				ESuiv.tab(i, C) := 'X';
				ESuiv.nbrCroix := ESuiv.nbrCroix + 1;
			end if;
			ESuiv.tabCol(C) := ESuiv.tabCol(C) + 1;
			return ESuiv;
		else
			raise coupImpossible;
		end if;
	end Jouer;

	function Est_Gagnant(E : Etat; J : Joueur) return Boolean is
		c : Character;
		--gagne : Boolean;
		k : Integer;
	begin
		--gagne := false;
		if J = Joueur1 then
			c := 'X';
		else
			c := 'O';
		end if;
		for i in 1..hauteur loop
			for j in 1..largeur loop
				if E.tab(i,j) = c then
					if i <= hauteur - nbrPionsAlignes + 1 then      -- on regarde si il y a nbrPions alignes verticalement
						k := 0;
						while k < nbrPionsAlignes and then E.tab(i+k,j) = c loop
							k := k+1;
						end loop;
						if k = nbrPionsAlignes then
							return true;
						end if;
					end if;
					if j <= largeur - nbrPionsAlignes + 1 then      -- on regarde si il y a nbrPionsAligne horizontalement
						k := 0;
						while k < nbrPionsAlignes and then E.tab(i,j+k) = c loop
							k := k+1;
						end loop;
						if k = nbrPionsAlignes then
							return true;
						end if;
					end if;
					if  i <= hauteur - nbrPionsAlignes + 1 and j <= largeur - nbrPionsAlignes + 1 then  -- on regarde si il y a nbrPionsAlignes dans la diagonale montante
						k := 0;
						while k < nbrPionsAlignes and then E.tab(i+k,j+k) = c loop
							k := k+1;
						end loop;
						if k = nbrPionsAlignes then
							return true;
						end if;
					end if;
					if i >= nbrPionsAlignes and j <= largeur - nbrPionsAlignes + 1 then    -- on regarde si il y a nbrPionsAlignes dans la diagonale descendente
						k := 0;
						while k < nbrPionsAlignes and then E.tab(i-k,j+k) = c loop
							k := k+1;
						end loop;
						if k = nbrPionsAlignes then
							return true;
						end if;
					end if;
				end if;
			end loop;
		end loop;
		return false;
	end Est_Gagnant;

	function Est_Nul(E : Etat) return Boolean is
	begin
		for i in 1..largeur loop
			if E.tabCol(i) /= hauteur then
				return false;
			end if;
		end loop;
		for J in Joueur loop
			if Est_Gagnant(E, J) then
				return false;
			end if;
		end loop;
		return true;
	end Est_Nul;

	procedure Afficher(E : Etat) is
	begin
		New_Line;
		New_Line;
		Put_Line("--------------------------------------------------------------------------------");
		New_Line;
		Put("  ");
		for i in 1..largeur loop
			Put(Integer'Image(i) & "  " );
		end loop;
		for i in 1..hauteur loop
			New_Line;
			for j in 1..largeur loop
				Put(" | " & E.tab(hauteur+1-i,j));
			end loop;
			Put(" |");
		end loop;
		New_Line;
		for i in 1..largeur loop
			Put("-----");
		end loop;
		Put_Line("-");
	end Afficher;

	procedure Affiche_Coup(C : in Coup) is
	begin
		Put_Line(Integer'Image(C));
	end Affiche_Coup;

	function Demande_Coup_Joueur1(E : Etat) return Coup is
		c : Coup;
	begin
		Put("Joueur 1 : Choissisez le numéro de la colonne ou vous voulez jouer : ");
		Boucle : loop
		begin
			Get(c);
			if E.tabCol(c) = hauteur then
				raise coupImpossible;
			end if;
			--Put("Joueur 1 joue : ");
			--Affiche_Coup(c);
			exit Boucle;
		exception when coupImpossible | Constraint_Error =>
			New_Line;
			Put_Line("Coup impossible ! Rejouez !");
			New_Line;
			Put("Joueur 1 : Choissisez le numéro de la colonne ou vous voulez jouer : ");
		end;
		end loop Boucle;
		return(c);
	end Demande_Coup_Joueur1;

	function Demande_Coup_Joueur2(E : Etat) return Coup is
		c : Coup;
	begin
		Put("Joueur 2 : Choissisez le numéro de la colonne ou vous voulez jouer : ");
		Boucle : loop
		begin
			Get(c);
			if E.tabCol(c) = hauteur then
				raise coupImpossible;
			end if;
			--Put("Joueur 2 joue : ");
			--Affiche_Coup(c);
			exit Boucle;
		exception when coupImpossible | Constraint_Error =>
			New_Line;
			Put_Line("Coup impossible ! Rejouez !");
			New_Line;
			Put("Joueur 2 : Choissisez le numéro de la colonne ou vous voulez jouer : ");
		end;
		end loop Boucle;
		return(c);
	end Demande_Coup_Joueur2;

	function Eval(E : Etat; J : Joueur) return Integer is
		resEval : Integer;--resultat a retourner
		resMax : Integer;
		c : Character;
	begin
		resEval := 0; --on considere que comme c'est a J de jouer, il a de l'avance
		resMax := (nbrPionsAlignes)*nbrPionsAlignes; --la valeur d'un etat gagnant

		if Est_Nul(E) then
			return 0;
		end if;

		if Est_Gagnant(E,J) then
			return resMax;
		end if;

		if Est_Gagnant(E, Adversaire(J)) then
			return resMax*(-1);
		end if;

		if J = Joueur1 then --pour ceux du joueur puis ceux de l'adversaire
			c := 'X';
		else
			c := 'O';
		end if;
			for I in 1..nbrPionsAlignes loop
				resEval := resEval + I*I*Sont_Alignes(E,c,I);--le compte augmente de i*i*Retour
			end loop;
		if J = Joueur1 then --puis l'adversaire
			c := 'O';
		else
			c := 'X';
		end if;
		for I in 1..nbrPionsAlignes loop
			resEval := resEval - I*I*Sont_Alignes(E,c,I);--le compte diminue de i*i*Retour
		end loop;

		if resEval > resMax then
			resEval := resMax;
		end if;
		if resEval < -resMax then
			resEval := -resMax;
		end if;

		return resEval;
	end Eval;


	  --on recherche les symboles alignés
	  --on va faire la meme chose sur les croix et les rond
	function Sont_Alignes(E : Etat; c : Character; nombre : Integer) return Integer is
	  k : Integer;
	  res : Integer; --le nombre d'occurences
	begin
	  res := 0;

	  for i in 1..hauteur loop
	    for j in 1..largeur loop

	      if E.tab(i,j) = c then
	              --s'ils sont en colonnes
	        if i <= hauteur - nombre + 1 then
	          k := 0;
	          while k < nombre and then E.tab(i+k,j) = c loop
	            k := k+1;
						end loop;
							if i+k <= hauteur then
			          if k = nombre and then E.tab(i+k,j) = ' ' then
			            res := res+1;
			          end if;
							end if;
	        end if;

	            --s'ils sont en ligne
	        if j <= largeur - nombre + 1 then
	          k := 0;
	          while k < nombre and then E.tab(i,j+k) = c loop
	            k := k+1;
	          end loop;

	          if k = nombre then
							if j-1 >= 1 and then E.tab(i,j-1) = ' ' then
	            	res := res+1;
							end if;
							if j+k <= largeur and then E.tab(i,j+k) = ' ' then
									res := res+1;
							end if;
	          end if;
	        end if;


						--s'ils sont en diagonale montante vers la droite
	        if  i <= hauteur - nombre + 1 and j <= largeur - nombre + 1 then
	          k := 0;
	          while k < nombre and then E.tab(i+k,j+k) = c loop
	            k := k+1;
	          end loop;
	          if k = nombre and then i+k <= hauteur then
							if j+k <= largeur and then E.tab(i+k,j+k) = ' ' then
								res := res+1;
							end if;
	          end if;
	        end if;

					--s'ils sont en diagonale montante vers la gauche
				if  i <= hauteur - nombre + 1 and j >= nombre then
					k := 0;
					while k < nombre and then E.tab(i+k,j-k) = c loop
						k := k+1;
					end loop;
					if k = nombre and then i+k <= hauteur then
						if j-k >= 1 and then E.tab(i+k,j-k) = ' ' then
								res := res+1;
						end if;
					end if;
				end if;

	      end if; --end if =c

	    end loop; --end parcours
	  end loop;
	  return res;
	end Sont_Alignes;


	function Coups_Possibles(E : Etat; J : Joueur) return Liste_Coups.Liste is
	L : Liste_Coups.Liste;
	begin
		L:=Liste_Coups.Creer_Liste;
		for C in 1..largeur loop
			if E.tabCol(C) < hauteur then
				Liste_Coups.Insere_Tete (C, L);
			end if;
		end loop;
		return L;
	end Coups_Possibles;



end Puissance4;
