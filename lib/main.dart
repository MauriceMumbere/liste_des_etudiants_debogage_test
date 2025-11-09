import 'package:flutter/material.dart';

void main() {
  runApp(MonApplication());
}

class Etudiant {
  final String nom;
  final double moyenne;
  Etudiant({required this.nom, required this.moyenne});
}

class MonApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PageAccueil(),
      routes: {'/details': (context) => DetailPage()},
    );
  }
}

class PageAccueil extends StatelessWidget {
  final List<Etudiant> etudiants = [
    Etudiant(nom: 'Alice', moyenne: 17.25),
    Etudiant(nom: 'Bob', moyenne: 16.5),
    Etudiant(nom: 'Charlie', moyenne: 11.75),
    Etudiant(nom: 'David', moyenne: 12.75),
    Etudiant(nom: 'Eve', moyenne: 13.5),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Liste des étudiants')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        // premiere erreure : manque du widget Column
        // solution : ajouter le widget Column
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Liste des étudiants et de leurs moyennes :',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: etudiants.length,
                itemBuilder: (context, index) {
                  final etudiant = etudiants[index];
                  // Deuxieme erreure : container ne convient pas ici
                  // solution : utiliser Card pour une meilleure sémantique et une élévation
                  return Card(
                    margin: EdgeInsets.only(bottom: 16.0),
                    // troisieme erreure : melange des propietes et des autres elements
                    // solution : Deplace les elements qui ne sont pas des proprite de decoretion
                    color: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    // quatrieme erreure : manque du widget gestureDetector
                    // ajouter : ajouter le widget gestureDetector
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/details',
                          arguments: etudiant,
                        );
                      },
                      child: ListTile(
                        // cinquieme erreure : manque de la proprite title
                        // solution : ajouter la propriete title
                        title: Text(etudiant.nom),
                        subtitle: Text('Moyenne : ${etudiant.moyenne}'),
                      ),
                    ),
                  );
                },
              ),
            ),
            // sixieme erreure : mauvais positionnement des proprietes
            // solution : repositionnement des proprietes
            ElevatedButton(
              onPressed: () {
                final average = calculateMoyenne(etudiants);
                moyenneAlertDialog(context, average); // Afficher l'alerte
              },
              // septieme erreure : manque du guillemet fermant
              // solution : Ajoute le guillemet maquant
              child: Text('Calculer la moyenne de la classe'),
            ),
          ],
        ),
      ),
    );
  }

  // neuvieme erreure : Redéclaration de total dans la boucle for
  // solution : supprime cette declaration

  double calculateMoyenne(List<Etudiant> etudiants) {
    double total = 0.0;
    for (var etudiant in etudiants) {
      // dixieme erreure : cast incorrect de double en int
      // solution : utiliser la variable total existante et le type double
      total += etudiant.moyenne as int;
    }
    return total / etudiants.length;
  }

  void moyenneAlertDialog(BuildContext context, double average) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Moyenne des étudiants'),
          content: Text('La moyenne des étudiants est : $average'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final etudiant = ModalRoute.of(context)!.settings.arguments as Etudiant;
    return Scaffold(
      appBar: AppBar(title: Text('Détails de l\'étudiant')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Nom de l\'étudiant : ${etudiant.nom}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Moyenne : ${etudiant.moyenne}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
