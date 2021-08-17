import 'package:chat_app/firebase/fb_auth_controller.dart';
import 'package:chat_app/firebase/fb_firestore_controller.dart';
import 'package:chat_app/widgets/bubble_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewMessages extends StatefulWidget {
  const ViewMessages({Key? key}) : super(key: key);

  @override
  _ViewMessagesState createState() => _ViewMessagesState();
}

class _ViewMessagesState extends State<ViewMessages> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FbFirebaseFirestoreController().getMessages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            List<QueryDocumentSnapshot> data = snapshot.data!.docs;
            return ListView.separated(
              reverse: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return BubbleMessage(
                  isSender: data[index].get('userId') == FbAuthController().getCurrentUserId(),
                  message: data[index].get('message'),
                  username: data[index].get('username'),
                  key: ValueKey(data[index].id),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox();
              },
            );
          } else {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.warning,
                    size: 85,
                    color: Colors.pink.withOpacity(0.4),
                  ),
                  Text(
                    'No Data',
                    style: TextStyle(
                        color: Colors.pink.withOpacity(0.4),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            );
          }
        });
  }
}
