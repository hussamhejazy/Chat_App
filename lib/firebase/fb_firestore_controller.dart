import 'package:chat_app/models/Message.dart';
import 'package:chat_app/models/account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FbFirebaseFirestoreController {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final String _usersCollection = 'User';
  final String _chatCollection = 'Chat';

  Future<void> createUser(
      {required String id, required Account account}) async {
    await _firebaseFirestore
        .collection(_usersCollection)
        .doc(id)
        .set(account.toMap());
  }

   Future<String> getUsername({required String path}) async{
    final userDate = await _firebaseFirestore.collection(_usersCollection).doc(path).get();
     return userDate.get('username');
  }

  Future<bool> sendMessage({required Message message}) async {
    return await _firebaseFirestore
        .collection(_chatCollection)
        .add(message.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }



  Stream<QuerySnapshot> getMessages() async* {
    yield* _firebaseFirestore
        .collection(_chatCollection)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
