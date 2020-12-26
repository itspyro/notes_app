


import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/modals/user.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser _userFromFirebaseUser(User user){
    return user !=null ? AppUser(userId: user.uid) : null;
  }


  Stream<AppUser> get user {
    return _auth.authStateChanges()
        .map(_userFromFirebaseUser);
  }

  Future<AppUser> signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User firebaseUser = userCredential.user;
      return _userFromFirebaseUser(firebaseUser);
    }catch(e){
      print("Error Ocurred");
      print(e);
      return null;
    }
  }

  Future<AppUser> signUpWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User firebaseUser = userCredential.user;
      return _userFromFirebaseUser(firebaseUser) ;
    }catch(e){
      print("Error Ocurred");
      print(e);
      return null;
    }
  }

  resetPass(String email) async {
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e);
    }
  }
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }
}