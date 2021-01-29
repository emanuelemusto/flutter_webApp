import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MedicationDetails extends StatelessWidget {

  var COLORS = {
    "teal": Colors.teal,
    "acc": Colors.tealAccent,
    "?": Color(0xFFC8B2BB)
  };
  
  var IMAGE = {
    "medication": "https://th.bing.com/th/id/OIP.4F_lAFt40gwk4B3am7P0DwHaHa?pid=Api&rs=1"
  };

  Map<String, dynamic> data;

  // receive data from the FirstScreen as a parameter
  MedicationDetails({Key key, @required this.data}) : super(key: key);

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
                          IMAGE["medication"],
                        ),
                        radius: 50.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        data["text"]["div"].toString().substring(data["text"]["div"].toString().indexOf('@') + 1,  data["text"]["div"].toString().indexOf('#')),
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
                                      data["id"],
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
                                      "Manufacturer",
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
                                      data["manufacturer"]["display"],
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
                  ListTile(
                    leading: Icon(Icons.medical_services_outlined),
                    title: Text("Form: " + data["form"]["text"],
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),

                  ListTile(
                    leading: Icon(Icons.calendar_today_outlined),
                    title: Text("Administration date start: " + data["text"]["div"].toString().substring(42, 53),
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),

                  ListTile(
                    leading: Icon(Icons.calendar_today_outlined),
                    title: Text("Administration date end: " + data["text"]["div"].toString().substring(56, 64),
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),

                  ListTile(
                    leading: Icon(Icons.pending_actions),
                    title: Text("Medical Note: " + data["text"]["div"].toString().substring(data["text"]["div"].toString().indexOf('#') + 1, data["text"]["div"].toString().length -  6),
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