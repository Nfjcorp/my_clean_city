import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_clean_city/core/utils/colors.dart';
import 'package:my_clean_city/core/utils/helpers.dart';
import 'package:my_clean_city/models/item_model.dart';
import 'package:my_clean_city/views/chat_ia_screen.dart';
import 'package:my_clean_city/views/citizen_collect_form.dart';
import 'package:my_clean_city/views/detail_screen.dart';
import 'package:my_clean_city/views/notifications/notification_screnn.dart';
import 'package:my_clean_city/views/report_waste_screen.dart';
import 'package:my_clean_city/widgets/button_custom.dart';
import 'package:my_clean_city/widgets/my_item_data.dart';
import 'package:my_clean_city/widgets/text_custom.dart';

class BodyHome extends StatefulWidget {
  const BodyHome({super.key});

  @override
  State<BodyHome> createState() => _BodyHomeState();
}

class _BodyHomeState extends State<BodyHome> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();
      setState(() {
        userData = doc.data();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TextCustom(
                      data: 'Hello,',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: lightPrimaryText,
                    ),
                    TextCustom(
                      data: userData!['name'] ?? 'Utilisateur',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                    Spacer(),
                    IconButton(
                      onPressed:
                          () =>
                              navigateToNextPage(context, NotificationScrenn()),
                      icon: Image.asset('assets/icons/notification.png'),
                    ),
                    IconButton(
                      onPressed:
                          () =>
                              navigateToNextPage(context, NotificationScrenn()),
                      icon: Icon(Icons.favorite_border_outlined),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 400,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      'assets/images/earn_point_light.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                TextCustom(
                  data: 'Categories',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 15),
                SizedBox(
                  height: 120,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, index) {
                      final data = itemData[index];
                      return GestureDetector(
                        onTap:
                            () => navigateToNextPage(
                              context,
                              DetailScreen(
                                item: ItemModel(
                                  description: data['description'],
                                  imagePath: data['imagePath'],
                                  name: data['name'],
                                  tag: data['tag'],
                                  color: data['color'],
                                  about: data['about'],
                                ),
                              ),
                            ),
                        child: MyItemData(
                          tag: data['tag'],
                          image: data['imagePath'],
                          data: data['name'],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 10.0);
                    },
                    itemCount: itemData.length,
                  ),
                ),
                SizedBox(height: 25.0),
                ButtonCustom(
                  onTap:
                      () => navigateToNextPage(context, CitizenCollectForm()),
                  child: Center(
                    child: TextCustom(
                      data: 'Effectuer une demande collectte',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 25.0),
                ButtonCustom(
                  onTap: () => navigateToNextPage(context, ReportWasteForm()),
                  child: Center(
                    child: TextCustom(
                      data: 'Signaler un depot d\'ordure',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToNextPage(context, ChatIaScreen()),
        backgroundColor: Colors.green,
        child: Icon(Icons.smart_toy, color: Colors.white),
      ),
    );
  }
}
