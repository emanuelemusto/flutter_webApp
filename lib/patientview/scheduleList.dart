import 'dart:math';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_webapp/constants.dart';
import 'package:flutter_webapp/patientview/patientHomeScreen.dart';
import 'package:http/http.dart' as http;

import 'doctorList.dart';


class ScheduleListPatient extends StatefulWidget {
  ScheduleListPatient({Key key, this.title}) : super(key: key);

  final String title;


  @override
  _ScheduleListPatient createState() => new _ScheduleListPatient();


}

class _ScheduleListPatient extends State<ScheduleListPatient> {

  List<dynamic> data = new List<dynamic>();

  Map<String, dynamic> list;

  Future<List<dynamic>> getData() async {
    dynamic idPat = await FlutterSession().get("id");
    var response = await http.get(
        Uri.encodeFull(urlServer + "/STU3/Schedule?_id=" + idPat.toString()),
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
        "title": list["entry"][i]["resource"]["serviceCategory"]["text"],
        "planning": "Planning at " + DateTime.parse(list["entry"][i]["resource"]["planningHorizon"]["start"].toString())
            .toUtc()
            .toString()
            .substring(
            0,
            DateTime.parse(
                list["entry"][i]["resource"]["planningHorizon"]["start"].toString())
                .toUtc()
                .toString()
                .indexOf(".")),
        "actor": "Doctor: " + list["entry"][i]["resource"]["actor"][0]["reference"].substring(0, list["entry"][i]["resource"]["actor"][0]["reference"].indexOf('/')),
        "active": "Confirmed: " + list["entry"][i]["resource"]["active"].toString()
      });
      i=i+1;
    }


    setState(() {});
    return data;
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
            "Schedule List",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(data[index]["title"]),
                subtitle: Text(data[index]["planning"] + "\n" + data[index]["actor"] + "\n" + data[index]["active"],
                )),
            );
          },
        ),
      );
  }
}


