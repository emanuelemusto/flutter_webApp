import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_webapp/patientview/doctorDetails.dart';
import 'package:flutter_webapp/patientview/patientHomeScreen.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';


class DoctorList extends StatefulWidget {
  DoctorList({Key key, this.title}) : super(key: key);

  final String title;


  @override
  _DoctorList createState() => new _DoctorList();


}

class _DoctorList extends State<DoctorList> {
  var COLORS = {
    "male": Color(0xFF9ae1ca),
    "female": Color(0xFFDF53A6),
    "?": Color(0xFFC8B2BB)
  };
  var IMAGE = {
    "male": 'assets/icons/doctor.png',
    "female": 'assets/icons/doctor.png',
    "?": 'assets/icons/doctor.png',
    "null" : "assets/icons/null.jpg"
  };

  TextEditingController editingController = TextEditingController();


  List<dynamic> data = new List<dynamic>();

  Map<String, dynamic> list;

  Future<List<dynamic>> getData(String name) async {
    dynamic token = await FlutterSession().get("token");
    dynamic user = await FlutterSession().get("username");
    var response = await http.get(
        Uri.encodeFull(urlServer + "/STU3/Practitioner?family=" + name+
            "&identifier=" +
            user.toString() +
            "|" +
            token.toString()),
        headers: {
          "Accept": "application/json"
        }
    );

    await Future.delayed(Duration(milliseconds: 2));


    list = json.decode(response.body);
    print(list["total"]);

    data.clear();
    var i = 0;
    while (i < list["total"]) {
      data.add({
        "title": list["entry"][i]["resource"]["name"][0]["family"] + " " + list["entry"][i]["resource"]["name"][0]["given"][0],
        "content": "Qualification: " + list["entry"][i]["resource"]["qualification"][0]["code"]["text"],
        "color": COLORS[list["entry"][i]["resource"]["gender"]],
        "image": IMAGE[list["entry"][i]["resource"]["gender"]]
      });
      i=i+1;
    }

    data.add({
      "title": "     ",
      "content": "    ",
      "color": Colors.white,
      "image": IMAGE["null"]
    });

    setState(() {});
    return data;
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Options menu',
                style: TextStyle(color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
            ),
            ListTile(
              leading: Icon(Icons.person_rounded),
              title: Text('My Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PatientHomePage()),
                );
              },
            ),

            ListTile(
              leading: Icon(Icons.search),
              title: Text('Search Doctor'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DoctorList()),
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,

      appBar: new AppBar(
        elevation: 0.0,
        title: new Text(
          "Doctor List",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: new Stack(
        children: <Widget>[
          new Transform.translate(
            offset: new Offset(0.0, MediaQuery.of(context).size.height * 0.22000),
            child: new ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (BuildContext content, int index) {
                return GestureDetector(
                  onTap: () {
                    print(list["entry"][index]);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DoctorDetails(data: list["entry"][index]["resource"])),
                    );
                  },
                  child: PatientListItem(
                    title: data[index]["title"],
                    content: data[index]["content"],
                    color: data[index]["color"],
                    image: data[index]["image"],

                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 36 + 33.0,
            left: 5,
            right: 5,
            child: TextField(
              cursorColor: Colors.teal,
              onChanged: (value) {
                this.getData(value);
              },
              controller: editingController,
              decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)))),
            ),
          ),

          new Transform.translate(
            offset: Offset(0.0, -56.0),
            child: new Container(
              padding: EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                bottom: 56.0,
              ),
              height: 120.0,
              decoration: BoxDecoration(
                color: Colors.teal,
              ),

              child: new Stack(
                children: [
                  new Opacity(
                    opacity: 0.2,
                    child: new Container(color: COLORS[0]),
                  ),
                  new Transform.translate(
                    offset: Offset(0.0, 50.0),
                    child: new ListTile(

                      title: new Text(
                        "Search Doctor by name",
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            letterSpacing: 2.0),
                      ),


                    ),
                  ),
                ],
              ),


            ),
          )
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = new Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height / 4.75);
    p.lineTo(0.0, size.height / 4.75);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class PatientListItem extends StatefulWidget {
  String title;
  String content;
  Color color;
  String image;

  PatientListItem({this.title, this.content, this.color, this.image});


  @override
  _PatientListItemState createState() => new _PatientListItemState();
}

class _PatientListItemState extends State<PatientListItem> {
  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Container(width: 10.0, height: 190.0, color: widget.color),
        new Expanded(
          child: new Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
            child: new Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  widget.title,
                  style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: new Text(
                    widget.content,
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
        new Container(
          height: 150.0,
          width: 150.0,
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              new Transform.translate(
                offset: new Offset(50.0, 0.0),
                child: new Container(
                  height: 100.0,
                  width: 100.0,
                  color: widget.color,
                ),
              ),
              new Transform.translate(
                offset: Offset(10.0, 20.0),
                child: new Card(
                  child: new Container(
                    height: 120.0,
                    width: 120.0,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            width: 10.0,
                            color: Colors.white,
                            style: BorderStyle.solid),
                        image: DecorationImage(
                          image: AssetImage(widget.image),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

