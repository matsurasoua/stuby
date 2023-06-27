import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // APIのエンドポイントURL
  final String apiURL = 'https://hvpjsk6o6g.execute-api.us-east-2.amazonaws.com/stuby/user/login';

  // ログイン状態を保持する変数
  bool isLoggedIn = false;
  int userId = 0;

  // ログインAPIにリクエストを送信するメソッド
  Future<void> login() async {
    // リクエストのボディデータを作成
    Map<String, dynamic> requestBody = {
      'user_email': emailController.text,
      'user_passwd': passwordController.text,
    };

    // リクエストを送信
    final response = await http.post(
      Uri.parse(apiURL),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    // レスポンスを出力
    print('レスポンスステータスコード: ${response.statusCode}');
    print('レスポンスボディ: ${response.body}');

    // レスポンスを解析
    final responseData = jsonDecode(response.body);
    int statusCode = response.statusCode;
    int userId = responseData['login_user_id'];
    String message = responseData['message'];

    if (statusCode == 200) {
      // ログイン成功
      setState(() {
        isLoggedIn = true;
        this.userId = userId;
        print('aaa');
        Navigator.pushNamed(context, '/signup');
      });
    } else {
      // ログイン失敗
      setState(() {
        isLoggedIn = false;
        this.userId = 0;
        print('bbb');
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
                  isLoggedIn
                      ? Text('ようこそ$userIdさん！')
                      : Text('ログインしてください'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
