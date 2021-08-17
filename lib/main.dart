import 'package:chat_app/screens/auth_screen.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/launch_screen.dart';
import 'package:chat_app/shared_preferences/shared_pref_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AppPreferencesController().initPreferences();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatApp',
      initialRoute: '/launch_screen',
      routes: {
        '/launch_screen': (context) => LaunchScreen(),
        '/auth_screen': (context) => AuthScreen(),
        '/chat_screen': (context) => ChatScreen(),
      },
    );
  }
}
