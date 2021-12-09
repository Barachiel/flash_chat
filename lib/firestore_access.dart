import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreAccess {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<UserCredential?> createNewUser(
      String email, String password, String displayName) async {
    final newUser = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    if (newUser != null) {
      final user = getCurrentUser();
      _firestore.collection('users').add(
          {'email': email, 'userId': user!.uid, 'displayName': displayName});
    }
    return newUser;
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  void signOut() {
    _auth.signOut();
  }

  CollectionReference<Map<String, dynamic>> getCollection(String name) {
    return _firestore.collection(name);
  }
}
