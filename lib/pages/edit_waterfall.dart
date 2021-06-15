import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uas/pages/waterfall_page.dart';

class EditWaterfall extends StatefulWidget {
  EditWaterfall(
      {this.titlewaterfall,
      this.locationwaterfall,
      this.river,
      this.height,
      this.index});
  final String titlewaterfall;
  final String locationwaterfall;
  final String river;
  final String height;
  final index;

  @override
  _EditWaterfallState createState() => new _EditWaterfallState();
}

class _EditWaterfallState extends State<EditWaterfall> {
  TextEditingController titleController;
  TextEditingController locationController;
  TextEditingController riverController;
  TextEditingController heightController;

  String titlewaterfall;
  String locationwaterfall;
  String river;
  String height;

  void _editWaterfall() {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(widget.index);
      await transaction.update(snapshot.reference, {
        "titlewaterfall": titlewaterfall,
        "locationwaterfall": locationwaterfall,
        "river": river,
        "height": height,
      });
    });
    MaterialPageRoute route =
        MaterialPageRoute(builder: (_) => WaterfallPage());
    Navigator.push(context, route);
  }

  @override
  void initState() {
    super.initState();

    titlewaterfall = widget.titlewaterfall;
    locationwaterfall = widget.locationwaterfall;
    river = widget.river;
    height = widget.height;

    titleController = TextEditingController(text: widget.titlewaterfall);
    locationController = TextEditingController(text: widget.locationwaterfall);
    riverController = TextEditingController(text: widget.river);
    heightController = TextEditingController(text: widget.height);
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
                  'https://images.unsplash.com/photo-1523224949444-170258978eef?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MzN8fHxlbnwwfHx8fA%3D%3D&w=1000&q=80')),
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
                    'Update',
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
                          titlewaterfall = str;
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
                          locationwaterfall = str;
                        });
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.location_city, color: Colors.white),
                        labelText: "Waterfall Location",
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
                      controller: riverController,
                      onChanged: (String str) {
                        setState(() {
                          river = str;
                        });
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.water, color: Colors.white),
                        labelText: "River Location",
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
                      controller: heightController,
                      onChanged: (String str) {
                        setState(() {
                          height = str;
                        });
                      },
                      decoration: InputDecoration(
                        icon: Icon(Icons.height, color: Colors.white),
                        labelText: "Height of Waterfall",
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
                      _editWaterfall();
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
