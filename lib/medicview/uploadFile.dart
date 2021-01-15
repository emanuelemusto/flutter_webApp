import 'dart:convert';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

import 'package:flutter/material.dart';
import 'package:universal_html/prefer_universal/html.dart' as html;

class ImagePickerLabPage extends StatefulWidget {
  @override
  _ImagePickerLabPageState createState() => _ImagePickerLabPageState();
}

class _ImagePickerLabPageState extends State<ImagePickerLabPage> {
  String name = '';
  String error;
  Uint8List data;

  pickImage() {
    final html.InputElement input = html.document.createElement('input');
    input
      ..type = 'file'
      ..accept = 'image/*';

    input.onChange.listen((e) {
      if (input.files.isEmpty) return;
      final reader = html.FileReader();
      reader.readAsDataUrl(input.files[0]);
      reader.onError.listen((err) =>
          setState(() {
            error = err.toString();
          }));
      reader.onLoad.first.then((res) {
        final encoded = reader.result as String;
        // remove data:image/*;base64 preambule
        final stripped =
        encoded.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');

        setState(() {
          name = input.files[0].name;
          data = base64.decode(stripped);
          error = null;
        });
      });
    });

    uploadImage(name, data);
    input.click();
  }

  Future<bool> uploadImage(String imageFilePath,
      Uint8List imageBytes,) async {
    String url = "http://192.168.1.11:8183/uploadFile";
    PickedFile imageFile = PickedFile(imageFilePath);
    var stream =
    new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));

    var uri = Uri.parse(url);
    int length = imageBytes.length;
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('files', stream, length,
        filename: basename(imageFile.path),
        contentType: MediaType('image', 'png'));

    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(name),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.open_in_browser),
          onPressed: () {
            pickImage();
          },
        ),
        body: Center(
          child: error != null
              ? Text(error)
              : data != null ? Image.memory(data) : Text('No data...'),
        ),
      );
    }
  }