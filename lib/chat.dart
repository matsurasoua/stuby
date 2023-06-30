import 'package:flutter/material.dart';
class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('チャット')),
      color: Colors.green[200],
    );
  }
}