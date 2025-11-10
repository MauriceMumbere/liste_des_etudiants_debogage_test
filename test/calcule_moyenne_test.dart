import 'package:flutter_test/flutter_test.dart';
import 'package:liste_des_etudiants_debogage_test/main.dart';

void main() {
  test('Test du calcul de la moyenne des étudiants', () {
    final page = PageAccueil();
    final etudiants = [
      Etudiant(nom: 'Alice', moyenne: 15),
      Etudiant(nom: 'Bob', moyenne: 17),
      Etudiant(nom: 'Charlie', moyenne: 13),
    ];

    final moyenne = page.calculateMoyenne(etudiants);

    expect(moyenne, equals((15 + 17 + 13) / 3));
  });
}
