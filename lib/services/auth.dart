import 'package:benebrew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:benebrew/models/user.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TheUser _userFromFirebaseUser(User user){
    return user!=null? TheUser(uid:user.uid):null;
  }

  //Auth Change user stream
  Stream<TheUser> get user{
    return _auth.authStateChanges()
    //.map((User user)=>_userFromFirebaseUser(user));
    .map(_userFromFirebaseUser);
  }


  // Sign in anom
  Future signInAnom() async{
    try{
      UserCredential result =await _auth.signInAnonymously();
      User user=result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }

  }

  // Sign in with email and password

  Future signInWithEmailAndPassword(String email,String password) async{
    try{
      UserCredential result=await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user=result.user;
      return _userFromFirebaseUser(user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //register with email & password\
  Future registerWithEmailAndPassword(String email,String password) async{
    try{
      UserCredential result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user=result.user;

      // Create a new Document for the user with the uid
      await DatabaseService(uid:user.uid).updateUserData('0','new crew member',100);

      return _userFromFirebaseUser(user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //Sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}