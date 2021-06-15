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
    return Material(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                  'https://www.teahub.io/photos/full/223-2237466_mountain-wallpaper-android.jpg')),
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
                    'Create',
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
                      onChanged: (String str) {
                        setState(() {
                          title = str;
                        });
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.title, color: Colors.white),
                        labelText: "Enter Title",
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      onChanged: (String str) {
                        setState(() {
                          location = str;
                        });
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.location_city, color: Colors.white),
                        labelText: "Enter Location",
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      onChanged: (String str) {
                        setState(() {
                          type = str;
                        });
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.data_saver_on, color: Colors.white),
                        labelText: "Enter Type of Mountain",
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
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
                      _addMountainData();
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
