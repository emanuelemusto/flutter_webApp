import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_webapp/constants.dart';
import 'package:flutter_webapp/patientview/doctorList.dart';
import 'package:flutter_webapp/patientview/scheduleList.dart';
import 'package:http/http.dart' as http;

import '../Screens/Login/login_screen.dart';
import '../clinicalDetail.dart';
import '../diagnosticDetail.dart';
import '../medicationDetails.dart';

class PatientHomePage extends StatefulWidget {
  @override
  _PatientHomePage createState() => _PatientHomePage();
}

// ignore: must_be_immutable
class _PatientHomePage extends State<PatientHomePage> {
  var COLORS = {
    "male": Color(0xFF9ae1ca),
    "female": Color(0xFFDF53A6),
    "?": Color(0xFFC8B2BB)
  };

  var IMAGE = {
    "male": 'assets/icons/patientm.png',
    "female": 'assets/icons/patientf.png',
    "?": 'assets/icons/patientm.png',
    "null": "assets/icons/null.jpg"
  };

  Map<String, dynamic> list;

  Future<Map<String, dynamic>> getData() async {
    dynamic idPat = await FlutterSession().get("id");
    var response = await http.get(
        Uri.encodeFull(urlServer + "/STU3/Patient/" + idPat.toString()),
        headers: {"Accept": "application/json"});
    list = json.decode(response.body);
    await Future.delayed(Duration(milliseconds: 2));
    setState(() {});
    return list;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: getData(),
        builder: (context, AsyncSnapshot<Map<String, dynamic>> load) {
          if (load.hasData) {
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
                        color: COLORS[list["gender"]],
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.person_rounded),
                      title: Text('My Profile'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PatientHomePage()),
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
                    ListTile(
                      leading: Icon(Icons.list_alt_rounded),
                      title: Text('My Schedule'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScheduleListPatient()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              backgroundColor: Colors.white,
              appBar: new AppBar(
                backgroundColor: COLORS[list["gender"]],
                elevation: 0.0,
                title: new Text(
                  "Patient Profile",
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
                              COLORS[list["gender"]],
                              COLORS[list["gender"]]
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
                                  backgroundImage:
                                      AssetImage(IMAGE[list["gender"]]),
                                  radius: 50.0,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  list["name"][0]["family"] +
                                      " " +
                                      list["name"][0]["given"][0],
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
                                                list["gender"],
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
                                                list["birthDate"],
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
                                                list["resourceType"],
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
                                itemCount: list["telecom"] == null
                                    ? 0
                                    : list["telecom"].length,
                                itemBuilder: (BuildContext content, int index) {
                                  return ListTile(
                                    leading: Icon(Icons.phone_rounded),
                                    title: Text(
                                      list["telecom"][index]["value"] +
                                          ' (' +
                                          list["telecom"][index]["use"] +
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
                                itemCount: list["address"] == null
                                    ? 0
                                    : list["address"].length,
                                itemBuilder: (BuildContext content, int index) {
                                  return ListTile(
                                    leading: Icon(Icons.home),
                                    title: Text(
                                      list["address"][index]["line"][0] +
                                          ', ' +
                                          list["address"][index]["city"] +
                                          ', ' +
                                          list["address"][index]["postalCode"] +
                                          ' (' +
                                          list["address"][index]["use"] +
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
                                itemCount: list["language"] == null ? 0 : 1,
                                itemBuilder: (BuildContext content, int index) {
                                  return ListTile(
                                      leading: Icon(Icons.credit_card_rounded),
                                      title: InkWell(
                                        child: Text(
                                          "Codice Fiscale:" + list["language"],
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
                            color: COLORS[list["gender"]],
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ClinicalData(data: list)),
                              );
                            },
                            child: Text("Clinical Data"),
                          ),
                        ),
                        ButtonTheme(
                          minWidth: 200.0,
                          height: 50.0,
                          child: RaisedButton(
                            color: COLORS[list["gender"]],
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DiagnosticData(data: list)),
                              );
                            },
                            child: Text("Diagnostic Data"),
                          ),
                        ),
                        ButtonTheme(
                          minWidth: 200.0,
                          height: 50.0,
                          child: RaisedButton(
                            color: COLORS[list["gender"]],
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MedicationList(data: list)),
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
          } else {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
        });
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
    "null": "assets/icons/null.jpg"
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

    list = json.decode(response.body);
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
                        .indexOf(" ")),
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
            ListTile(
              leading: Icon(Icons.list_alt_rounded),
              title: Text('My Schedule'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScheduleListPatient()),
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
          "Patient Profile",
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
                            builder: (context) => PatientHomePage()),
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
    "null": "assets/icons/null.jpg"
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

    list1 = json.decode(response.body);

    if (response.body.length < 500) {
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

    list2 = json.decode(response.body);

    if (response.body.length < 500) {
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
            ListTile(
              leading: Icon(Icons.list_alt_rounded),
              title: Text('My Schedule'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScheduleListPatient()),
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
          "Patient Profile",
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
                            builder: (context) => PatientHomePage()),
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
    "null": "assets/icons/null.jpg"
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

    list = json.decode(response.body);

    if (response.body.length < 500) {
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
            ListTile(
              leading: Icon(Icons.list_alt_rounded),
              title: Text('My Schedule'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScheduleListPatient()),
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
          "Patient Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),
      resizeToAvoidBottomInset: true,
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
                            builder: (context) => PatientHomePage()),
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
