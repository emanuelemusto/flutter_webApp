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
import 'package:http/http.dart' as http;

class Body extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<String> login() async {
    print("entarto ");
    final http.Response response = await http.post(
      'http://192.168.1.13:8183/login',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': nameController.text,
        'password': passwordController.text,
      }),
    );
    print("stato " + response.statusCode.toString());
    print("body " + response.body.toString());
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
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
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
                login();
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
