import 'package:flutter/material.dart';
import 'package:my_clean_city/core/utils/colors.dart';
import 'package:my_clean_city/core/utils/helpers.dart';
import 'package:my_clean_city/providers/auth_providers.dart';
import 'package:my_clean_city/views/notifications/notification_screnn.dart';
import 'package:my_clean_city/widgets/text_custom.dart';
import 'package:provider/provider.dart';

class BodyHome extends StatelessWidget {
  const BodyHome({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProviders>(context);
    final user = auth.getCurrentUser();
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
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: lightPrimaryText,
                    ),
                    TextCustom(
                      data: user != null ? '${user.email}' : 'null',
                      fontSize: 24,
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
                      return Container(
                        width: 20,
                        height: 20,
                        color: Colors.yellow,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 10.0);
                    },
                    itemCount: 5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
