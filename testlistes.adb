with Liste_Generique;
with Ada.Text_IO; use Ada.Text_IO;

procedure Testlistes is

  procedure Affiche_Int(E : Integer) is
  begin
    Put_Line(Integer'Image(E));
  end Affiche_Int;

  package Listes_Test is new Liste_Generique(Integer, Affiche_Int);

  L : Listes_Test.Liste;
  I : Listes_Test.Iterateur;
begin
  L := Listes_Test.Creer_Liste;

  for I in 1..5 loop
    Listes_Test.Insere_Tete(I,L);
  end loop;
  I := Listes_Test.Creer_Iterateur(L);

  while Listes_Test.A_Suivant(I) loop
    Affiche_Int(Listes_Test.Element_Courant(I));
    Listes_Test.Suivant(I);
  end loop;

  Listes_Test.Affiche_Liste(L);
end Testlistes;
