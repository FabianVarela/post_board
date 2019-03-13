import 'package:firebase_database/firebase_database.dart';

class FirebaseHelper {

  FirebaseDatabase database;

  FirebaseHelper() {
    database = FirebaseDatabase.instance;
  }

  void sendData() {
    database.reference().child("test").set({
      "firstName": "Fabian",
      "lastName": "Varela"
    });
  }

  void getData() {
    database.reference().child("test").once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> map = snapshot.value;
      print("Data: ${map.values}");
    });
  }
}