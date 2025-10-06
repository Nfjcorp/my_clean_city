import 'package:flutter/material.dart';
import 'package:my_clean_city/core/utils/helpers.dart';
import 'package:my_clean_city/views/settings/profile_screen.dart';
import 'package:my_clean_city/widgets/text_custom.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: TextCustom(
          data: 'Settings',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextCustom(
              data: 'Profile',
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 10.0),
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.person_outline_sharp),
                  ),
                  title: TextCustom(
                    data: 'Gérer son profil',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  subtitle: TextCustom(
                    data: 'Accéder à vos informations et modifier son profil',
                    fontSize: 14.0,
                    color: Colors.blue.shade300,
                  ),
                  onTap: () => navigateToNextPage(context, ProfileScreen()),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextCustom(
              data: 'Paramètres de l\'application',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 10.0),
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.person),
                  ),
                  title: TextCustom(
                    data: 'Langue par défaut',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  subtitle: TextCustom(
                    data: 'choisissez votre langue préféré',
                    fontSize: 14.0,
                    color: Colors.blue.shade300,
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder:
                          (context) => DraggableScrollableSheet(
                            maxChildSize: 0.7,
                            builder: (context, scrollController) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                              );
                            },
                          ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.help_outline),
                  ),
                  title: TextCustom(
                    data: 'Help & Support',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  subtitle: TextCustom(
                    data: 'Get help and find answers to common questions',
                    fontSize: 14.0,
                    color: Colors.blue.shade300,
                  ),
                  onTap: () => navigateToNextPage(context, ProfileScreen()),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextCustom(
              data: 'Support',
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 10.0),
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.help_outline),
                  ),
                  title: TextCustom(
                    data: 'Help & Support',
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  subtitle: TextCustom(
                    data: 'Get help and find answers to common questions',
                    fontSize: 14.0,
                    color: Colors.blue.shade300,
                  ),
                  onTap: () => navigateToNextPage(context, ProfileScreen()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // DraggableScrolableSheet custom

  Widget draggableScrollableSheetCustom(ScrollController scrollController) {
    return DraggableScrollableSheet(
      maxChildSize: 0.25,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextCustom(
                  data: 'Choisir la langue',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(20),
                    color: Colors.grey.shade300,
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: TextCustom(data: 'Français', fontSize: 16),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(20),
                    color: Colors.grey.shade300,
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: TextCustom(
                      data: 'Anglais',
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
