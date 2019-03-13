import 'package:flutter/material.dart';
import 'package:post_board/firebase_database/firebase_helper.dart';
import 'package:post_board/model/post.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Post Board',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> postMessages = List();
  Post post;

  final FirebaseHelper helper = FirebaseHelper();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    post = Post("", "");
  }

  /*
  void _incrementCounter() {
    var firebaseHelper = FirebaseHelper();
    firebaseHelper.sendData();

    setState(() {
      firebaseHelper.getData();
    });
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[],
          ),
        ));
  }
}
