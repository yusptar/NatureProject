import 'package:flutter/material.dart';
import 'package:uas/pages/home_page.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class EditMountain extends StatefulWidget {
  EditMountain({this.title, this.location, this.type, this.index});
  final String title;
  final String location;
  final String type;
  final index;
  @override
  _EditMountainState createState() => new _EditMountainState();
}

class _EditMountainState extends State<EditMountain> {
  TextEditingController titleController;
  TextEditingController locationController;
  TextEditingController typeController;

  String title;
  String location;
  String type;

  void _editMountain() {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(widget.index);
      await transaction.update(snapshot.reference, {
        "title": title,
        "location": location,
        "type": type,
      });
    });
    MaterialPageRoute route = MaterialPageRoute(builder: (_) => HomePage());
    Navigator.push(context, route);
  }

  @override
  void initState() {
    super.initState();

    title = widget.title;
    location = widget.location;
    type = widget.type;

    titleController = TextEditingController(text: widget.title);
    locationController = TextEditingController(text: widget.location);
    typeController = TextEditingController(text: widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://jw-webmagazine.com/wp-content/uploads/2019/06/jw-5d1486c9a694f6.28337520.jpeg'),
                  fit: BoxFit.cover),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Edit Mountain Data",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    letterSpacing: 2.0,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: TextField(
              controller: titleController,
              onChanged: (String str) {
                setState(() {
                  title = str;
                });
              },
              decoration: InputDecoration(
                  icon: Icon(Icons.title),
                  hintText: "title",
                  border: InputBorder.none),
              style: TextStyle(fontSize: 22.0, color: Colors.black),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: TextField(
              controller: locationController,
              onChanged: (String str) {
                setState(() {
                  location = str;
                });
              },
              decoration: InputDecoration(
                  icon: Icon(Icons.location_history),
                  hintText: "location",
                  border: InputBorder.none),
              style: TextStyle(fontSize: 22.0, color: Colors.black),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: TextField(
              controller: typeController,
              onChanged: (String str) {
                setState(() {
                  type = str;
                });
              },
              decoration: InputDecoration(
                  icon: Icon(Icons.merge_type),
                  hintText: "mount type",
                  border: InputBorder.none),
              style: TextStyle(fontSize: 22.0, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.check, size: 40.0),
                  onPressed: () {
                    _editMountain();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.close, size: 40.0),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
