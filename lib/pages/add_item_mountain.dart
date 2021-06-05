import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uas/pages/home_page.dart';
import 'package:uas/service/sign_in.dart';

class AddItemMountain extends StatefulWidget {
  AddItemMountain({this.email});
  final String email;
  @override
  _AddItemMountainState createState() => new _AddItemMountainState();
}

class _AddItemMountainState extends State<AddItemMountain> {
  String title = '';
  String location = '';
  String type = '';

  void _addMountainData() {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference _user =
          FirebaseFirestore.instance.collection('mountain');
      await _user.add({
        "email": email,
        "title": title,
        "location": location,
        "type": type,
      });
    });
    MaterialPageRoute route = MaterialPageRoute(builder: (_) => HomePage());
    Navigator.push(context, route);
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
                  "Create Mountain Data",
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
                    _addMountainData();
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
