import 'package:flutter/material.dart';
import 'dart:io';

class SamplePage extends StatelessWidget {
  final String name;
  final String password;
  final String email;
  final String school;
  final String grade;
  final String faculty;
  final String overview;
  final String? subject1;
  final String? subject2;
  // final String? subject3;
  final File? icon;
  final File? profile;

  SamplePage({
    required this.name,
    required this.password,
    required this.email,
    required this.school,
    required this.grade,
    required this.faculty,
    required this.overview,
    required this.subject1,
    required this.subject2,
    // required this.subject3,
    required this.icon,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('サンプルページ'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('名前: $name'),
            Text('パスワード: $password'),
            Text('メールアドレス: $email'),
            Text('学名: $school'),
            Text('学年: $grade'),
            Text('学部: $faculty'),
            Text('自己紹介: $overview'),
            Text('得意科目: $subject1'),
            Text('苦手科目: $subject2'),
            // Text('学びたい科目: $subject3'),
            SizedBox(height: 16.0),
            if (icon != null)
              Image.file(
                icon!,
                fit: BoxFit.cover,
                width: 200,
                height: 150,
              ),
            SizedBox(height: 16.0),
            if (profile != null)
              Image.file(
                profile!,
                fit: BoxFit.cover,
                width: 200,
                height: 150,
              ),
          ],
        ),
      ),
    );
  }
}
