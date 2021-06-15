import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uas/pages/home_page.dart';
import 'package:uas/service/sign_in.dart';

class AddItemWaterfall extends StatefulWidget {
  AddItemWaterfall({this.email});
  final String email;
  @override
  _AddItemWaterfallState createState() => new _AddItemWaterfallState();
}

class _AddItemWaterfallState extends State<AddItemWaterfall> {
  String titlewaterfall = '';
  String locationwaterfall = '';
  String river = '';
  String height = '';

  void _addWaterfallData() {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference _user =
          FirebaseFirestore.instance.collection('waterfall');
      await _user.add({
        "email": email,
        "titlewaterfall": titlewaterfall,
        "locationwaterfall": locationwaterfall,
        "river": river,
        "height": height,
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
              image:
                  NetworkImage('https://wallpaperaccess.com/full/2784478.jpg')),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Create',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Waterfall Data',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
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
                          titlewaterfall = str;
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
                          locationwaterfall = str;
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
                          river = str;
                        });
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.water, color: Colors.white),
                        labelText: "Enter River",
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
                          height = str;
                        });
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.height, color: Colors.white),
                        labelText: "Enter Height of Waterfall (M)",
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 15),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(Icons.check, size: 40.0, color: Colors.white),
                    onPressed: () {
                      _addWaterfallData();
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
