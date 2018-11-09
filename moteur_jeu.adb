with Participant; use Participant;
with Liste_Generique;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Discrete_Random;


package body Moteur_Jeu is

    --Generateur aleatoire entre 1 et 1O
    subtype Small_Int_Range is Integer range 1..10 ;
    package My_Small_Int_Random is new Ada.Numerics.Discrete_Random( Small_Int_Range ) ;
    use My_Small_Int_Random ;


  function Choix_Coup(E : Etat) return Coup is
    L : Liste_Coups.Liste; --la liste des coups possibles
    I : Liste_Coups.Iterateur; --l'iterateur sur L
    I2 : Liste_Coups.Iterateur; --l'iterateur sur L
    resMinMax : Integer; -- le resultat de MinMax pour chaque coup
    Max : Integer; --le max des valeurs de resMinMax
    C : Coup; --le coup associe a Max

  begin

    L := Liste_Coups.Creer_Liste;
    L := Coups_Possibles(E, JoueurMoteur); -- cree la liste des coups possibles
    I := Liste_Coups.Creer_Iterateur(L); --cree un iterateur sur cette liste
    I2 := Liste_Coups.Creer_Iterateur(L); --cree un iterateur sur cette liste
      Max := Eval_Min_Max(E,P,Liste_Coups.Element_Courant(I),JoueurMoteur); --initalisation de max et c
      C := Liste_Coups.Element_Courant(I);


      while Liste_Coups.A_Suivant(I) loop
        resMinMax := Eval_Min_Max(E,P,Liste_Coups.Element_Courant(I),JoueurMoteur);
        if resMinMax > Max then
          C := Liste_Coups.Element_Courant(I);
          Max := resMinMax;
        end if;
        Liste_Coups.Suivant(I);
      end loop;
      --On le fait une fois encore apres le loop
      resMinMax := Eval_Min_Max(E,P,Liste_Coups.Element_Courant(I),JoueurMoteur);
      if resMinMax > Max then
        C := Liste_Coups.Element_Courant(I);
        Max := resMinMax;
      end if;

      Liste_Coups.Libere_Liste(L);
      Liste_Coups.Libere_Iterateur(I);
      return C;
  end Choix_Coup;



  function Eval_Min_Max(E : Etat; P : Natural; C : Coup; J : Joueur) return Integer is
    L : Liste_Coups.Liste;
    I : Liste_Coups.Iterateur;
    ret : Integer; --la valeur de retour
    valeur : Integer; --la valeur de retour de MinMax pour chaque coup
  	ESuiv : Etat;
  begin
    valeur := 0;
	  ESuiv := E;
    ESuiv := Etat_Suivant(ESuiv,C);--on joue le coup
    if P = 1 then
      return Eval(ESuiv,J);
    end if;
    if Est_Gagnant(ESuiv,J) then
      return Eval(ESuiv,J);
    end if;
    if Est_Gagnant(ESuiv,Adversaire(J)) then
      return Eval(ESuiv,J);
    end if;
    if Est_Nul(ESuiv) then
      return Eval(ESuiv,J);
    end if;

    L := Liste_Coups.Creer_Liste; -- cree une liste de coups
    L := Coups_Possibles(ESuiv,J); -- cree la liste des coups possibles
    I := Liste_Coups.Creer_Iterateur(L); --cree un iterateur sur cette liste
    ret := Eval_Min_Max(ESuiv,P-1,Liste_Coups.Element_Courant(I),J); -- initialisation de ret

    if Joue(E,Adversaire(J)) then --remonte le max si c'est a l'ordinateur de jouer
      while Liste_Coups.A_Suivant(I) loop --on parcours la liste
        valeur := Eval_Min_Max(ESuiv,P-1,Liste_Coups.Element_Courant(I),J);
        if ret < valeur then
          ret := valeur;
        end if;
        Liste_Coups.Suivant(I);
      end loop;
      --la meme chose que la boucle, pour le dernier maillon
      valeur := Eval_Min_Max(ESuiv,P-1,Liste_Coups.Element_Courant(I),J);
      if ret < valeur then
        ret := valeur;
      end if;

    else --remonte le min sinon
      while Liste_Coups.A_Suivant(I) loop --on parcours la liste
        valeur := Eval_Min_Max(ESuiv,P-1,Liste_Coups.Element_Courant(I),J);
        if ret > valeur then
          ret := valeur;
        end if;
        Liste_Coups.Suivant(I);
      end loop;
      --la meme chose pour le dernier
      valeur := Eval_Min_Max(ESuiv,P-1,Liste_Coups.Element_Courant(I),J);
      if ret > valeur then
        ret := valeur;
      end if;
    end if;

    Liste_Coups.Libere_Liste(L);
    Liste_Coups.Libere_Iterateur(I);
    return ret;
  end Eval_Min_Max;


end Moteur_Jeu;
