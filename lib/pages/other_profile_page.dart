import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/member_model.dart';
import '../model/post_model.dart';
import '../services/db_services.dart';

class OtherProfilePage extends StatefulWidget {
  final String userId;

  const OtherProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  State<OtherProfilePage> createState() => _OtherProfilePageState();
}

class _OtherProfilePageState extends State<OtherProfilePage> {
  bool isLoading = false;
  int axisCount = 2;
  List<Post> items = [];
  String fullname = "", email = "", img_url = "";
  int count_posts = 0, count_followers = 0, count_following = 0;

  @override
  void initState() {
    super.initState();
    _apiLoadUserData();
    _apiLoadUserPosts();
  }

  void _apiLoadUserData() {
    setState(() {
      isLoading = true;
    });
    DBService.loadMemberById(widget.userId).then((value) {
      _showMemberInfo(value);
    });
  }

  void _showMemberInfo(Member member) {
    setState(() {
      isLoading = false;
      fullname = member.fullname;
      email = member.email;
      img_url = member.img_url;
      count_following = member.following_count;
      count_followers = member.followers_count;
    });
  }

  void _apiLoadUserPosts() {
    DBService.loadUserPosts(widget.userId).then((value) {
      _showUserPosts(value);
    });
  }

  void _showUserPosts(List<Post> posts) {
    setState(() {
      items = posts;
      count_posts = posts.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          fullname,
          style: TextStyle(
              color: Colors.black, fontFamily: "Billabong", fontSize: 25),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                //#profile picture
                Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(70),
                    border: Border.all(
                      width: 1.5,
                      color: Color.fromRGBO(193, 53, 132, 1),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: img_url == null || img_url.isEmpty
                        ? Image(
                      image: AssetImage("assets/images/ic_person.png"),
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    )
                        : Image.network(
                      img_url,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(height: 10),

                //#username and email
                Text(
                  fullname.toUpperCase(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 3),
                Text(
                  email,
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),

                SizedBox(height: 10),

                //#post count, followers, following
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 80,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              count_posts.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 3),
                            Text(
                              "POSTS",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              count_followers.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 3),
                            Text(
                              "FOLLOWERS",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              count_following.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 3),
                            Text(
                              "FOLLOWING",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //#grid or list view of posts
                Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                axisCount = 1;
                              });
                            },
                            icon: Icon(Icons.list_alt),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                axisCount = 2;
                              });
                            },
                            icon: Icon(Icons.grid_view),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: axisCount),
                    itemCount: items.length,
                    itemBuilder: (ctx, index) {
                      return _itemOfPost(items[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemOfPost(Post post) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          Expanded(
            child: CachedNetworkImage(
              width: double.infinity,
              imageUrl: post.img_post,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 3),
          Text(
            post.caption,
            style: TextStyle(color: Colors.black87.withOpacity(0.7)),
            maxLines: 2,
          )
        ],
      ),
    );
  }
}
