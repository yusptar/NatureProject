import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uas/pages/add_item_mountain.dart';
import 'package:uas/pages/add_item_waterfall.dart';
import 'package:uas/pages/edit_mountain.dart';
import 'package:uas/pages/login_page.dart';
import 'package:uas/pages/waterfall_page.dart';
import 'package:uas/service/sign_in.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 243, 243, 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          Container(
            margin: EdgeInsets.all(10),
            child: CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
            ),
          )
        ],
      ),
      drawer: Drawer(
        elevation: 16.0,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                  image: NetworkImage(
                      'https://cdn.pling.com/img/3/9/2/c/e7c08777001f07b0948f08103c2eacf57a1f.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(imageUrl),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: Text(
                      'Hi ' + name + ' !',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: Text(
                      email,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text("MAIN MENU"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                MaterialPageRoute route =
                    MaterialPageRoute(builder: (_) => HomePage());
                Navigator.push(context, route);
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Create Mountain Data"),
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(
                    builder: (_) => AddItemMountain(email: email));
                Navigator.push(context, route);
              },
            ),
            ListTile(
              leading: Icon(Icons.add_circle),
              title: Text("Create Waterfall Data"),
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(
                    builder: (_) => AddItemWaterfall(email: email));
                Navigator.push(context, route);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Log Out"),
              onTap: () {
                signOutGoogle();

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return LoginPage();
                }), ModalRoute.withName('/'));
              },
            ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1574950578143-858c6fc58922?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHx8&w=1000&q=80')),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 160.0),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("mountain")
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
                  return new MyList(document: snapshot.data.docs);
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
                        'Mountain Data',
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MaterialPageRoute route =
              MaterialPageRoute(builder: (_) => WaterfallPage());
          Navigator.push(context, route);
        },
        child: Icon(Icons.navigate_next, color: Colors.black),
        backgroundColor: Colors.white,
      ),
    );
  }
}

class MyList extends StatelessWidget {
  MyList({this.document});
  final List<DocumentSnapshot> document;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: document.length,
      itemBuilder: (BuildContext context, int i) {
        String title = document[i].data()['title'].toString();
        String location = document[i].data()['location'].toString();
        String type = document[i].data()['type'].toString();

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
                          title,
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
                              location,
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.data_saver_on,
                                  color: Colors.white),
                            ),
                            Text(
                              type,
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
                      builder: (_) => EditMountain(
                          title: title,
                          location: location,
                          type: type,
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
