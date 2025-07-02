class OnboardingModel {
  final String imageUrl;
  final String title;
  final String description;

  OnboardingModel({
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}

List<Map<String, dynamic>> onboardingData = [
  {
    'imageUrl': 'assets/images/onbaording1.png',
    'title': 'Recycle Intelligemment',
    'description':
        'Triez les déchets avec facilités et participez à la préservation de l\'environnement',
  },
  {
    'imageUrl': 'assets/images/onbaording2.png',
    'title': 'Gérez vos déchets',
    'description':
        'Gérer efficacement vos déchets à la maison ou en entreprise',
  },
  {
    'imageUrl': 'assets/images/onboarding.png',
    'title': 'Gagnez des points écologiques',
    'description':
        'Accumulez des points à chaque recyclage et profitez de récompenses éco-responsables',
  },
];
