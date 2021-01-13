import 'dart:math';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    var response = await http.get(
        Uri.encodeFull("http://192.168.1.11:8183/STU3/Schedule?actor=" + "40"),
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
                    .indexOf('/')),
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
      'http://192.168.1.11:8183/confirmSchedule',
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
      'http://192.168.1.11:8183/rejectSchedule',
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
        appBar: AppBar(
          title: Text("My Schedule"),
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
                            TextButton(
                              child: const Text('Confirm'),
                              onPressed: () {
                                confirmSchedule(index);
                                getData();
                                setState(() {
                                });
                              },
                            ),
                            const SizedBox(width: 8),
                            TextButton(
                              child: const Text('Reject'),
                              onPressed: () {
                                rejectSchedule(index);
                                getData();
                                setState(() {
                                });
                              },
                            ),
                            const SizedBox(width: 8),
                          ],
                        )
                      ]));
                })));
  }
}
