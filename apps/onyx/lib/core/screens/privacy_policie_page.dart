import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Politique de confidentialité"),
        backgroundColor: Theme.of(context).cardColor,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Politique de confidentialité",
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 16),
              const Text(
                  "Notre application est conçue pour fournir un accès en ligne aux services de l'université de Lyon 1. Nous prenons la protection de vos informations personnelles au sérieux et nous sommes déterminés à assurer la confidentialité de vos informations."),
              const SizedBox(height: 16),
              Text("Collecte de données",
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              const Text(
                  "Notre application ne collecte aucune information personnelle à part les données de crashlitics. Les données de connexion sont stockées uniquement sur le téléphone de l'utilisateur et ne sont communiquées qu'avec les serveurs de l'université, pour lesquels nous ne sommes pas responsables."),
              const SizedBox(height: 16),
              Text("Sécurité des données",
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              const Text(
                  "Nous prenons des mesures de sécurité raisonnables pour protéger vos informations personnelles contre la perte, l'utilisation abusive, l'accès non autorisé, la modification et la divulgation. Néanmoins, aucune méthode de transmission sur Internet ou de stockage électronique n'est sûre à 100 %. Par conséquent, bien que nous nous efforcions de protéger vos informations personnelles, nous ne pouvons garantir la sécurité absolue de vos informations transmises à notre application et vous le faites à vos risques et périls."),
              const SizedBox(height: 16),
              Text("Modifications de cette politique de confidentialité",
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              const Text(
                  "Nous nous réservons le droit de modifier cette politique de confidentialité de temps à autre. Toute modification sera publiée sur cette page et prendra effet immédiatement après sa publication. Il est de votre responsabilité de consulter régulièrement cette page pour vous tenir informé des modifications apportées à notre politique de confidentialité."),
              const SizedBox(height: 16),
              Text("Contactez-nous",
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              const Text(
                  "Si vous avez des questions concernant cette politique de confidentialité, veuillez nous contacter sur github"),
            ],
          ),
        ),
      ),
    );
  }
}
