import 'package:cloud_firestore/cloud_firestore.dart';

class Coffeeco {
  final String name;
  final String sugar;
  final int strength;

  Coffeeco({this.name, this.sugar, this.strength});
}
class UserData {
  final String name;
  final String sugar;
  final int strength;
  final uid;

  UserData({this.name, this.sugar, this.strength,this.uid});
}

class DataServices {
  final String uid;
  DataServices({this.uid});

  final CollectionReference coffeecoCollection = Firestore.instance.collection(
      "coffeeco");

  Stream<List<Coffeeco>> get coffeeco {
    return coffeecoCollection.snapshots().map(_coffeecoListfromSnapshot);
  }
  UserData _userdatafromsnapshot(DocumentSnapshot snapshot){
    return UserData(
      name: snapshot.data['name']??'',
      strength: snapshot.data['strangth']??100,
      sugar: snapshot.data['sugar']??'0'
    );
  }
  Stream<UserData> get userData{
    return coffeecoCollection.document(uid).snapshots().map(_userdatafromsnapshot);
  }


  Future updateUserData(String name, String sugar, int strength) async {
    return await coffeecoCollection.document(uid).setData(
        {"name": name, "sugar": sugar, "strength": strength});
  }
  List<Coffeeco> _coffeecoListfromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Coffeeco(
        sugar: doc['sugar'],
        strength:doc['strength'],
        name:doc['name']
      );
    }).toList();
  }

}