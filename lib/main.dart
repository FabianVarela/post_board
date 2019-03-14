import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
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

  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DatabaseReference databaseReference;

  @override
  void initState() {
    super.initState();

    post = Post("", "");
    databaseReference = database.reference().child("post_board");
    databaseReference.onChildAdded.listen(_onEntryAdded);
    databaseReference.onChildChanged.listen(_onEntryChanged);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Board"),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 0,
            child: Center(
              child: Form(
                key: formKey,
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    ListTile(
                        leading: Icon(Icons.subject),
                        title: TextFormField(
                            initialValue: "",
                            onSaved: (value) => post.subject = value,
                            validator: (value) => value == "" ? value : null)),
                    ListTile(
                        leading: Icon(Icons.message),
                        title: TextFormField(
                            initialValue: "",
                            onSaved: (value) => post.body = value,
                            validator: (value) => value == "" ? value : null)),
                    FlatButton(
                      child: Text("Save"),
                      color: Colors.redAccent,
                      onPressed: () {
                        _submitPostForm();
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 10, bottom: 10)),
          Flexible(
            child: FirebaseAnimatedList(
                query: databaseReference,
                itemBuilder: (_, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.red,
                      ),
                      title: Text(postMessages[index].subject),
                      subtitle: Text(postMessages[index].body),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  void _onEntryAdded(Event event) {
    setState(() {
      postMessages.add(Post.fromSnapshot(event.snapshot));
    });
  }

  void _submitPostForm() {
    final FormState state = formKey.currentState;

    if (state.validate()) {
      state.save();
      state.reset();

      databaseReference.push().set(post.toJson());
    }
  }

  void _onEntryChanged(Event event) {
    var oldData = postMessages.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      postMessages[postMessages.indexOf(oldData)] =
          Post.fromSnapshot(event.snapshot);
    });
  }
}
