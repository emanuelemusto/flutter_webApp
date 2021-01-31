import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_webapp/medicview/doctorDetails.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../patientList.dart';
import 'createAllergy.dart';
import 'createCondition.dart';
import 'createDiagnosticReport.dart';
import 'createMedication.dart';
import 'createSchedule.dart';

class ScheduleListDoctor extends StatefulWidget {
  ScheduleListDoctor({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ScheduleListDoctor createState() => new _ScheduleListDoctor();
}

class _ScheduleListDoctor extends State<ScheduleListDoctor> {
  TextEditingController editingController = TextEditingController();

  List<dynamic> data = new List<dynamic>();

  Map<String, dynamic> list;

  Future<List<dynamic>> getData() async {
    dynamic idPractioner = await FlutterSession().get("id");
    var response = await http.get(
        Uri.encodeFull(urlServer + "/STU3/Schedule?actor=" + idPractioner.toString()),
        headers: {"Accept": "application/json"});

    list = json.decode(response.body);
    print(list["total"]);

    data.clear();
    var i = 0;
    while (i < list["total"]) {
      data.add({
        "title": list["entry"][i]["resource"]["serviceCategory"]["text"],
        "planning": "Planning: " +
            list["entry"][i]["resource"]["planningHorizon"]["start"],
        "actor": "Patient: " +
            list["entry"][i]["resource"]["actor"][0]["reference"].substring(
                list["entry"][i]["resource"]["actor"][0]["reference"]
                    .indexOf('/') + 1),
        "active":
            "Confirmed: " + list["entry"][i]["resource"]["active"].toString()
      });
      i = i + 1;
    }

    setState(() {});
    return data;
  }

  Future<http.Response> confirmSchedule(int index) {
    return http.post(
      urlServer + '/confirmSchedule',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': list["entry"][index]["resource"]["id"]
      }),
    );
  }

  Future<http.Response> rejectSchedule(int index) {
    return http.post(
      urlServer + '/rejectSchedule',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': list["entry"][index]["resource"]["id"]
      }),
    );
  }


  @override
  void initState() {
    super.initState();
    getData();
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
            "My Schedule",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Center(
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                        ListTile(
                          trailing: Icon(Icons.arrow_forward_ios),
                          title: Text(data[index]["title"]),
                          subtitle: Text(data[index]["planning"] +
                              "\n" +
                              data[index]["actor"] +
                              "\n" +
                              data[index]["active"]),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            list["entry"][index]["resource"]["active"] == false ?
                            TextButton(
                              child: const Text('Confirm'),
                              onPressed: () {
                                confirmSchedule(index);
                                getData();
                                setState(() {
                                });
                              },
                            ): Text(
                              '     '
                            ),
                            const SizedBox(width: 8),
                            list["entry"][index]["resource"]["active"] == true ?
                            TextButton(
                              child: const Text('Reject'),
                              onPressed: () {
                                rejectSchedule(index);
                                getData();
                                setState(() {
                                });
                              },
                            ): Text("      "),
                            const SizedBox(width: 8),
                          ],
                        )
                      ]));
                })));
  }
}
