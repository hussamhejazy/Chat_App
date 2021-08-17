import 'package:chat_app/firebase/fb_auth_controller.dart';
import 'package:chat_app/firebase/fb_firestore_controller.dart';
import 'package:chat_app/models/Message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WriteNewMessage extends StatefulWidget {
  const WriteNewMessage({Key? key}) : super(key: key);

  @override
  _WriteNewMessageState createState() => _WriteNewMessageState();
}

class _WriteNewMessageState extends State<WriteNewMessage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Send a message...',
              labelStyle: TextStyle(
                color: Colors.pinkAccent
              ),
              fillColor: Colors.pinkAccent,
                enabledBorder:UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.pinkAccent, width: 2.0),
                ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.pinkAccent, width: 2.0),
              ),
            ),
          )),
          IconButton(
            color: Colors.pinkAccent,
            icon: const Icon(Icons.send),
            onPressed: () async => await _sendMessage(),
          )
        ],
      ),
    );
  }

  bool _checkMessage() {
    if (_controller.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> _sendMessage() async {
    if (_checkMessage()) {
      FocusScope.of(context).unfocus();
      await FbFirebaseFirestoreController().sendMessage(message: await _message);
      _controller.text = '';
    }
  }

  Future<Message> get _message async{
    Message message = Message();
    String userId = FbAuthController().getCurrentUserId();
    message.userId = userId;
    message.username = await FbFirebaseFirestoreController().getUsername(path: userId);
    message.message = _controller.text;
    message.createdAt = Timestamp.now();
    return message;
  }
}


