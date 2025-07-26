// ignore_for_file: prefer_const_constructors, duplicate_import, unused_import, unused_local_variable

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notepad/provider/pref-provider.dart';
import 'package:notepad/screens/add_note.dart';
import 'package:notepad/themes/custom-theme.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'hive/notes_model.dart';
import 'provider/addnotes_provider.dart';
import 'provider/homescreen_provider.dart';
import 'provider/pref-provider.dart';
import 'screens/home_screen.dart';
import 'hive/notes_model.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AddNotesProvider.initHive();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => HomescreenProvider()),
    ChangeNotifierProvider(create: (_) => AddNotesProvider()),
    ChangeNotifierProvider(create: (_) => PrefProvider())
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    setTheme();
    super.initState();
  }

  void setTheme() {
    final prefProvider = context.read<PrefProvider>();
    prefProvider.getSavePref();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: context.watch<PrefProvider>().isDarkMode ? darkTheme : lightTheme,
      home: HomeScreen(),
    );
  }
}
