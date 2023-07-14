import 'package:flutter/material.dart';
import 'package:stuby_develop/RegistrationPage.dart';
import 'package:stuby_develop/login.dart';
import 'package:stuby_develop/ProRegPage.dart';
import 'package:stuby_develop/home.dart';
import 'package:stuby_develop/main.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => RegistrationPage(),
        '/ProReg': (context) => ProRegPage(),
        '/home': (context) => Main(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 250,
                  height: 350,
                  child: Image.asset('assets/title.png'),
                ),
                OutlinedButton(
                  child: const Text('新規登録'),
                  style: OutlinedButton.styleFrom(
                    primary: Colors.white,
                    shape: const StadiumBorder(),
                    side: const BorderSide(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                ),
    // Flutter1.22以降のみ
                TextButton(
                  child: const Text('ログイン'),
                  style: TextButton.styleFrom(
                  primary: Colors.white,
                  ),
                  onPressed: () {
                   Navigator.pushNamed(context, '/login');
                  },
                ),
                // TextButton(
                //   child: const Text('新規登録ページ(Debug用)'),
                //   style: TextButton.styleFrom(
                //     primary: Colors.white,
                //   ),
                //   onPressed: () {
                //     Navigator.pushNamed(context, '/ProReg');
                //   },
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
