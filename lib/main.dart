import 'dart:math';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'medicview/createPatient.dart';

void main() => runApp(new MyApp());

var COLORS = {
  "male": Color(0xFF9ae1ca),
  "female": Color(0xFFDF53A6),
  "?": Color(0xFFC8B2BB)
};
var IMAGE = {
  "male": "https://p.kindpng.com/picc/s/78-786207_user-avatar-png-user-avatar-icon-png-transparent.png",
  "female": "https://www.kindpng.com/picc/m/163-1636340_user-avatar-icon-avatar-transparent-user-icon-png.png",
  "?": "https://p.kindpng.com/picc/s/78-786207_user-avatar-png-user-avatar-icon-png-transparent.png",
  "null" : "https://vistapointe.net/images/white-wallpaper-8.jpg"
};
List data;
class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: new MyHomePage(title: 'Patient List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;


  @override
  _MyHomePageState createState() => new _MyHomePageState();


}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController editingController = TextEditingController();


  List<dynamic> data = new List<dynamic>();

  Map<String, dynamic> list;

  Future<List<dynamic>> getData(String name) async {

    var response = await http.get(
        Uri.encodeFull("http://192.168.1.15:8183/STU3/Patient?family=" + name),
        headers: {
          "Accept": "application/json"
        }
    );

    await Future.delayed(Duration(seconds: 1));


    list = json.decode(response.body);
    print(list["total"]);

    data.clear();
    var i = 0;
    while (i < list["total"]) {
      data.add({
        "title": list["entry"][i]["resource"]["name"][0]["family"] + " " + list["entry"][i]["resource"]["name"][0]["given"][0],
        "content": "Birth date: " + list["entry"][i]["resource"]["birthDate"],
        "color": COLORS[list["entry"][i]["resource"]["gender"]],
        "image": IMAGE[list["entry"][i]["resource"]["gender"]]
      });
      i=i+1;
    }

    data.add({
      "title": "     ",
      "content": "    ",
      "color": Colors.white,
      "image": IMAGE["null"]
    });

    return data;
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignupPage()), //TODO
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
      appBar: new AppBar(
        elevation: 0.0,
        title: new Text(
          "Patient List",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: new Stack(
        children: <Widget>[
          new Transform.translate(
            offset: new Offset(0.0, MediaQuery.of(context).size.height * 0.22000),
            child: new ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (BuildContext content, int index) {
                return GestureDetector(
                  onTap: () {
                    print(list["entry"][index]);
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SecondRoute(data: list["entry"][index]["resource"])),
                    );
                  },
                  child: PatientListItem(
                      title: data[index]["title"],
                      content: data[index]["content"],
                      color: data[index]["color"],
                      image: data[index]["image"],

                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 36 + 33.0,
            left: 5,
            right: 5,
            child: TextField(
              cursorColor: Colors.teal,
              onChanged: (value) {
                this.getData(value);
                setState(() {});
              },
              controller: editingController,
              decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)))),

            ),
          ),

          new Transform.translate(
            offset: Offset(0.0, -56.0),
            child: new Container(
              padding: EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                bottom: 56.0,
              ),
              height: 120.0,
              decoration: BoxDecoration(
                color: Colors.teal,
              ),

                child: new Stack(
                  children: [
                    new Opacity(
                      opacity: 0.2,
                      child: new Container(color: COLORS[0]),
                    ),
                    new Transform.translate(
                      offset: Offset(0.0, 50.0),
                      child: new ListTile(  //TODO
                        leading: new CircleAvatar(
                          child: new Container(
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                              image: new DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: NetworkImage(
                                    "https://www.shareicon.net/data/512x512/2016/09/01/822712_user_512x512.png"),
                              ),
                            ),
                          ),
                        ),
                        title: new Text(
                          "Wealcome Medical X", //TODO add medical name
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              letterSpacing: 2.0),
                        ),
                        subtitle: new Text(
                          "Medical Role", //TODO add medical role
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 10.0,
                              letterSpacing: 2.0),
                        ),

                      ),
                    ),
                  ],
                ),


            ),
          )
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = new Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height / 4.75);
    p.lineTo(0.0, size.height / 4.75);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class PatientListItem extends StatefulWidget {
  String title;
  String content;
  Color color;
  String image;

  PatientListItem({this.title, this.content, this.color, this.image});


  @override
  _PatientListItemState createState() => new _PatientListItemState();
}

class _PatientListItemState extends State<PatientListItem> {
  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Container(width: 10.0, height: 190.0, color: widget.color),
        new Expanded(
          child: new Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
            child: new Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  widget.title,
                  style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: new Text(
                    widget.content,
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
        new Container(
          height: 150.0,
          width: 150.0,
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              new Transform.translate(
                offset: new Offset(50.0, 0.0),
                child: new Container(
                  height: 100.0,
                  width: 100.0,
                  color: widget.color,
                ),
              ),
              new Transform.translate(
                offset: Offset(10.0, 20.0),
                child: new Card(
                  child: new Container(
                    height: 120.0,
                    width: 120.0,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            width: 10.0,
                            color: Colors.white,
                            style: BorderStyle.solid),
                        image: DecorationImage(
                          image: NetworkImage(widget.image),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/*
class SecondRoutetttt extends StatelessWidget {
  final int id;

  // receive data from the FirstScreen as a parameter
  SecondRoutetttt({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text(
        id.toString(),
        style: TextStyle(fontSize: 24),
      ),
          ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ]
      ),
    );
  }
}
*/

// ignore: must_be_immutable
class SecondRoute extends StatelessWidget {

  var COLORS = {
    "male": Color(0xFF9ae1ca),
    "female": Color(0xFFDF53A6),
    "?": Color(0xFFC8B2BB)
  };
  var IMAGE = {
    "male": "https://p.kindpng.com/picc/s/78-786207_user-avatar-png-user-avatar-icon-png-transparent.png",
    "female": "https://www.kindpng.com/picc/m/163-1636340_user-avatar-icon-avatar-transparent-user-icon-png.png",
    "?": "https://p.kindpng.com/picc/s/78-786207_user-avatar-png-user-avatar-icon-png-transparent.png",
    "null" : "https://vistapointe.net/images/white-wallpaper-8.jpg"
  };


  Map<String, dynamic> list;
  var data;

  // receive data from the FirstScreen as a parameter
  SecondRoute({Key key, @required this.data}) : super(key: key);

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
                                      "BirthDate",
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

                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: 300.00,


            child: RaisedButton(
                onPressed: (){},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)
                ),
                elevation: 0.0,
                padding: EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [COLORS[data["gender"]], COLORS[data["gender"]]]
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: Text("switch button ",
                      style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight:FontWeight.w300),
                    ),
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }
}



