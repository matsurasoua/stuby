import 'package:flutter/material.dart';
import 'match.dart';

const List<String> Subject = <String>['こだわらない','国語', '数学', '英語', '理科', '社会'];
const List<String> Gender = <String>['こだわらない','男性','女性'];

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String isSelectedValue = Subject.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Color.fromRGBO(228, 252, 255, 1),
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
                Container(
                  margin: EdgeInsets.only(left: 80),
                    child:TextButton(
                    onPressed: () {
                    // ボタンが押されたときの処理
                    //絞り込み内容を保存してmatch.dartにもどる
                    //return MatchPage();
                  },
                  child: Text('Save'),
                ),
                ),
              ],
            ),
          ),
        ),
      body: Column(
        children: <Widget>[
          DropdownButton(
            padding: EdgeInsets.only(left: 60),
            items: Subject.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            value: isSelectedValue,
            onChanged: (String? value) {
              setState(() {
                isSelectedValue = value!;
              });
            },
          ),
          DropdownButton(
            padding: EdgeInsets.only(left: 60),
            items: Gender.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            value: isSelectedValue,
            onChanged: (String? value) {
              setState(() {
                isSelectedValue = value!;
              });
            },
          ),
        ],
      ),
    );
  }
}