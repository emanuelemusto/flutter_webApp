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

class CreateMedication extends StatefulWidget {
  @override
  _CreateMedication createState() => _CreateMedication();
}

class _CreateMedication extends State<CreateMedication> {
  TextEditingController name = TextEditingController();
  TextEditingController code = TextEditingController();
  TextEditingController form = TextEditingController();
  TextEditingController dateStart = TextEditingController();
  TextEditingController dateEnd = TextEditingController();
  String patientName;
  TextEditingController amount = TextEditingController();
  String patientId;
  String practitionerId;
  TextEditingController noteController = TextEditingController();

  final format = DateFormat("dd/MM/yyyy");
  bool _validate = false;
  bool _validate2 = false;
  bool _validate3 = false;
  bool _validate4 = false;
  bool _validate5 = false;
  bool _validate6 = false;
  bool _validate7 = false;
  bool _validate8 = false;

  Future<http.Response> createMedication() {
    return http.post(
      urlServer + '/addMedication',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': list2["entry"][int.parse(code.text)]["resource"]["text"]["div"]
            .toString()
            .substring(
                list2["entry"][int.parse(code.text)]["resource"]["text"]["div"]
                        .toString()
                        .indexOf('@') +
                    1,
                list2["entry"][int.parse(code.text)]["resource"]["text"]["div"]
                        .toString()
                        .length -
                    6),
        'code': list2["entry"][int.parse(code.text)]["resource"]["code"]["text"]
            .toString(),
        'form': list2["entry"][int.parse(code.text)]["resource"]["form"]["text"]
            .toString(),
        'manufacturer': list2["entry"][int.parse(code.text)]["resource"]
                ["manufacturer"]["display"]
            .toString(),
        'dateStart': dateStart.text,
        'dateEnd': dateEnd.text,
        'patientId': patientId,
        'amount': " ",
        'note': noteController.text
      }),
    );
  }

  List<String> data = new List<String>();

  Map<String, dynamic> list;

  List<String> data2 = new List<String>();

  Future<List<dynamic>> data3;

  Map<String, dynamic> list2;

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

  Future<List<dynamic>> getMedicationApproved() async {
    var response = await http.get(
        Uri.encodeFull(urlServer + "/STU3/Medication?status=true"),
        headers: {"Accept": "application/json"});

    list2 = json.decode(response.body);
    print(list2["total"]);

    data2.clear();
    for (int i = 0; i < 7378; i++) {
      data2.add(list2["entry"][i]["resource"]["code"]["text"].toString() +
          "  " +
          list2["entry"][i]["resource"]["text"]["div"].toString().substring(
              list2["entry"][i]["resource"]["text"]["div"]
                      .toString()
                      .indexOf('@') +
                  1,
              list2["entry"][i]["resource"]["text"]["div"].toString().length -
                  6) +
          " " +
          list2["entry"][i]["resource"]["form"]["text"].toString());
    }
    return data2;
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

  String equalsMedicationName(String value) {
    String id;
    bool compare = false;
    var i = 0;
    while (i < data2.length) {
      compare = data2[i] == (value);
      if (compare) {
        id = i.toString();
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
    data3 = getMedicationApproved();
  }

  String dropdownValue;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: data3,
        builder: (context, AsyncSnapshot<List<dynamic>> load) {
          if (load.hasData) {
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
                              Icons.medical_services_outlined,
                              size: 45,
                              color: Colors.white,
                            ),
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 32, right: 32),
                              child: Text(
                                'Create new Medication',
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
                            height: 80,
                            padding: EdgeInsets.only(
                                top: 4, left: 16, right: 16, bottom: 4),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        _validate3 ? Colors.red : Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12, blurRadius: 5)
                                ]),
                            child: SearchableDropdown.single(
                              items: data2.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              value: name.text,
                              underline: SizedBox(),
                              hint: "Medication",
                              searchHint: "Search Medication",
                              onChanged: (value) {
                                setState(() {
                                  name.text = value;
                                  code.text = equalsMedicationName(value);
                                });
                              },
                              dialogBox: true,
                              isExpanded: true,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 45,
                            padding: EdgeInsets.only(
                                top: 4, left: 16, right: 16, bottom: 4),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        _validate4 ? Colors.red : Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12, blurRadius: 5)
                                ]),
                            child: DateTimeField(
                              format: format,
                              controller: dateStart,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Administration start date',
                                suffixIcon: Icon(
                                  Icons.calendar_today_sharp,
                                  size: 24,
                                ),
                              ),
                              onShowPicker: (context, currentValue) {
                                return showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1982),
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
                            height: 45,
                            padding: EdgeInsets.only(
                                top: 4, left: 16, right: 16, bottom: 4),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        _validate5 ? Colors.red : Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12, blurRadius: 5)
                                ]),
                            child: DateTimeField(
                              format: format,
                              controller: dateEnd,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Administration end date',
                                suffixIcon: Icon(
                                  Icons.calendar_today_sharp,
                                  size: 24,
                                ),
                              ),
                              onShowPicker: (context, currentValue) {
                                return showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1982),
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
                            padding: EdgeInsets.only(
                                top: 4, left: 16, right: 16, bottom: 4),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        _validate6 ? Colors.red : Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12, blurRadius: 5)
                                ]),
                            child: SearchableDropdown.single(
                              items: data.map<DropdownMenuItem<String>>(
                                  (String value) {
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
                            padding: EdgeInsets.only(
                                top: 4, left: 16, right: 16, bottom: 4),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        _validate8 ? Colors.red : Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12, blurRadius: 5)
                                ]),
                            child: TextField(
                              controller: noteController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Medical note'),
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
                                code.text.isEmpty
                                    ? _validate = true
                                    : _validate = false;
                                name.text.isEmpty
                                    ? _validate2 = true
                                    : _validate2 = false;
                                form == null
                                    ? _validate3 = true
                                    : _validate3 = false;
                                dateStart.text.isEmpty
                                    ? _validate4 = true
                                    : _validate4 = false;
                                dateEnd.text.isEmpty
                                    ? _validate5 = true
                                    : _validate5 = false;
                                patientName == null
                                    ? _validate6 = true
                                    : _validate6 = false;
                                amount.text.isEmpty
                                    ? _validate7 = true
                                    : _validate7 = false;
                                noteController.text.isEmpty
                                    ? _validate8 = true
                                    : _validate8 = false;
                              });

                              if (_validate ||
                                  _validate2 ||
                                  _validate3 ||
                                  _validate4 ||
                                  _validate5 ||
                                  _validate6 ||
                                  _validate7 ||
                                  _validate8) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    // return object of type Dialog
                                    return AlertDialog(
                                      title: new Text("Form Error"),
                                      content: new Text(
                                          "All fields must be completed"),
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
                                          "New patient's medication created successfully"),
                                      actions: <Widget>[
                                        // usually buttons at the bottom of the dialog
                                        new FlatButton(
                                          child: new Text("Close"),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MedicationList(
                                                          data: list["entry"][k]
                                                              ["resource"])),
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );

                                this.createMedication();
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: Center(
                                child: Text(
                                  'Create'.toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
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
          } else {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
        });
  }
}
