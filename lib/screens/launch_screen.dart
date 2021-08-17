import 'package:chat_app/firebase/fb_auth_controller.dart';
import 'package:chat_app/shared_preferences/shared_pref_controller.dart';
import 'package:flutter/material.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    super.initState();
    String route =
        AppPreferencesController().loggedIn ? '/chat_screen' : '/auth_screen';
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('ChatApp'),
      ),
    );
  }
}
