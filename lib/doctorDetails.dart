import 'dart:math';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_webapp/patientview/createSchedule.dart';
import 'package:http/http.dart' as http;
import 'diagnosticDetail.dart';
import 'clinicalDetail.dart';
import 'medicationDetails.dart';

// ignore: must_be_immutable
class DoctorDetails extends StatelessWidget {

  var COLORS = {
    "male": Color(0xFF9ae1ca),
    "female": Color(0xFFDF53A6),
    "?": Color(0xFFC8B2BB)
  };
  var IMAGE = {
    "male": "https://library.kissclipart.com/20190406/cwq/kissclipart-surgeon-icon-png-clipart-computer-icons-clip-art-e1b95eb686c71747.jpg",
    "female": "https://library.kissclipart.com/20190406/cwq/kissclipart-surgeon-icon-png-clipart-computer-icons-clip-art-e1b95eb686c71747.jpg",
    "?": "https://library.kissclipart.com/20190406/cwq/kissclipart-surgeon-icon-png-clipart-computer-icons-clip-art-e1b95eb686c71747.jpg",
    "null": "https://library.kissclipart.com/20190406/cwq/kissclipart-surgeon-icon-png-clipart-computer-icons-clip-art-e1b95eb686c71747.jpg",
  };


  Map<String, dynamic> list;
  var data;

  // receive data from the FirstScreen as a parameter
  DoctorDetails({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [COLORS[data["gender"]], COLORS[data["gender"]]]
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
                          data["name"][0]["family"] + " " + data["name"][0]["given"][0],
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
                                        "Gender",
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
                                        data["gender"],
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
                                        "Birth Date",
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
                                        data["birthDate"],
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
                                        data["resourceType"],
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
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: data["telecom"] == null ? 0 : data["telecom"].length,
                        itemBuilder: (BuildContext content, int index) {
                          return ListTile(
                            leading: Icon(Icons.phone_rounded),
                            title: Text(data["telecom"][index]["value"] + ' (' +  data["telecom"][index]["use"] + ')',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          );
                        }
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount:  data["address"] == null ? 0 : data["address"].length,
                        itemBuilder: (BuildContext content, int index) {
                          return ListTile(
                            leading: Icon(Icons.home),
                            title: Text(data["address"][index]["line"][0] + ', ' + data["address"][index]["city"] + ', ' +  data["address"][index]["postalCode"] + ' (' + data["address"][index]["use"] + ')',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          );
                        }
                    ),

                    ListView.builder(
                        shrinkWrap: true,
                        itemCount:  data["qualification"].length == null ? 0 : data["qualification"].length,
                        itemBuilder: (BuildContext content, int index) {
                          return ListTile(
                            leading: Icon(Icons.work),
                            title: Text("Qualification: " + data["qualification"][index]["code"]["text"],
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          );
                        }
                    ),

                    ListView.builder(
                        shrinkWrap: true,
                        itemCount:  data["qualification"].length == null ? 0 : data["qualification"].length,
                        itemBuilder: (BuildContext content, int index) {
                          return ListTile(
                            leading: Icon(Icons.work),
                            title: Text("Issues: " + data["qualification"][index]["issuer"]["reference"],
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          );
                        }
                    ),

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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CreateSchedule(practitioner: data)),
                      );
                    },
                    color: COLORS[data["gender"]],
                    child: Text("Request Schedule"),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
