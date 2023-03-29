import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/post_provider.dart';
import '../widget/single_comments.dart';


class PostDetailsScreens extends StatefulWidget {
  static const routeName = '/post-details-screens';
  @override
  _PostDetailsScreensState createState() => _PostDetailsScreensState();
}

class _PostDetailsScreensState extends State<PostDetailsScreens> {
  bool _showComments = false;
  String commenttitle = '';
  final commentControler = TextEditingController();

  void _addComment() {
    if (commenttitle.length <= 0) {
      return;
    }
    final id = ModalRoute.of(context)!.settings.arguments as int? ?? 0;

    Provider.of<PostState>(context, listen: false).addcomment(id, commenttitle);
    commentControler.text = '';
    commenttitle = '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as int? ?? 0;
    final post = Provider.of<PostState>(context).singlePost(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      post.title,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(post.category.title),
                      ),
                    ),
                  ],
                ),
                if (post.code.length != 0)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Code : ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Card(
                          color: Theme.of(context).primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              post.code,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                post.content.length > 100
                    ? Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.content,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        child: Text(
                          "${post.content}",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                Divider(),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Provider.of<PostState>(context, listen: false)
                              .addlike(post.id);
                        },
                        icon: Icon(
                          post.like ? Icons.favorite : Icons.favorite_border,
                          color: Theme.of(context).accentColor,
                        ),
                        label: Text(
                          "Like(${post.totallike})",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            _showComments = !_showComments;
                          });
                        },
                        icon: Icon(
                          Icons.comment,
                          color: Theme.of(context).accentColor,
                        ),
                        label: Text(
                          "Comment(${post.comment.length})",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_showComments)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: TextField(
                          controller: commentControler,
                          onChanged: (v) {
                            setState(() {
                              commenttitle = v;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Comment...",
                            suffix: IconButton(
                              onPressed: commenttitle.length <= 0
                                  ? null
                                  : () {
                                      _addComment();
                                    },
                              icon: Icon(Icons.send),
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: post.comment
                                .map(
                                  (e) => SingleComment(e),
                                )
                                .toList(),
                          ),
                        ),
                      )
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}