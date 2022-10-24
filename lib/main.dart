import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:unchicchi/domain/toilet/toilet.dart';
import 'package:unchicchi/domain/toilet/toilet_date.dart';
import 'package:unchicchi/domain/toilet/toilet_id.dart';
import 'package:unchicchi/domain/toilet/toilet_level.dart';
import 'package:unchicchi/presentation/screens/app_screen.dart';
import 'package:unchicchi/presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ToiletAdapter());
  Hive.registerAdapter(ToiletIdAdapter());
  Hive.registerAdapter(ToiletLevelAdapter());
  Hive.registerAdapter(ToiletDateAdapter());

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("ja"),
      ],
      locale: const Locale('ja', 'JP'),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AppScreen(),
    );
  }
}
