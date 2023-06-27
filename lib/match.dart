import 'package:flutter/material.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({Key? key}) : super(key: key);

  @override
  _MatchPageState createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage>
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
      body: Column(
        children: <Widget>[
          TabBar(
            controller: _tabController,
            labelColor: Colors.blueAccent,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'おすすめ'),
              Tab(text: 'オンライン中'),
              Tab(text: '距離順'),
            ],
            indicatorColor: Colors.blue,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                GridView.count(
                  padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: <Widget>[
                    for (int i = 0; i < 50; i++) ...{Prof(context)}
                  ],
                ),
                GridView.count(
                  padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: <Widget>[
                    for (int i = 0; i < 50; i++) ...{Prof(context)}
                  ],
                ),
                GridView.count(
                  padding: EdgeInsets.only(left: 10, top: 10, right: 10),
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: <Widget>[
                    //取ってきたユーザーの数だけまわす
                    for (int i = 0; i < 50; i++) ...{Prof(context)}
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget Prof(BuildContext context) {
    return Stack(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image(
          image: AssetImage('../assets/gogo.png'),
          fit: BoxFit.cover,
          width: 140,
          height: 140,
        ),
      ),
      Container(
          margin: EdgeInsets.only(top: 90),
          height: 70,
          width: 140,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Stack(
            children: <Widget>[
              //Container(
              //   height: 125,
              //   width: 500,
              //   color: Colors.red,
              // ),
              // コンテナの下半分
              //マッチングユーザー名
              Container(
                margin: EdgeInsets.only(bottom: 6, left: 5),
                child: Text(
                  'ユーザ名',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Container(
                //年齢コンテナ
                  margin: EdgeInsets.only(top: 2, left: 55),
                  //width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    //性別によってピンクと青色変える
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(6)),
                  child: Text(
                    '10',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  padding: EdgeInsets.only(
                    left: 5,
                    right: 5,
                  ))
            ],
          )
      ),
      Container(
          margin: EdgeInsets.only(top: 110, left: 6),
          //width: MediaQuery.of(context).size.width * 0.5,
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 3),
                child: Text(
                  '好き',
                  style: TextStyle(
                      fontSize: 8),
                ),
              ),
              Image(
                image: AssetImage('../assets/yaj.png'),
                width: 10,
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 3),
                child: Text(
                  '苦手',
                  style: TextStyle(
                      fontSize: 8),
                ),
              ),
            ],
          ))
    ]);
  }
}
