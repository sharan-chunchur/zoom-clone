import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Stream to get history of meetings
  Stream<QuerySnapshot<Map<String, dynamic>>> get meetingsHistory => _firestore
      .collection('users')
      .doc(_auth.currentUser!.uid)
      .collection('meetings').orderBy('createdAt', descending: true)
      .snapshots();


  //method to add meetings to firestore collection 'meetings'
  void addToMettingHistory(String meetingName) {
    try {
      _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('meetings')
          .add({
        'meetingName': meetingName,
        'createdAt': DateTime.now(),
      });
    } catch (e) {
      print(e);
    }
  }
}
