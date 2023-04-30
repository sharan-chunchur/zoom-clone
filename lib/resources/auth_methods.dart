import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zoom_clone/utils/utils.dart';

class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // to get stream of user in Home of materialWidget. If already signed in then Login screen will be skipped
  Stream<User?> get authChanges =>  _auth.authStateChanges();

  User get user => _auth.currentUser!;

  Future signInWithGoogle(BuildContext context) async{
    bool result = false;
    try{
      //signInWithGoogle() is a function that initiates the Google Sign-In process. When the user signs in,
      // the function returns a GoogleSignInAccount object, which contains the user's Google account information.
      final GoogleSignInAccount? googleSignInUser = await googleSignIn.signIn();

      //the line await googleSignInAccount!.authentication returns a GoogleSignInAuthentication object that contains the
      // accessToken and idToken properties, which are required to authenticate the user with Firebase Authentication.
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInUser!.authentication;


      //The GoogleAuthProvider.credential() method takes two arguments: accessToken and idToken. The accessToken
      // is an OAuth 2.0 access token that can be used to access Google APIs, and the idToken is a JSON Web Token (JWT)
      // that contains user profile information and is used to authenticate the user with Firebase Authentication.
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      //user's Google credentials, which can then be passed to the signInWithCredential() method of the
      // FirebaseAuth class to authenticate the user with Firebase Authentication.
      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      User? user = userCredential.user;
      if(user != null){
        if(userCredential.additionalUserInfo!.isNewUser){
          await _firestore.collection('users').doc(user.uid).set({
            'userName' : user.displayName,
            'email' : user.email,
            'uid' : user.uid,
            'profilePhoto' : user.photoURL
          });
        }
      }
    }on FirebaseAuthException catch(e){
      showSnackBar(context, e.message!);
      print(e);
    }
  }


  void signOut() async{
    try{
      _auth.signOut();
    }catch(e){
      print(e);
    }
  }

}