import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_webapp/Screens/Login/components/background.dart';
import 'package:flutter_webapp/Screens/Signup/signup_screen.dart';
import 'package:flutter_webapp/components/already_have_an_account_acheck.dart';
import 'package:flutter_webapp/components/rounded_button.dart';
import 'package:flutter_webapp/components/rounded_input_field.dart';
import 'package:flutter_webapp/components/rounded_password_field.dart';
import 'package:flutter_webapp/constants.dart';
import 'package:flutter_webapp/patientList.dart';
import 'package:flutter_webapp/patientview/patientHomeScreen.dart';
import 'package:flutter_webapp/utente.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:flutter_session/flutter_session.dart';

class Body extends StatelessWidget {
  User user;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  User parseUser(String body) {
    Map<String, dynamic> map = json.decode(body);

    return User.fromJson(map);
  }

  Future<void> saveData(http.Response response) async {
    print("tutu " + parseUser(response.body).token.toString());
    user = parseUser(response.body);

    var session = FlutterSession();
    await session.set("token", user.token);
    await session.set("username", user.username);
    await session.set("role", user.role);

    dynamic token = await FlutterSession().get("role");

    print(token);
  }

  Future<String> login(BuildContext context) async {
    //genero un token casuale
    Random random = new Random();
    int token = random.nextInt(100); // from 0 upto 99 included

    print(" token " + token.toString());
    final http.Response response = await http.post(
      'http://127.0.0.1:8183/login',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': nameController.text,
        'password': passwordController.text,
        'token': token.toString(),
      }),
    );
    saveData(response);
    print(user.role);
    if (user.role == 'MEDIC') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return MyHomePage(title: 'Patient List');
          },
        ),
      );
    }

    if (user.role == 'PATIENT') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return PatientHomePage();
          },
        ),
      );
    }
    print("stato " + response.statusCode.toString());
    print("body " + response.body.toString());
    //print("ecco " + json.decode(response.body));
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
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            /*SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),*/
            SizedBox(
              height: size.height * 0.03,
            ),
            RoundedInputField(
              controller: nameController,
              hintText: "Il tuo Username",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              controller: passwordController,
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                login(context);
                print(nameController.text);
                print(passwordController.text);
              },
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            AlreadyHaveAnAccountCheck(
                login: true,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
                      },
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
