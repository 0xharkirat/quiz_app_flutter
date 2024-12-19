
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app_flutter/src/views/screens/my_home_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;

  void _toggleBrightness() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent, brightness: _isDarkMode ? Brightness.dark : Brightness.light),
        useMaterial3: true,
      ),
      home:  MyHomePage(
        isDarkMode: _isDarkMode,
        toggleBrightness: _toggleBrightness,
      ),
    );
  }
}
