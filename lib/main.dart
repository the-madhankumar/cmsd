import 'package:cmsd_home/loading.dart';
import 'package:cmsd_home/localization/locales.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalization localization = FlutterLocalization.instance;

  @override
  void initState() {
    configureLocalization();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CMSD_Home',
      supportedLocales: localization.supportedLocales,
      localizationsDelegates: localization.localizationsDelegates,
      home: const Loading(),
    );
  }

  void configureLocalization() {
    localization.init(mapLocales: LOCALES, initLanguageCode: "en");
    localization.onTranslatedLanguage = onTranslatedLanguage;
  }

  void onTranslatedLanguage(Locale? locale) {
    setState(() {
      
    });
  }
}
