import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_webapp/constants.dart';
import 'package:flutter_webapp/medicview/scheduleList.dart';
import 'package:http/http.dart' as http;

import '../patientList.dart';
import 'createAllergy.dart';
import 'createCondition.dart';
import 'createDiagnosticReport.dart';
import 'createMedication.dart';
import 'createSchedule.dart';

class DocDetails extends StatefulWidget {
  @override
  _DoctorDetails createState() => _DoctorDetails();
}

// ignore: must_be_immutable
class _DoctorDetails extends State<DocDetails> {

  Future<Map<String, dynamic>> getData2() async {
    dynamic idPra = await FlutterSession().get("id");
    var response = await http.get(
        Uri.encodeFull(urlServer + "/STU3/Practitioner/" + idPra.toString()),
        headers: {"Accept": "application/json"});
    list2 = json.decode(response.body);
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
    data = list2;
    return data;
  }

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

  Map<String, dynamic> list2;
  Future<Map<String, dynamic>> list3;
  var data;

  @override
  void initState() {
    super.initState();
    list3 = getData2();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: list3,
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
                elevation: 0.0,
                backgroundColor: COLORS[data["gender"]],
                title: new Text(
                  "My info",
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
                                  backgroundImage: AssetImage(
                                    IMAGE[data["gender"]],
                                  ),
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
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: data["qualification"].length == null
                                    ? 0
                                    : data["qualification"].length,
                                itemBuilder: (BuildContext content, int index) {
                                  return ListTile(
                                    leading: Icon(Icons.work),
                                    title: Text(
                                      "Qualification: " +
                                          data["qualification"][index]["code"]
                                              ["text"],
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                  );
                                }),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: data["qualification"].length == null
                                    ? 0
                                    : data["qualification"].length,
                                itemBuilder: (BuildContext content, int index) {
                                  return ListTile(
                                    leading: Icon(Icons.work),
                                    title: Text(
                                      "Issues: " +
                                          data["qualification"][index]["issuer"]
                                              ["reference"],
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
                                          "Codice Fiscale: " + data["language"],
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
