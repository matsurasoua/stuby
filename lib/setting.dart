import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPage createState() => _SettingPage();
}

class _SettingPage extends State<SettingPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Stack(children: [
      Image.asset(
        '../assets/parupa_head.png',
        fit: BoxFit.cover,
        //width: double.infinity,
        width: MediaQuery.of(context).size.width,
        height: 150,
      ),
      Container(
        margin: EdgeInsets.only(top: 110, left: 30),
        child: CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage('../assets/parupa_icon.jpg'),
        ),
      ),
      Row(
        children: [
          Container(
            //名前コンテナ
            margin: EdgeInsets.only(top: 150, left: 130),
            //width: MediaQuery.of(context).size.width * 0.5,
            child: Text(
              'ECC太郎',
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              //年齢コンテナ
              margin: EdgeInsets.only(top: 150, left: 20),
              //width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(6)),
              child: Text(
                '10',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 30,
                ),
              ),
              padding: EdgeInsets.only(
                left: 5,
                right: 5,
              )),
        ], //children
      ),
      Container(
        //学部
        margin: EdgeInsets.only(top: 180, left: 130),
        //width: MediaQuery.of(context).size.width * 0.5,
        child: Text(
          'ECCコンピュータ専門学校',
          style: TextStyle(fontSize: MediaQuery.of(context).size.width / 30),
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 200, left: 130),
        //width: MediaQuery.of(context).size.width * 0.5,
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 5),
              child: Text(
                '好き',
                style:
                    TextStyle(fontSize: MediaQuery.of(context).size.width / 30),
              ),
            ),
            Image(
              image: AssetImage('../assets/yaj.png'),
              width: MediaQuery.of(context).size.width / 30,
              height: MediaQuery.of(context).size.width / 30,
            ),
            Container(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                '苦手',
                style:
                    TextStyle(fontSize: MediaQuery.of(context).size.width / 30),
              ),
            ),
          ],
        ),
      ),
      Row(
        children: [
          Container(
            //followコンテナ
            margin: EdgeInsets.only(top: 220, left: 130),
            //width: MediaQuery.of(context).size.width * 0.5,
            child: Text(
              'follow',
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.width / 30),
            ),
          ),
          Container(
            //いいね
            margin: EdgeInsets.only(top: 220, left: 20),
            //width: MediaQuery.of(context).size.width * 0.5,
            child: Text(
              'good',
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.width / 30),
            ),
          ),
        ], //children
      ),
      Container(
          margin: EdgeInsets.only(top: 240, left: 130),
          child: SizedBox(
            width: 75, //横幅
            height: 25, //高さ
            child: ElevatedButton(
              onPressed: () {
                // フォローする
              },
              child: Text('フォローする', style: TextStyle(fontSize: 8)),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.all(10),
              ), //style
            ),
          )),
      Container(
          margin: EdgeInsets.only(top: 240, left: 220),
          child: SizedBox(
            width: 75, //横幅
            height: 25, //高さ
            child: ElevatedButton(
              onPressed: () {
                // フォローする
              },
              child: Text('メッセージ', style: TextStyle(fontSize: 8)),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.all(10),
              ), //style
            ),
          )),
      Container(
        margin: EdgeInsets.only(top: 280),
        color: Colors.redAccent,
        child: Text(
          '                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       ',
          style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20),
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 320),
        child: TabBar(
          controller: _tabController,
          labelColor: Colors.blueAccent,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(text: '投稿'),
            Tab(text: 'メディア'),
            Tab(text: 'いいね'),
          ],
          indicatorColor: Colors.blue,
        ),
      ),
      // タブバーの下にコンテンツを追加
      Container(
        margin: EdgeInsets.only(top: 375),
        height: MediaQuery.of(context).size.height,
        child: TabBarView(
          controller: _tabController,
          children: [
            ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                Post(context),
                Post(context),
                Post(context),
                Post(context),
                Post(context),
                Post(context),
              ],
            ),
            ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                Post(context),
                Post(context),
                Post(context),
                Post(context),
                Post(context),
                Post(context),
                Post(context),
              ],
            ),
          ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              Post(context),
              Post(context),
              Post(context),
              Post(context),
              Post(context),
              Post(context),
              Post(context),
            ],
          ),
          ],
        ),
      ),
    ])));
  }

  Widget Post(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        border: Border.all(
          color: Colors.blueAccent,
          width: 3,
        ),
      ),
    );
  }
}
