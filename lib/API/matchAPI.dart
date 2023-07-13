import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:stuby_develop/match.dart';
import 'package:stuby_develop/main.dart' as main;
import 'package:stuby_develop/models/MatchModels.dart';
//APIのエンドポイント
//final String matchap = 'https://d1xwn0sj8q7csh.cloudfront.net/stuby/user';


//リクエスト送信
class UserMatch{
 static Future<dynamic> MatchApi() async {
   final url = Uri.parse('https://d1xwn0sj8q7csh.cloudfront.net/stuby/user/select/matching/recommendation');
   //エンドポイント続き : /select/profile/my_id/{Myuser_id}/other_id/{other_user_id}
   final response = await http.get(url);

   if(response.statusCode == 200){
     final jason = jsonDecode(response.body);
     return jason;
     // user_id: jason['user_id'],   // ユーザーID
     // user_name: jason['user_name'], // ユーザーの名前
     // user_gender: jason['user_gender'], //ユーザーの性別
     // user_old: jason['user_old'], // 年齢
     // fasubject:jason['fasuject'], //得意科目
     // wesubject: jason['wesubject'] //苦手科目
     // );
   }else{
     print('Response status: ${response.statusCode}');
   }
   //print('Response status: ${response.statusCode}');
   //print('Response body: ${response.body}');
 }
 //モデル作成
}
// class UserInfo{
//   UserInfo({
//     required this.user_id,   // ユーザーID
//     required this.user_name, // ユーザーの名前
//     required this.user_gender, //ユーザーの性別
//     required this.user_old, // 年齢
//     required this.fasubject, //得意科目
//     required this.wesubject, //苦手科目
//   });
//
//   int user_id = 00;
//   String user_name = 'ユーザー名';
//   String user_gender = '性別';
//   int user_old = 20;
//   String fasubject = '得意な教科';
//   String wesubject = '苦手な教科';
//
//   factory UserInfo
//
// }