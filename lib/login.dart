import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GlobalData {
  static int userId = 0;
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final String apiURL = 'https://hvpjsk6o6g.execute-api.us-east-2.amazonaws.com/stuby/user/login';

  bool isLoggedIn = false;

  Future<void> login() async {
    Map<String, dynamic> requestBody = {
      'user_email': emailController.text,
      'user_passwd': passwordController.text,
    };

    final response = await http.post(
      Uri.parse(apiURL),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    print('レスポンスボディ: ${response.body}');
    print('レスポンスステータスコード: ${response.statusCode}');

    final responseData = jsonDecode(response.body);
    int statusCode = response.statusCode;
    // int userId = responseData['login_user_id'];



    if (statusCode == 200) {
      setState(() {
        isLoggedIn = true;
        GlobalData.userId = responseData['login_user_id']; // userIdをグローバル変数に代入
        Navigator.pushNamed(context, '/ProReg');
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ログインエラー'),
            content: Text('正しいログイン情報を入力してください。'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );

      setState(() {
        isLoggedIn = false;
        GlobalData.userId = 0;
      });
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/stuby_BG.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Image.asset('assets/title.png'),
            ),
          ),
          Center(
            child: Container(
              width: 300,
              height: 300,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    child: const Text('ログイン'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlueAccent,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: login,
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}