import 'package:benebrew/screens/Home/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:benebrew/models/brew.dart';
import 'package:benebrew/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});
  //Collection reference

  final CollectionReference brewCollection=FirebaseFirestore.instance.collection('brews');
    Future updateUserData(String sugars,String name,int strength) async{
      return await brewCollection.doc(uid).set({
        'sugars':sugars,
        'name':name,
        'strength':strength,
      });
    }

    //brew list from snapshot
    List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
      return snapshot.documents.map((doc){
        return Brew(
          name:doc.data()['name'] ?? '',
          strength:doc.data()['strength'] ?? 0,
          sugars:doc.data()['sugars'] ?? '0'
        );
      }).toList();
    }

    //UserData from snapshot
  UserData _userDataFromSnapShot(DocumentSnapshot snapshot){
      return UserData(
        uid:uid,
        name:snapshot.data()['name'],
        sugars:snapshot.data()['sugars'],
        strength:snapshot.data()['strength'],
      );
  }


    // Get Brews Stream
    Stream<List<Brew>> get brews{
      return brewCollection.snapshots()
      .map(_brewListFromSnapshot);
    }

    //get user doc stream
    Stream<UserData> get userData{
      return brewCollection.doc(uid).snapshots()
      .map(_userDataFromSnapShot);
    }


}