import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uas/pages/edit_waterfall.dart';
import 'package:uas/service/sign_in.dart';

class WaterfallPage extends StatefulWidget {
  @override
  _WaterfallPageState createState() => _WaterfallPageState();
}

class _WaterfallPageState extends State<WaterfallPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1547276483-835137145b2f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjZ8fHdhdGVyZmFsbHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80')),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 160.0),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("waterfall")
                    .where("email", isEqualTo: email)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData)
                    return new Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  return new MyListWaterfall(document: snapshot.data.docs);
                },
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(30))),
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Database',
                        style: TextStyle(color: Colors.black87, fontSize: 20),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Waterfall Data',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'List Today',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyListWaterfall extends StatelessWidget {
  MyListWaterfall({this.document});
  final List<DocumentSnapshot> document;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: document.length,
      itemBuilder: (BuildContext context, int i) {
        String titlewaterfall = document[i].data()['titlewaterfall'].toString();
        String locationwaterfall =
            document[i].data()['locationwaterfall'].toString();
        String river = document[i].data()['river'].toString();
        String height = document[i].data()['height'].toString();

        return Dismissible(
          key: Key(document[i].id),
          onDismissed: (direction) {
            FirebaseFirestore.instance.runTransaction((transaction) async {
              DocumentSnapshot snapshot =
                  await transaction.get(document[i].reference);
              await transaction.delete(snapshot.reference);
            });

            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text("Data has been deleted"),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titlewaterfall,
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.location_city,
                                  color: Colors.white),
                            ),
                            Text(
                              locationwaterfall,
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.water, color: Colors.white),
                            ),
                            Text(
                              river,
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.height, color: Colors.white),
                            ),
                            Text(
                              height,
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.white),
                  onPressed: () {
                    MaterialPageRoute route = MaterialPageRoute(
                      builder: (_) => EditWaterfall(
                          titlewaterfall: titlewaterfall,
                          locationwaterfall: locationwaterfall,
                          river: river,
                          height: height,
                          index: document[i].reference),
                    );
                    Navigator.push(context, route);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
