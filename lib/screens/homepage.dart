// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../libraries.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNotes(),
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
      body: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Color.fromARGB(255, 9, 144, 159),
        elevation: 10.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) => Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.note,
                            color: Color.fromARGB(255, 15, 180, 21),
                          ),
                          title: Text(
                            "_title",
                            style: TextStyle(
                                color: Colors.amber[900], fontSize: 20.0),
                          ),
                          subtitle: Text(
                            "_description",
                            style: TextStyle(fontSize: 15.0),
                          ),
                          isThreeLine: true,
                          trailing: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                  )),
        ),
      ),
    );
  }
}
