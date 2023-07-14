import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<int> create(int user_id, String post_sentence,String post_img) async{
  final response = await http.post(
    Uri.parse("https://d1xwn0sj8q7csh.cloudfront.net/stuby/post/insert"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'user_id': user_id,
      'post_sentence':post_sentence,
      'post_img':post_img,
    }),

  );

  if (response.statusCode == 201) {
    print(response.statusCode);
    return 1;
  } else {
    print(response.statusCode);
    throw Exception("しっぱい");
  }

}
