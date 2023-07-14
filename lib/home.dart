//ホーム画面
import 'package:flutter/material.dart';
import 'package:stuby_develop/PosDis.dart';
import 'package:stuby_develop/storyPost.dart';
import 'package:stuby_develop/submitPost.dart';


const String apiEndpoint = 'https://d1xwn0sj8q7csh.cloudfront.net/stuby/test '; // API

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin{
  late TabController _tabController;
  // 状態を管理する変数などをここに追加
  List<bool> isFavoriteList = List.filled(4, false); // 投稿数に合わせたリストを作成し、初期値をfalseで埋める

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(228, 252, 255, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 37,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.lightBlue,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.lightBlueAccent,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(text: 'フォロワー'),
                  Tab(text: 'パブリック'),
                ],
              ),
            ),
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: ScrollPhysics(),
                child: Row(
                  children: [
                    Story_you('あなた', 'assets/hamesu.png'),
                    Story('User 2', 'assets/yuuri.png'),
                    Story('User 3', 'assets/messi.png'),
                    Story('User 4', 'assets/user1_story.png'),
                    Story('User 5', 'assets/messi_post.png'),
                    Story('User 6', 'assets/yuuri.png'),
                    Story('User 7', 'assets/yuuri.png'),
                    Story('User 8', 'assets/yuuri.png'),
                    Story('User 9', 'assets/yuuri.png'),
                    Story('User 10', 'assets/yuuri.png'),
                    Story('User 11', 'assets/yuuri.png'),
                    Story('User 12', 'assets/yuuri.png'),
                    Story('User 13', 'assets/yuuri.png'),
                    Story('User 14', 'assets/yuuri.png'),
                    Story('User 15', 'assets/yuuri.png'),
                    Story('User 16', 'assets/yuuri.png'),
                    Story('User 17', 'assets/yuuri.png'),
                    Story('User 18', 'assets/yuuri.png'),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 1.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.67,
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      for (int i = 0; i < 4; i++) ...{
                        Post(context, i),
                      }
                    ],
                  ),
                  ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      for (int i = 0; i < 1; i++) ...{
                        Post(context, i),
                      }
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      //右下のボタン
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightBlueAccent,
          // onPressed: test,
          onPressed:() {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SubmitPostPage()),
            );
          },
          child: Image.asset("assets/post.png")),
    );
  }

  //自分用ストーリー
  Widget Story_you(String username, String imagePath) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StoryPostPage()),
          );
        },
        child: Container(
          margin: EdgeInsets.only(top: 20, left: 20),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(104, 251, 255, 1),
                          Color.fromRGBO(104, 251, 255, 1),
                          Color.fromRGBO(104, 251, 255, 1),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Container(
                        child: CircleAvatar(
                          radius: 35.0,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 34.0,
                        backgroundImage: AssetImage(imagePath),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(username),
            ],
          ),
        ));
  }

  //他人のストーリー
  Widget Story(String username, String imagePath) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StoryPostPage()),
          );
        },
        child: Container(
          margin: EdgeInsets.only(top: 20, left: 20),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(104, 251, 255, 1),
                          Color.fromRGBO(104, 251, 255, 1),
                          Color.fromRGBO(104, 251, 255, 1),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Container(
                        child: CircleAvatar(
                          radius: 35.0,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 34.0,
                        backgroundImage: AssetImage(imagePath),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(username),
            ],
          ),
        ));
  }

  Widget Post(BuildContext context, int i) {
    //名前
    List<String> names = ["優里ch", "Lionel Messi", "優里ch", "Lionel Messi"];
    //トプ画
    List<String> images = [
      "assets/yuuri.png",
      "assets/messi.png",
      "assets/yuuri.png",
      "assets/messi.png",
    ];
    //時間
    List<String> times = ["09:20", "22:20", "23:03", "00:00"];
    //投稿画像
    List<String> image_posts = [
      "assets/yuuri_post.png",
      "assets/messi_post.png",
      "assets/yuuri_post.png",
      "assets/messi_post.png"
    ];
    //投稿文章
    List<String> posts = [
      "新しいアルバム出しました\n\"1stアルバム「ECC」\"",
      "EZWIN 3-0",
      "新しいアルバム出しました\n\"1stアルバム「ECC」\"",
      "EZWIN 3-0"
    ];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PosDisPage(
              name: names[i],
              image: images[i],
              time: times[i],
              image_post: image_posts[i],
              post: posts[i],
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 35, right: 10, bottom: 5, left: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
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
                      backgroundImage: AssetImage(images[i]),
                    ),
                  ),
                ),
                //時間
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(top: 30, right: 25),
                    child: Text(
                      times[i],
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
                      names[i],
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
                    posts[i],
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              //投稿画像
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(image_posts[i]),
                  ),
                  margin:
                  EdgeInsets.only(top: 20, bottom: 30, left: 20, right: 20),
                ),
              ),
            ),
            //icon達
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isFavoriteList[i] = !isFavoriteList[i]; // クリックされた投稿のお気に入り状態を反転させる
                        });
                      },
                      child: Container(
                        child: Icon(
                          isFavoriteList[i] ? Icons.favorite : Icons.favorite_border,
                          size: 23,
                          color:Colors.pink, // 状態に応じて色を変更
                        ),
                      ),
                    ),
                    margin: EdgeInsets.only(bottom: 18, right: 26),
                  ),
                  Container(
                    child: Icon(
                      Icons.mode_comment_outlined,
                      size: 23,
                      color: Colors.lightBlueAccent,
                    ),
                    margin: EdgeInsets.only(bottom: 16, right: 30),
                  ),
                  Container(
                    child: Image.asset(
                      "assets/share.png",
                    ),
                    margin: EdgeInsets.only(bottom: 18, right: 30),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}