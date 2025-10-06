import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:my_clean_city/firebase_options.dart';
import 'package:my_clean_city/providers/auth_providers.dart';
import 'package:my_clean_city/views/splash/splash_screnn1.dart';
import 'package:provider/provider.dart';

const apiKey = 'AIzaSyClCZmyOcp9a8i7xaGhcqc__ajn5xQ1Su4';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
    Gemini.init(apiKey: apiKey);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AuthProviders())],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: SplashScrenn(),
      ),
    );
  }
}
