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
    "clinicalReport": "https://www.seekpng.com/png/full/388-3880682_clinical-data-visualization-health-information-management-icon.png"
  };

  Map<String, dynamic> data;

  // receive data from the FirstScreen as a parameter
  ClinicalDetail({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(data);
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
                          IMAGE["clinicalReport"],
                        ),
                        radius: 50.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        data["resource"]["code"]["text"],
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
                                      "Clinical Status",
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
                                      data["resource"]["clinicalStatus"],
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
                    leading: Icon(Icons.code_outlined),
                    title: Text("Verification Status: " + data["resource"]["verificationStatus"],
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),


                  ListTile(
                    leading: Icon(Icons.description),
                    title: Text("Description: " + data["resource"]["note"][0]["text"] ,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),

                  ListTile(
                    leading: Icon(Icons.access_time_outlined),
                    title: Text("Issued: " + data["resource"]["note"][0]["time"],
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
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class AllergyDetail extends StatelessWidget {

  var COLORS = {
    "teal": Colors.teal,
    "acc": Colors.tealAccent,
    "?": Color(0xFFC8B2BB)
  };
  var IMAGE = {
    "clinicalReport": "https://www.seekpng.com/png/full/388-3880682_clinical-data-visualization-health-information-management-icon.png"
  };

  Map<String, dynamic> data;

  // receive data from the FirstScreen as a parameter
  AllergyDetail({Key key, @required this.data}) : super(key: key);

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
                          IMAGE["clinicalReport"],
                        ),
                        radius: 50.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        data["resource"]["code"]["text"],
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
                                      "Clinical Status",
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
                                      data["resource"]["clinicalStatus"],
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
                    leading: Icon(Icons.code_outlined),
                    title: Text("Verification Status: " + data["resource"]["verificationStatus"],
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),


                  ListTile(
                    leading: Icon(Icons.description),
                    title: Text("Type: " + data["resource"]["type"] ,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),

                  ListTile(
                    leading: Icon(Icons.access_time_outlined),
                    title: Text("Issuded: " + data["resource"]["note"][0]["time"],
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),

                  ListTile(
                    leading: Icon(Icons.access_time_outlined),
                    title: Text("Last Occurrence: " + data["resource"]["lastOccurrence"],
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}