class Post {
  int id;
  String title;
  String code;
  String content;
  String date;
  Category category;
  bool like;
  int totallike;
  List<Comment> comment;

  Post({
    required this.id,
    required this.title,
    required this.code,
    required this.content,
    required this.date,
    required this.category,
    required this.like,
    required this.totallike,
    required this.comment,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    var category = json['category'] != null ? Category.fromJson(json['category']) : null;

    var commentList = <Comment>[];
    if (json['comment'] != null) {
      var commentJsonList = json['comment'] as List;
      commentList = commentJsonList.map((commentJson) => Comment.fromJson(commentJson)).toList();
    }

    return Post(
      id: json['id'],
      title: json['title'],
      code: json['code'],
      content: json['content'],
      date: json['date'],
      category: category!,
      like: json['like'],
      totallike: json['totallike'],
      comment: commentList,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['code'] = this.code;
    data['content'] = this.content;
    data['date'] = this.date;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    data['like'] = this.like;
    data['totallike'] = this.totallike;
    if (this.comment != null) {
      data['comment'] = this.comment.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int id;
  String title;

  Category({
    required this.id, 
    required this.title,
    });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}


class Comment {
  int id;
  String title;
  String time;
  User user;
  int post;
  List<Reply> reply;

  Comment({
    required this.id,
    required this.title,
    required this.time,
    required this.user,
    required this.post,
    required this.reply,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    var replyList = <Reply>[];
    if (json['reply'] != null) {
      replyList = (json['reply'] as List).map((e) => Reply.fromJson(e)).toList();
    }
    return Comment(
      id: json['id'],
      title: json['title'],
      time: json['time'],
      user: User.fromJson(json['user']),
      post: json['post'],
      reply: replyList,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['time'] = this.time;
    data['user'] = this.user.toJson();
    data['post'] = this.post;
    data['reply'] = this.reply.map((e) => e.toJson()).toList();
    return data;
  }
}

class User {
  int id;
  String username;
  String email;

  User({
    required this.id,
    required this.username,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    return data;
  }
}

class Reply {
  int id;
  String title;
  String time;
  User user;
  int comment;

  Reply({
    required this.id,
    required this.title,
    required this.time,
    required this.user,
    required this.comment,
  });

  factory Reply.fromJson(Map<String, dynamic> json) {
    return Reply(
      id: json['id'],
      title: json['title'],
      time: json['time'],
      user: User.fromJson(json['user']),
      comment: json['comment'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['time'] = this.time;
    data['user'] = this.user.toJson();
    data['comment'] = this.comment;
    return data;
  }
}


