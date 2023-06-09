import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/post_provider.dart';
import '../widget/single_post.dart';

class CategoryScreens extends StatefulWidget {
  static const routeName = '/category-screens';
  @override
  _CategoryScreensState createState() => _CategoryScreensState();
}

class _CategoryScreensState extends State<CategoryScreens> {
  @override
  Widget build(BuildContext context) {
    
    final id = ModalRoute.of(context)?.settings.arguments as int? ?? 0;
    final posts = Provider.of<PostState>(context).categoryposts(id);

    return posts.length == 0
        ? Scaffold(
            appBar: AppBar(
              title: Text("No post for This Category"),
            ),
            body: Center(
              child: Text("No Post"),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text("All Post for ${posts[0].category.title} "),
              centerTitle: true,
            ),
            body: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (ctx, i) => SinglePost(posts[i]),
            ),
          );
  }
}