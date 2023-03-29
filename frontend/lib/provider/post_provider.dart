import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

import '../models/post_model.dart';

class PostState with ChangeNotifier {
  late List<Post> _posts;
  late List<Category> _category;

    final LocalStorage storage = LocalStorage("usertoken");

  Future<bool> getPostData() async {
    try {
      final String baseUrl = 'http://127.0.0.1:8000';
      final String apiPath = '/api/posts/';
      final Uri apiUrl = Uri.parse('$baseUrl$apiPath');

      final String token = storage.getItem('token');
      final http.Response response = await http.get(
        apiUrl,
        headers: {'Authorization': 'token $token'},
      );

      final List<dynamic> data = json.decode(response.body);
      final List<Post> temp = [];
      data.forEach((element) {
        final Post post = Post.fromJson(element);
        temp.add(post);
      });

      _posts = temp;
      notifyListeners();
      return true;
    } catch (e) {
      print("error getPostData");
      print(e);
      return false;

    }
  }

  Future<void> getCategoryData() async {
  try {
    final String baseUrl = 'http://127.0.0.1:8000';
    final String apiPath = '/api/categorys/';
    final Uri apiUrl = Uri.parse('$baseUrl$apiPath');

    final String token = storage.getItem('token');
    final http.Response response = await http.get(
      apiUrl,
      headers: {'Authorization': 'token $token'},
    );

    final List<dynamic> data = json.decode(response.body);
    final List<Category> temp = [];
    data.forEach((element) {
      final Category category = Category.fromJson(element);
      temp.add(category);
    });

    _category = temp;
    notifyListeners();
  } catch (e) {
    print("error getCategoryData");
    print(e);
  }
}


  Future<void> addlike(int id) async {
  try {
    final String baseUrl = 'http://127.0.0.1:8000';
    final String apiPath = '/api/addlike/';
    final Uri apiUrl = Uri.parse('$baseUrl$apiPath');

    final String token = storage.getItem('token');
    final http.Response response = await http.post(
      apiUrl,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'token $token',
      },
      body: json.encode({
        "id": id,
      }),
    );

    final data = json.decode(response.body);
    if (data['error'] == false) {
      await getPostData();
    }
  } catch (e) {
    print("error addlike");
    print(e);
  }
}


  Future<void> addcomment(int postid, String commenttext) async {
  try {
    final String baseUrl = 'http://127.0.0.1:8000';
    final String apiPath = '/api/addcomment/';
    final Uri apiUrl = Uri.parse('$baseUrl$apiPath');
    final String token = storage.getItem('token');
    final http.Response response = await http.post(
      apiUrl,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'token $token',
      },
      body: json.encode({
        "postid": postid,
        "comment": commenttext,
      }),
    );
    final Map<String, dynamic> data = json.decode(response.body);
    if (data['error'] == false) {
      await getPostData();
    }
  } catch (e) {
    print("error addcomment");
    print(e);
  }
}


  Future<void> addreply(int commentid, String replytext) async {
    try {
      final String baseUrl = 'http://127.0.0.1:8000';
      final String apiPath = '/api/addreply/';
      final Uri apiUrl = Uri.parse('$baseUrl$apiPath');

      final String token = storage.getItem('token');
      final http.Response response = await http.post(
        apiUrl,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'token $token',
        },
        body: json.encode({
          "commentid": commentid,
          "replytext": replytext,
        }),
      );
      final data = json.decode(response.body);
      if (data['error'] == false) {
        getPostData();
      }
    } catch (e) {
      print("error addreply");
      print(e);
    }
  }


  Future<bool> loginNow(String username, String password) async {
  try {
    final String baseUrl = 'http://127.0.0.1:8000';
    final String apiPath = '/api/login/';
    final Uri apiUrl = Uri.parse('$baseUrl$apiPath');

    final http.Response response = await http.post(
      apiUrl,
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );
    final data = json.decode(response.body) as Map;
    if (data.containsKey('token')) {
      storage.setItem('token', data['token']);
      return false;
    }
    return true;
  } catch (e) {
    print("error loginnow");
    print(e);
    return true;
  }
}


  Future<bool> registerNow(String username, String password) async {
  try {
    final String baseUrl = 'http://127.0.0.1:8000';
    final String apiPath = '/api/register/';
    final Uri apiUrl = Uri.parse('$baseUrl$apiPath');

    final http.Response response = await http.post(
      apiUrl,
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );
    final data = json.decode(response.body) as Map;
    return data['error'];
  } catch (e) {
    print("error registerNow");
    print(e);
    return true;
  }
}


  List<Post>? get post {
    if (_posts != null) {
      return [..._posts];
    }
    return null;
  }

  List<Category>? get category {
    if (_posts != null) {
      return [..._category];
    }
    return null;
  }

  Post singlePost(int id) {
    return _posts.firstWhere((element) => element.id == id);
  }

  List<Post> categoryposts(int id) {
    return [..._posts.where((element) => element.category.id == id)];
  }
}