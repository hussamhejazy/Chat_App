import 'package:chat_app/firebase/fb_auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  late String message;
  late Timestamp createdAt;
  late String username;
  late String userId;

  Message();

  Message.fromMap(Map<String, dynamic> map) {
    message = map['message'];
    username = map['username'];
    userId = map['userId'];
    createdAt = map['createdAt'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['message'] = message;
    map['username'] = username;
    map['userId'] = userId;
    map['createdAt'] = createdAt;
    return map;
  }
}
