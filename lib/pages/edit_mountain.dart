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
    return Material(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image:
                  NetworkImage('https://wallpaperaccess.com/full/1941180.jpg')),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Update',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Mountain Data',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 310,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      controller: titleController,
                      onChanged: (String str) {
                        setState(() {
                          title = str;
                        });
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.title, color: Colors.white),
                        labelText: "Title",
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: TextStyle(fontSize: 15.0, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      controller: locationController,
                      onChanged: (String str) {
                        setState(() {
                          location = str;
                        });
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.location_city, color: Colors.white),
                        labelText: "Mountain Location",
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: TextStyle(fontSize: 15.0, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      controller: typeController,
                      onChanged: (String str) {
                        setState(() {
                          type = str;
                        });
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.merge_type, color: Colors.white),
                        labelText: "Mountain Type",
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: TextStyle(fontSize: 15.0, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(Icons.check, size: 40.0, color: Colors.white),
                    onPressed: () {
                      _editMountain();
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.close, size: 40.0, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
