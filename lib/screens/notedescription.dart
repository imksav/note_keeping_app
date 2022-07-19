import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NoteDescription extends StatefulWidget {
  String title;
  String description;
  String createdDate;
  String createdTime;
  NoteDescription(
      {Key? key,
      required this.title,
      required this.description,
      required this.createdDate,
      required this.createdTime})
      : super(key: key);

  @override
  State<NoteDescription> createState() => _NoteDescriptionState();
}

class _NoteDescriptionState extends State<NoteDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Notes"),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Card(
        color: Colors.blue,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.25,
          child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.title,
                      style: TextStyle(fontSize: 30.0, color: Colors.white)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.description,
                      style: TextStyle(fontSize: 20.0, color: Colors.white)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.createdDate,
                      style: TextStyle(fontSize: 15.0, color: Colors.white)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.createdTime,
                      style: TextStyle(fontSize: 15.0, color: Colors.white)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
