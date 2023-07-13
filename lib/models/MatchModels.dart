import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:stuby_develop/API/matchAPI.dart';

//モデル作成

class UserInfo{
  int user_id = 00;
  String user_name = 'ユーザー名';
  String user_gender = '性別';
  int user_old = 20;
  String fasubject = '得意な教科';
  String wesubject = '苦手な教科';

  UserInfo({
  required this.user_id,   // ユーザーID
  required this.user_name, // ユーザーの名前
  required this.user_gender, //ユーザーの性別
  required this.user_old, // 年齢
  required this.fasubject, //得意科目
  required this.wesubject, //苦手科目
  });

  factory UserInfo.fromJson(Map<String, dynamic> json){
    return UserInfo(
      user_id: json['user_id'],
      user_name: json['user_name'],
      user_gender: json['user_gender'],
      user_old: json['user_old'],
      fasubject: json['fasubject'],
      wesubject: json['wesubject'],
    );
  }

}
