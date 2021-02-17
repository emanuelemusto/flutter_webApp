import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_webapp/constants.dart';
import 'package:flutter_webapp/medicview/createSchedule.dart';
import 'package:flutter_webapp/medicview/doctorDetails.dart';
import 'package:flutter_webapp/medicview/scheduleList.dart';
import 'package:http/http.dart' as http;

import 'Screens/Login/login_screen.dart';
import 'medicview/createAllergy.dart';
import 'medicview/createCondition.dart';
import 'medicview/createDiagnosticReport.dart';
import 'medicview/createMedication.dart';
import 'medicview/createPatient.dart';
import 'medicview/createSchedule.dart';
import 'patientdetails.dart';

void main() => runApp(new MyApp());

var COLORS = {
  "male": Color(0xFF9ae1ca),
  "female": Color(0xFFDF53A6),
  "?": Color(0xFFC8B2BB)
};
var IMAGE = {
  "male": 'assets/icons/patientm.png',
  "female": 'assets/icons/patientf.png',
  "?": 'assets/icons/patientm.png',
  "null": 'assets/icons/null.jpg'
};
List data;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Medici App',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: new MyHomePage(title: 'Patient List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController editingController = TextEditingController();

  List<dynamic> data = new List<dynamic>();

  Map<String, dynamic> list;

  Map<String, dynamic> list2;

  Future<List<dynamic>> getData(String name) async {
    dynamic token = await FlutterSession().get("token");
    dynamic user = await FlutterSession().get("username");
    print("prova token client" + token.toString());
    var response = await http.get(
        Uri.encodeFull(urlServer +
            "/STU3/Patient?family=" +
            name +
            "&identifier=" +
            user.toString() +
            "|" +
            token.toString()),
        headers: {"Accept": "application/json"});

    await Future.delayed(Duration(milliseconds: 15));

    if (response.body.length <= 50) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
          },
        ),
      );
    }
    print("-->" + response.body.length.toString());
    list = json.decode(response.body);
    print(list);

    data.clear();
    var i = 0;
    while (i < list["total"]) {
      data.add({
        "title": list["entry"][i]["resource"]["name"][0]["family"] +
            " " +
            list["entry"][i]["resource"]["name"][0]["given"][0],
        "content": "Birth date: " + list["entry"][i]["resource"]["birthDate"],
        "color": COLORS[list["entry"][i]["resource"]["gender"]],
        "image": IMAGE[list["entry"][i]["resource"]["gender"]]
      });
      i = i + 1;
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

  Future<Map<String, dynamic>> getData2() async {
    dynamic idPra = await FlutterSession().get("id");
    var response = await http.get(
        Uri.encodeFull(urlServer + "/STU3/Practitioner/" + idPra.toString()),
        headers: {"Accept": "application/json"});
    list2 = json.decode(response.body);
    await Future.delayed(Duration(milliseconds: 2));
    setState(() {});
    return list2;
  }

  @override
  void initState() {
    super.initState();
    getData2();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Options menu',
                style: TextStyle(
                    color: Colors.white,
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
                  MaterialPageRoute(builder: (context) => DocDetails()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list_alt_rounded),
              title: Text('My Schedule'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScheduleListDoctor()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Search Patient'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              },
            ),
            Divider(
              color: Colors.grey,
              height: 0.5,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Add',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add Schedule'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateSchedule()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add Patient'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreatePatient()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add Diagnostic Report'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateDiagnosticReport()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add Condition'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateCondition()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add Allergy Intolerance'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateAllergy()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add Medication'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateMedication()),
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
          "Patient List",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: new Stack(
        children: <Widget>[
          new Transform.translate(
            offset:
                new Offset(0.0, MediaQuery.of(context).size.height * 0.22000),
            child: new ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (BuildContext content, int index) {
                return GestureDetector(
                  onTap: () {
                    print(list["entry"][index]);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PatientDetails(
                              data: list["entry"][index]["resource"])),
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
                      leading: new CircleAvatar(
                        child: new Container(
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                            image: new DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: AssetImage('assets/icons/doctor.png'),
                            ),
                          ),
                        ),
                      ),
                      title: new Text(
                        "Welcome Doc",
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            letterSpacing: 2.0),
                      ),
                      subtitle: new Text(
                        "Role: Medic",
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 10.0,
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
