class ItemModel {
  String imagePath;
  String name;
  String tag;
  String description;
  String color;
  String about;

  ItemModel({
    required this.imagePath,
    required this.name,
    required this.tag,
    required this.description,
    required this.color,
    required this.about,
  });
}

List<Map<String, dynamic>> itemData = [
  {
    "imagePath": "assets/images/plastic.png",
    "name": "Plastique",
    "tag": "plastique",
    "description":
        "Toutes les bouteilles d'eau, de soda de shampoing, produits ménagers se recyclent et sont à trier bien vidées, meme salies en enlevant les étiquettes des bouteilles",
    "color": "Orange",
    "about":
        "les bouteilles de palstiques recyclées peuvent servir à la fabrication d'autres bouteilles plastiques",
  },
  {
    "imagePath": "assets/images/aluminium.png",
    "name": "Aluminium",
    "tag": "aluminium",
    "description":
        "Toutes las canettes de biére, les emballages en aluminium, les casses de voitures se recyclent et sont à trier vidées pour donner de l'acier.",
    "color": "Rouge",
    "about":
        "les canettes en aluminium recyclées peuvent servir à la fabrication de nouvelles canettes, des chemins de fer et d'autres voitures",
  },
  {
    "imagePath": "assets/images/carton.png",
    "name": "Carton",
    "tag": "carton",
    "description":
        "Toutes les boîtes en carton, les emballages alimentaires en carton, les briques alimentaires, de cosmetiques, de jouets et ejux ou de produits ménagers se recyclent et sont à trier bien vidées, meme si elles sont souillées.",
    "color": "Bleue",
    "about":
        "Avec 4 boîtes en carton de céréales recyclées, on fabrique 1 boîtes à chaussures.",
  },
  {
    "imagePath": "assets/images/ampoule.png",
    "name": "Ampoule LED",
    "tag": "ampoule",
    "description":
        "Toutes ampoules (LED, fluocompactes, tubes néon) se recyclent et sont broyées pour séparer les differents composants",
    "color": "jaune",
    "about":
        "les ampoules recyclées permettent de fabriquer de nouvelles ampoules, des isolent thermique et broyés pour faire des abrasifs ou des revetements routiers",
  },
  {
    "imagePath": "assets/images/verre.png",
    "name": "Verre",
    "tag": "verre",
    "description":
        "Tous les emballages en verre, les bouteilles, les bocaux se recyclent et sont à trier bien vidés.",
    "color": "verte",
    "about":
        "Les verres recyclés sont transformés en ampoules ou de fibres de verre",
  },
];
