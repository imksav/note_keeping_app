// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_keeping_app/models/user_model.dart';
import 'package:note_keeping_app/screens/notedescription.dart';
import '../libraries.dart';

class HomePage extends StatefulWidget {
  final String? userId;
  const HomePage({Key? key, this.userId}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {
        loggedInUser = loggedInUser;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNotes(userId: loggedInUser.uid),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Note Keeping App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(loggedInUser.uid)
            .collection('notes')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: ((context) {
                    return NoteDescription(
                        title: document['title'],
                        description: document['description'],
                        createdDate: document['createdDate'],
                        createdTime: document['createdTime']);
                  })));
                },
                child: Card(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                            child: Image.asset(
                                "assets/images/sikshyatechnology.jpg")),
                        iconColor: Colors.black,
                        title: Text(
                          document['title'],
                          style: const TextStyle(
                              color: Colors.black, fontSize: 30.0),
                        ),
                        subtitle: Text(
                          document['description'],
                          style: TextStyle(
                              fontSize: 20.0, color: Colors.grey[700]),
                        ),
                        isThreeLine: true,
                        trailing: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
