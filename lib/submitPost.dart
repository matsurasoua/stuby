//投稿画面
import 'package:flutter/material.dart';

class SubmitPostPage extends StatelessWidget {
  const SubmitPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.close),
            color: Colors.lightBlueAccent,
            onPressed: () => Navigator.pop(context),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Center(
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5, left: 85), // 上部に8のマージンを追加
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
        body: SingleChildScrollView(
          child: Column(),
        )
    );
  }
}
