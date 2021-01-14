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

class CreateAllergy extends StatefulWidget {
  @override
  _CreateAllergy createState() => _CreateAllergy();
}

class _CreateAllergy extends State<CreateAllergy> {

  TextEditingController name = TextEditingController();
  String clinicalStatus;
  String verificationStatus;
  String patientId;
  String category;
  TextEditingController issueddateController = TextEditingController();
  TextEditingController lastOccurencedateController = TextEditingController();
  String practitionerId;
  String patientName;
  String type;
  TextEditingController note = TextEditingController();


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
    print(issueddateController.text);
    return http.post(
      'http://192.168.1.11:8183/addAllergy',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name.text,
        'clinicalStatus': clinicalStatus,
        'verificationStatus' : verificationStatus,
        'patientId': patientId,
        'issueddate' : issueddateController.text,
        'lastOccurencedate': lastOccurencedateController.text,
        'category' : category,
        'type' : type,
        'note' : note.text
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
                      child: Text('Create a new Allergy Intolerance',
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

            SizedBox(
              height: 15,
            ),

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
                items: <String>['ACTIVE', 'INACTIVE', 'NULL','RESOLVED']
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
              width: MediaQuery.of(context).size.width/1.2,
              height: 45,
              padding: EdgeInsets.only(
                  top: 4,left: 16, right: 16, bottom: 4
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: _validate3 ? Colors.red : Colors.white),
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
                items: <String>['CONFIRMED', 'UNCONFIRMED', 'REFUTED','ENTEREDINERROR', 'NULL']
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
              child: DropdownButton<String>(
                hint: Text("Category"),

                underline: Container(
                  height: 0,
                  color: Colors.tealAccent,

                ),
                value: category,
                onChanged: (String newValue) {
                  setState(() {
                    category = newValue;
                  });
                },
                items: <String>['INTOLERANCE', 'ALLERGY', 'NULL']
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
              width: MediaQuery.of(context).size.width/1.2,
              height: 45,
              padding: EdgeInsets.only(
                  top: 4,left: 16, right: 16, bottom: 4
              ),
              decoration: BoxDecoration(
                  border: Border.all(color: _validate8 ? Colors.red : Colors.white),
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
                hint: Text("Type"),

                underline: Container(
                  height: 0,
                  color: Colors.tealAccent,

                ),
                value: type,
                onChanged: (String newValue) {
                  setState(() {
                    type = newValue;
                  });
                },
                items: <String>['BIOLOGIC', 'FOOD', 'ENVIRONMENT', 'MEDICATION', 'NULL']
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
              child: DateTimeField(
                format: format,
                controller: issueddateController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Issued date',
                  suffixIcon: Icon(Icons.calendar_today_sharp,
                    size: 24,
                  ),
                ),

                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1950),
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
              child: DateTimeField(
                format: format,
                controller: lastOccurencedateController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Last occurrence date',
                  suffixIcon: Icon(Icons.calendar_today_sharp,
                    size: 24,
                  ),
                ),

                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1950),
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
                  border: Border.all(color: _validate7 ? Colors.red : Colors.white),
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
                  border: Border.all(color: _validate9 ? Colors.red : Colors.white),
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
                controller: note,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Note',
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),


            InkWell(
              onTap: (){
                setState(() {
                  name.text.isEmpty ? _validate = true : _validate = false;
                  clinicalStatus.isEmpty ? _validate2 = true : _validate2 = false;
                  verificationStatus.isEmpty ? _validate3 = true : _validate3 = false;
                  category.isEmpty ? _validate4 = true : _validate4 = false;
                  issueddateController.text.isEmpty ? _validate5 = true : _validate5 = false;
                  lastOccurencedateController.text.isEmpty ? _validate6 = true : _validate6 = false;
                  patientName.isEmpty ? _validate7 = true : _validate7 = false;
                  type.isEmpty ? _validate8 = true : _validate8 = false;
                  note.text.isEmpty ? _validate9 = true : _validate9 = false;

                });

                if(_validate & _validate2 & _validate3 & _validate4 & _validate5 & _validate6 & _validate7 & _validate8 & _validate9) {
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
                        content: new Text("New Allergy Intolerance created successfully"),
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

                  this.createDiagnosticReport();

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
    );
  }
}