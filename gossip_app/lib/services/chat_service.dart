import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gossip_app/models/message.dart';

class ChatService {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth= FirebaseAuth.instance;
  


  Stream<List<Map<String,dynamic>>> getUsersStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();

        return user;
      }).toList();
    });
  }

    // get all users stream except blocked user
    Stream<List<Map<String, dynamic>>> getUsersStreamExcludingBlocked() {
      final currentUser = _auth.currentUser;

      return _firestore
      .collection('Users')
      .doc(currentUser!.uid)
      .collection('BlockedUsers')
      .snapshots()
      .asyncMap((snapshot) async{
        // get blocked user ids
        final blockedUserIds = snapshot.docs.map((doc) => doc.id).toList();

        // get all users
        final usersSnapshot = await _firestore.collection('Users').get();

        // return as stream list 
        return usersSnapshot.docs
        .where((doc) => 
        doc.data()['email'] != currentUser.email &&
         !blockedUserIds.contains(doc.id))
         .map((doc) => doc.data())
        .toList();
      });
    }
    // send message 
  Future<void> sendMessage(String reciverID, message) async {
    // get current user info
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
      senderID: currentUserId,
       message: message,
        receiverID: reciverID,
         senderEmail: currentUserEmail,
          timestamp: timestamp,);


    // construct chat room Id for the two user(sorted to ensure uniqueness)
    List<String> ids = [currentUserId, reciverID];
    ids.sort();
    String chatRoomID = ids.join('_');
    //  add new message to database
    await _firestore
    .collection("chat_rooms")
    .doc(chatRoomID)
    .collection("messages")
    .add(newMessage.toMap());
  }
    

    // get messages
    Stream<QuerySnapshot> getMessages(String userid, otherUserid) {
      List<String> ids = [userid, otherUserid];
      ids.sort();
      String chatRoomID = ids.join('_');

      return _firestore
      .collection("chat_rooms")
      .doc(chatRoomID)
      .collection("messages")
      .orderBy("timestamp", descending: false)
      .snapshots();
    }

    // report user
    Future<void> reportUser(String messageId, String userID) async {
      final  currentUser = _auth.currentUser;
      final report = {
        'reportedBy' : currentUser!.uid,
        'messageid': messageId,
        'messageOwnerId': userID,
        'timestamp': FieldValue.serverTimestamp(),
      };
      await _firestore.collection('Reports').add(report);
    }

    // block user
    Future<void> blockUser(String userID) async {
      final  currentUser = _auth.currentUser;
    await _firestore
      .collection("Users")
      .doc(currentUser!.uid)
      .collection("BlockedUsers")
      .doc(userID)
      .set({
        'timestamp': FieldValue.serverTimestamp(),
      });
    }

    // un block user
    Future<void> unblockUser(String blockUserId) async {
      final  currentUser = _auth.currentUser;

      await _firestore.collection("Users")
      .doc(currentUser!.uid)
      .collection("BlockedUsers")
      .doc(blockUserId)
      .delete();

    // get blocked user steam
    Stream<List<Map<String, dynamic>>> getBlockedUserStream(String userId){
      return _firestore
      .collection("Users")
      .doc(userId)
      .collection("BlockedUsers")
      .snapshots()
      .asyncMap((snapshot) async {

        final blockedUserIds = snapshot.docs.map((doc) => doc.id).toList();

        final userDocs = await Future.wait(
          blockedUserIds
          .map((id) => _firestore.collection('users').doc(id).get()),
        );
        // return as a list 
        return userDocs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      });
    }
}

  getBlockedUsersStream(userId) {}
}
