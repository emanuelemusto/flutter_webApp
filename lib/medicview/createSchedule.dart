import 'dart:math';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_webapp/patientList.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

export 'createPatient.dart';

class CreateSchedule extends StatefulWidget {
  @override
  _CreateSchedule createState() => _CreateSchedule();
}

class _CreateSchedule extends State<CreateSchedule> {

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
      'http://192.168.1.11:8183/addSchedulePractitioner',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'serviceCategory': serviceCategory.text,
        'serviceType': serviceType.text,
        'patientId': patientId,
        'practitionerId': practitionerId,
        'planning': dateController.text + " " + timeController.text,
        'active': active
      }),
    );
  }

  Future<List<dynamic>> getData() async {

    var response = await http.get(
        Uri.encodeFull("http://192.168.1.11:8183/STU3/Patient?family=" + "c"), //TODO aspettando l'id del medico
        headers: {
          "Accept": "application/json"
        }
    );

    await Future.delayed(Duration(milliseconds: 15));


    list = json.decode(response.body);
    print(list["total"]);

    data.clear();
    var i = 0;
    while (i < list["total"]) {
      data.add(
        list["entry"][i]["resource"]["name"][0]["family"] + " " + list["entry"][i]["resource"]["name"][0]["given"][0] + " " +  list["entry"][i]["resource"]["birthDate"],
      );
      i=i+1;
    }


    setState(() {});
    return data;
  }

  String equalsName(String value) {

    String id;
    bool compare = false;
    var i = 0;
    while (i < data.length) {
      compare = data[i] == (value);
      if(compare) {
        id = list["entry"][i]["resource"]["id"];
      }
      i=i+1;
    }


    setState(() {});
    return id;
  }

  Future<Null> _selectedTime(BuildContext context) async {
    timeedit = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );

    final localizations = MaterialLocalizations.of(context);
    final formattedTimeOfDay = localizations.formatTimeOfDay(timeedit);


    if (timeedit != null) {
      setState(() {
        DateTime date= DateFormat.jm().parse(formattedTimeOfDay);
        timeController.text = DateFormat("HH:mm").format(date);
      });
    }
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
    getData();
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
              height: MediaQuery.of(context).size.height/5.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.teal,
                    Colors.teal
                  ],
                ),

              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Icon(Icons.list_alt_rounded,
                      size: 45,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 32,
                          right: 32
                      ),
                      child: Text('Create a new Schedule',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
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
                    width: MediaQuery.of(context).size.width/1.2,
                    height: 45,
                    padding: EdgeInsets.only(
                        top: 4,left: 16, right: 16, bottom: 4
                    ),
                    decoration: BoxDecoration(

                        border: Border.all(color: _validate ? Colors.red : Colors.white),
                        borderRadius: BorderRadius.all(
                            Radius.circular(50)
                        ),

                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5
                          )
                        ]
                    ),
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
                    width: MediaQuery.of(context).size.width/1.2,
                    height: 45,
                    padding: EdgeInsets.only(
                        top: 4,left: 16, right: 16, bottom: 4
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: _validate2 ? Colors.red : Colors.white),
                        borderRadius: BorderRadius.all(
                            Radius.circular(50)
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5
                          )
                        ]
                    ),
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
                    width: MediaQuery.of(context).size.width/1.2,
                    height: 45,
                    padding: EdgeInsets.only(
                        top: 4,left: 16, right: 16, bottom: 4
                    ),

                    decoration: BoxDecoration(
                        border: Border.all(color: _validate4 ? Colors.red : Colors.white),
                        borderRadius: BorderRadius.all(
                            Radius.circular(50)
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5
                          )
                        ]
                    ),
                    child: DateTimeField(
                      format: format,
                      controller: dateController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Date of schedule',
                        suffixIcon: Icon(Icons.calendar_today_sharp,
                          size: 24,
                        ),
                      ),

                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2100));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width/1.2,
                    height: 45,
                    padding: EdgeInsets.only(
                        top: 4,left: 16, right: 16, bottom: 4
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: _validate5 ? Colors.red : Colors.white),
                        borderRadius: BorderRadius.all(
                            Radius.circular(50)
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5
                          )
                        ]
                    ),
                    child: TextField(
                      controller: timeController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Hour of schedule',
                        suffixIcon: Icon(Icons.access_time_outlined,
                          size: 24,
                        ),
                      ),

                      onTap: () => _selectedTime(context),
                    ),

                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/1.2,
                    height: 45,
                    padding: EdgeInsets.only(
                        top: 4,left: 16, right: 16, bottom: 4
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: _validate6 ? Colors.red : Colors.white),
                        borderRadius: BorderRadius.all(
                            Radius.circular(50)
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5
                          )
                        ]
                    ),
                    child: DropdownButton<String>(
                      hint:  Text("Patient"),
                      value: patientName,
                      underline: Container(
                        height: 0,
                        color: Colors.tealAccent,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          patientId = equalsName(newValue);
                          patientName = newValue;
                        });
                      },
                      items: data.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/1.2,
                    height: 45,
                    padding: EdgeInsets.only(
                        top: 4,left: 16, right: 16, bottom: 4
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: _validate6 ? Colors.red : Colors.white),
                        borderRadius: BorderRadius.all(
                            Radius.circular(50)
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5
                          )
                        ]
                    ),
                    child: DropdownButton<String>(
                      hint:  Text("Active"),
                      value: active,
                      underline: Container(
                        height: 0,
                        color: Colors.tealAccent,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          active = newValue;
                        });
                      },
                      items: <String>['Active', 'Disabled'].map<DropdownMenuItem<String>>((String value) { //TODO
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),



                  InkWell(
                    onTap: (){
                      setState(() {
                        serviceCategory.text.isEmpty ? _validate = true : _validate = false;
                        serviceType.text.isEmpty ? _validate2 = true : _validate2 = false;
                        patientId == null ? _validate3 = true : _validate3 = false;
                        dateController.text.isEmpty ? _validate4 = true : _validate4 = false;
                        timeController.text.isEmpty ? _validate5 = true : _validate5 = false;
                        active == null ? _validate6 = true : _validate6 = false;

                      });

                      if(_validate & _validate2 & _validate3 & _validate4 & _validate5 & _validate6) {
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
                              content: new Text("New schedule created successfully"),
                              actions: <Widget>[
                                // usually buttons at the bottom of the dialog
                                new FlatButton(
                                  child: new Text("Close"),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => MyHomePage()), //TODO
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
                      width: MediaQuery.of(context).size.width/1.2,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.tealAccent,
                              Colors.teal,
                            ],
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(50)
                          )
                      ),
                      child: Center(
                        child: Text('Create'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
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