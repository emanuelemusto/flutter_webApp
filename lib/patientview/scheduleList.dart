import 'dart:math';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


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
    var response = await http.get(
        Uri.encodeFull("http://127.0.0.1:8183/STU3/Schedule?_id=" + "20"), //TODO
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
        "planning": "Planning at " + list["entry"][i]["resource"]["planningHorizon"]["start"],
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
        appBar: AppBar(
          title: Text("My Schedule"),
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


