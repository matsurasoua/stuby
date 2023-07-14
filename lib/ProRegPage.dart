import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:stuby_develop/login.dart';
import 'package:stuby_develop/RegistrationPage.dart';
import 'package:minio_new/minio.dart';
import 'package:flutter/services.dart';

final minio = Minio(
  endPoint: 'https://stuby-eteam.s3.amazonaws.com/images',
  region: 'us-east-1',
  accessKey: 'AKIA4QEAAAZWMHC4WGT7',
  secretKey: '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',
);

class ProRegPage extends StatefulWidget {
  ProRegPage({Key? key}) : super(key: key);

  @override
  _ProRegPageState createState() => _ProRegPageState();
}

class _ProRegPageState extends State<ProRegPage> {

  int userId = GlobalData.userId; // GlobalDataのuserIdを取得
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _schoolController = TextEditingController();
  TextEditingController _gradeController = TextEditingController();
  TextEditingController _facultyController = TextEditingController();
  TextEditingController _overviewController = TextEditingController();

  String? _updateImageName;
  String? _selectedImageName;
  String? _selectedSubject1;
  String? _selectedSubject2;
  File? _selectedImage;
  File? _uploadImage;
  File? icon;
  File? profile;

  String? iconName = "";
  String? profileName = "";


  void uploadedImage() async {
    final byteData = await rootBundle.load(profile.toString());
    Stream<Uint8List> imageBytes = Stream.value(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    await minio.putObject(
      'stuby-eteam',
      profileName!,
      imageBytes,
    );
  }

  void selectImage() async {
    final byteData = await rootBundle.load(icon.toString());
    Stream<Uint8List> imageBytes = Stream.value(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    await minio.putObject(
      'stuby-eteam',
      iconName!,
      imageBytes,
    );
  }

  void _register() async {

    String name = _nameController.text;
    String password = _passwordController.text;
    String email = _emailController.text;
    String school = _schoolController.text;
    String grade = _gradeController.text;
    String faculty = _facultyController.text;
    String overview = _overviewController.text;

    icon = _selectedImage ;
    profile = _uploadImage;

    String? subject1 = _selectedSubject1;
    String? subject2 = _selectedSubject2;

    iconName = _updateImageName;
    profileName = _selectedImageName;

    uploadedImage();
    selectImage();

    print(iconName);
    print(profileName);
    print(icon);
    print(profile);
    // APIリクエストの送信
    final url = 'https://hvpjsk6o6g.execute-api.us-east-2.amazonaws.com/stuby/user/update';
    int userId = GlobalData.userId;

    print(userId);
    // メールアドレスのバリデーションチェックとエラーダイアログの表示
    if (!email.contains('@')) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('エラー'),
            content: Text('正しいメールアドレスを入力してください'),
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
      return;
    }

// APIリクエストのボディデータを作成
    Map<String, dynamic> requestData = {
      "user_id" : userId, //ユーザーのid
      "user_name": name, //ユーザーの名前
      "user_email" : email, //ユーザーのメールアドレス
      "user_passwd" : password, //ユーザーのパスワード
      "user_school_name" : school, //学校名
      "user_faculty" : faculty, //学校のコース名
      "user_schoolyear": grade, //学年
      "fasubject" : subject1, //得意科目(教えれる科目)
      "wesubject" : subject2, //苦手科目(教えてほしい科目)
      "icon_img" : iconName, //ユーザーのアイコン画像ファイル名(小さい丸い方)
      "pro_img" : profileName, //ユーザーのプロフィール画像ファイル名(長方形の方)
      "user_intro" : overview //ユーザーの自己紹介
      //"user_status" : Boolean
    };

// APIリクエストを送信
    http.Response response = await http.put(
      Uri.parse(url),
      body: json.encode(requestData),
      headers: {'Content-Type': 'application/json'},
    );

    // APIレスポンスのステータスコードを取得
    int statusCode = response.statusCode;
    print('レスポンスステータスコード: $statusCode');
    print('レスポンスボディ: ${response.body}');
    if (statusCode == 204) {
      // APIレスポンスのユーザーIDを取得
      // レスポンスの処理を行うことができます
      Navigator.pushNamed(context, '/home');

    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('エラー'),
            content: Text('APIリクエストが失敗しました。ステータスコード：$statusCode'),
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
    }



  }



  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
        _selectedImageName = pickedImage.name;
      });
    }
  }

  Future<void> _pick2Image() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _uploadImage = File(pickedImage.path);
        _updateImageName = pickedImage.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    print(userId);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Image.asset('assets/logo.png', width: 100, height: 100),
          centerTitle: true,
          leading: TextButton(
            child: Text('戻る'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            TextButton(
              child: Text('Save'),
              onPressed: _register,
            )
          ],
        ),
        backgroundColor: Colors.blue[50],
        body: Container(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton.icon(
                  icon: Icon(Icons.camera_alt),
                  label: Text('プロフィール画像を選択'),
                  onPressed: _pick2Image,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                if (_uploadImage != null)
                  Image.file(
                    _uploadImage!,
                    fit: BoxFit.cover,
                    width: 200,
                    height: 150,
                  ),
                SizedBox(height: 16.0),
                ElevatedButton.icon(
                  icon: Icon(Icons.photo_library),
                  label: Text('アイコン画像を選択'),
                  onPressed: _pickImage,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                if (_selectedImage != null)
                  Image.file(
                    _selectedImage!,
                    fit: BoxFit.cover,
                    width: 200,
                    height: 150,
                  ),
                SizedBox(height: 16.0),
                TextField(
                  maxLength: 25,
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: '名前',
                  ),
                ),
                TextField(
                  maxLength: 25,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'パスワード',
                  ),
                  obscureText: true,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'メールアドレス',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'メールアドレスを入力してください';
                    }
                    if (!value.contains('@')) {
                      return '正しいメールアドレスを入力してください';
                    }
                    return null;
                  },
                ),
                TextField(
                  controller: _schoolController,
                  decoration: InputDecoration(
                    labelText: '学名',
                  ),
                ),
                TextField(
                  controller: _facultyController,
                  decoration: InputDecoration(
                    labelText: '学部',
                  ),
                ),
                TextField(
                  controller: _gradeController,
                  decoration: InputDecoration(
                    labelText: '学年',
                  ),
                ),
                DropdownButtonFormField<String>(
                  value: _selectedSubject1,
                  decoration: InputDecoration(
                    labelText: '得意科目',
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedSubject1 = newValue;
                    });
                  },
                  items: <String>[
                    '国語',
                    '数学',
                    '英語',
                    '理科',
                    '社会',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                DropdownButtonFormField<String>(
                  value: _selectedSubject2,
                  decoration: InputDecoration(
                    labelText: '苦手科目',
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedSubject2 = newValue;
                    });
                  },
                  items: <String>[
                    '国語',
                    '数学',
                    '英語',
                    '理科',
                    '社会',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                TextFormField(
                  controller: _overviewController,
                  maxLength: 160,
                  decoration: InputDecoration(
                    labelText: '自己紹介',
                  ),
                  maxLines: null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ProRegPage(),
  ));
}


