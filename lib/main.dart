import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hemoqr/bindings/splash_binding.dart';
import 'package:hemoqr/localization/local_strings.dart';
import 'package:hemoqr/routes/routes.dart';
import 'package:flutter/services.dart';
import 'package:hemoqr/services/notification_service.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await NotificationSerivce.initialize();
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: Locale('en', 'US'),
      translations: LocaleString(),
      navigatorObservers: <NavigatorObserver>[observer],
      initialBinding: SplashBinding(),
      theme: ThemeData.light().copyWith(
        primaryColorLight: Color(0xFFEEf3FA),
        scaffoldBackgroundColor: Color(0xFFEEf3FA),
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF7F53B7),
          onPrimary: Color.fromARGB(255, 150, 83, 238),
          secondary: Color.fromARGB(255, 197, 162, 242),
          onSecondary: Color.fromARGB(255, 255, 195, 215),
          error: Color(0xffd8cee1),
          onError: Color(0xFFCEB7BE), // Dark red color for error messages
          background: Color(0xFFF2F2F2), // Light gray background
          onBackground:
              Color(0xFF000000), // Black text on light gray background
          surface: Color(0xFFFFFFFF), // White surface
          onSurface: Color(0xFF333333), // Dark gray text on white surface
        ),
        textTheme: TextTheme().copyWith(
            titleLarge: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: MediaQuery.of(context).textScaleFactor * 30,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w700),
            titleMedium: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: MediaQuery.of(context).textScaleFactor * 20,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w700),
            bodyLarge: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: MediaQuery.of(context).textScaleFactor * 20),
            labelMedium: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: MediaQuery.of(context).textScaleFactor * 18,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w700),
            bodyMedium: TextStyle(
              fontFamily: 'Montserrat',
              color: Theme.of(context).colorScheme.primary,
            ),
            labelLarge: TextStyle(
              fontFamily: 'Montserrat',
              color: Theme.of(context).colorScheme.primary,
            ),
            headlineMedium: TextStyle(
              fontFamily: 'Montserrat',
              color: Theme.of(context).colorScheme.primary,
            ),
            titleSmall: TextStyle(
              fontFamily: 'Montserrat',
              color: Theme.of(context).colorScheme.primary,
            )
            //lablelarge
            //headline medium
            ),
      ),
      initialRoute: "/",
      getPages: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
