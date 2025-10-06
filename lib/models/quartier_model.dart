class QuartierModel {
  final String nom;
  final double latitude;
  final double longitude;

  QuartierModel({required this.nom, required this.latitude, required this.longitude});
}

final List<QuartierModel> quartiers = [
  QuartierModel(nom: "Bonamoussadi", latitude: 4.0850, longitude: 9.7560),
  QuartierModel(nom: "Akwa", latitude: 4.0483, longitude: 9.7043),
  QuartierModel(nom: "Makepe", latitude: 4.0987, longitude: 9.7405),
  QuartierModel(nom: "Deido", latitude: 4.0590, longitude: 9.7086),
  QuartierModel(nom: "Bonanjo", latitude: 4.0515, longitude: 9.6897),
];
