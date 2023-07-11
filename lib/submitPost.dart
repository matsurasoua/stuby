//投稿画面
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker_web/image_picker_web.dart';

class SubmitPostPage extends StatefulWidget {
  const SubmitPostPage({Key? key}) : super(key: key);

  @override
  State<SubmitPostPage> createState() => _SubmitPostPageState();
}

class _SubmitPostPageState extends State<SubmitPostPage> {
  TextEditingController _postController = TextEditingController();

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
                  'assets/logo.png',
                  width: 80,
                  height: 80,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.height,
              height: 40,
              color: Colors.white,
              child: Text(
                '投稿',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              color: Color.fromRGBO(228, 252, 255, 1),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30),
              child: TextFormField(
                controller: _postController,
                // maxLength: 160,本番は160文字
                //テスト用で今は10文字
                maxLength: 160,
                decoration: InputDecoration(
                  hintText: 'テキスト',
                  border: InputBorder.none,
                ),
                maxLines: null,
                focusNode: FocusNode()..requestFocus(),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Stack(
                children: [
                  Container(
                    child: Image.asset('assets/hamesu.png'),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 0.2,
              color: Colors.grey,
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(right: 12),
                width: 70,
                child: ElevatedButton(
                  child: const Text('投稿',
                      style: TextStyle(
                        fontSize: 14,
                      )),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlueAccent,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
