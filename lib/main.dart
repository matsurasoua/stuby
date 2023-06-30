//appbarとnavigationbar
import 'package:flutter/material.dart';
import 'home.dart';
import 'match.dart';
import 'chat.dart';
import 'com.dart';
import 'setting.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stuby-勉強マッチング-',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // 選択中フッターメニューのインデックスを一時保存する用変数
  int selectedIndex = 0;

  // 切り替える画面のリスト
  List<Widget> display = [
    HomePage(),
    MatchPage(),
    ChatPage(),
    ComPage(),
    SettingPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ヘッダーメニュー
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top:5), // 上部に8のマージンを追加
                  child: Image.asset(
                    '../assets/logo.png',
                    width: 80,
                    height: 80,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: display[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(
                  Icons.home_rounded,
                  color: selectedIndex == 0
                  ? Colors.lightBlueAccent
                  : Colors.grey,
                  size: 30,
                ),
                label: 'ホーム', // ラベルのテキストスタイルを指定
              ),
              BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  icon: Icon(
                    Icons.find_in_page_outlined,
                    color: selectedIndex == 1
                        ? Colors.lightBlueAccent
                        : Colors.grey,
                    size: 30,
                  ),
                  label: 'マッチング'),
              BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  icon: Icon(
                    Icons.message_outlined,
                    color: selectedIndex == 2
                        ? Colors.lightBlueAccent
                        : Colors.grey,
                    size: 30,
                  ),
                  label: 'チャット'),
              BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  icon: Icon(
                    Icons.share_rounded,
                    color: selectedIndex == 3
                        ? Colors.lightBlueAccent
                        : Colors.grey,
                    size: 30,
                  ),
                  label: 'コミュニティ'),
              BottomNavigationBarItem(
                  backgroundColor: Colors.white,
                  icon: Icon(
                    Icons.person,
                    color: selectedIndex == 4
                        ? Colors.lightBlueAccent
                        : Colors.grey,
                    size: 30,
                  ),
                  label: 'プロフィール'),
            ],
            // 現在選択されているフッターメニューのインデックス
            currentIndex: selectedIndex,
            // フッター領域の影
            elevation: 0,
            // フッターメニュータップ時の処理
            onTap: (int index) {
              selectedIndex = index;
              setState(() {});
            },
            // 選択中フッターメニューの色
            fixedColor: Colors.grey
        ));
  }
}
