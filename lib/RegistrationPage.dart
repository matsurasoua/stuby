import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String apiEndpoint = 'https://hvpjsk6o6g.execute-api.us-east-2.amazonaws.com/stuby/user/insert'; // API

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _schoolController = TextEditingController();
  TextEditingController _facultyController = TextEditingController();
  TextEditingController _SYearController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  String? _selectedGender; // 選択された性別を保持する変数
  String? _selectedSubject1; // 選択された得意科目を保持する変数
  String? _selectedSubject2; // 選択された苦手科目を保持する変数
  String? _userID; // ユーザーIDを保持する変数

  List<String> _missingFields = []; // 入力していない項目を保持するリスト

  Future<void> _register() async {
    _missingFields.clear(); // リストを初期化

    String name = _nameController.text;
    String password = _passwordController.text;
    String email = _emailController.text;
    String school = _schoolController.text;
    String faculty = _facultyController.text;
    String SYear = _SYearController.text;
    String age = _ageController.text;
    String? gender = _selectedGender; // 選択された性別を取得
    String? subject1 = _selectedSubject1; // 選択された得意科目を取得
    String? subject2 = _selectedSubject2; // 選択された苦手科目を取得

    int userID = 0;

    // 必須項目のバリデーションチェック
    if (name.isEmpty) {
      _missingFields.add('名前');
    }
    if (age.isEmpty) {
      _missingFields.add('年齢');
    }
    if (password.isEmpty) {
      _missingFields.add('パスワード');
    }
    if (email.isEmpty) {
      _missingFields.add('メールアドレス');
    }
    if (school.isEmpty) {
      _missingFields.add('学校');
    }
    if (faculty.isEmpty) {
      _missingFields.add('学部');
    }
    if (SYear.isEmpty) {
      _missingFields.add('学年');
    }
    if (_selectedGender == null) {
      _missingFields.add('性別');
    }
    if (_selectedSubject1 == null) {
      _missingFields.add('得意科目');
    }
    if (_selectedSubject2 == null) {
      _missingFields.add('苦手科目');
    }

    // リクエストのバリデーションチェックとエラーダイアログの表示
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
      return;
    }

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
      'user_name': name,
      'user_email': email,
      'user_passwd': password,
      'user_old': age is List<int>,
      'user_school_name': school,
      'user_faculty': faculty,
      'user_schoolyear': SYear is List<int>,
      'user_gender': gender,
      'fasubject': subject1,
      'wesubject': subject2,
    };

// APIリクエストを送信
    http.Response response = await http.post(
      Uri.parse(apiEndpoint),
      body: json.encode(requestData),
      headers: {'Content-Type': 'application/json'},
    );

    // APIレスポンスのステータスコードを取得
    int statusCode = response.statusCode;
    print('レスポンスステータスコード: $statusCode');
    print('レスポンスボディ: ${response.body}');

    final responseData = jsonDecode(response.body);
    int userId = responseData['login_user_id'];
    // print(responseData['login_user_id']);
    if (statusCode == 201) {
      // APIレスポンスのユーザーIDを取得
      // レスポンスの処理を行うことができます
      Navigator.pushNamed(context, '/login');

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('新規登録'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('../assets/stubyHeader.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '名前',
                  style: TextStyle(fontSize: 16),
                ),
                TextFormField(
                  controller: _nameController,
                  maxLength: 25,
                  decoration: InputDecoration(
                    hintText: '名前を入力してください',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '年齢(例:18歳 = 18)',
                  style: TextStyle(fontSize: 16),
                ),
                TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  decoration: InputDecoration(
                    hintText: '年齢を入力してください ',
                    border: OutlineInputBorder(),
                  ),
                ),
                Text(
                  'パスワード',
                  style: TextStyle(fontSize: 16),
                ),
                TextFormField(
                  controller: _passwordController,
                  maxLength: 25,
                  decoration: InputDecoration(
                    hintText: 'パスワードを入力してください',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 10),
                Text(
                  'メールアドレス',
                  style: TextStyle(fontSize: 16),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'メールアドレスを入力してください',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '学校',
                  style: TextStyle(fontSize: 16),
                ),
                TextFormField(
                  controller: _schoolController,
                  decoration: InputDecoration(
                    hintText: '学校を入力してください',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '学部',
                  style: TextStyle(fontSize: 16),
                ),
                TextFormField(
                  controller: _facultyController,
                  decoration: InputDecoration(
                    hintText: '学部を入力してください',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '学年(例:1年生 = 1)',
                  style: TextStyle(fontSize: 16),
                ),
                TextFormField(
                  controller: _SYearController,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  decoration: InputDecoration(
                    hintText: '学年を入力してください',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '性別',
                  style: TextStyle(fontSize: 16),
                ),
                DropdownButton<String>(
                  value: _selectedGender,
                  hint: Text('性別を選択してください'),
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                  items: <String>['男性', '女性', 'その他']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),
                Text(
                  '得意科目',
                  style: TextStyle(fontSize: 16),
                ),
                DropdownButton<String>(
                  value: _selectedSubject1,
                  hint: Text('得意科目を選択してください'),
                  onChanged: (value) {
                    setState(() {
                      _selectedSubject1 = value;
                    });
                  },
                  items: <String>[
                    '数学',
                    '英語',
                    '国語',
                    '社会',
                    '理科'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),
                Text(
                  '苦手科目',
                  style: TextStyle(fontSize: 16),
                ),
                DropdownButton<String>(
                  value: _selectedSubject2,
                  hint: Text('苦手科目を選択してください'),
                  onChanged: (value) {
                    setState(() {
                      _selectedSubject2 = value;
                    });
                  },
                  items: <String>[
                    '数学',
                    '英語',
                    '国語',
                    '社会',
                    '理科'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                Center( // 中央にボタンを配置
                  child: ElevatedButton(
                    child: const Text('進む'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlueAccent,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: _register,
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container( //フッター
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('../assets/stubyFooetr.png'),
                fit: BoxFit.cover,
              ),
            ),
            height: 100
        ),
      ),
    );
  }
}
