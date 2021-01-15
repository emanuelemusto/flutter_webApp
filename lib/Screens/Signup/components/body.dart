import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_webapp/Screens/Login/login_screen.dart';
import 'package:flutter_webapp/Screens/Signup/components/background.dart';
import 'package:flutter_webapp/Screens/Signup/registratePatient.dart';
import 'package:flutter_webapp/components/already_have_an_account_acheck.dart';
import 'package:flutter_webapp/components/rounded_button.dart';
import 'package:flutter_webapp/components/rounded_input_field.dart';
import 'package:flutter_webapp/components/rounded_password_field.dart';
import 'package:flutter_webapp/constants.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController1 = TextEditingController();

  TextEditingController passwordController2 = TextEditingController();

  bool checkbox = false;

  Future<String> registrazione(BuildContext context) async {
    if (!(nameController.text.length >= 5 ||
        passwordController1.text.length >= 5))
      showAlertDialog(
          context, "username e password devono contenere almeno 5 caratteri");
    else if (passwordController1.text == passwordController2.text) {
      print("entrato");
      print("questo è l'username " + nameController.text);
      print("questo è la password " + passwordController1.text);
      String ruolo;
      if (!checkbox)
        ruolo = 'PATIENT';
      else
        ruolo = 'MEDIC';

      print(ruolo);

      final http.Response response = await http.post(
        'http://192.168.1.9:8183/registrazione',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': nameController.text,
          'password': passwordController1.text,
          'ruolo': ruolo,
        }),
      );
      if (response.body.toString() == "utente gia esistente") {
        showAlertDialog(context, "utente gia esistente");
      } else if (ruolo != 'MEDIC') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return SignupPatientPage(
                user: nameController.text,
              );
            },
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return LoginScreen();
            },
          ),
        );
      }
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'spunta se sei un medico',
                style: TextStyle(color: kPrimaryColor),
              ),
              Checkbox(
                activeColor: kPrimaryColor,
                value: checkbox,
                onChanged: (value) {
                  setState(() => checkbox = value);
                },
              ),
            ],
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
