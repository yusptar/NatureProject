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
    return new Material(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://www.ourtasteforlife.com/wp-content/uploads/2019/09/TIBUMANA-WATERFALL-BALI-1.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          FlutterLogo(size: 60),
          SizedBox(
            height: 10,
          ),
          Text(
            "Edit Waterfall Data",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
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
                      icon: Icon(Icons.title),
                      hintText: "title",
                    ),
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
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
                      icon: Icon(Icons.location_city),
                      hintText: "location",
                    ),
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
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
                      icon: Icon(Icons.water),
                      hintText: "river",
                    ),
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
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
                      icon: Icon(Icons.height),
                      hintText: "height",
                    ),
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
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
                  icon: Icon(Icons.check, size: 40.0),
                  onPressed: () {
                    _editWaterfall();
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
