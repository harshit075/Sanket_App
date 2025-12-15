import 'package:Sanket/screens/intro_screens.dart';
import 'package:flutter/material.dart';
import 'package:Sanket/admin_dashboard/provider/education_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart'; 
import 'firebase_options.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ArogyaSetuNerApp());
}

class ArogyaSetuNerApp extends StatefulWidget {
  const ArogyaSetuNerApp({super.key});

  @override
  State<ArogyaSetuNerApp> createState() => _ArogyaSetuNerAppState();
}

class _ArogyaSetuNerAppState extends State<ArogyaSetuNerApp> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 129, 140, 225),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EducationProvider()), 
        
      ],
      child: MaterialApp(
        title: 'Arogya Setu NER',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: colorScheme,
          scaffoldBackgroundColor: const Color(0xFFF3F4F6),
          fontFamily: 'Sans',
          appBarTheme: AppBarTheme(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            elevation: 2,
            centerTitle: true,
          ),
          cardTheme: CardThemeData(
            elevation: 1,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            clipBehavior: Clip.antiAlias,
            surfaceTintColor: Colors.transparent,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
              textStyle: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: colorScheme.primary,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
          ),
        ),
        home: const IntroScreens(),
      ),
    );
  }
}
