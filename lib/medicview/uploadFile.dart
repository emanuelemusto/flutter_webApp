import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_webapp/patientdetails.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../constants.dart';

class FileUploadApp extends StatefulWidget {
  FileUploadApp({Key key, @required this.data}) : super(key: key);
  Map<String, dynamic> data;
  @override
  createState() => _FileUploadAppState(data: data);
}

class _FileUploadAppState extends State<FileUploadApp> {
  _FileUploadAppState({Key key, @required this.data});
  Map<String, dynamic> data;
  List<int> _selectedFile;
  Uint8List _bytesData;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  startWebFilePicker() async {
    html.InputElement uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      final file = files[0];
      final reader = new html.FileReader();

      reader.onLoadEnd.listen((e) {
        _handleResult(reader.result);
      });
      reader.readAsDataUrl(file);
    });
  }

  void _handleResult(Object result) {
    setState(() {
      _bytesData = Base64Decoder().convert(result.toString().split(",").last);
      _selectedFile = _bytesData;
    });
  }

  Future<String> makeRequest() async {
    var url = Uri.parse(
        urlServer + "/uploadFile");
    var request = new http.MultipartRequest("POST", url);
    request.files.add(await http.MultipartFile.fromBytes('file', _selectedFile,
        contentType: new MediaType('application', 'octet-stream'),
        filename: DateTime.now().year.toString() + DateTime.now().month.toString() + DateTime.now().day.toString() + DateTime.now().hour.toString() + DateTime.now().minute.toString() + DateTime.now().second.toString() + ".jpg"));

    request.send().then((response) {
      print("test");
      print(response.statusCode);
      if (response.statusCode == 200) print("Uploaded!");
    });

    showDialog(
        barrierDismissible: false,
        context: context,
        child: new AlertDialog(
          title: new Text("Details"),
          //content: new Text("Hello World"),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text("Upload successful"),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Close'),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => DiagnosticData(
                      data: data)),
                      (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('A Flutter Web file picker'),
        ),
        body: Center(
          child: new Form(
            autovalidate: true,
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 28),
              child: new Container(
                  width: 350,
                  child: Column(children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          MaterialButton(
                            color: Colors.teal,
                            elevation: 8,
                            highlightElevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            textColor: Colors.white,
                            child: Text('Select a file'),
                            onPressed: () {
                              startWebFilePicker();
                            },
                          ),
                          Divider(
                            color: Colors.teal,
                          ),
                          RaisedButton(
                            color: Colors.tealAccent,
                            elevation: 8.0,
                            textColor: Colors.white,
                            onPressed: () {
                              makeRequest();
                            },
                            child: Text('Send file to server'),
                          ),
                        ])
                  ])),
            ),
          ),
        ),
      ),
    );
  }
}