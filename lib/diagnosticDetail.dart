import 'dart:math';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'medicview/createPatient.dart';

// ignore: must_be_immutable
class ClinicalDetail extends StatelessWidget {

  var COLORS = {
    "teal": Colors.teal,
    "acc": Colors.tealAccent,
    "?": Color(0xFFC8B2BB)
  };
  var IMAGE = {
    "male": "data:image/jpeg;base64,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",
    "female": "https://www.kindpng.com/picc/m/163-1636340_user-avatar-icon-avatar-transparent-user-icon-png.png",
    "?": "data:image/jpeg;base64,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",
    "null" : "https://vistapointe.net/images/white-wallpaper-8.jpg"
  };


  Map<String, dynamic> list;
  var data;

  // receive data from the FirstScreen as a parameter
  ClinicalDetail({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [COLORS["teal"], COLORS["teal"]]
                  )
              ),
              child: Container(
                width: double.infinity,
                height: 350.0,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          IMAGE[data["gender"]],
                        ),
                        radius: 50.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        data["resource"]["text"],
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Card(
                        margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 22.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(

                                  children: <Widget>[
                                    Text(
                                      "Id",
                                      style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      data["resource"]["id"],
                                      style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontSize: 18.0,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(

                                  children: <Widget>[
                                    Text(
                                      "status",
                                      style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      data["resource"]["status"],
                                      style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontSize: 18.0,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(

                                  children: <Widget>[
                                    Text(
                                      "Resource Type",
                                      style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      data["resource"]["resourceType"],
                                      style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontSize: 18.0,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.phone_rounded),
                          title: Text(data["resource"]["category"]["coding"][0],
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ),

                        ListTile(
                          leading: Icon(Icons.access_time_outlined),
                          title: Text("Issuded: " + data["resource"]["issued"] ,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        )


                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          ButtonBar(
            mainAxisSize: MainAxisSize.max,
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonTheme(
                minWidth: 200.0,
                height: 50.0,
                child: RaisedButton(
                  onPressed: () {

                  },
                  color: Colors.grey,
                  child: Text("Info Patient"),
                ),
              ),
              ButtonTheme(
                minWidth: 200.0,
                height: 50.0,
                child: RaisedButton(
                  color: COLORS[data["gender"]],
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ClinicalData(data: data)),
                    );
                  },
                  child: Text("Clinical Data"),
                ),
              ),
              ButtonTheme(
                minWidth: 200.0,
                height: 50.0,
                child: RaisedButton(
                  color: COLORS[data["gender"]],
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DiagnosticData(data: data)),
                    );
                  },
                  child: Text("Diagnostic Data"),
                ),
              ),
              ButtonTheme(
                minWidth: 200.0,
                height: 50.0,
                child: RaisedButton(
                  color: COLORS[data["gender"]],
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MedicationList(data: data)),
                    );
                  },
                  child: Text("Medication"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}