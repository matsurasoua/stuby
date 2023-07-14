//投稿画面
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:stuby_develop/login.dart';
import 'package:stuby_develop/main.dart';
import 'package:path/path.dart' as path;
import 'package:stuby_develop/datastore/post.dart';

class GlobalImg {
  static String post_img = "";
}

const String apiEndpoint = 'https://d1xwn0sj8q7csh.cloudfront.net/stuby/post/insert';
int userId = GlobalData.userId;

class SubmitPostPage extends StatefulWidget {
  const SubmitPostPage({Key? key}) : super(key: key);

  @override
  State<SubmitPostPage> createState() => _SubmitPostPageState();
}

class _SubmitPostPageState extends State<SubmitPostPage> {
  TextEditingController _postController = TextEditingController();
  File? _image;

  Future getImageFromGallery() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      final post = _postController.text;
      if (pickedFile == null) return;
      final imageTemp = File(pickedFile.path);
      final file_name = path.basename(imageTemp.path);
      // print(user_id);
      // print(post);
      // print(file_name);

      // response(user_id,post,file_name);
      setState(() => this._image = imageTemp);
      setState(() {
        GlobalImg.post_img = file_name;
      });

    }on PlatformException catch (e){
      print("しっぱい");
    }
  }


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
              width: MediaQuery
                  .of(context)
                  .size
                  .height,
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
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  margin: EdgeInsets.only(top: 20),
                  width: 350,
                  child: _image == null ? Text('') : Image.file(_image!)),
            ),
            //グレーの線追加
            Divider(
              thickness: 0.25,
              color: Colors.grey,
            ),
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 35,bottom: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: getImageFromGallery,
                      tooltip: 'Pick Image From Gallery',
                      icon: Icon(Icons.add_photo_alternate_outlined,
                          color: Colors.grey, size: 35),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(right: 30, top: 5,bottom: 10),
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
                      onPressed: () {
                        print('投稿したお～～～～～～～～～～～');
                        print('本文：' + _postController.text);
                        print(_image);
                        // test();
                        //本文+画像が未入力の場合
                        if (_image?.path == null && _postController.text == "") {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('入力エラー',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold)),
                                content: Text('"投稿本文"又は、"投稿画像"が未入力です。'),
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
                        //  本文or画像が入力されている場合
                        }else{
                          showDialog(
                            //ダイアログ表示後範囲外タッチできないようにする
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('投稿完了'),
                                content: Text('投稿完了しました！！'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed:() {

                                      create(12, _postController.text,GlobalImg.post_img);
                                      // test();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => MyApp()),
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
