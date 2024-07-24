import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
// instance of Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore =  FirebaseFirestore.instance;

  User? getCurrentUser(){
    return _auth.currentUser;
  }


// Sign in
 Future<UserCredential> signInWithEmailAndPassword(String email, password) async{
  try{
    // sign in user in
    UserCredential userCredentail = await _auth.signInWithEmailAndPassword(
      email: email,
       password: password,
       );
       // save user info if it doesn't exist 
       _firestore.collection("Users").doc(userCredentail.user!.uid).set(
        {
          'uid': userCredentail.user!.uid,
          'email': userCredentail.user!.email,
        },
       );

       //save user info in a seperste doc
       _firestore.collection("Users").doc(userCredentail.user!.uid).set(
        {
          'uid': userCredentail.user!.uid,
          'email': userCredentail.user!.email,
        },
       );

    return userCredentail;
  } on FirebaseAuthException catch(e) {
    throw Exception(e.code);
  }
 }

// Sign up
Future<UserCredential> signUpWithEmailPassword(String email, password) async{
  try{
    UserCredential userCredentail = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return userCredentail;
  }on FirebaseAuthException catch (e){
    throw Exception(e.code);
  }
}

  Future<void> signOut() async{
    return await _auth.signOut();
  }




}