import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_dubl_3/models/message.dart';

class ChatService {
  // get instanse of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get user stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection('Users').snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          final user = doc.data();
          return user;
        }).toList();
      },
    );
  }

  //send message
  Future<void> sendMessage(String recevierID, message) async {
    //get currentUser info
    final String currenUserID = _auth.currentUser!.uid;
    final String curentUsserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //great a new massege
    Message newMessage = Message(
        senderId: currenUserID,
        senderEmail: curentUsserEmail,
        recevireId: recevierID,
        message: message,
        timestamp: timestamp.toDate().toIso8601String());

    //constract chat room Id fo the two users
    List<String> ids = [currenUserID, recevierID];
    ids.sort();
    String chatRoomID = ids.join('_');

    //add new massage
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection('message')
        .add(
          newMessage.toMap(),
        );
  }

  //get messages
  Stream<QuerySnapshot> getMessage(String userID, otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("message")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
