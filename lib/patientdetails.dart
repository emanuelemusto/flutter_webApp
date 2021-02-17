import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_webapp/constants.dart';
import 'package:flutter_webapp/medicview/doctorDetails.dart';
import 'package:flutter_webapp/patientList.dart';
import 'package:http/http.dart' as http;

import 'Screens/Login/login_screen.dart';
import 'clinicalDetail.dart';
import 'diagnosticDetail.dart';
import 'medicationDetails.dart';
import 'medicview/createAllergy.dart';
import 'medicview/createCondition.dart';
import 'medicview/createDiagnosticReport.dart';
import 'medicview/createMedication.dart';
import 'medicview/createSchedule.dart';
import 'medicview/scheduleList.dart';

// ignore: must_be_immutable
class PatientDetails extends StatelessWidget {
  var COLORS = {
    "male": Color(0xFF9ae1ca),
    "female": Color(0xFFDF53A6),
    "?": Color(0xFFC8B2BB)
  };
  var IMAGE = {
    "male": 'assets/icons/patientm.png',
    "female": 'assets/icons/patientf.png',
    "?": 'assets/icons/patientm.png',
    "null": "'assets/icons/null.jpg'"
  };

  Map<String, dynamic> list;
  var data;

  // receive data from the FirstScreen as a parameter
  PatientDetails({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                color: COLORS[data["gender"]],
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
        backgroundColor: COLORS[data["gender"]],
        elevation: 0.0,
        title: new Text(
          "Patient details",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      COLORS[data["gender"]],
                      COLORS[data["gender"]]
                    ])),
                child: Container(
                  width: double.infinity,
                  height: 350.0,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: AssetImage(IMAGE[data["gender"]]),
                          radius: 50.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          data["name"][0]["family"] +
                              " " +
                              data["name"][0]["given"][0],
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Card(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5.0),
                          clipBehavior: Clip.antiAlias,
                          color: Colors.white,
                          elevation: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 22.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Gender",
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        data["gender"],
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 18.0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Birth Date",
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        data["birthDate"],
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 18.0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Resource Type",
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        data["resourceType"],
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 18.0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 30.0, horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: data["telecom"] == null
                            ? 0
                            : data["telecom"].length,
                        itemBuilder: (BuildContext content, int index) {
                          return ListTile(
                            leading: Icon(Icons.phone_rounded),
                            title: Text(
                              data["telecom"][index]["value"] +
                                  ' (' +
                                  data["telecom"][index]["use"] +
                                  ')',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          );
                        }),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: data["address"] == null
                            ? 0
                            : data["address"].length,
                        itemBuilder: (BuildContext content, int index) {
                          return ListTile(
                            leading: Icon(Icons.home),
                            title: Text(
                              data["address"][index]["line"][0] +
                                  ', ' +
                                  data["address"][index]["city"] +
                                  ', ' +
                                  data["address"][index]["postalCode"] +
                                  ' (' +
                                  data["address"][index]["use"] +
                                  ')',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          );
                        }),
                    new ListView.builder(
                        shrinkWrap: true,
                        itemCount: data["language"] == null ? 0 : 1,
                        itemBuilder: (BuildContext content, int index) {
                          return ListTile(
                              leading: Icon(Icons.credit_card_rounded),
                              title: InkWell(
                                child: Text(
                                  "Codice Fiscale:" + data["language"],
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                              ));
                        })
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ButtonBar(
              mainAxisSize: MainAxisSize.max,
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                ButtonTheme(
                  minWidth: 200.0,
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {},
                    color: Colors.grey,
                    child: Text("Info Patient"),
                  ),
                ),
                ButtonTheme(
                  minWidth: 200.0,
                  height: 50.0,
                  child: RaisedButton(
                    color: COLORS[data["gender"]],
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ClinicalData(data: data)),
                      );
                    },
                    child: Text("Clinical Data"),
                  ),
                ),
                ButtonTheme(
                  minWidth: 200.0,
                  height: 50.0,
                  child: RaisedButton(
                    color: COLORS[data["gender"]],
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DiagnosticData(data: data)),
                      );
                    },
                    child: Text("Diagnostic Data"),
                  ),
                ),
                ButtonTheme(
                  minWidth: 200.0,
                  height: 50.0,
                  child: RaisedButton(
                    color: COLORS[data["gender"]],
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MedicationList(data: data)),
                      );
                    },
                    child: Text("Medication"),
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

// ignore: must_be_immutable
class DiagnosticData extends StatefulWidget {
  var data;

  DiagnosticData({Key key, @required this.data}) : super(key: key);

  @override
  _DiagnosticData createState() => _DiagnosticData(data: data);
}

class _DiagnosticData extends State<DiagnosticData> {
  @override
  void initState() {
    super.initState();
    // NOTE: Calling this function here would crash the app.
    getData();
  }

  var COLORS = {
    "male": Color(0xFF9ae1ca),
    "female": Color(0xFFDF53A6),
    "?": Color(0xFFC8B2BB)
  };
  var IMAGE = {
    "male": 'assets/icons/patientm.png',
    "female": 'assets/icons/patientf.png',
    "?": 'assets/icons/patientm.png',
    "null": "'assets/icons/null.jpg'"
  };

  var data;

  List<dynamic> data2 = new List<dynamic>();

  Map<String, dynamic> list;

  // receive data from the FirstScreen as a parameter
  _DiagnosticData({Key key, @required this.data});

  Future<List<dynamic>> getData() async {
    dynamic token = await FlutterSession().get("token");
    dynamic user = await FlutterSession().get("username");
    var response = await http.get(
        Uri.encodeFull(urlServer +
            "/STU3/DiagnosticReport?_id=" +
            data["id"] +
            "&identifier=" +
            user.toString() +
            "|" +
            token.toString()),
        headers: {"Accept": "application/json"});

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

    list = json.decode(response.body);

    print("-->" + response.body.length.toString());
    print(list["entry"][0]["resource"]["category"]["text"]);

    data2.clear();
    var i = 0;
    while (i < list["total"]) {
      data2.add({
        "title": list["entry"][i]["resource"]["category"]["text"],
        "issued":
            DateTime.parse(list["entry"][i]["resource"]["issued"].toString())
                .toUtc()
                .toString()
                .substring(
                    0,
                    DateTime.parse(
                            list["entry"][i]["resource"]["issued"].toString())
                        .toUtc()
                        .toString()
                        .indexOf(" "))
      });
      i = i + 1;
    }

    setState(() {});
    return data2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                color: COLORS[data["gender"]],
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
        backgroundColor: COLORS[data["gender"]],
        elevation: 0.0,
        title: new Text(
          "Patient details",
          style: TextStyle(color: Colors.white),
        ),
      ),
      resizeToAvoidBottomInset: false,
      // set it to false
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      COLORS[data["gender"]],
                      COLORS[data["gender"]]
                    ])),
                child: Container(
                  width: double.infinity,
                  height: 350.0,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: AssetImage(IMAGE[data["gender"]]),
                          radius: 50.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          data["name"][0]["family"] +
                              " " +
                              data["name"][0]["given"][0],
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Card(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5.0),
                          clipBehavior: Clip.antiAlias,
                          color: Colors.white,
                          elevation: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 22.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Gender",
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        data["gender"],
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 18.0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Birth Date",
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        data["birthDate"],
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 18.0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Resource Type",
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        data["resourceType"],
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 18.0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 30.0, horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: data2 == null ? 0 : data2.length,
                        itemBuilder: (BuildContext content, int index) {
                          return ListTile(
                            leading: Icon(Icons.analytics),
                            title: Text(data2[index]["title"]),
                            subtitle: Text(data2[index]["issued"]),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              print(list["entry"][index]);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DiagnosticDetail(
                                        data: list["entry"][index])),
                              );
                            },
                          );
                        }),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ButtonBar(
              mainAxisSize: MainAxisSize.max,
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                ButtonTheme(
                  minWidth: 200.0,
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PatientDetails(data: data)),
                      );
                    },
                    color: COLORS[data["gender"]],
                    child: Text("Info Patient"),
                  ),
                ),
                ButtonTheme(
                  minWidth: 200.0,
                  height: 50.0,
                  child: RaisedButton(
                    color: COLORS[data["gender"]],
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ClinicalData(data: data)),
                      );
                    },
                    child: Text("Clinical Data"),
                  ),
                ),
                ButtonTheme(
                  minWidth: 200.0,
                  height: 50.0,
                  child: RaisedButton(
                    color: Colors.grey,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(),
                      );
                    },
                    child: Text("Diagnostic Data"),
                  ),
                ),
                ButtonTheme(
                  minWidth: 200.0,
                  height: 50.0,
                  child: RaisedButton(
                    color: COLORS[data["gender"]],
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MedicationList(data: data)),
                      );
                    },
                    child: Text("Medication"),
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

// ignore: must_be_immutable
class ClinicalData extends StatefulWidget {
  var data;

  ClinicalData({Key key, @required this.data}) : super(key: key);

  @override
  _ClinicalData createState() => _ClinicalData(data: data);
}

class _ClinicalData extends State<ClinicalData> {
  @override
  void initState() {
    super.initState();
    // NOTE: Calling this function here would crash the app.
    getData();
    getData2();
  }

  var COLORS = {
    "male": Color(0xFF9ae1ca),
    "female": Color(0xFFDF53A6),
    "?": Color(0xFFC8B2BB)
  };
  var IMAGE = {
    "male": 'assets/icons/patientm.png',
    "female": 'assets/icons/patientf.png',
    "?": 'assets/icons/patientm.png',
    "null": "'assets/icons/null.jpg'"
  };

  var data;

  List<dynamic> data2 = new List<dynamic>();

  List<dynamic> data3 = new List<dynamic>();

  Map<String, dynamic> list1;

  Map<String, dynamic> list2;

  // receive data from the FirstScreen as a parameter
  _ClinicalData({Key key, @required this.data});

  Future<List<dynamic>> getData() async {
    dynamic token = await FlutterSession().get("token");
    dynamic user = await FlutterSession().get("username");
    var response = await http.get(
        Uri.encodeFull(urlServer +
            "/STU3/AllergyIntolerance?_id=" +
            data["id"] +
            "&identifier=" +
            user.toString() +
            "|" +
            token.toString()),
        headers: {"Accept": "application/json"});

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
    list1 = json.decode(response.body);

    data2.clear();
    var i = 0;
    while (i < list1["total"]) {
      data2.add({
        "title": list1["entry"][i]["resource"]["code"]["text"],
        "issued": DateTime.parse(
                list1["entry"][i]["resource"]["note"][0]["time"].toString())
            .toUtc()
            .toString()
            .substring(
                0,
                DateTime.parse(list1["entry"][i]["resource"]["note"][0]["time"]
                        .toString())
                    .toUtc()
                    .toString()
                    .indexOf(" ")),
        "type": 1,
      });
      i = i + 1;
    }

    setState(() {});
    return data2;
  }

  Future<List<dynamic>> getData2() async {
    dynamic token = await FlutterSession().get("token");
    dynamic user = await FlutterSession().get("username");
    var response = await http.get(
        Uri.encodeFull(urlServer +
            "/STU3/Condition?_id=" +
            data["id"] +
            "&identifier=" +
            user.toString() +
            "|" +
            token.toString()),
        headers: {"Accept": "application/json"});

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

    list2 = json.decode(response.body);

    var i = 0;
    data3.clear();
    while (i < list2["total"]) {
      data3.add({
        "title": list2["entry"][i]["resource"]["code"]["text"],
        "issued": DateTime.parse(
                list2["entry"][i]["resource"]["note"][0]["time"].toString())
            .toUtc()
            .toString()
            .substring(
                0,
                DateTime.parse(list2["entry"][i]["resource"]["note"][0]["time"]
                        .toString())
                    .toUtc()
                    .toString()
                    .indexOf(" ")),
        "type": 2,
      });
      i = i + 1;
    }

    setState(() {});
    return data3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                color: COLORS[data["gender"]],
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
        backgroundColor: COLORS[data["gender"]],
        elevation: 0.0,
        title: new Text(
          "Patient details",
          style: TextStyle(color: Colors.white),
        ),
      ),
      resizeToAvoidBottomInset: false,
      // set it to false
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      COLORS[data["gender"]],
                      COLORS[data["gender"]]
                    ])),
                child: Container(
                  width: double.infinity,
                  height: 350.0,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: AssetImage(IMAGE[data["gender"]]),
                          radius: 50.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          data["name"][0]["family"] +
                              " " +
                              data["name"][0]["given"][0],
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Card(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5.0),
                          clipBehavior: Clip.antiAlias,
                          color: Colors.white,
                          elevation: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 22.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Gender",
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        data["gender"],
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 18.0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Birth Date",
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        data["birthDate"],
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 18.0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Resource Type",
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        data["resourceType"],
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 18.0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 30.0, horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: data2 == null ? 0 : data2.length,
                        itemBuilder: (BuildContext content, int index) {
                          return ListTile(
                            leading: Icon(Icons.rule_folder_outlined),
                            title: Text(data2[index]["title"]),
                            subtitle: Text(data2[index]["issued"]),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              print(list1["entry"][index]);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllergyDetail(
                                        data: list1["entry"][index])),
                              );
                            },
                          );
                        }),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: data3 == null ? 0 : data3.length,
                        itemBuilder: (BuildContext content, int index2) {
                          return ListTile(
                            leading: Icon(Icons.graphic_eq_outlined),
                            title: Text(data3[index2]["title"]),
                            subtitle: Text(data3[index2]["issued"]),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              print(list2["entry"][index2]);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ClinicalDetail(
                                        data: list2["entry"][index2])),
                              );
                            },
                          );
                        }),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ButtonBar(
              mainAxisSize: MainAxisSize.max,
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                ButtonTheme(
                  minWidth: 200.0,
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PatientDetails(data: data)),
                      );
                    },
                    color: COLORS[data["gender"]],
                    child: Text("Info Patient"),
                  ),
                ),
                ButtonTheme(
                  minWidth: 200.0,
                  height: 50.0,
                  child: RaisedButton(
                    color: Colors.grey,
                    onPressed: () {},
                    child: Text("Clinical Data"),
                  ),
                ),
                ButtonTheme(
                  minWidth: 200.0,
                  height: 50.0,
                  child: RaisedButton(
                    color: COLORS[data["gender"]],
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DiagnosticData(data: data)),
                      );
                    },
                    child: Text("Diagnostic Data"),
                  ),
                ),
                ButtonTheme(
                  minWidth: 200.0,
                  height: 50.0,
                  child: RaisedButton(
                    color: COLORS[data["gender"]],
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MedicationList(data: data)),
                      );
                    },
                    child: Text("Medication"),
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

// ignore: must_be_immutable
class MedicationList extends StatefulWidget {
  var data;

  MedicationList({Key key, @required this.data}) : super(key: key);

  @override
  _MedicationList createState() => _MedicationList(data: data);
}

class _MedicationList extends State<MedicationList> {
  @override
  void initState() {
    super.initState();
    // NOTE: Calling this function here would crash the app.
    getData();
  }

  var COLORS = {
    "male": Color(0xFF9ae1ca),
    "female": Color(0xFFDF53A6),
    "?": Color(0xFFC8B2BB)
  };
  var IMAGE = {
    "male": 'assets/icons/patientm.png',
    "female": 'assets/icons/patientf.png',
    "?": 'assets/icons/patientm.png',
    "null": "'assets/icons/null.jpg'"
  };
  var data;

  List<dynamic> data2 = new List<dynamic>();

  Map<String, dynamic> list;

  // receive data from the FirstScreen as a parameter
  _MedicationList({Key key, @required this.data});

  Future<List<dynamic>> getData() async {
    dynamic token = await FlutterSession().get("token");
    dynamic user = await FlutterSession().get("username");
    var response = await http.get(
        Uri.encodeFull(urlServer +
            "/STU3/Medication?_id=" +
            data["id"] +
            "&identifier=" +
            user.toString() +
            "|" +
            token.toString()),
        headers: {"Accept": "application/json"});

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

    data2.clear();
    var i = 0;
    while (i < list["total"]) {
      data2.add({"title": list["entry"][i]["resource"]["text"]["div"]});
      i = i + 1;
    }

    setState(() {});
    return data2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                color: COLORS[data["gender"]],
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
        backgroundColor: COLORS[data["gender"]],
        elevation: 0.0,
        title: new Text(
          "Patient details",
          style: TextStyle(color: Colors.white),
        ),
      ),
      resizeToAvoidBottomInset: false,
      // set it to false
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      COLORS[data["gender"]],
                      COLORS[data["gender"]]
                    ])),
                child: Container(
                  width: double.infinity,
                  height: 350.0,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: AssetImage(IMAGE[data["gender"]]),
                          radius: 50.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          data["name"][0]["family"] +
                              " " +
                              data["name"][0]["given"][0],
                          style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Card(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5.0),
                          clipBehavior: Clip.antiAlias,
                          color: Colors.white,
                          elevation: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 22.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Gender",
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        data["gender"],
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 18.0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Birth Date",
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        data["birthDate"],
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 18.0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Resource Type",
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        data["resourceType"],
                                        style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 18.0,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 30.0, horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: data2 == null ? 0 : data2.length,
                        itemBuilder: (BuildContext content, int index) {
                          return ListTile(
                            leading: Icon(Icons.local_hospital),
                            title: Text(data2[index]["title"]
                                .toString()
                                .substring(
                                    data2[index]["title"]
                                            .toString()
                                            .indexOf('@') +
                                        1,
                                data2[index]["title"]
                                    .toString()
                                    .indexOf('#'))),
                            subtitle: Text(data2[index]["title"]
                                .toString()
                                .substring(42, 64)),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MedicationDetails(
                                        data: list["entry"][index]
                                            ["resource"])),
                              );
                            },
                          );
                        }),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ButtonBar(
              mainAxisSize: MainAxisSize.max,
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                ButtonTheme(
                  minWidth: 200.0,
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PatientDetails(data: data)),
                      );
                    },
                    color: COLORS[data["gender"]],
                    child: Text("Info Patient"),
                  ),
                ),
                ButtonTheme(
                  minWidth: 200.0,
                  height: 50.0,
                  child: RaisedButton(
                    color: COLORS[data["gender"]],
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ClinicalData(data: data)),
                      );
                    },
                    child: Text("Clinical Data"),
                  ),
                ),
                ButtonTheme(
                  minWidth: 200.0,
                  height: 50.0,
                  child: RaisedButton(
                    color: COLORS[data["gender"]],
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DiagnosticData(data: data)),
                      );
                    },
                    child: Text("Diagnostic Data"),
                  ),
                ),
                ButtonTheme(
                  minWidth: 200.0,
                  height: 50.0,
                  child: RaisedButton(
                    color: Colors.grey,
                    onPressed: () {},
                    child: Text("Medication"),
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
