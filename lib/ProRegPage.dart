import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:stuby_develop/sample_page.dart';


class ProRegPage extends StatefulWidget {
  const ProRegPage({Key? key}) : super(key: key);

  @override
  _ProRegPageState createState() => _ProRegPageState();
}

class _ProRegPageState extends State<ProRegPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _SchoolController = TextEditingController();
  TextEditingController _GreadController = TextEditingController();
  TextEditingController _FacultyController = TextEditingController();
  TextEditingController _OverViewController = TextEditingController();

  String? _selectedSubject1; // 選択された得意科目を保持する変数
  String? _selectedSubject2; // 選択された苦手科目を保持する変数
  // String? _selectedSubject3;// 選択された学びたい科目科目を保持する変数
  File? _selectedImage;
  File? _uploadImage;

  List<String> _missingFields = []; // 入力していない項目を保持するリスト

  void _register() async{
    _missingFields.clear(); // リストを初期化

    String name = _nameController.text;
    String password = _passwordController.text;
    String email = _emailController.text;
    String school = _SchoolController.text;
    String grade = _GreadController.text;
    String faculty = _FacultyController.text;
    String overview = _OverViewController.text;

    File? icon = _selectedImage;
    File? profile = _uploadImage;

    String? subject1 = _selectedSubject1; // 選択された得意科目を取得
    String? subject2 = _selectedSubject2; // 選択された苦手科目を取得

    if (name.isEmpty) {
      _missingFields.add('名前');
    }
    if (password.isEmpty) {
      _missingFields.add('パスワード');
    }
    if (email.isEmpty) {
      _missingFields.add('メールアドレス');
    }
    if (school.isEmpty) {
      _missingFields.add('学名');
    }
    if (grade.isEmpty) {
      _missingFields.add('学年');
    }
    if (faculty.isEmpty) {
      _missingFields.add('学部');
    }
    if (overview.isEmpty) {
      _missingFields.add('自己紹介');
    }
    if (_selectedSubject1 == null) {
      _missingFields.add('得意科目');
    }
    if (_selectedSubject2 == null) {
      _missingFields.add('苦手科目');
    }

    if (_missingFields.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('エラー'),
            content: Text('以下の項目を入力してください：\n${_missingFields.join(", ")}'),
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
      return; // 必須項目が入力されていない場合は登録処理を中断
    }

    // 登録処理

    // 登録後、ホーム画面に遷移
    // Navigator.pushReplacementNamed(context, '/home');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SamplePage(
          name: name,
          password: password,
          email: email,
          school: school,
          grade: grade,
          faculty: faculty,
          overview: overview,
          subject1: subject1,
          subject2: subject2,
          // subject3: subject3,
          icon: icon,
          profile: profile,
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> _pick2Image() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _uploadImage = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Image.asset('../assets/logo.png', width: 100, height: 100),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            TextButton(
              child: Text('Save'),
              onPressed: _register,
            ),
          ],
        ),
        body: Container(
          color: Color(0xFF00C8FF),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                  controller: _SchoolController,
                  decoration: InputDecoration(
                    labelText: '学名',
                  ),
                ),
                TextField(
                  controller: _FacultyController,
                  decoration: InputDecoration(
                    labelText: '学部',
                  ),
                ),
                TextField(
                  controller: _GreadController,
                  decoration: InputDecoration(
                    labelText: '学年',
                  ),
                ),
                DropdownButtonFormField<String>(
                  value: _selectedSubject1,
                  decoration: InputDecoration(
                    labelText: '得意科目',
                  ),
                  items: <String>[
                    '数学',
                    '英語',
                    '国語',
                    '理科',
                    '社会',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedSubject1 = value;
                    });
                  },
                ),
                DropdownButtonFormField<String>(
                  value: _selectedSubject2,
                  decoration: InputDecoration(
                    labelText: '苦手科目',
                  ),
                  items: <String>[
                    '数学',
                    '英語',
                    '国語',
                    '理科',
                    '社会',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedSubject2 = value;
                    });
                  },
                ),
                // DropdownButtonFormField<String>(
                //   value: _selectedSubject3,
                //   decoration: InputDecoration(
                //     labelText: '学びたい科目',
                //   ),
                //   items: <String>[
                //     '数学',
                //     '英語',
                //     '国語',
                //     '理科',
                //     '社会',
                //   ].map<DropdownMenuItem<String>>((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                //   onChanged: (value) {
                //     setState(() {
                //       _selectedSubject3 = value;
                //     });
                //   },
                // ),
                TextField(
                  controller: _OverViewController,
                  decoration: InputDecoration(
                    labelText: '自己紹介',
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 20.0),
                Text(
                  'アイコン画像を選択',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                _selectedImage != null
                    ? Image.file(
                  _selectedImage!,
                  width: 100.0,
                  height: 100.0,
                )
                    : SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: _pickImage,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'プロフィール画像を選択',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                _uploadImage != null
                    ? Image.file(
                  _uploadImage!,
                  width: 100.0,
                  height: 100.0,
                )
                    : SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: _pick2Image,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
