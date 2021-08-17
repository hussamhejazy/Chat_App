import 'package:chat_app/shared_preferences/shared_pref_controller.dart';
import 'package:chat_app/widgets/view_messages.dart';
import 'package:chat_app/widgets/write_new_message.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: const Text(
            'Chat',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: () async => await signOut(),
            )
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(child: ViewMessages()),
              WriteNewMessage(),
            ],
          ),
        ));
  }

  Future<void> signOut() async {
    await AppPreferencesController().logout();
    Navigator.pushReplacementNamed(context, '/auth_screen');
  }
}
