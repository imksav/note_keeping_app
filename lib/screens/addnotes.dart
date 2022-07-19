// ignore_for_file: prefer_const_constructors, deprecated_member_use, unnecessary_brace_in_string_interps, avoid_print

import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    _dateController.text = ""; //set the initial value of text field
    super.initState();
  }

  DateTime pickedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Notes'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.0),
              TextField(
                textInputAction: TextInputAction.next,
                controller: _titleController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Enter Title',
                    hintText: 'Enter title of your note........'),
              ),
              SizedBox(height: 20.0),
              TextField(
                textInputAction: TextInputAction.next,
                controller: _descriptionController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Enter Description',
                    hintText: 'Enter description of your note........'),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Select Date',
                ),
                readOnly: true,
                onTap: () async {
                  pickedDate = (await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2025)))!;
                  if (pickedDate != null) {
                    // String formattedDate =
                    //     DateFormat('yyyy-MM-dd').format(pickedDate);
                    // print(formattedDate);
                    setState(() {
                      // _dateController.text = formattedDate;
                    });
                  }
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'title': _titleController.text,
                    'description': _descriptionController.text,
                    'date': _dateController.text,
                  });
                  print(
                      "${_titleController.text}\n${_descriptionController.text}\n${_dateController.text}");
                },
                child: Text('Add Note'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
