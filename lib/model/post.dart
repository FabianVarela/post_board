import 'package:firebase_database/firebase_database.dart';

class Post {
  String key;
  String subject;
  String body;

  Post(this.subject, this.body);

  Post.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        subject = snapshot.value["subject"],
        body = snapshot.value["body"];

  toJson() {
    return {"subject": subject, "body": body};
  }
}
