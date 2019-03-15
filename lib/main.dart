import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Log In"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8),
                child: FlatButton(
                  color: Colors.red,
                  child: Text("Google Sign In"),
                  onPressed: () => _signInGoogle(),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: FlatButton(
                  color: Colors.orange,
                  child: Text("Sign In with Email"),
                  onPressed: () => _signInWithEmail(),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: FlatButton(
                  color: Colors.purple,
                  child: Text("Create account"),
                  onPressed: () => _createUser(),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: FlatButton(
                  color: Colors.green,
                  child: Text("Sign Out"),
                  onPressed: () => _signOut(),
                ),
              )
            ],
          ),
        ));
  }

  Future<FirebaseUser> _signInGoogle() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    FirebaseUser user = await _firebaseAuth.signInWithCredential(credential);

    print("User is ${user.displayName}");

    return user;
  }

  Future _createUser() async {
    await _firebaseAuth
        .createUserWithEmailAndPassword(
            email: "fvarela@smarttaxi.com", password: "Jfabian920330")
        .then((user) {
      print("User created: ${user.displayName}");
      print("Email: ${user.email}");
    });
  }

  void _signOut() {
    _googleSignIn.signOut();
  }

  void _signInWithEmail() {
    _firebaseAuth
        .signInWithEmailAndPassword(
            email: "fvarela@smarttaxi.com", password: "Jfabian920330")
        .then((user) {
      print("User signed in: ${user.email}");
    });
  }
}
