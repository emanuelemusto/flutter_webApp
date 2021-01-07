import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_webapp/Screens/Login/login_screen.dart';
import 'package:flutter_webapp/Screens/Signup/components/background.dart';
import 'package:flutter_webapp/components/already_have_an_account_acheck.dart';
import 'package:flutter_webapp/components/rounded_button.dart';
import 'package:flutter_webapp/components/rounded_input_field.dart';
import 'package:flutter_webapp/components/rounded_password_field.dart';
import 'package:http/http.dart' as http;

class Body extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController1 = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();

  Future<String> registrazione(BuildContext context) async {
    if (!(nameController.text.length >= 5 ||
        passwordController1.text.length >= 5))
      showAlertDialog(
          context, "username e password devono contenere almeno 5 caratteri");
    else if (passwordController1.text == passwordController2.text) {
      print("entrato");
      print("questo è l'username " + nameController.text);
      print("questo è la password " + passwordController1.text);

      final http.Response response = await http.post(
        'http://192.168.1.13:8183/registrazione',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': nameController.text,
          'password': passwordController1.text,
        }),
      );
      print("stato " + response.statusCode.toString());
      print("body " + response.body.toString());
    } else {
      showAlertDialog(context, "Le Password non coincidono");
    }
  }

  showAlertDialog(BuildContext context, String message) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Dati errati"),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Registrazione",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          SvgPicture.asset(
            "assets/icons/signup.svg",
            height: size.height * 0.3,
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          RoundedInputField(
            controller: nameController,
            hintText: "Username",
            onChanged: (value) {},
          ),
          RoundedPasswordField(
            controller: passwordController1,
            onChanged: (value) {},
          ),
          RoundedPasswordField(
            controller: passwordController2,
            onChanged: (value) {},
          ),
          RoundedButton(
            text: "Registarti",
            press: () {
              registrazione(context);
            },
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              })
        ],
      ),
    ));
  }
}
