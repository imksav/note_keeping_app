// ignore_for_file: deprecated_member_use
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_keeping_app/models/user_model.dart';
import 'package:note_keeping_app/screens/notedescription.dart';
import 'package:note_keeping_app/screens/updateNotes.dart';
import '../libraries.dart';

class HomePage extends StatefulWidget {
  final String? userId;
  final String? noteId;
  const HomePage({Key? key, this.userId, this.noteId}) : super(key: key);

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
      backgroundColor: Colors.white,
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
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Icon(
          Icons.menu,
          color: Colors.blue,
        ),
        actions: [
          IconButton(
            color: Colors.blue,
            onPressed: () {
              // method to show the search bar
              showSearch(
                  context: context,
                  // delegate to customize the search bar
                  delegate: CustomSearchDelegate());
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.blue,
            ),
            onPressed: () {},
          ),
          IconButton(
              onPressed: () {
                logout(context);
              },
              icon: const Icon(Icons.logout, color: Colors.blue))
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
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: snapshot.data!.docs.map((document) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: ((context) {
                      return NoteDescription(
                        userId: loggedInUser.uid!,
                        title: document['title'],
                        description: document['description'],
                        createdDate: document['createdDate'],
                        createdTime: document['createdTime'],
                      );
                    })));
                  },
                  child: Card(
                    elevation: 5.0,
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
                        ),
                        Container(
                            padding: const EdgeInsets.all(10.0),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  RaisedButton(
                                    elevation: 3.0,
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => UpdateNotes(
                                                    userId: loggedInUser.uid,
                                                    noteId: document.id,
                                                    title: document['title'],
                                                    description:
                                                        document['description'],
                                                    createdDate:
                                                        document['createdDate'],
                                                    createdTime:
                                                        document['createdTime'],
                                                  )));
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                    color: Colors.green,
                                  ),
                                  RaisedButton(
                                    elevation: 3.0,
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text("Share To"),
                                              // content: Text(e!.message),
                                              content: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () async {
                                                        const url =
                                                            'https://facebook.com';
                                                        if (await canLaunch(
                                                            url)) {
                                                          await launch(url);
                                                        } else {
                                                          throw 'Could not launch $url';
                                                        }
                                                      },
                                                      child: Icon(
                                                        FontAwesomeIcons
                                                            .facebook,
                                                        size: 36.0,
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        const url =
                                                            'https://instagram.com';
                                                        if (await canLaunch(
                                                            url)) {
                                                          await launch(url);
                                                        } else {
                                                          throw 'Could not launch $url';
                                                        }
                                                      },
                                                      child: Icon(
                                                        FontAwesomeIcons
                                                            .instagram,
                                                        size: 36.0,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        const url =
                                                            'https://linkedin.com/in/';
                                                        if (await canLaunch(
                                                            url)) {
                                                          await launch(url);
                                                        } else {
                                                          throw 'Could not launch $url';
                                                        }
                                                      },
                                                      child: Icon(
                                                        FontAwesomeIcons
                                                            .linkedin,
                                                        size: 36.0,
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        const url =
                                                            'https://twitter.com';
                                                        if (await canLaunch(
                                                            url)) {
                                                          await launch(url);
                                                        } else {
                                                          throw 'Could not launch $url';
                                                        }
                                                      },
                                                      child: Icon(
                                                        FontAwesomeIcons
                                                            .twitter,
                                                        size: 36.0,
                                                        color: Colors.blue,
                                                      ),
                                                    ),
                                                  ]),
                                              backgroundColor: Colors.white,
                                              actions: [
                                                IconButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    icon: const Icon(
                                                        Icons.exit_to_app))
                                              ],
                                            );
                                          });
                                    },
                                    child: Icon(
                                      Icons.share,
                                      color: Colors.white,
                                    ),
                                    color: Colors.blue,
                                  ),
                                  RaisedButton(
                                    elevation: 3.0,
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(loggedInUser.uid)
                                          .collection('notes')
                                          .doc(document.id)
                                          .delete();
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SigninScreen()));
  }

  _launchURL(shareUrl) {
    print("facebook");
    launch(shareUrl);
    // const url = shareUrl;
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }
}
