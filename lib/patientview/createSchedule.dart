import 'dart:math';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_webapp/constants.dart';
import 'package:flutter_webapp/patientList.dart';

import 'package:flutter/material.dart';
import 'package:flutter_webapp/patientview/patientHomeScreen.dart';
import 'package:flutter_webapp/patientview/scheduleList.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:time_picker_widget/time_picker_widget.dart';

class CreateSchedule extends StatefulWidget {
  Map<String, dynamic> practitioner;
  DateTime now;

  // receive data from the FirstScreen as a parameter
  CreateSchedule({Key key, @required this.practitioner, @required this.now}) : super(key: key);

  @override
  _CreateSchedule createState() => _CreateSchedule(this.practitioner, this.now);
}

class _CreateSchedule extends State<CreateSchedule> {
  Map<String, dynamic> practitioner;

  _CreateSchedule(this.practitioner, this.now);

  TextEditingController serviceType = TextEditingController();
  TextEditingController serviceCategory = TextEditingController();
  String patientId;
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TimeOfDay timeedit;
  String active;
  String practitionerId;
  String patientName;

  List<String> data = new List<String>();

  Map<String, dynamic> list;

  List<DateTime> date = new List<DateTime>();

  List<String> date2 = new List<String>();

  Map<String, dynamic> list2;

  var idPat;

  final format = DateFormat("dd/MM/yyyy");
  bool _validate = false;
  bool _validate2 = false;
  bool _validate3 = false;
  bool _validate4 = false;
  bool _validate5 = false;
  bool _validate6 = false;
  bool _validate7 = false;
  bool _validate8 = false;

  Future<http.Response> createSchedule() {
    return http.post(
      urlServer + '/addSchedulePractitioner',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'serviceCategory': serviceCategory.text,
        'serviceType': serviceType.text,
        'patientId': idPat.toString(),
        'practitionerId': practitioner["id"],
        'planning': dateController.toString(),
        'active': "Disabled"
      }),
    );
  }
  DateTime now;

  Future<List<dynamic>> getData2() async {
    idPat = await FlutterSession().get("id");
    var response = await http.get(
        Uri.encodeFull(urlServer + "/STU3/Schedule?actor=" + practitioner["id"]),
        headers: {"Accept": "application/json"});

    await Future.delayed(Duration(milliseconds: 15));

    list2 = json.decode(response.body);
    print("coso ciao" + now.toString());


    var time = new DateTime(now.year, now.month, now.day, 9, 0, 0, 0, 0);


      for (int j = 0; j < 18; j++) {
        date2.add(time.toString());
        time = time.add(new Duration(minutes: 30));
      }

    print('Recent sunday $time');

    DateTime dateTime;

    var i = 0;
    while (i < list2["total"]) {
      dateTime = DateTime.parse(
          list2["entry"][i]["resource"]["planningHorizon"]["start"].toString());
      print(dateTime);
      if (date2.contains(
          dateTime.toString().substring(0, dateTime.toString().indexOf('Z')))) {
        date2.remove(
            dateTime.toString().substring(0, dateTime.toString().indexOf('Z')));
      }
      i = i + 1;
    }
    print(dateTime.toString().substring(0, dateTime.toString().indexOf('Z')));
    print(date2);

    setState(() {});
    return date2;
  }


  String equalsName(String value) {
    String id;
    bool compare = false;
    var i = 0;
    while (i < data.length) {
      compare = data[i] == (value);
      if (compare) {
        id = list["entry"][i]["resource"]["id"];
      }
      i = i + 1;
    }

    setState(() {});
    return id;
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
    getData2();
  }

  String dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 5.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.teal, Colors.teal],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.list_alt_rounded,
                      size: 45,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 32, right: 32),
                      child: Text(
                        'Create a new Schedule',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 62),
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 45,
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: _validate ? Colors.red : Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ]),
                    child: TextField(
                      controller: serviceCategory,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Service Category',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 45,
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: _validate2 ? Colors.red : Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ]),
                    child: TextField(
                      controller: serviceType,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Service Type',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 80,
                    padding:
                    EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: _validate3 ? Colors.red : Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ]),
                    child: SearchableDropdown.single(
                      items:
                      date2.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: dateController.text,
                      underline: SizedBox(),
                      hint: "Date of Schedule",
                      searchHint: "Search date",
                      onChanged: (value) {
                        setState(() {
                          dateController.text = value;
                        });
                      },
                      isExpanded: true,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        serviceCategory.text.isEmpty
                            ? _validate = true
                            : _validate = false;
                        serviceType.text.isEmpty
                            ? _validate2 = true
                            : _validate2 = false;
                        dateController == null
                            ? _validate3 = true
                            : _validate3 = false;
                      });

                      if (_validate ||
                          _validate2 ||
                          _validate3) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // return object of type Dialog
                            return AlertDialog(
                              title: new Text("Form Error"),
                              content: new Text("All fields must be completed"),
                              actions: <Widget>[
                                // usually buttons at the bottom of the dialog
                                new FlatButton(
                                  child: new Text("Close"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // return object of type Dialog
                            return AlertDialog(
                              title: new Text("Form Success"),
                              content:
                                  new Text("New schedule created successfully"),
                              actions: <Widget>[
                                // usually buttons at the bottom of the dialog
                                new FlatButton(
                                  child: new Text("Close"),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ScheduleListPatient()),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );

                        this.createSchedule();
                      }
                    },
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.tealAccent,
                              Colors.teal,
                            ],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Center(
                        child: Text(
                          'Create'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
