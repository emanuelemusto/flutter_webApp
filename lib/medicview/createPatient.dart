import 'dart:math';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

export 'createPatient.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  TextEditingController familynameController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  String gender;
  TextEditingController dateController = TextEditingController();
  TextEditingController telecomValueController = TextEditingController();
  String telecomUse;
  TextEditingController addressLineController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postCodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  String addressUse;

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
  bool _validate10 = false;
  bool _validate11 = false;

  Future<http.Response> createPatient() {
    return http.post(
      'http://192.168.1.15:8183/addpatient',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'firstname': firstnameController.text,
        'familyname': familynameController.text,
        'gender': gender,
        'date': dateController.text,
        'telecomValue': telecomValueController.text,
        'telecomUse': telecomUse,
        'addressLine': addressLineController.text,
        'city':  cityController.text,
        'postCode': postCodeController.text,
        'country': countryController.text,
        'addressUse': addressUse,
      }),
    );
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
    String dropdownValue = 'One';
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
                    child: Icon(Icons.person,
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
                      child: Text('Create new Patient',
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
                      controller: firstnameController,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.drive_file_rename_outline),
                        border: InputBorder.none,
                        hintText: 'First name',
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
                      controller: familynameController,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.drive_file_rename_outline),
                        border: InputBorder.none,
                        hintText: 'Family name',
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
                      hint: Text("Gender"),

                      underline: Container(
                        height: 0,
                        color: Colors.tealAccent,

                      ),
                      value: gender,
                      /*icon: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.arrow_downward,
                              size: 24,
                              color: Colors.teal)
                      ),*/
                      onChanged: (String newValue) {
                        setState(() {
                          gender = newValue;
                        });
                      },
                      items: <String>['male', 'female', 'other']
                          .map<DropdownMenuItem<String>>((String value) {
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
                        hintText: 'Date of birth',
                        suffixIcon: Icon(Icons.calendar_today_sharp,
                                size: 24,
                        ),
                      ),

                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                            context: context,
                            firstDate: DateTime(1900),
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
                      controller: telecomValueController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Telecom value',
                        suffixIcon: Icon(Icons.phone_rounded),
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
                      hint:  Text("Telecom use"),
                      value: telecomUse,
                      underline: Container(
                        height: 0,
                        color: Colors.tealAccent,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          telecomUse = newValue;
                        });
                      },
                      items: <String>['home', 'work', 'old', 'mobile']
                          .map<DropdownMenuItem<String>>((String value) {
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
                    child: TextField(
                      controller: addressLineController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Address line',
                        suffixIcon: Icon(Icons.add_road),
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
                    child: TextField(
                      controller: cityController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'City',
                        suffixIcon: Icon(Icons.location_city_sharp)
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
                      controller: postCodeController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Post code',
                        suffixIcon: Icon(Icons.local_post_office_outlined)
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
                        border: Border.all(color: _validate10 ? Colors.red : Colors.white),
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
                      controller: countryController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Country',
                        suffixIcon: Icon(Icons.flag_outlined)
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
                        border: Border.all(color: _validate11 ? Colors.red : Colors.white),
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
                      hint:  Text("Address use"),
                      value: addressUse,
                      underline: Container(
                        height: 0,
                        color: Colors.tealAccent,
                      ),

                      onChanged: (String newValue) {
                        setState(() {
                          addressUse = newValue;
                        });
                      },
                      items: <String>['home', 'work', 'old']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),


                  InkWell(
                    onTap: (){
                      setState(() {
                        firstnameController.text.isEmpty ? _validate = true : _validate = false;
                        familynameController.text.isEmpty ? _validate2 = true : _validate = false;
                        gender == null ? _validate3 = true : _validate = false;
                        dateController.text.isEmpty ? _validate4 = true : _validate = false;
                        telecomValueController.text.isEmpty ? _validate5 = true : _validate = false;
                        telecomUse == null ? _validate6 = true : _validate = false;
                        addressLineController.text.isEmpty ? _validate7 = true : _validate = false;
                        cityController.text.isEmpty ? _validate8 = true : _validate = false;
                        postCodeController.text.isEmpty ? _validate9 = true : _validate = false;
                        countryController.text.isEmpty ? _validate10 = true : _validate = false;
                        addressUse == null ? _validate11 = true : _validate = false;

                      });

                      if(_validate & _validate2 & _validate3 & _validate4 & _validate5 & _validate6 & _validate7 & _validate8 & _validate9
                      & _validate10 & _validate11) {
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
                              content: new Text("New patient created successfully"),
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

                        this.createPatient();

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