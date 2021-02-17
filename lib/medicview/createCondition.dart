import 'dart:async';
import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../Screens/Login/login_screen.dart';
import '../constants.dart';
import '../patientdetails.dart';

export 'createPatient.dart';

class CreateCondition extends StatefulWidget {
  @override
  _CreateCondition createState() => _CreateCondition();
}

class _CreateCondition extends State<CreateCondition> {
  TextEditingController name = TextEditingController();
  String clinicalStatus;
  String patientId;
  TextEditingController dateController = TextEditingController();
  String verificationStatus;
  String practitionerId;
  String patientName;
  TextEditingController description = TextEditingController();

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
  bool _validate9 = false;

  Future<http.Response> createDiagnosticReport() {
    return http.post(
      urlServer + '/addCondition',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name.text,
        'clinicalStatus': clinicalStatus,
        'patientId': patientId,
        'date': dateController.text,
        'verificationStatus': verificationStatus,
        'description': description.text,
      }),
    );
  }

  Future<List<dynamic>> getData() async {
    dynamic token = await FlutterSession().get("token");
    dynamic user = await FlutterSession().get("username");
    var response = await http.get(
        Uri.encodeFull(urlServer +
            "/STU3/Patient?family=" +
            "c" +
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
    print(list["total"]);

    data.clear();
    var i = 0;
    while (i < list["total"]) {
      data.add(
        list["entry"][i]["resource"]["name"][0]["family"] +
            " " +
            list["entry"][i]["resource"]["name"][0]["given"][0] +
            " " +
            list["entry"][i]["resource"]["birthDate"] +
            " " +
            list["entry"][i]["resource"]["id"],
      );
      i = i + 1;
    }

    setState(() {});
    return data;
  }

  var k;

  String equalsName(String value) {
    String id;
    bool compare = false;
    var i = 0;

    while (i < data.length) {
      compare = data[i] == (value);
      if (compare) {
        id = list["entry"][i]["resource"]["id"];
        k = i;
      }
      i = i + 1;
    }

    setState(() {});
    return id;
  }

  @override
  void initState() {
    super.initState();
    getData();
    String dropdownValue = 'UNKNOWN';
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
                        'Create a new Patient\'s Condition',
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
            SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: 45,
              padding: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
              decoration: BoxDecoration(
                  border:
                      Border.all(color: _validate2 ? Colors.red : Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
              child: TextField(
                controller: name,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Name',
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: 45,
              padding: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
              decoration: BoxDecoration(
                  border:
                      Border.all(color: _validate3 ? Colors.red : Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
              child: DropdownButton<String>(
                hint: Text("Clinical Status"),
                underline: Container(
                  height: 0,
                  color: Colors.tealAccent,
                ),
                value: clinicalStatus,
                onChanged: (String newValue) {
                  setState(() {
                    clinicalStatus = newValue;
                  });
                },
                items: <String>['ACTIVE', 'INACTIVE', 'NULL', 'RESOLVED']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: 5, //
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: 45,
              padding: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
              decoration: BoxDecoration(
                  border:
                      Border.all(color: _validate5 ? Colors.red : Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
              child: DropdownButton<String>(
                hint: Text("Verification Status"),
                underline: Container(
                  height: 0,
                  color: Colors.tealAccent,
                ),
                value: verificationStatus,
                onChanged: (String newValue) {
                  setState(() {
                    verificationStatus = newValue;
                  });
                },
                items: <String>[
                  'CONFIRMED',
                  'DIFFERENTIAL',
                  'NULL',
                  'REFUTED',
                  'UNKNOWN'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: 5, //
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: 45,
              padding: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
              decoration: BoxDecoration(
                  border:
                      Border.all(color: _validate4 ? Colors.red : Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
              child: DateTimeField(
                format: format,
                controller: dateController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Date',
                  suffixIcon: Icon(
                    Icons.calendar_today_sharp,
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
              width: MediaQuery.of(context).size.width / 1.2,
              height: 80,
              padding: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
              decoration: BoxDecoration(
                  border:
                      Border.all(color: _validate6 ? Colors.red : Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
              child: SearchableDropdown.single(
                items: data.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                value: patientName,
                underline: SizedBox(),
                hint: "Patient",
                searchHint: "Search Patient",
                onChanged: (value) {
                  setState(() {
                    patientName = value;
                    patientId = equalsName(value);
                  });
                },
                isExpanded: true,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: 45,
              padding: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
              decoration: BoxDecoration(
                  border:
                      Border.all(color: _validate7 ? Colors.red : Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
              child: TextField(
                controller: description,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'description',
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  clinicalStatus.isEmpty
                      ? _validate3 = true
                      : _validate3 = false;
                  name.text.isEmpty ? _validate2 = true : _validate2 = false;
                  dateController.text.isEmpty
                      ? _validate4 = true
                      : _validate4 = false;
                  verificationStatus.isEmpty
                      ? _validate5 = true
                      : _validate5 = false;
                  patientId == null ? _validate6 = true : _validate6 = false;
                  description.text.isEmpty
                      ? _validate7 = true
                      : _validate7 = false;
                });

                if (_validate2 ||
                    _validate3 ||
                    _validate4 ||
                    _validate5 ||
                    _validate6 ||
                    _validate7) {
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
                        content: new Text(
                            "New Patient\'s Condition created successfully"),
                        actions: <Widget>[
                          // usually buttons at the bottom of the dialog
                          new FlatButton(
                            child: new Text("Close"),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ClinicalData(
                                        data: list["entry"][k]["resource"])),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );

                  this.createDiagnosticReport();
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
    );
  }
}
