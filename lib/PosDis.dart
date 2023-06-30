//投稿詳細画面
import 'package:flutter/material.dart';

class PosDisPage extends StatelessWidget {
  final String name;
  final String image;
  final String time;
  final String image_post;
  final String post;

  const PosDisPage({Key? key,
    required this.name,
    required this.image,
    required this.time,
    required this.image_post,
    required this.post,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(228, 252, 255, 1),
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
                  '../assets/logo.png',
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
            Post(context),
            for (int i = 0; i < 8; i++) ...{
              Reply(context),
            }
          ],
        ),
      ),
    );
  }

  Widget Post(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        // constraints: BoxConstraints.tightFor(height: double.infinity),
        child: Column(
          children: [
            Stack(
              children: [
                //トプ画
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(top: 20, left: 20),
                    child: CircleAvatar(
                      radius: 28.0,
                      backgroundImage: AssetImage(image),
                    ),
                  ),
                ),
                //時間
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(top: 30, right: 25),
                    child: Text(
                      time,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                //名前
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(top: 37, right: 65, left: 90),
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              //投稿内容
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.only(right: 15, left: 90),
                  child: Text(
                    post,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              //投稿画像
              child:Align(
                alignment: Alignment.topCenter,
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(image_post),
                  ),
                  margin: EdgeInsets.only(top: 20,bottom: 30,left: 20,right: 20),
                ),
              ),
            ),
            //icon達
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite_border,
                          size: 23,
                          color: Colors.pink,
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(bottom: 20, right:26),
                  ),
                  Container(
                    child: Icon(
                      Icons.mode_comment_outlined,
                      size: 23,
                      color: Colors.lightBlueAccent,
                    ),
                    margin: EdgeInsets.only(bottom: 16,right: 30),
                  ),
                  Container(
                    child:Image.asset(
                      "../assets/share.png",
                    ),
                    margin: EdgeInsets.only(bottom: 18, right: 35),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Reply(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.13,
      width: MediaQuery.of(context).size.width * 0.93,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
    );
  }
}


